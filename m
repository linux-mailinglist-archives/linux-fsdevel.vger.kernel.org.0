Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5485172C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 17:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385844AbiEBPjY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 11:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbiEBPjX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 11:39:23 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D109BD8;
        Mon,  2 May 2022 08:35:53 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id B4AE6200B; Mon,  2 May 2022 11:35:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B4AE6200B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1651505752;
        bh=TxMt/VGeT+IZHG5jiAIrsfD3khSuQ+MhAtKpMxRED0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYnGEgs1OnC+P6qThAl5ZIkMcZj1xQbVezJU3hLvi2Uezdx+xnGFBoDazWqD5W/J1
         gMjEf6R1gPFmACbDv/b3BRqOoWYUGSJRzH3Bm+gjTQKDcMBZwIpdVcv0d9LW1IY5zh
         P/PwopbpOFIXxrfMthU/lWBCSVR611F64VatVWpI=
Date:   Mon, 2 May 2022 11:35:52 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v24 3/7] NFSD: move create/destroy of laundry_wq to
 init_nfsd and exit_nfsd
Message-ID: <20220502153552.GC30550@fieldses.org>
References: <1651426696-15509-1-git-send-email-dai.ngo@oracle.com>
 <1651426696-15509-4-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651426696-15509-4-git-send-email-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 01, 2022 at 10:38:12AM -0700, Dai Ngo wrote:
> This patch moves create/destroy of laundry_wq from nfs4_state_start
> and nfs4_state_shutdown_net to init_nfsd and exit_nfsd to prevent
> the laundromat from being freed while a thread is processing a
> conflicting lock.

Reviewed-by: J. Bruce Fields <bfields@fieldses.org>

> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 28 ++++++++++++++++------------
>  fs/nfsd/nfsctl.c    |  4 ++++
>  fs/nfsd/nfsd.h      |  4 ++++
>  3 files changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 0e98e9c16e3e..f369142da79f 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -127,6 +127,21 @@ static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
>  
>  static struct workqueue_struct *laundry_wq;
>  
> +int nfsd4_create_laundry_wq(void)
> +{
> +	int rc = 0;
> +
> +	laundry_wq = alloc_workqueue("%s", WQ_UNBOUND, 0, "nfsd4");
> +	if (laundry_wq == NULL)
> +		rc = -ENOMEM;
> +	return rc;
> +}
> +
> +void nfsd4_destroy_laundry_wq(void)
> +{
> +	destroy_workqueue(laundry_wq);
> +}
> +
>  static bool is_session_dead(struct nfsd4_session *ses)
>  {
>  	return ses->se_flags & NFS4_SESSION_DEAD;
> @@ -7748,22 +7763,12 @@ nfs4_state_start(void)
>  {
>  	int ret;
>  
> -	laundry_wq = alloc_workqueue("%s", WQ_UNBOUND, 0, "nfsd4");
> -	if (laundry_wq == NULL) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
>  	ret = nfsd4_create_callback_queue();
>  	if (ret)
> -		goto out_free_laundry;
> +		return ret;
>  
>  	set_max_delegations();
>  	return 0;
> -
> -out_free_laundry:
> -	destroy_workqueue(laundry_wq);
> -out:
> -	return ret;
>  }
>  
>  void
> @@ -7800,7 +7805,6 @@ nfs4_state_shutdown_net(struct net *net)
>  void
>  nfs4_state_shutdown(void)
>  {
> -	destroy_workqueue(laundry_wq);
>  	nfsd4_destroy_callback_queue();
>  }
>  
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 16920e4512bd..322a208878f2 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1544,6 +1544,9 @@ static int __init init_nfsd(void)
>  	retval = register_cld_notifier();
>  	if (retval)
>  		goto out_free_all;
> +	retval = nfsd4_create_laundry_wq();
> +	if (retval)
> +		goto out_free_all;
>  	return 0;
>  out_free_all:
>  	unregister_pernet_subsys(&nfsd_net_ops);
> @@ -1566,6 +1569,7 @@ static int __init init_nfsd(void)
>  
>  static void __exit exit_nfsd(void)
>  {
> +	nfsd4_destroy_laundry_wq();
>  	unregister_cld_notifier();
>  	unregister_pernet_subsys(&nfsd_net_ops);
>  	nfsd_drc_slab_free();
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 23996c6ca75e..847b482155ae 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -162,6 +162,8 @@ void nfs4_state_shutdown_net(struct net *net);
>  int nfs4_reset_recoverydir(char *recdir);
>  char * nfs4_recoverydir(void);
>  bool nfsd4_spo_must_allow(struct svc_rqst *rqstp);
> +int nfsd4_create_laundry_wq(void);
> +void nfsd4_destroy_laundry_wq(void);
>  #else
>  static inline int nfsd4_init_slabs(void) { return 0; }
>  static inline void nfsd4_free_slabs(void) { }
> @@ -175,6 +177,8 @@ static inline bool nfsd4_spo_must_allow(struct svc_rqst *rqstp)
>  {
>  	return false;
>  }
> +static inline int nfsd4_create_laundry_wq(void) { return 0; };
> +static inline void nfsd4_destroy_laundry_wq(void) {};
>  #endif
>  
>  /*
> -- 
> 2.9.5
