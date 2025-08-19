Return-Path: <linux-fsdevel+bounces-58311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A300EB2C756
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 16:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54CC71BC536A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 14:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8B62773CD;
	Tue, 19 Aug 2025 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="YJBJi7qr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0382765C8
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614601; cv=none; b=tRO1CF6u1f5kLmeRCTPJHOrHMqJF2qCzmb3KYRPvoAld8DsbR1UR+HSk62k9tpQvGbrnAIinw4x7V0/zRSFN8i5pYec4l/X659R8QDVSiaMy2Qm5c+7SNqZgxs7HfB+e7Dg46ren1BarSvNZ7e0KrJ9FziZQwaPt3qxxfVBNjC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614601; c=relaxed/simple;
	bh=1gt1lex3grNQeKweDrZh+rqQKF/wlWxEI4BveN5KhSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOPMhso4fZKYnbQXbwH7zkQE6wyVZcyw/MJvoRAmYHXUXCOgTdhEiEV+3wBit4lwciMMbByc96uWwyJd4EkUBWZuXK83uhMGiWT1HzAbXdfItKLPEUvylewD1ZozoLf7+9xmBLubA6959FSmRN3m1Xynx8TWmndXLs4l9qRu304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=YJBJi7qr; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e87031ce70so362261285a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Aug 2025 07:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755614596; x=1756219396; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SrRc2tgp4KmdlBjHC+5Qbb1F91AXXvvTuUbuEZCoeaA=;
        b=YJBJi7qrrZEsZgtQdiRaaaCTI1SNMKLAXaNyM3Q6D/aqWatsF4vAB9FVwT7SknvRMb
         iROuXwOQK/Vu4eIQAIpz+N8oBDxzP0gOhlJUADjS9xTwwL/AdvfTZn1m4AYSzPLg/dpu
         njw8x6126e+j4XzmJHrC0HS2Pb47G3+NC8V+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755614596; x=1756219396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SrRc2tgp4KmdlBjHC+5Qbb1F91AXXvvTuUbuEZCoeaA=;
        b=dNQ+CCck5NZubczGxNmixX0Ur6Z5s2YwsOwlDZpiEN9nIpMftQYKgeNs7zTXRTjqsA
         yjE3YM8habLJjZScuvrY4WgWYQRE/WkV+hgoDLoxc/EwXDQ0YHZFpl+k/3GkxBn0Mz5E
         hmbjXynoWdf0WrXNJZ2F4ZNmSYVXI3+8Vdqk9KLCOYWxjeIiAozzfz4og5Q1nvr0p8uU
         1nq85wfwwe5bHAjc9ZoZsl4DG0V0AQFPqSFG/iDttGZ+cJVWhoCY+5YHf4/yki2spadn
         5dhknm9VWMGJQxy4B/So/ASuwETZGASV9HDvJUu4CTPZ4VSflVBCsfO5hzAQ9DyRPtJo
         q42A==
X-Forwarded-Encrypted: i=1; AJvYcCWM54gEwAqrwm1hGsGXuxzZHOUOPikKSBPSVW0a1HPCN3qKIkhWyxuqZVYtJyF0bNP6alDee+tVfdBHOXnu@vger.kernel.org
X-Gm-Message-State: AOJu0YzqPbW3Xkv6Qt9QkGzAphZ5OIYcnYbWtFRYZGt/r9fmQLhQE+3H
	B/a5j8Mf/Uqy7QiFs7ge/45wpS96q81X3uMjUu/Q6Zu/ZbKi/BUSudxptSalk+9RwVnDeptAM88
	fWN/G/8ZS2mF7fB2l1lXQjQviFLqmj9aHHxIy1WR7FQ==
