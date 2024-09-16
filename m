Return-Path: <linux-fsdevel+bounces-29526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4E097A750
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 20:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4C228B51B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 18:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD6C15B572;
	Mon, 16 Sep 2024 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avePzGF0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C0513211F;
	Mon, 16 Sep 2024 18:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726511177; cv=none; b=Emd6hlJ9gKEx3YZEk3aHxRHStJxgzpIT9QvJlnhw4imhjSdfxtU6YtCv71wY3VDj/tyrD7f0pXhiK5vGb4W7LqFoXkj0VGxa4bLqFF/2mUfbCsz0XTVHQngkOuHcS/J7ijvSKdwbjZ07+Kgkk+zEJ+Uv3voOplTTVvzc7zbzjyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726511177; c=relaxed/simple;
	bh=v56YRJJZy/wRNHZbG1ywnyqgE0PluUV7/SsL50AVYqw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZqeA9MpHtYYDiFgObDLmzQjJldDfnQC/0pf/igGQjO1hkbAUNOh12NTGGy99NjtFWWf7OSE2xMxH07NfkTux+bd+gOXuNPjbzlW+4qA6JPgafBFY18KTrpPXk+leS7wBRfUvIu0HIF3HFnfnYIUru1GqO3mXWmmh1mgV5MeWdlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avePzGF0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8ce5db8668so832611666b.1;
        Mon, 16 Sep 2024 11:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726511174; x=1727115974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aIKV/f4fmNN+xl9ScoTPdS6tXhDJDmlBWNBiM5jjZOk=;
        b=avePzGF0ni1+fZ9BsQrzpcUdAtONSXLWU62BnQJ+kSsa8nmhZcExmk6py0FsKe2wgj
         N37LDVq1fcgyMSsihdYTZZy4wICmjUncVeqi9sSrqcl4/uQe/RYCnRa8eumQgWifRUxH
         YZA/G0stIohZvJpXfvtb+PKhpfy/9kv9ZqJqMOfx/S6oKzsftFD3Q82f7BjqIBsMfK2h
         GMS3M5NVBGuFhH6gwwISrEA8sjx+VCKnPXS6V8WWqqyNpgIq9esNlPAYbZDWj4vGD0Q7
         TNICaXT3Ixiz0z5vy1j2D9m1wD5GUHPGUPH70cLMP0KEdhXmvHeTUd65FdR0qp+DES36
         JsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726511174; x=1727115974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIKV/f4fmNN+xl9ScoTPdS6tXhDJDmlBWNBiM5jjZOk=;
        b=cmm+n6AHW0DNxAl+Km0Z6A+6X2DafANhDJeaIZBR6w2yqPKlrK4wYY/gqEIdcOcsKY
         bw0EheJOzZcVY8e2IFaI4uiv3B8AtcpR3RdyIABPFe3twApTYEocPC5zXji7uo6Kd2GU
         RLzlvRH0TEM6/mSe94Xa8ONoezl8D4bFS4BwlLnN1BxAXRaPgw4tdVQUUGBX5FuoUtmM
         sEfd5CnvStanfNv8GLBAkIWrM2m25r/hUnEelVlobGM0eazXXQHmw6DNkT17orAFnZQv
         fmxxAYW6tbPqgcPhHmq6NflY2n7afGi29eWCtm0/vbKasUJS/6NIVKUdC5jB9GyioP6I
         iFEg==
X-Forwarded-Encrypted: i=1; AJvYcCVVejVcOnOJ/p4EtEbotH/WlPe7BcaTlUXAzs44MLtvMG8WL2z8KiXFub2O3dYfQ3RWj4sd+ueETJFQ82JU@vger.kernel.org, AJvYcCVellwzOaSIjijxTJUkwQS1kVKqUr4qYul6YMFkqUfFzWsxQCH6m05AV17M7XZ6PU84gFmw7g/ieXyc2Kf8Aw==@vger.kernel.org, AJvYcCXKRlbz0P99/VqFoeCqrt59IL/7VPxYSInGUnt7oJxBGVtEnwlvwiYSqB37xuSURSSO00UzyTQnx43+qTyh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6C198udoPbdUasdHzZmDXdY+/9LO1V8f4V1X/flrRBguVngME
	9QMkMWzkQ3T2UIoIKrtODdoEcv6CmkcFRPYB/2nDFPZ4QrHEZDcc
X-Google-Smtp-Source: AGHT+IHZP5bpH5qlg2I9OOJbzFLfW3myCBjFcT869tCQtqCK3mxPDp7nmlTfLNMEnVpsMHcaCRBxoA==
X-Received: by 2002:a17:907:e214:b0:a86:c1ff:c973 with SMTP id a640c23a62f3a-a902961ded5mr1657274866b.47.1726511172823;
        Mon, 16 Sep 2024 11:26:12 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061096aa2sm348392666b.35.2024.09.16.11.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 11:26:12 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs updates for 6.12
Date: Mon, 16 Sep 2024 20:26:08 +0200
Message-Id: <20240916182608.1532691-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull overlayfs updates for 6.12.

This branch has been sitting in linux-next for over a week and
it has gone through the usual overlayfs test routines.

The branch merges cleanly with master branch of the moment.

Thanks,
Amir.

----------------------------------------------------------------
The following changes since commit 3e9bff3bbe1355805de919f688bef4baefbfd436:

  Merge tag 'vfs-6.11-rc6.fixes' of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs (2024-08-27 16:57:35 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-update-6.12

for you to fetch changes up to 6c4a5f96450415735c31ed70ff354f0ee5cbf67b:

  ovl: fail if trusted xattrs are needed but caller lacks permission (2024-09-08 15:36:59 +0200)

----------------------------------------------------------------
overlayfs updates for 6.12

- Increase robustness of overlayfs to crashes in the case of underlying
  filesystems that to not guarantee metadata ordering to persistent storage
  (problem was reported with ubifs).

- Deny mount inside container with features that require root privileges
  to work properly, instead of failing operations later.

- Some clarifications to overlayfs documentation.

----------------------------------------------------------------
Amir Goldstein (1):
      ovl: fsync after metadata copy-up

Haifeng Xu (1):
      ovl: don't set the superblock's errseq_t manually

Mike Baynton (1):
      ovl: fail if trusted xattrs are needed but caller lacks permission

Yuriy Belikov (1):
      overlayfs.rst: update metacopy section in overlayfs documentation

 Documentation/filesystems/overlayfs.rst |  7 ++++--
 fs/overlayfs/copy_up.c                  | 43 ++++++++++++++++++++++++++++++---
 fs/overlayfs/params.c                   | 38 +++++++++++++++++++++++++----
 fs/overlayfs/super.c                    | 10 ++------
 4 files changed, 79 insertions(+), 19 deletions(-)

