Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA8852A507
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 16:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349144AbiEQOgq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 10:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349131AbiEQOgp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 10:36:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AC04FC7E;
        Tue, 17 May 2022 07:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CZekkTwrC4S+/YZo062E5YXgbQ0lRlxuhi1puw/bt/M=; b=uTu+DhNslWz8qWcmVmfH54N8KF
        wBUcjSpcSJ2nJHiPkW7OMlvxTG/p7GEThEEHmIvejja/Th7nfN9SgZs00QOlQM9lj+Afr/XBUlo9R
        NrTdcBD6HaKEn4+/erscw4J7/nD/1qbABGbfPcXEEHrYgWpC05pJYW4yylOjsTLWa0bEYrIzJQo0j
        VUNXn4UnOlD/Q6uzKfMD5D0zfW6v/HOp6ZKwl4bfC1jArn8OIVR7L/zd15dOZ8Xp32hfTMdhGXBVc
        eqd2lhtWc8OhEElbhDSM0FafInhFphzZrN3tEQldNOPtBzY0xKcDd66gODXEYjQfYUyYdLqn8zXDV
        q6Wf+5IQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqyJ9-00Ave3-IJ; Tue, 17 May 2022 14:36:19 +0000
Date:   Tue, 17 May 2022 15:36:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     jlayton@kernel.org, viro@zeniv.linux.org.uk, idryomov@gmail.com,
        vshankar@redhat.com, ceph-devel@vger.kernel.org,
        dchinner@redhat.com, hch@lst.de, arnd@arndb.de, mcgrof@kernel.org,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 2/2] ceph: wait the first reply of inflight async
 unlink
Message-ID: <YoOy40sGQv4DjmAq@casper.infradead.org>
References: <20220517125549.148429-1-xiubli@redhat.com>
 <20220517125549.148429-3-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517125549.148429-3-xiubli@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 17, 2022 at 08:55:49PM +0800, Xiubo Li wrote:
> +int ceph_wait_on_conflict_unlink(struct dentry *dentry)
> +{
> +	struct ceph_fs_client *fsc = ceph_sb_to_client(dentry->d_sb);
> +	struct dentry *pdentry = dentry->d_parent;
> +	struct dentry *udentry, *found = NULL;
> +	struct ceph_dentry_info *di;
> +	struct qstr dname;
> +	u32 hash = dentry->d_name.hash;
> +	int err;
> +
> +	dname.name = dentry->d_name.name;
> +	dname.len = dentry->d_name.len;
> +
> +	rcu_read_lock();
> +	hash_for_each_possible_rcu(fsc->async_unlink_conflict, di,
> +				   hnode, hash) {
> +		udentry = di->dentry;
> +
> +		spin_lock(&udentry->d_lock);
> +		if (udentry->d_name.hash != hash)
> +			goto next;
> +		if (unlikely(udentry->d_parent != pdentry))
> +			goto next;
> +		if (!hash_hashed(&di->hnode))
> +			goto next;
> +
> +		if (!test_bit(CEPH_DENTRY_ASYNC_UNLINK_BIT, &di->flags))
> +			pr_warn("%s dentry %p:%pd async unlink bit is not set\n",
> +				__func__, dentry, dentry);
> +
> +		if (d_compare(pdentry, udentry, &dname))
> +			goto next;
> +
> +		spin_unlock(&udentry->d_lock);
> +		found = dget(udentry);
> +		break;
> +next:
> +		spin_unlock(&udentry->d_lock);
> +	}
> +	rcu_read_unlock();
> +
> +	if (likely(!found))
> +		return 0;
> +
> +	dout("%s dentry %p:%pd conflict with old %p:%pd\n", __func__,
> +	     dentry, dentry, found, found);
> +
> +	err = wait_on_bit(&di->flags, CEPH_DENTRY_ASYNC_UNLINK_BIT,
> +			  TASK_INTERRUPTIBLE);

Do you really want to use TASK_INTERRUPTIBLE here?  If the window is
resized and you get a SIGWINCH, or a timer goes off and you get a
SIGALRM, you want to return -EINTR?  I would suggest that TASK_KILLABLE
is probably the semantics that you want.