X-Gm-Gg: ASbGnctYfVWwgEQsVZWjZn5yjvDlpyAX4GzV9XEQSen+lpCR+Q8w0oNYzynkBVO7eKD
	xBES4mUNKtqhmtk1vF+m6cQIqSMKzx1BNibRTfeoV9ShXaEnAWn0DMOIokbU/tFm/yUKban8LEl
	QHHo+2ixsot6Sig4o3J2VEGdX6R6NtUrCbkp3Qibo6bCkJPqvaJ9NruWv2808AsuR1TPWlv2zU9
	ovbTkYQ0w==
X-Google-Smtp-Source: AGHT+IG0IS8qYIkVRt6jBlySvHnHAK+TO0NBUsBdfgiRRR1+7sv9LNFxAwuDsYR07WsXvD0WKu4kiPSaR/JbzSVK0Y8=
X-Received: by 2002:a05:620a:1a94:b0:7e6:6028:6180 with SMTP id
 af79cd13be357-7e9f3430dd2mr319417785a.30.1755614596159; Tue, 19 Aug 2025
 07:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815182539.556868-2-joannelkoong@gmail.com> <20250818083224.229-1-luochunsheng@ustc.edu>
In-Reply-To: <20250818083224.229-1-luochunsheng@ustc.edu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 Aug 2025 16:43:05 +0200
X-Gm-Features: Ac12FXzbkQ6VyMzyvHmK-f_qn_sNV9m2g9wwdd9ZHICpJmQXInW0YZBjVefGp64
Message-ID: <CAJfpegvXHBTvRHoC3u3iDRzs5LpMPQq0+L6cWdGye545qv15FQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fuse: reflect cached blocksize if blocksize was changed
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: joannelkoong@gmail.com, brauner@kernel.org, djwong@kernel.org, 
	kernel-team@meta.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Aug 2025 at 10:32, Chunsheng Luo <luochunsheng@ustc.edu> wrote:
>
> On Fri, 15 Aug 2025 11:25:38 Joanne Koong wrote:
> >diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> >index ec248d13c8bf..1647eb7ca6fa 100644
> >--- a/fs/fuse/fuse_i.h
> >+++ b/fs/fuse/fuse_i.h
> >@@ -210,6 +210,12 @@ struct fuse_inode {
> >        /** Reference to backing file in passthrough mode */
> >        struct fuse_backing *fb;
> > #endif
> >+
> >+       /*
> >+        * The underlying inode->i_blkbits value will not be modified,
> >+        * so preserve the blocksize specified by the server.
> >+        */
> >+       u8 cached_i_blkbits;
> > };
>
> Does the `cached_i_blkbits` member also need to be initialized in the
> `fuse_alloc_inode` function like `orig_ino`?
>
> And I am also confused, why does `orig_ino` need to be initialized in
> `fuse_alloc_inode`, but the `orig_i_mode` member does not need it?

Strictly speaking neither one needs initialization, since these
shouldn't be accessed until the in-core inode is set up in lookup or
create.

But having random values in there is not nice, so I prefer having
everything initialized in fuse_alloc_inode().  See patch below
(whitespace damage(TM) by gmail).

Thanks,
Miklos

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 19fc58cb84dc..9d26a5bc394d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -101,14 +101,11 @@ static struct inode *fuse_alloc_inode(struct
super_block *sb)
        if (!fi)
                return NULL;

-       fi->i_time = 0;
+       /* Initialize private data (i.e. everything except fi->inode) */
+       BUILD_BUG_ON(offsetof(struct fuse_inode, inode) != 0);
+       memset((void *) fi + sizeof(fi->inode), 0, sizeof(*fi) -
sizeof(fi->inode));
+
        fi->inval_mask = ~0;
-       fi->nodeid = 0;
-       fi->nlookup = 0;
-       fi->attr_version = 0;
-       fi->orig_ino = 0;
-       fi->state = 0;
-       fi->submount_lookup = NULL;
        mutex_init(&fi->mutex);
        spin_lock_init(&fi->lock);
        fi->forget = fuse_alloc_forget();

