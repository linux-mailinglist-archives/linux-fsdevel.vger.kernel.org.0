Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D93550E992
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 21:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244971AbiDYTiw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 15:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244968AbiDYTiv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:38:51 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176D211115A;
        Mon, 25 Apr 2022 12:35:46 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 90A8014DB; Mon, 25 Apr 2022 15:35:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 90A8014DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1650915345;
        bh=RMqHgOKqXXbxUoCSNWhPfJAimj7IFB101BD794lejj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GcIDZNBprxrZ3zkBj2HiXt23Ne0HH2haVnBRRUJrmbz730MEfO3QqHPz0ZJM3Zo4H
         UunADjkK9fh0qd8b+y+pWxLnB5TJRncYlAiZGe6dmzyfr2+sAWZ7Djgsa3qrI1rWGU
         lVSLw94lR6euALxpLFMBG5zJqQemAAw614GFS7GA=
Date:   Mon, 25 Apr 2022 15:35:45 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v21 3/7] NFSD: move create/destroy of laundry_wq to
 init_nfsd and exit_nfsd
Message-ID: <20220425193545.GG24825@fieldses.org>
References: <1650739455-26096-1-git-send-email-dai.ngo@oracle.com>
 <1650739455-26096-4-git-send-email-dai.ngo@oracle.com>
 <8640dbe0-cece-4515-fa4f-efa2e0a14303@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8640dbe0-cece-4515-fa4f-efa2e0a14303@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 25, 2022 at 08:27:22AM -0700, dai.ngo@oracle.com wrote:
> This patch has problem to build with this error:
> 
> >>nfsctl.c:(.exit.text+0x0): undefined reference to `laundry_wq'
> >>mipsel-linux-ld: nfsctl.c:(.exit.text+0x4): undefined reference to `laundry_wq'
> 
> This happens when CONFIG_NFSD is defined but CONFIG_NFSD_V4
> is not. I think to fix this we need to also move the declaration
> of laundry_wq from nfs4state.c to nfsctl.c. However this seems
> odd since the laundry_wq is only used for v4, unless you have
> any other suggestion.

I'd just leave laundry_wq private to nfs4state.c.  Define
create_laundromat() and destroy_laundromat() in nfs4state.c too.  And in
nfsd.h, do the usual trick of defining no-op versions of those functions
in the non-v4 case.  (See e.g. what we do with nfsd4_init/free_slabs().)

--b.

> 
> -Dai
> 
> On 4/23/22 11:44 AM, Dai Ngo wrote:
> >This patch moves create/destroy of laundry_wq from nfs4_state_start
> >and nfs4_state_shutdown_net to init_nfsd and exit_nfsd to prevent
> >the laundromat from being freed while a thread is processing a
> >conflicting lock.
> >
> >Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> >---
> >  fs/nfsd/nfs4state.c | 15 ++-------------
> >  fs/nfsd/nfsctl.c    |  6 ++++++
> >  fs/nfsd/nfsd.h      |  1 +
> >  3 files changed, 9 insertions(+), 13 deletions(-)
> >
> >diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> >index b08c132648b9..b70ba2eb5665 100644
> >--- a/fs/nfsd/nfs4state.c
> >+++ b/fs/nfsd/nfs4state.c
> >@@ -125,7 +125,7 @@ static void free_session(struct nfsd4_session *);
> >  static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
> >  static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
> >-static struct workqueue_struct *laundry_wq;
> >+struct workqueue_struct *laundry_wq;
> >  static bool is_session_dead(struct nfsd4_session *ses)
> >  {
> >@@ -7798,22 +7798,12 @@ nfs4_state_start(void)
> >  {
> >  	int ret;
> >-	laundry_wq = alloc_workqueue("%s", WQ_UNBOUND, 0, "nfsd4");
> >-	if (laundry_wq == NULL) {
> >-		ret = -ENOMEM;
> >-		goto out;
> >-	}
> >  	ret = nfsd4_create_callback_queue();
> >  	if (ret)
> >-		goto out_free_laundry;
> >+		return ret;
> >  	set_max_delegations();
> >  	return 0;
> >-
> >-out_free_laundry:
> >-	destroy_workqueue(laundry_wq);
> >-out:
> >-	return ret;
> >  }
> >  void
> >@@ -7850,7 +7840,6 @@ nfs4_state_shutdown_net(struct net *net)
> >  void
> >  nfs4_state_shutdown(void)
> >  {
> >-	destroy_workqueue(laundry_wq);
> >  	nfsd4_destroy_callback_queue();
> >  }
> >diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> >index 16920e4512bd..884e873b46ad 100644
> >--- a/fs/nfsd/nfsctl.c
> >+++ b/fs/nfsd/nfsctl.c
> >@@ -1544,6 +1544,11 @@ static int __init init_nfsd(void)
> >  	retval = register_cld_notifier();
> >  	if (retval)
> >  		goto out_free_all;
> >+	laundry_wq = alloc_workqueue("%s", WQ_UNBOUND, 0, "nfsd4");
> >+	if (laundry_wq == NULL) {
> >+		retval = -ENOMEM;
> >+		goto out_free_all;
> >+	}
> >  	return 0;
> >  out_free_all:
> >  	unregister_pernet_subsys(&nfsd_net_ops);
> >@@ -1566,6 +1571,7 @@ static int __init init_nfsd(void)
> >  static void __exit exit_nfsd(void)
> >  {
> >+	destroy_workqueue(laundry_wq);
> >  	unregister_cld_notifier();
> >  	unregister_pernet_subsys(&nfsd_net_ops);
> >  	nfsd_drc_slab_free();
> >diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> >index 23996c6ca75e..d41dcf1c4312 100644
> >--- a/fs/nfsd/nfsd.h
> >+++ b/fs/nfsd/nfsd.h
> >@@ -72,6 +72,7 @@ extern unsigned long		nfsd_drc_max_mem;
> >  extern unsigned long		nfsd_drc_mem_used;
> >  extern const struct seq_operations nfs_exports_op;
> >+extern struct workqueue_struct *laundry_wq;
> >  /*
> >   * Common void argument and result helpers
