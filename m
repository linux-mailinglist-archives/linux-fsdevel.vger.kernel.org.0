Return-Path: <linux-fsdevel+bounces-34017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D969C1EE9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 15:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB1021C225B6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 14:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB771F4285;
	Fri,  8 Nov 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Qy6r6KnS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602BC1E1C18
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731075082; cv=none; b=G9Q8g1KVFvYcwE3R/WLVDqPmnB6quS+kb5Z0rgBCWWRnsGVeA5+3kcSDceBQ//851PWkLbvlpZcuxWM0XWMbsgCl8iSaPbHYbVX9jbBuMTUUAqCyJO5aYxap2FXW/KWzmNVm9Ae08dxkEnJ1BNViRO3Tz/E2nSiZ8SsMxCpB95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731075082; c=relaxed/simple;
	bh=geipAEp7Iny0knzgJN0trsMJLnXKvldNQshwvVzOt24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmRG7jeo2Mtno/BwmJtIZFKR4cGRCu8v3jrY0DSzd7O/SdM8DFfNHko+cqYuu4xYkPc0W+RR8je8bM/Zqh8DDLMiMrBJ1W0th8cWscnvlxtGyLMEnXr+ELGSRh9QjrOVDVPUq63QFnQJR9Dbl+xhOWsISN3/heS/TKbbxSj3BqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Qy6r6KnS; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460c0f9c13eso19578571cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Nov 2024 06:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731075077; x=1731679877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PKrXMfJU3Q1zGCXveeHgzpUc2RHjdnafoKeLdo/+mG0=;
        b=Qy6r6KnSXA5bCL2tJSwZOBOOWWt5gEkgEH1ZIH7tqTrkppJPj+zuDXhCWAu4s/pnSC
         85qPT3M/voje6cPj/ztnE1XCdWnIO5tT7yrjR6ST8+St5QJEFA8XD7Bf5DBMEdxiUzR3
         QXhW21mZzS5uBuBHXutqKqrf8hUBT0UVjUUtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731075077; x=1731679877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKrXMfJU3Q1zGCXveeHgzpUc2RHjdnafoKeLdo/+mG0=;
        b=BGVLWockX1H9GX6uWgVe9nqTxYFp6+CpgNs0AkIF5MhALYUywKU2lvRMiqSkeJX6eg
         8FWlF2JOKY2eEml93Y6zy4pMbKknLbaxT3YxT6zu8oyVKPbHop4L8u3iz2A012Hk2sSS
         NGwcN5MDnRVLOVA8AtDc70bP3avXPDNuu1Svjf6VBxnKRLxsAg+vHzirirri2dVeaO4S
         BvepxXyeyr/QZPb8Gfdcnq/G+alCNHyP3esVO77l2vZ/tVFOc/7ADN8FsQlFxeCy3/Kl
         a59jvggJb471wj/ebnnXt3famSvASTLsCblrhxtDwFU6sX/eA6zEG+f5ynOLKFWZPjHC
         KyZg==
X-Forwarded-Encrypted: i=1; AJvYcCW62Hab43V4szn8CGQ7pfWHRy/B9fSGXkIPyIqxeibuHylirtqBduXwrfOUvqdCXdgwVtRFnQmKmevVvBA1@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj77sY+xYy1tOjiCZqnEyUMTBAu6uAchDJ7E/2qvN8NHFa49sV
	RRY0FqjlTaMA/klMIKl+XOrKCPhDN4Dw9oaHUCC7Jh9dzuxDFkOrMcrWMxwDOn63voP6DF0dbw6
	+WmmPCnB9vrqxc3vzM0ee9qm6NXEEg5ugEGvOaA==
X-Google-Smtp-Source: AGHT+IFlDnPeo/Bb8HEj42CD758Mq3MxIyeUubE4knE5l2tFQ+A4Td9GiYRSx26ULv1fdh0YLMjkT1FpbjFuz+Wxc6k=
X-Received: by 2002:ac8:690e:0:b0:461:1679:9062 with SMTP id
 d75a77b69052e-46309a6de7emr59383801cf.9.1731075077202; Fri, 08 Nov 2024
 06:11:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024164726.77485-1-hreitz@redhat.com> <CAJfpeguWjwXtM4VJYP2+-0KK5Jkz80eKpWc-ST+yMuKL6Be0=w@mail.gmail.com>
 <ae437cf6-caa2-4f9a-9ffa-bdc7873a99eb@redhat.com> <CAJfpegvfYhL4-U-4=sSkcne3MSNZk3P3jqBAPYWp5b5o4Ryk6w@mail.gmail.com>
 <ece87ac3-71e2-4c43-a144-659d19b1e75d@redhat.com>
In-Reply-To: <ece87ac3-71e2-4c43-a144-659d19b1e75d@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 8 Nov 2024 15:11:06 +0100
Message-ID: <CAJfpegtuVxtf9xoyJPveqA=uXb-wnzPcqD_rXNOV4LMahWqxEQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-fs: Query rootmode during mount
To: Hanna Czenczek <hreitz@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	virtualization@lists.linux.dev, Miklos Szeredi <mszeredi@redhat.com>, 
	German Maglione <gmaglione@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Nov 2024 at 18:59, Hanna Czenczek <hreitz@redhat.com> wrote:

> > Regardless, something smells here: fuse_mount_remove() is only called
> > if sb->s_root is set (both plain fuse and virtiofs).  The top level
> > fuse_mount is added to fc->mounts in fuse_conn_init(), way before
> > sb->s_root is set...
> >
> > Will look into this.

This is the deal:

1) When the top sb is created the fm->fc_entry is chained on
fc->mounts in fuse_conn_init() which is called near the top of
fuse_get_tree() and virtio_fs_get_tree(). If things fail during
->get_tree() or an existing fc is used instead of the newly allocated
one, then fuse_mount_destroy() is called, which frees the fm and
fm->fc, ignoring the mounts list.  This is okay, though a bit
confusing.

2) When a submount is created, then fm is only chained onto fc->mounts
towards the end of fuse_get_tree_submount() in the success case.

There should be no way for fuse_mount_destroy() to see fm chained onto
fc yet fc having other fuse mounts.  The below patch reflects this
with a WARN_ON().  Not tested yet, but there would be memory
corruption if it wasn't the case.

As for your patch, the condition (sb->s_root || (fm &&
fm->fc->initialized)) should work AFAICS.

Thanks,
Miklos

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index fd3321e29a3e..0c4eb5b89e71 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1653,6 +1653,7 @@ static int fuse_get_tree_submount(struct fs_context *fsc)
        if (!fm)
                return -ENOMEM;

+       INIT_LIST_HEAD(&fm->fc_entry);
        fm->fc = fuse_conn_get(fc);
        fsc->s_fs_info = fm;
        sb = sget_fc(fsc, NULL, set_anon_super_fc);
@@ -1976,6 +1977,13 @@ static void fuse_sb_destroy(struct super_block *sb)

 void fuse_mount_destroy(struct fuse_mount *fm)
 {
+       /*
+        * We can get here in case of an error before the top sb is fully set
+        * up.  The sole reference to the fc must come from fm in that case
+        * otherwise may end up with corruption on fc->mounts list.
+        */
+       WARN_ON(!list_empty(&fm->fc_entry) &&
refcount_read(&fm->fc->count) != 1);
+
        fuse_conn_put(fm->fc);
        kfree_rcu(fm, rcu);
 }

