Return-Path: <linux-fsdevel+bounces-59770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 698DAB3E024
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 12:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E668D189DFD6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 10:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89892494F8;
	Mon,  1 Sep 2025 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="U0YT2dDU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0693B24291B
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756722625; cv=none; b=MykZTy7YnnReoRONqB96eqDHJFGZVbQxA1n3dw4SJH/iaj3ufOXs4rcWhfr4pT5+zSdPif74+CuExkk95XjS8kD0PQL82DAbje6mRyl3NtR6/TQ8NupsM8797rnE8pN0Yfc2bPB6CBxfTGZa+pLUVN6HbyJ6qWG7yIhI4J/uy3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756722625; c=relaxed/simple;
	bh=KW13pbNW6Vv8Ihl8O3Oqsu5K5Wxu6cMp16+gzOLrQb4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gJR3+waS83wxLKNzjKEhxaZAVNvN90pNAxq0caNBxyON3l/73GHUKJR4XMD9JMQ0mK61sMpqkAeTo4m4IAWVvaVVUNsg3063qpkuKHbOT7EP2Tr7tVZLKYA5DPpWCWD1ngN9fJu72YBq6vc4AWlRqPxTGT/Qrnp45JcShVMLOp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=U0YT2dDU; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7f8ea864d54so386208685a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 03:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756722621; x=1757327421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tSMZxrvlVebn4Lgdc99RUi1DutqM985mnloKk4c7Guk=;
        b=U0YT2dDUnMD3yvfy9RlM60S7CFqas6i/PNPUR6JZH/6TLAkKe7uPgmOuZR1pcWd9Pc
         IetpEPHo6HmEU/bDO2oMZl4dpSLrOQpMJ55xS6xjvEKrKNka9fcGW6fiTiJySzeFZCX7
         /AU/mY4YLSvqkLtTYgGXYg2qHd6Nr8e/nEe2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756722621; x=1757327421;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tSMZxrvlVebn4Lgdc99RUi1DutqM985mnloKk4c7Guk=;
        b=vphVQapRdEyotTg8Hj0KX6HNDdyyo4RRzAOgJ4DQAbRP5aOcbvkLY/TsmePBqDvSEI
         MnpY5CmEB/yk//6s/8yS+74R59bLiirA+kxXtt9AbeduZgWP9W+3jkS8wSjPnQLeaz1l
         IjTG9DuGG3jTsnChZx2O/eolQsmp+PFCU521ct+W0zskN/49guSlaV+EerCohPPLWenp
         uYMKu8N+lxHT1tIjQWx9U2g3gSQxaSoemexTIXh8zatYyAWukqRqk88a7nRJ3SINMsCy
         o2MWBKi+G2Iny0W+VfAsOGQjMQEQKBNpbKY7WekjKvOtrSdSZNbgkLXtHptpN5qYFpSZ
         CLBQ==
X-Gm-Message-State: AOJu0YyaC+QKnMkseby7J85h2sD1EVyxiYNAk+Pu4XjIKZxNpnk6kScJ
	hkrdxvjWJ6CNMAAZ59FoAbZm0fjQ23Nnlw89FI5Q/ekus1szLYxLk1sCSN4X4/IlWXZsOi+6n26
	DpA+XP+ljCsmjsvivR+5t01IdeaNc4g/t0bIfM9uaMg==
X-Gm-Gg: ASbGnct7G8Lj0N0LGzX+1kumU+qvzHlK9XtkHnAf7j7RXGbSlhLj0VGDhqu7lFkGIM+
	tFFgazuHGNuy7DdPAtJWmautRdc2A9Ff7tk5Pmd+fX05B4xBaTaPhgNDBcEOdW8o7h4e/RWL1eT
	0ihH3QX6K8KDHh0+MENBF2Mr+Y8/7oFOF8uYTrrSgtwFdJKcp8sSzo90jo99e/mnAMHpOujx/1c
	96yA+XseQsGWpPceAz4Jm6lJW+4GIk=
X-Google-Smtp-Source: AGHT+IFF5HpqDOXuHs//h5pcaM3Cb+V9eRPHgoWdVF2iaUZDEj+EbwyblF0yVsQ6RbLmNYRe0jRRgyxQHTHuBgP/8Kw=
X-Received: by 2002:a05:620a:4105:b0:7e6:9644:c977 with SMTP id
 af79cd13be357-7ff27b1f7d9mr820358885a.27.1756722620686; Mon, 01 Sep 2025
 03:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 1 Sep 2025 12:30:09 +0200
X-Gm-Features: Ac12FXwwXOscVfEh_b00oFPmh-dX0LZ7NPAbCZS8FhxDyb_r1n0NUdk7uWPXEIY
Message-ID: <CAJfpeguEVMMyw_zCb+hbOuSxdE2Z3Raw=SJsq=Y56Ae6dn2W3g@mail.gmail.com>
Subject: [GIT PULL] fuse fixes for 6.17-rc5
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Christian,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-fixes-6.17-rc5

- fix iomap partial writes (Joanne)

- fix possible overflow in FUSE_RETRIEVE (Edward Adam Davis)

- only allow passthrough for regular files (Amir)

- fix copy_file_range overflow issues (Miklos)

Thanks,
Miklos
---

Amir Goldstein (1):
      fuse: do not allow mapping a non-regular backing file

Edward Adam Davis (1):
      fuse: Block access to folio overlimit

Joanne Koong (2):
      fuse: reflect cached blocksize if blocksize was changed
      fuse: fix fuseblk i_blkbits for iomap partial writes

Miklos Szeredi (2):
      fuse: check if copy_file_range() returns larger than requested size
      fuse: prevent overflow in copy_file_range return value

---
 fs/fuse/dev.c         |  2 +-
 fs/fuse/dir.c         |  3 ++-
 fs/fuse/file.c        |  5 ++++-
 fs/fuse/fuse_i.h      | 14 ++++++++++++++
 fs/fuse/inode.c       | 16 ++++++++++++++++
 fs/fuse/passthrough.c |  5 +++++
 6 files changed, 42 insertions(+), 3 deletions(-)

