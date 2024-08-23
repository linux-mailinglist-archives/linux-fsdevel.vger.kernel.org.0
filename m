Return-Path: <linux-fsdevel+bounces-26931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D6D95D350
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43249B26049
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 16:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D5018BB9B;
	Fri, 23 Aug 2024 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfRv4M/z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD0D1885A0
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430457; cv=none; b=KeD32x6L6NuiduvFERl/1t1J0GpsQwlcWQ/wQOuQVjoGkARXMtWqMMC4q1zKLmrfq+jlVYG/aW0rDzI6v82BqWDrnTPQX8bu0YlMWPCHluAvemFgbDl6+bm5pBhFilnhLysCWG3whnC4M+iQatDXlKy7G/iqn2p4I9I34GtkydE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430457; c=relaxed/simple;
	bh=le9DzEXZK+d94SbF0wx0gIV8vueU1Oqh2+pLk2n+KZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iZAsn98LFqFTeHII50ctEw1MkzQg3EtoKm2rMRSihVemsNj0RVXZOzUgM0sbsBwg2iq1ngGBumkGTbBV5szdlQzBd0xY4qAhynD80hEntEoBSIyW2MHgpz7qFcQqkAMgiua+FVqV3al4yVVK5A2M7XJTa0nfiYJs6jIWmq268pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfRv4M/z; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso2244330276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 09:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724430455; x=1725035255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=umgy71U1V/J3mck19jYXO+fhPA+z6Yit1f9AbpM1MJU=;
        b=EfRv4M/znHJX+oedwo+B38esfvx+YoafexVrJ+T3u0sjl5vlt70MLlaV25NfjQfFnD
         8a0eXc+t0uJcB6Qy9uOKxQdmJIh2u0P6A26BALx+DImQaXDKkmoKWA2sCOKT5T4KVEuq
         /48s2/EDYEk0g9Ei1QoFkrsBFZj9wtxdyDRyUTKM/pxg0a80pnOAGC5Zyodg3MrQWOTL
         x76WvzgI56uyVfs1rayMcxjHYIlZ/8QOBetpz0SdI97OKnIQVNCl17IQADf1112NmwP+
         U8fHKez1VRTjCdQ4yyfuUFGnlnJkMb2Uxffp1HX1JOa/moaMMG4wZEJ7r+G1z+RVJGDX
         V2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724430455; x=1725035255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umgy71U1V/J3mck19jYXO+fhPA+z6Yit1f9AbpM1MJU=;
        b=Jgd5kmxgT1Kcwi7rULY3deDk98o+n1S5aulJ5wTmzczb1xKo4LQr+EdaxISONNos+W
         2+aPEVgv/POQ1IwipMjVYab9R+2cjGXY+3EY9Sp+N7PdSYwPcgdKrRF3otxg8DRTrbzj
         9pVFakWNZZxLe3hA0pnN+DdsYe4m4+q5xw2a9r3zrzygabdr/mA37o5Bfmc0jXvdUnwm
         cgiDsvRcaPzwGWkW+wxZBcA9WeRWGQIWV0h84gmnwMMNUG09vYg7/IrcDXvngv6qjuSJ
         JkJCj6U3CrwgQi5/nrBrttDoNex6v3aGAFKHJudRnqbE3K44pCl/vLeK/Ad8+SROR7Kg
         y98w==
X-Forwarded-Encrypted: i=1; AJvYcCUU0iOiSxBrNTMk2Dhj5Eikn/TcYzjariH3EhyRJf3S5bLwvMOyb7KNTacJW7XQ9VAzk5q9D0uq+BDVpemM@vger.kernel.org
X-Gm-Message-State: AOJu0YzphTOLwamQrSmLQBXCoG/ukogHiWypEMRQj/CJdz+yJz8evg9L
	dSoB9ZS/8V75wVOeqtjATRqtl2BQUWRObEIcXDFC38svdNFZpxRy
X-Google-Smtp-Source: AGHT+IEgPdTC5nzL2TObVYgaXZVfIjSjq2v44QfhVyni9eWkbB1OYvjmn0mwer3vhp7XwRQlf2HSHQ==
X-Received: by 2002:a25:e0cd:0:b0:e17:bb87:fd06 with SMTP id 3f1490d57ef6-e17bb87fe00mr642130276.49.1724430454930;
        Fri, 23 Aug 2024 09:27:34 -0700 (PDT)
Received: from localhost (fwdproxy-nha-009.fbsv.net. [2a03:2880:25ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e4bd277sm740262276.38.2024.08.23.09.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:27:34 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v3 0/9] fuse: writeback clean up / refactoring
Date: Fri, 23 Aug 2024 09:27:21 -0700
Message-ID: <20240823162730.521499-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains some minor clean up / refactoring for the fuse
writeback code.

As a sanity check, I ran fio to check against crashes -
./libfuse/build/example/passthrough_ll -o cache=always -o writeback -o source=~/fstests ~/tmp_mount
fio --name=test --ioengine=psync --iodepth=1 --rw=randwrite --bs=1M --direct=0 --size=2G --numjobs=2 --directory=/home/user/tmp_mount

and (suggested by Miklos) fsx test -
sudo HOST_OPTIONS=fuse.config ./check -fuse generic/616
generic/616 (soak buffered fsx test) without the -U (io_uring) flag
(verified this uses the fuse_writepages_fill path)


v2: https://lore.kernel.org/linux-fsdevel/20240821232241.3573997-1-joannelkoong@gmail.com/
Changes from v2 -> v3:
* Drop v2 9/9 (Miklos)
* Split v2 8/9 into 2 patches (v3 8/9 and 9/9) to review easier
* Change error pattern usage (Miklos)

v1: https://lore.kernel.org/linux-fsdevel/20240819182417.504672-1-joannelkoong@gmail.com/
Changes from v1 -> v2:
* Added patches 2 and 4-9
* Add commit message to patch 1 (Jingbo)

Joanne Koong (9):
  fuse: drop unused fuse_mount arg in fuse_writepage_finish()
  fuse: refactor finished writeback stats updates into helper function
  fuse: update stats for pages in dropped aux writeback list
  fuse: clean up error handling in fuse_writepages()
  fuse: move initialization of fuse_file to fuse_writepages() instead of
    in callback
  fuse: convert fuse_writepages_fill() to use a folio for its tmp page
  fuse: move folio_start_writeback to after the allocations in
    fuse_writepage_locked()
  fuse: move fuse file initialization to wpa allocation time
  fuse: refactor out shared logic in fuse_writepages_fill() and
    fuse_writepage_locked()

 fs/fuse/file.c | 169 +++++++++++++++++++++++++------------------------
 1 file changed, 87 insertions(+), 82 deletions(-)

-- 
2.43.5


