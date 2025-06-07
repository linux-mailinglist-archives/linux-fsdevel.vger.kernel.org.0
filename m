Return-Path: <linux-fsdevel+bounces-50903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFA6AD0D37
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 13:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134E73B2959
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 11:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513DC221296;
	Sat,  7 Jun 2025 11:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOybE1WD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BC41A8401
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Jun 2025 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749297192; cv=none; b=OT0+X0QnigFwqbtc13GWFX1f84vpOL/Xw+20n+WBWdvdBU3elFP81daXorEF/g3cmqSl6xRI0l5P7sJReJbDbO07i3pPt8u2LeXCmXWydLequE0oDc4TWGVmfya1CMVBpqpzrzELkuKP8wPdy6aHlDKkftWYORzS9xU5JT8DZLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749297192; c=relaxed/simple;
	bh=cuuX0Id0LOV2lEQ5WVETIY4YkdPHwVdsAKu3hPK1Iw0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A+fWZ1wVtpIDNaaPiJR+yxcufCKmpBx++gEd99IXpMaw5b10FHrunDmkMJ8hYbWqhfocHLS/+tlipxnczl/cqOt01t/No5ABEaKPV9jPGO8+dtOAfIysqPaSkBaGTXb2F4ZczdWPT4QOn6zg/soSvplokVP8pEUt3KkkOhdkQ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOybE1WD; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so5581646a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Jun 2025 04:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749297188; x=1749901988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eek5dLNXFYTXccdhPGmT+6lfiU6FumUBpZkvmVYNz2c=;
        b=EOybE1WDkrr/RBXNE3XpJtUBjNcF2g93YSXxebB58vOWAGyL9akCkIIk05BcJErsfb
         OTmp/+AcArIIlbtMdvkehI0it5ndXC0ah5dH2x98CpJSAFcUy6/X/9R7Gq4wKKbsupaC
         YduhZNs/BkmjSORJ6GANr21VJVsTusTiH+vM2SiIRZUp3Hjifk3TT3MlngPAfqaq3mMK
         Sv+4dICbgLejrV7GUGpaDJwr5+HMzdVrHbxUjQnI8zUdrVaq7JvvUFlG+LPpF8g6dSGx
         FQV2t2Ozeg8aIwXCaHRo76eU8cCdGE/TQhT3dflgEpjiiFIXwpuEanzOMQP/gN2jqGpf
         /ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749297188; x=1749901988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eek5dLNXFYTXccdhPGmT+6lfiU6FumUBpZkvmVYNz2c=;
        b=AZuwS7fmVZmzSa8EKo1CxTbJKNF7Yl3aFAOEae94VyZSS2ccVLO2R3rQnhvYFvS7Jn
         UkbmaLwLwE7PAd/Kiejr9ud9uOex9axDUiR+n/Jxlr+OD3q18HYqyehWwvtTJYPl35Jv
         QchcYO4CyoupgTSbMY9qJnGOBBYngeekwaCvEth26Y0jJICFPTyhCgXCdK+C1j1IFKwr
         Y860DPI4CYNWSWYAxorO8sU8j7JuMJILulM9lVK+tYgcxNVPmuMEHPTUJVEJ72R9OjmG
         HnRozGOw0J/nyj/0j0UtYcGSWMF3+sJPeAZxmt3ny8/b6ZC7ghH5kCkgxjEoep7hPHdO
         Npeg==
X-Forwarded-Encrypted: i=1; AJvYcCWcU0BOplUtWm42jVbQi7HFoloRorYpfYkUlEGkbsT8P8SO/gM4Yrojk+9mweqEQOTp0XPgmIuI4Wt8hBcF@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu8QTe5zERJmYfHMSyZDvXVkiBRxGT5vUbjVEjVDT9dNDjw/l0
	Ue9Jfx6oKjpEWTFIzTxjepmRLTViMgwzk2PejH/HNZyzzzAWC3sgVhwU6DkzxGrT
X-Gm-Gg: ASbGncvHgjw/vr/H7ib17I3eLWQIsppdU+tJr8rcjcqQjn2FZsOVN24UrkWUbnc6w3S
	8bRzqcBesAuRRBUHdglfadXPfFLFs1+gxRC0V6PxzerM5RjAQ0hE1ceknPQ1Gyk7SH1wkuZ2EaW
	9pKflEXhvTspXTqfK+zOCgDQJM77JC/RRrnwvFCNQlQu4/U7VdgV4zUTSM2kTc3WmX9891EIVhZ
	FOmYHPFoiyxUe24DzHOrt8YhVM2QivosvtBcTQpbH2OSiAKIOkabdY27d4DyJjN2ViUG7zHkFpD
	zifmDVIgrF0KNDxr+I8jHMRZf3oo6QeIrQskYvpTrd4Ak0od7Q/HBZDZIjwGfTkkfB7Xh+taVCX
	tzmZ5YPhelsAiaa1frlbnZkHTixJ5IFyxW1FdC525/A/eqazs
X-Google-Smtp-Source: AGHT+IFY9rezmJ1klT7whwD2looll9s0+4/r/+IYaXN/Q/zHW4cCpspXXLFfKWjR564ncumL/4akXQ==
X-Received: by 2002:a05:6402:270e:b0:605:2990:a9e7 with SMTP id 4fb4d7f45d1cf-60773513871mr5897661a12.13.1749297188244;
        Sat, 07 Jun 2025 04:53:08 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1d7542b1sm264876766b.35.2025.06.07.04.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 04:53:07 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] backing_file accessors cleanup
Date: Sat,  7 Jun 2025 13:53:02 +0200
Message-Id: <20250607115304.2521155-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian,

As promissed, here is the backing_file accessors cleanup that
was dicussed on the overlayfs pr [1].

I have kept the ovl patch separate from the vfs patch, so that
the vfs patch could be backported to stable kernels, because
the ovl patch depends on master of today.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxgFJCikAi4o4e9vzXTH=cUQGyvoo+cpdtfmBwJzutSCzw@mail.gmail.com/

Amir Goldstein (2):
  fs: constify file ptr in backing_file accessor helpers
  ovl: remove unneeded non-const conversion

 fs/backing-file.c   |  4 ++--
 fs/file_table.c     | 13 ++++++++-----
 fs/internal.h       |  1 +
 fs/overlayfs/file.c |  2 +-
 include/linux/fs.h  |  6 +++---
 5 files changed, 15 insertions(+), 11 deletions(-)

-- 
2.34.1


