Return-Path: <linux-fsdevel+bounces-28348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51941969A51
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 12:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB631F240CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 10:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EDD1B984C;
	Tue,  3 Sep 2024 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Tzkqhswi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B461A0BEC
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359909; cv=none; b=PxRGbavOAHoNbrIPxyVMRZgk1ZOM3fJcKHW31OUcGZqAyBnmv8Izrviz3Ni3JB3UTj5Wcfn8Aun4xUjU+jFqQu+YGp/jY+J+BidC4k5F/q9xOwZ68qDgyiyiKtT32ZRxNKH/97W2gEGZ1Ypk7XoOQXrqH/M/uhgZ7914KKzrzqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359909; c=relaxed/simple;
	bh=IpGzSwq01bG+uYW7sy64WUAjjUCeEmCuQYp+d2Un/3g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=adXT/s2gB+s17ro3Q1/BRzFdGO/yCxkldtS47diVaSJfN5ApiUyEmO4pLrADllFap6lzdU0XzFiuS8LtjI9beXO42aQ8tOMYfwHbqMRV48fS4OvsmBBqXxbrkXWBfDEAcdpiEb35Kaq6I1Mxsu5jhOdEFa0VrWC8+/Na4VqY1UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Tzkqhswi; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so567497866b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2024 03:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1725359905; x=1725964705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x6Q3eYsITfxnypFGe3Fw8XAGNfc1A4gIAvgZwhL1hhM=;
        b=TzkqhswiJyPfyWbn17cwB069DGFnsjSBtKg8sadpF9TKTq6Ckj9poG6UTDt3+j0j8p
         MduwXVv4ChD6/QgIYaZLPuxLmR2qSA4YiwrXWMB7iss7D6Xv9DHXi6moZJbokt6CDvtv
         wk8C0xNM3U5qMX7Aw6gqAkkKizYwfhJ7VO7fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725359905; x=1725964705;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x6Q3eYsITfxnypFGe3Fw8XAGNfc1A4gIAvgZwhL1hhM=;
        b=aNqo0dK0hBHw/CvUtx/vDsOJyJhkZ6JglHaXL8VDf9A6FXxSgvAoaabGBvC36+EWBH
         jgAh+OLZlZTJJThLGF2BN0B1UWW9J1WWUstZTOlogzOnQs0KB4wwvPXWijJh9BESP8BV
         rPBFC5uz+DY15l9Z6W3o5SZZdddZ+44ZSe6RaAPJ+EGylkebX95jWH29kaA2ngGcpBAc
         KwHm8/eVMheLbpTpQkTcn0LozBiB2Z3P3ype0KVwJUGwxFU70ff7XzGgzVw2p2xksb/Z
         lbk1yAby57qerYiJeuMVdJGuqE3xNPAMypQxZL7SrZWVbEDCBL5LAV27WXzBnN6Tl5hi
         zQ2w==
X-Forwarded-Encrypted: i=1; AJvYcCUK15h4ThgGIjKD8TFfCPAo/zS5GFWGABGHq+c6MXefVWIhB7NCD5pVlWagXqAR6/t3zC8srcWeMr77pRf9@vger.kernel.org
X-Gm-Message-State: AOJu0YxLZcJL9zm5dmBEQuAo3axwUiS3fmrq4dcx/mfuOlm1a+mLCJTP
	4JR2Ly3EoL3iTKPnwE2l9Pl5svndHVkZLzkok2kA9s73+RU3X1NtdyLy7mvLzD6C1W91pSd+M6q
	s3szr4uZDA8dT9VtI23zgZfs/EDso9qam2D2ZTw==
X-Google-Smtp-Source: AGHT+IFyKzm67wu/yuibz5w2254/bwCWTDvbeXT90It4zB3i/dkPa2pncQBbDsLbh40dWyLfuTt29muGncb2pj61WDo=
X-Received: by 2002:a17:907:3e0f:b0:a7a:a5ae:11b7 with SMTP id
 a640c23a62f3a-a89faf995b5mr469332766b.49.1725359904279; Tue, 03 Sep 2024
 03:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 3 Sep 2024 12:38:12 +0200
Message-ID: <CAJfpeguT0XBxBCzBrJqS1LLCLmEahVT3FF0NZ1nkAKMRKWpyfw@mail.gmail.com>
Subject: [GIT PULL] fuse fixes for 6.11-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-fixes-6.11-rc7

- Fix EIO if splice and page stealing are enabled on the fuse device

- Disable problematic combination of passthrough and writeback-cache

- Other bug fixes found by code review

Thanks,
Miklos

---
Bernd Schubert (1):
      fuse: disable the combination of passthrough and writeback cache

Jann Horn (1):
      fuse: use unsigned type for getxattr/listxattr size truncation

Joanne Koong (2):
      fuse: check aborted connection before adding requests to pending
list for resending
      fuse: update stats for pages in dropped aux writeback list

Miklos Szeredi (1):
      fuse: clear PG_uptodate when using a stolen page

yangyun (1):
      fuse: fix memory leak in fuse_create_open

---
 fs/fuse/dev.c   | 14 ++++++++++----
 fs/fuse/dir.c   |  2 +-
 fs/fuse/file.c  |  8 +++++++-
 fs/fuse/inode.c |  7 ++++++-
 fs/fuse/xattr.c |  4 ++--
 5 files changed, 26 insertions(+), 9 deletions(-)

