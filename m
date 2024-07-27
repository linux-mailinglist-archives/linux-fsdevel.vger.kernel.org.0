Return-Path: <linux-fsdevel+bounces-24364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1193A93DEA6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 12:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E828B2246F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 10:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767764DA00;
	Sat, 27 Jul 2024 10:08:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120018F6D;
	Sat, 27 Jul 2024 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722074920; cv=none; b=DM1qmHhPlL4sGq888mX9aUZ7uVjCGCbiMqJoFYIYA0KUNfdUVbS9fsec8CCNFGrsRM55N9Ii0S4PCewvV95Xw5LtqCej8fyi0HxdOp9PzP2XWCoO+PZlepYrOo5gVb+O2VLrdGNrZVAXOvTCTNlMNF8JywOA3QxjP506Umzn2b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722074920; c=relaxed/simple;
	bh=xvIrdOAA1BqGl3nNiB9S31qiQPAJqhChIPI76QrwMAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CyItepAJyCs/OzHv+xq0ilOey6rAI/XnfCyKzD3AUBwidg6PnCX6oNZvzAWtCbNjnFEWPmkEbLdSEsV10g6JkJD8Gs7fs4C8Aazjg9UR1epk/b6V4E/fJ5vHou4maz7xFAaJGMjXdb8WaxMzGS8P9L0/V4v28bl6R/h0i62ZCm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WWKvc2S24zyNjn;
	Sat, 27 Jul 2024 18:03:40 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 391BC14011B;
	Sat, 27 Jul 2024 18:08:34 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemd100024.china.huawei.com
 (7.221.188.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 27 Jul
 2024 18:08:33 +0800
From: yangyun <yangyun50@huawei.com>
To: <josef@toxicpanda.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<miklos@szeredi.hu>, <yangyun50@huawei.com>
Subject: Re: [PATCH 2/2] fuse: add support for no forget requests
Date: Sat, 27 Jul 2024 18:08:29 +0800
Message-ID: <20240727100829.1227123-1-yangyun50@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240726154017.GE3432726@perftesting>
References: <20240726154017.GE3432726@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100024.china.huawei.com (7.221.188.41)


On Fri, Jul 26, 2024 at 11:40:17AM -0400, Josef Bacik wrote:
> On Fri, Jul 26, 2024 at 04:37:52PM +0800, yangyun wrote:
> > FUSE_FORGET requests are not used if the fuse file system does not
> > implement the forget operation in userspace (e.g., fuse file system
> > does not cache any inodes).
> > 
> > However, the kernel is invisible to the userspace implementation and
> > always sends FUSE_FORGET requests, which can lead to performance
> > degradation because of useless contex switch and memory copy in some
> > cases (e.g., many inodes are evicted from icache which was described
> > in commit 07e77dca8a1f ("fuse: separate queue for FORGET requests")).
> > 
> > Just like 'no_interrupt' in 'struct fuse_conn', we add 'no_forget'.
> > But since FUSE_FORGET request does not have a reply from userspce,
> > we can not use ENOSYS to reflect the 'no_forget' assignment. So add
> > the FUSE_NO_FORGET_SUPPORT init flag.
> > 
> > Besides, if no_forget is enabled, 'nlookup' in 'struct fuse_inode'
> > does not used and its value change can be disabled which are protected
> > by spin_lock to reduce lock contention.
> > 
> > Signed-off-by: yangyun <yangyun50@huawei.com>
> > ---
> >  fs/fuse/dev.c             |  6 ++++++
> >  fs/fuse/dir.c             |  4 +---
> >  fs/fuse/fuse_i.h          | 24 ++++++++++++++++++++++++
> >  fs/fuse/inode.c           | 10 +++++-----
> >  fs/fuse/readdir.c         |  8 ++------
> >  include/uapi/linux/fuse.h |  3 +++
> >  6 files changed, 41 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 932356833b0d..10890db9426b 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -238,6 +238,9 @@ void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
> >  {
> >  	struct fuse_iqueue *fiq = &fc->iq;
> >  
> > +	if (fc->no_forget)
> > +		return;
> > +
> >  	forget->forget_one.nodeid = nodeid;
> >  	forget->forget_one.nlookup = nlookup;
> >  
> > @@ -257,6 +260,9 @@ void fuse_force_forget(struct fuse_mount *fm, u64 nodeid)
> >  	struct fuse_forget_in inarg;
> >  	FUSE_ARGS(args);
> >  
> > +	if (fm->fc->no_forget)
> > +		return;
> > +
> >  	memset(&inarg, 0, sizeof(inarg));
> >  	inarg.nlookup = 1;
> >  	args.opcode = FUSE_FORGET;
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index 6bfb3a128658..833225ed1d4f 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -236,9 +236,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
> >  				fuse_force_forget(fm, outarg.nodeid);
> >  				goto invalid;
> >  			}
> > -			spin_lock(&fi->lock);
> > -			fi->nlookup++;
> > -			spin_unlock(&fi->lock);
> > +			fuse_nlookup_inc_if_enabled(fm->fc, fi);
> >  		}
> >  		if (ret == -ENOMEM || ret == -EINTR)
> >  			goto out;
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index b9a5b8ec0de5..924d6b0ad700 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -860,6 +860,9 @@ struct fuse_conn {
> >  	/** Passthrough support for read/write IO */
> >  	unsigned int passthrough:1;
> >  
> > +	/** Do not send FORGET request */
> > +	unsigned int no_forget:1;
> > +
> >  	/** Maximum stack depth for passthrough backing files */
> >  	int max_stack_depth;
> >  
> > @@ -1029,6 +1032,27 @@ static inline void fuse_sync_bucket_dec(struct fuse_sync_bucket *bucket)
> >  	rcu_read_unlock();
> >  }
> >  
> > +static inline void fuse_nlookup_inc_if_enabled(struct fuse_conn *fc, struct fuse_inode *fi)
> > +{
> > +	if (fc->no_forget)
> > +		return;
> > +
> > +	spin_lock(&fi->lock);
> > +	fi->nlookup++;
> > +	spin_unlock(&fi->lock);
> > +}
> > +
> > +static inline void fuse_nlookup_dec_if_enabled(struct fuse_conn *fc, struct fuse_inode *fi)
> > +{
> > +	if (fc->no_forget)
> > +		return;
> > +
> > +	spin_lock(&fi->lock);
> > +	fi->nlookup--;
> > +	spin_lock(&fi->lock);
> > +}
> 
> This naming scheme is overly verbose, you can simply have
> 
> fuse_inc_nlookup()
> fuse_dec_nlookup()

Thanks for your advice.
I will modify this in the next version. 

> 
> Thanks,
> 
> Josef

