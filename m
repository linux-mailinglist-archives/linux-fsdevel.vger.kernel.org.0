Return-Path: <linux-fsdevel+bounces-41843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8B5A38188
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 12:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52295173453
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 11:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38974217F20;
	Mon, 17 Feb 2025 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="is3vVwPD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95897217671
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2025 11:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791105; cv=none; b=Q2Iq/mQ5SHJhjSbWpFas3mpPqxbn4PDfj0y9s/sLmOu8hbk4Ttdjo5zjSfH+M03eF51ucAQXeo99idW0SS6vr5xLgoOUmqlfa1Z/1hKJ7ZLcBYuEKHvyIY0J7gS8/0Lq8e8G8NwirhIxb033TdJqy+BeqS0TWs7ipuml0KQ+43c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791105; c=relaxed/simple;
	bh=wak+BhcJwK9zuSbMS9HspnnFFG5IOygNwgHh8EOhG3k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mYiWvCXCCPXxqwa2SbNMzIGE7mElI3bPVjmvLNo/YD3UTC99SNWc6kxjHZjvE0WeoSW3GGEQ150MBGENSzffgPEnkaCUgqo6OP6l7LJZzNzY9nCwpjw6GndHBHKVX4w90iu3iolsoLtsKHQwAUZzOcI1IgnSkRbCQQH9MJuDA9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=is3vVwPD; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46c8474d8f6so36739811cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2025 03:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739791100; x=1740395900; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v/3164v73rH1650L+HLN7xzBvg4oufwr9+fusycb+9g=;
        b=is3vVwPD9D3XQsuCLf8R7cfsFyeSRZB2BOCgILt1MsDjk2s60tYfOcT4i5jJLjUaUf
         efPzsiG28WlH1+R4soM1myYPi1I3+mefBivVhag/Z+MrXbBDzKK/2V+GBRS9b+BubLF4
         FNa0t4as6W/TKkLR6IeHFqqduZi2KixUMyjfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739791100; x=1740395900;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/3164v73rH1650L+HLN7xzBvg4oufwr9+fusycb+9g=;
        b=Y5OhPC1aXrVaJv90yEN+6UIr5K1tYXkN/1cfJIIqZJwvvwKVsMf8QI+4LFnp0mK9OK
         OW5I7aJ28SXnNfUbjBpEDFNk4rkARQ8xiYsi2izTE1Dqt6I0bblJQCebeDKWWGCj91Bj
         3vhEWNdfGTiLyPq1YFU9TMU5oNSSiVEQ0tzDMO6yl/psShFcy7imbYb5Cuqo4nDfJyw/
         Cet6Ef7K5akaaNGPKPdJ2xd3YivZjEk53nXVReSSRm3BdJnSJ3odqKU1NdMATFDR647I
         X1unNBtUMZpBsdW4CPFuvb426DJ7ITT+Vys2Moi7EdnsZPJAkBywR2LipoUin5gUQ1ek
         otdQ==
X-Gm-Message-State: AOJu0YxsPaH2m6yfC5xaOCoLZV9WC075kidPeQTP22GXgK+92qes6t8z
	t/XdIkvxWWoxtgYML1w7gHens327WK5UVTQKLwOTRV8Np2MxAVZ2117LmdFjmgBL+z5E/vFLUJE
	0mOH/OLSElXIV+8F57mYAqfZMKe9vXXGxLsrc8qMQerq5hbaumss=
X-Gm-Gg: ASbGncvNVA08pXiYZ30bNo+w4QwoulxRRlVm6Xc6LDjf+6uxssbtKGVhsXo+0xNZeqM
	obXtcMPwKt1fkqiQhX9qlCfoKTq6bTzw2p1nYD0Y6QGQ0X1zEmI3oPWHLjnSYWYdTFwh2qpM=
X-Google-Smtp-Source: AGHT+IHXQFIU9QFNrGFiphXIDGfZEeuLh9O92Eht6EZ9nJZXMuRdF4FiwBD80G6kZfayL9yMCrJU5ySxhEOXml6H0OE=
X-Received: by 2002:a05:622a:1b1f:b0:471:99e9:59cd with SMTP id
 d75a77b69052e-471dbd21f95mr127018121cf.19.1739791100111; Mon, 17 Feb 2025
 03:18:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 17 Feb 2025 12:18:09 +0100
X-Gm-Features: AWEUYZlxpIbG32ytmLucfyb-lsXOSQhRPy4NzKf3Odmoq3djjwwuMTtUIPoDzDY
Message-ID: <CAJfpegv=+M4hy=hfBKEgBN8vfWULWT9ApbQzCnPopnMqyjpkzA@mail.gmail.com>
Subject: [GIT PULL] fuse fixes for 6.14-rc4
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Christian,

Please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-fixes-6.14-rc4

- Fix a v6.13 regression in fuse readahead, triggered by SPLICE_F_MOVE
on /dev/fuse.

Thanks,
Miklos
---

Joanne Koong (1):
      fuse: revert back to __readahead_folio() for readahead

---
 fs/fuse/dev.c  |  6 ++++++
 fs/fuse/file.c | 13 +++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

