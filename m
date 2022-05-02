Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2D95173BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 18:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241045AbiEBQKE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 12:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240675AbiEBQKB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 12:10:01 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E598B17;
        Mon,  2 May 2022 09:06:32 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id CD3516CCD; Mon,  2 May 2022 12:06:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CD3516CCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1651507591;
        bh=fefRNgwP2JK/PA4RbrIuAA8K3Kcmfe5fM3W6FiebHeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lBZAtnmo05ndGRgQcO+dcRJhSIe96fCWi2qH/MaXev/7rhnnTuL7DFFzEwoJ124ti
         i85cgOHtNHLE4H2OPgf5BlSAOb4GeJvAafrkQMuWfpJHvZXW0Tn6c/u/amgSMGOgIG
         P6cdkIvrJTRFvPFeXs1SXhGu9Ug++87sdWJziXMY=
Date:   Mon, 2 May 2022 12:06:31 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v24 7/7] NFSD: Show state of courtesy client in
 client info
Message-ID: <20220502160631.GG30550@fieldses.org>
References: <1651426696-15509-1-git-send-email-dai.ngo@oracle.com>
 <1651426696-15509-8-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651426696-15509-8-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 01, 2022 at 10:38:16AM -0700, Dai Ngo wrote:
> Update client_info_show to show state of courtesy client
> and time since last renew.

At this point I may be borderline woodshedding, but: for simplicity's
sake, let's just keep that time as a number of seconds.  I'm thinking
that'll make it marginally easier for people processing the output and
doing comparisons and such.

--b.

> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 4ab7dda44f38..9cff06fc3600 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2473,7 +2473,8 @@ static int client_info_show(struct seq_file *m, void *v)
>  {
>  	struct inode *inode = m->private;
>  	struct nfs4_client *clp;
> -	u64 clid;
> +	u64 clid, hrs;
> +	u32 mins, secs;
>  
>  	clp = get_nfsdfs_clp(inode);
>  	if (!clp)
> @@ -2481,10 +2482,19 @@ static int client_info_show(struct seq_file *m, void *v)
>  	memcpy(&clid, &clp->cl_clientid, sizeof(clid));
>  	seq_printf(m, "clientid: 0x%llx\n", clid);
>  	seq_printf(m, "address: \"%pISpc\"\n", (struct sockaddr *)&clp->cl_addr);
> -	if (test_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags))
> +
> +	if (clp->cl_state == NFSD4_COURTESY)
> +		seq_puts(m, "status: courtesy\n");
> +	else if (clp->cl_state == NFSD4_EXPIRABLE)
> +		seq_puts(m, "status: expirable\n");
> +	else if (test_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags))
>  		seq_puts(m, "status: confirmed\n");
>  	else
>  		seq_puts(m, "status: unconfirmed\n");
> +	hrs = div_u64_rem(ktime_get_boottime_seconds() - clp->cl_time,
> +				3600, &secs);
> +	mins = div_u64_rem((u64)secs, 60, &secs);
> +	seq_printf(m, "time since last renew: %llu:%02u:%02u\n", hrs, mins, secs);
>  	seq_printf(m, "name: ");
>  	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
>  	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
> -- 
> 2.9.5
