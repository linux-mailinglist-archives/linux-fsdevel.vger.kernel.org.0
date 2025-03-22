Return-Path: <linux-fsdevel+bounces-44791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 127D2A6CBBF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 18:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92AD1893785
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 17:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9A4230BE6;
	Sat, 22 Mar 2025 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuXwyKu+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAE64D599
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Mar 2025 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742665991; cv=none; b=C0hUDECfYK7073lRjPQYI6KywzFIty84W/3xNi8C/90adIPylCcw5gje3VtVpeYk1FlLXzRu5h2RjfAAM+WTMZyhjoQYb68mzUC84mNXft4C1XyaUcDpjxG8QwmAF7lW57gTN50D/ljQ0NMAoHUYBbOwWTUyf1C7SP0FsRGgWcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742665991; c=relaxed/simple;
	bh=tmtEIbsWyNywcdc7xXNKcatnpc3yUWgEIBW0lF0HLpM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=d2Vx3dT/EfBlYJELjUY/6CNMdho/lmRqbVbUbf/sgdw1M2uL2jrFGE++hPBE8WREaHt4lgTG1w1Es3OAVxgGKnUiSpoHsr6tVEEIoApVtwS+35ydAVGFisQTFjWhiEru0DbJUzq5hV2S+YLqAr7F/UrUxWBUkq/xo6eNxl+oqfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuXwyKu+; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4769bbc21b0so32546671cf.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Mar 2025 10:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742665988; x=1743270788; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PBCKG58OWbq4NvEZOol9u+x0f2IAGLNFGfS/6kDnnOs=;
        b=AuXwyKu+cmWcKHncmThmP00sERKaFrKytG35hVRtLG4R7AfPyt+xgGs732DIKwVLdl
         alCeEi0iKW71VjNKwTRCQn8Lt+AA1izbgJap1HWJ7QlyWhD+eJNGKySWAz+/pfA2WByp
         g1LZl06ZhN48TKBYByq/5FLyXMn/k1iwZ0MxnEUq9yQRAqjK4agfcwUUI8DyWe/Zi9oG
         fscCMgDUI+1d6GyE0rCz871HgBQb2m9qVtTErfCTElrDGOL+ZOz/6L8NBp//WyP4yMxT
         7Syd8l6wUrrS8C3/qrPqYjwX9ClhiY8KeXqfxQz2SicVbHEsW9KaMv/ivPlYyejx4jwg
         wuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742665988; x=1743270788;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PBCKG58OWbq4NvEZOol9u+x0f2IAGLNFGfS/6kDnnOs=;
        b=T7U6EInFP8kk+PkCvTIIXLpC4BgQQxC1trPY4c91jWXizpghXqS02IQTn4gCJaFgAj
         pc1Ttqkb861x6dh2LFSATNA2BsaKfNuc9FdbJ/awKUBezC1rgCy+fHz7BxvwuZ2XmLrF
         ctNZuA3Hty438pncWH0/k0ZRxrbJeDkZOMbhE7L7jzPae+CC2N40ZlVyzdC7WRdR99i/
         K/oTBu4YJoU1tiLIdUsz6NQWulFEL/snxVF4bSD+/hEQtMx+g2mF1naf3TqlV/Bb29hz
         X1kT3B4Au9Q8Hy5zBuaj1LnYH1Ndg4SNWkhomcDBq2uXDBKadPh2alfQoqVHMUoqbaa1
         Ty9g==
X-Forwarded-Encrypted: i=1; AJvYcCXF5M4nRV5gnqfKS6P0FDTcVkHA6ViAhGxDLlngidloagGP0PBk1LQUCOuds5zbmcv64U5GqlZmHkZ27t8C@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjtmjqk4kLE5I+k/940Z5XVMH7agsfdTWBMqCz3WuvQM9KduCi
	MaeCrMIYtyLeBdsAQyFOGIDTuL/G+HQOKLl6g8t5yxx4O9ADNuvjT0b0ww6pTJaet64KDlFrSYb
	jr3UAJsyccThnJzdrS1b8aTdwbHrrlrlR/1gG9pT0
