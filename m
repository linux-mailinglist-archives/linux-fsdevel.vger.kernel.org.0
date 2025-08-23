Return-Path: <linux-fsdevel+bounces-58870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DFEB32626
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 03:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F370A05794
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 01:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9855C19C553;
	Sat, 23 Aug 2025 01:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kH8RMLMG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1991991CA;
	Sat, 23 Aug 2025 01:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755911634; cv=none; b=IZienuAdJ4xdsmyPjDS+Z6PndHcmLwEiow8xTxrWqW2j330gLddADrEeL8/5rCYCmDVLcV14PAV18UgiDHW08hqOEpQmM61iIfduYLzjdxw5WH2btbgRZaNoVFuWXHLyD9Go79tCuSEi6LismFt78HZDw5R8RZ8PNr89mzVxenY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755911634; c=relaxed/simple;
	bh=YVdoctcN+sBLlB3ATTxVT2x+pbYz16y0zZVCJswXHjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5aYkIm/P9WUQjADgDhPn7kIk22zz/jDQ7fqfQfoIg+UeyUoqN37JvyHXkgV/GaGGCytcetpi9Ykjlv4wr86vZetU2xJzkUjA7hMf1YmD0vimDJ97sk8m4j9j0NqGIpSEc6Frk+BbwZO5UQKM1RQ3APLjsAHGzYUoXSioOtE/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kH8RMLMG; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b133b24e66so20584691cf.2;
        Fri, 22 Aug 2025 18:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755911632; x=1756516432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KElVxybZfgeP8XY/4ZhNJAL4TJBTMTr+Odgn1YjwqBM=;
        b=kH8RMLMGYhvNBND8T592R7Mcogqy8ZyUvcwCo0Q1f2gnL6BELOJiqA0hnpEVYHih8S
         SS7AvoRfzQE58aSND9bsK15j7nr6afZyisnmnWfccto0LJ2Osrir5QKbTiSNGIRuzDgI
         X9ZTx7kOZ1HqHa6WNPhdiHiJjFRFdDQZL7+PnJlWvX2me1X8kpSU/ggExF/Y1dLfebdF
         pEl0JOYcLk+4DFzx9XKM7ve9cIe/Ye9m+bEaVWlCk8KZ/BkWF11855VHDljOFxDBNlnI
         2ZhuQbuQrEICHXfoZ1V3s+t52XV/yKHUdghGvNRi/7mvdPLLJB8jeWSoCV1A0FaKzgyK
         zcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755911632; x=1756516432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KElVxybZfgeP8XY/4ZhNJAL4TJBTMTr+Odgn1YjwqBM=;
        b=mm12Za/dHz8dJJln6ClUbsLwO1j6OdNpxIwk0UvEqOwSfZ+3r4tL2eY6XE7pDtpYWn
         6qvT2dWMs0TKPa2iCNUF7uU6HNPrdYqpEj+tQO5UQ1Y2G+ioqzU6L3U6G6EahcoOCqYn
         Pcy5oujcbd4pG+J210gwsQrvmOBriNkGT/mxt0meu60rPlJyyt2Cb44mUjL/5qKoHO9Y
         GLWjzbFxYYmWmItve9FaahYOfAkuT9It6N+/POIle8CpvqfwT1asx2qMCN7MlHZ5wMPa
         UajE0sKcH3IwNzBeA6lPqpZnAXNZL14tvf1L+RdPFuBVs/RccHW4l0B/3PQSGMVavrPr
         FDCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6u4FlUCo14/SJVAQnQNUXqkNvJCmt7AILKXk8d7sQVM4L9Gr3iwLRi5A/Z1lu0J0XlzKKFUEwC60dmfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws7/pI9yy6H5BI2/3MtLiigqUKj43ZZdc62zebMxsSeiUuOQ4t
	8yAjrMs4z4H0I6CsM/nFtoEnpOT4QpzapMcLWn/9vRF41kWvD3Oulw1l4h8lsKrMKzzmvBCflG3
	a/APonQ47CmDouTfnKku7NuI96aheztU=
X-Gm-Gg: ASbGncs0XziK2VcUmX0vC4SjrP3wAZM4E2qMXSvC5KtDABW40zJD51c7Fn/5kfo6I7i
	lS+kJEmxB0hCdF+T6vJ7YKfaFVFOIMWDHwGKjK72DcUAhnKBHW+/d81xOEBb5Bxd/S1OJ3mnBkX
	uABVea+2l4pPItiJkcRqjzqcBs8GttNjXWvwbnhVSzTmwwk2tHZoSjsKK81k8QCFksOiXzQyq4K
	X/527hSFADqKa2wH2E=
X-Google-Smtp-Source: AGHT+IFcjp7QQ/odZxGauu+mzp49jt71QsGNfiNq/lI88r6TmV6tR9rQUoypMqW865FmGR9rUahMDJYkjBOxvWdLD44=
X-Received: by 2002:a05:622a:5515:b0:4b2:8ac4:f08e with SMTP id
 d75a77b69052e-4b2aab2b995mr75090931cf.76.1755911632200; Fri, 22 Aug 2025
 18:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1bSD+HfwLqbFv8gsRsPt0kRsr8JZcEXdqBWuKh2Qnz_yA@mail.gmail.com>
 <68a91168.a00a0220.33401d.02f0.GAE@google.com>
In-Reply-To: <68a91168.a00a0220.33401d.02f0.GAE@google.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 22 Aug 2025 18:13:41 -0700
X-Gm-Features: Ac12FXxF7i427SMTeJeGjZ1IpuCRZXZWX91V6g-W3Tg7hLiH_aRXdPxI6_yiiKs
Message-ID: <CAJnrk1Y1UJ54+4kjHvfJvjh2Dp1J_vVJVGmqfh04zoRFDQy04w@mail.gmail.com>
Subject: Re: [syzbot] [fuse?] KASAN: slab-out-of-bounds Write in fuse_dev_do_write
To: syzbot <syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 5:55=E2=80=AFPM syzbot
<syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> failed to apply patch:
> checking file fs/fuse/dev.c
> patch: **** unexpected end of file in patch
>
>
>
> Tested on:
>
> commit:         cf6fc5ee Merge tag 's390-6.17-3' of git://git.kernel.o..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db7511150b112b=
9c3
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2d215d165f9354b=
9c4ea
> compiler:
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D116eaa3458=
0000
>

#syz test: upstream cf6fc5eefc5bbbbff92a085039ff74cdbd065c29

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e80cd8f2c049..e84e05de9cdb 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1893,7 +1893,7 @@ static int fuse_retrieve(struct fuse_mount *fm,
struct inode *inode,

        index =3D outarg->offset >> PAGE_SHIFT;

-       while (num) {
+       while (num && num_pages) {
                struct folio *folio;
                unsigned int folio_offset;
                unsigned int nr_bytes;
@@ -1914,6 +1914,7 @@ static int fuse_retrieve(struct fuse_mount *fm,
struct inode *inode,

                offset =3D 0;
                num -=3D nr_bytes;
+               num_pages -=3D nr_pages;
                total_len +=3D nr_bytes;
                index +=3D nr_pages;
        }
--
2.47.3

