Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CC14BBACD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 15:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbiBROkS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 09:40:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbiBROkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:40:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D3F294FCE;
        Fri, 18 Feb 2022 06:39:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4CA8A1F37E;
        Fri, 18 Feb 2022 14:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645195198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NZ81IbztRFq96P1SFEoMH20zQGMnSy2lBQ+y+pPVA9s=;
        b=A9SnUNcczRvGqKU/bKFhCF1TFm3nsi8W4DLkQJCLWhvA2i8VmxsJ664QhAjG20GNphCAD4
        W8Wc1zsB3MoScKQFv6KVgiPRt7FuhE2jArOAAenT6Mpt9HwLOVeIQCdvtRSG8wDrNinqyE
        yHNTSuDYOC9WCmmfkOKslI0f8JShd/E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5CCB13C94;
        Fri, 18 Feb 2022 14:39:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L7hGNL2vD2LECgAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 18 Feb 2022 14:39:57 +0000
Message-ID: <dc75ed71-608d-13cd-c274-04801619da8a@suse.com>
Date:   Fri, 18 Feb 2022 16:39:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] btrfs: remove the cross file system checks from
 remap
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, viro@ZenIV.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1645194730.git.josef@toxicpanda.com>
 <ac03eaa51bac7c30ee4b116777ac9eb57573a280.1645194730.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
In-Reply-To: <ac03eaa51bac7c30ee4b116777ac9eb57573a280.1645194730.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 18.02.22 г. 16:38 ч., Josef Bacik wrote:
> The sb check is already done in do_clone_file_range, and the mnt check
> (which will hopefully go away in a subsequent patch) is done in
> ioctl_file_clone().  Remove the check in our code and put an ASSERT() to
> make sure it doesn't change underneath us.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>   fs/btrfs/reflink.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index a3930da4eb3f..6fed103f1000 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -772,9 +772,7 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>   		if (btrfs_root_readonly(root_out))
>   			return -EROFS;
>   
> -		if (file_in->f_path.mnt != file_out->f_path.mnt ||
> -		    inode_in->i_sb != inode_out->i_sb)
> -			return -EXDEV;
> +		ASSERT(inode_in->i_sb == inode_out->i_sb);
>   	}
>   
>   	/* Don't make the dst file partly checksummed */