X-Gm-Gg: ASbGncu6YPOJF//ajHxKN1YMwiIH13IagbCJvYYpQ1p82jN8TU6QLFPh6RyTWqfuf/2
	yLYKUIcJDbuMDrAhWfcu2tf1NTtQGaTPCV7zsSJmKUFzSqcckmlmbjhkWUeT6tnSCyxKoVwO0IW
	UIFzCU3RJNimILZ83Vk3c1D3dRZ47tqKV+lEPs
X-Google-Smtp-Source: AGHT+IGKK3NV4bw7gpIlEDbh27zEF4Gn+ZrEB8R9BgsJQaz208yDYG9AhP01a8FuE9lZ3805g1ZbUm04iE5GwYxdvJw=
X-Received: by 2002:a05:622a:4c12:b0:476:9296:80a4 with SMTP id
 d75a77b69052e-4771dd57f2dmr102326501cf.7.1742665988449; Sat, 22 Mar 2025
 10:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Date: Sun, 23 Mar 2025 01:52:57 +0800
X-Gm-Features: AQ5f1Jrp16QlfX2NcM--u10pTmWnZ6Q-G-eiKeKZdQgh0QhR53jQFg-Ds2gxi7c
Message-ID: <CALf2hKtnFskBvmZeigK_=mqq9Vd4TWT+YOXcwfNNt1ydOY=0Yg@mail.gmail.com>
Subject: [Kernel Bug] BUG: unable to handle kernel paging request in const_folio_flags
To: mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	ocfs2-devel@lists.linux.dev, willy@infradead.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

Dear Developers and Maintainers,

We would like to report a Linux kernel bug titled "BUG: unable to
handle kernel paging request in const_folio_flags" found in
Linux-6.14-rc7 by our modified tool. We have reproduced the crash and
applied a patch that can avoid the kernel panic. Here are the relevant
attachments:

kernel config: https://drive.google.com/file/d/1vHuHlQyiKlXbyuo03sZTiuaA5jZ5MtV6/view?usp=sharing
report: https://drive.google.com/file/d/11LD1uFid1u3r7brsvd85-SrBzvXwH-w2/view?usp=sharing
syz reproducer:
https://drive.google.com/file/d/10v3FtkewHcAnTjsUGqFCDl7k7hiCJ12-/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1L9WTVbO2pfqXLjXyQcMy4f-Am3obTJcN/view?usp=sharing
crash log: https://drive.google.com/file/d/1zwYU3061pnTSVIEpuZ-EBR7FYvWPxX4z/view?usp=sharing

We speculate this vulnerability arises from a missing check for error
pointers in the array folios[i] within the function
ocfs2_unlock_and_free_folios(). When the kernel fails to write or
allocate folios for writing (e.g., due to OOM), the wc->w_folios[i]
may be assigned an error pointer (e.g., -ENOMEM) in
fs/ocfs2/aops.c:1075, which is then returned as an error to
ocfs2_write_begin_nolock(). Within ocfs2_unlock_and_free_folios(),
there is no proper handling for error pointers, so the function
attempts to process folios[i] directly. This results in the kernel
attempting to dereference an invalid pointer during the call chain:
ocfs2_unlock_and_free_folios->folio_unlock->folio_test_locked->const_folio_flags.
Specifically, during debugging, we observe that the kernel attempts to
read data from rbx+0x8 (where rbx = 0xfffffffffffffff4), causing a
page fault and kernel panic.

I tested the following patch, which prevents the kernel panic by
checking for error pointers before accessing folios[i]:

--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -767,7 +767,7 @@ void ocfs2_unlock_and_free_folios(struct folio
**folios, int num_folios)
        int i;

        for(i = 0; i < num_folios; i++) {
-               if (!folios[i])
+               if (!folios[i] || IS_ERR(folios[i]))    // or use
IS_ERR_OR_NULL instead
                        continue;
                folio_unlock(folios[i]);
                folio_mark_accessed(folios[i]);

However, I am not sure if the analysis and patch are appropriate.
Could you check this issue? With the verification, I would like to
submit a patch.

Wish you a nice day!

Best,
Zhiyu Zhang

