Return-Path: <linux-fsdevel+bounces-45271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8081A756B4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 15:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FDEB170CCD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 14:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616FA1B424F;
	Sat, 29 Mar 2025 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRWNa0Tr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A51E8F6D
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Mar 2025 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743258799; cv=none; b=FYRNxDscGPtMGIYpSSnnEiUIIuFA74n7yFMQZwvj1f0uWY2GQ1M42k7uf6d0iD6qXsuuwiiT2swXnOT9u595rUTd7mIvrHR3mZPQtq1uOxtvfEXQfj++Vi656rQi9L/3Ut019KFbRix2OxBdmOJdPJCwrH2HZCCTwzopOR/Xxlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743258799; c=relaxed/simple;
	bh=9crxq2Yfg5N+x9SR8tu1os1Yj5WU6B4CScEoxKhhnQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WE9t6q9HCKVWYEzXWnALqNrRoR6ijtwlsaP2Xm9Yp+7n/rAjnQXdebZDDCqvY8UlT7rND0rJtIR4Xn1IRerCP/Ytzq03gEgnJrURLp6H6fEqxsZdFJPMFZ2Ja0QvqcymDxuVbsXGZkgEKP8KewqpjhJFAyK2GAh6sI4yGSDCu7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRWNa0Tr; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac41514a734so512654566b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Mar 2025 07:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743258796; x=1743863596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IaLESnj6zrOr2mWwXbtoyIbiEN42Oxdh31onsaLwTZQ=;
        b=aRWNa0TrlbA2ehSadX4EwZ9P5wNZG+b3r3I65TPd+PzDRARlJExSRBjqqbvPAeiLhz
         unpAiU5Yrr6D48f4uSy9bUANVf/a1djc/zEO13K6f6sMm9ZwakdEJbbFopulgZ/jbK8e
         FAumi5dTkGbCZdhGIjvaBjjRuvmzQoE5yV8okyvmh5fgXxUQnTIjPMlO680lf4bJ+69s
         QCe2HeBgn41uAayb3uZNQrcfr7FiUPH2n/oVIY2z5Hzy86l3eCcQCbJ7ajSI976+nlQs
         97lsvDGyBOVL6vZvGMoFSdNVKu0i13v3Qg6NXo5DjGIzLBNyUsECARfq0x/K+gmwzwzz
         C3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743258796; x=1743863596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IaLESnj6zrOr2mWwXbtoyIbiEN42Oxdh31onsaLwTZQ=;
        b=BKmx4h0jw5d/PsLl0beVaX0l95/IrLHVggW2pWdVRkqIPS450PcV7B8k3e6H0TtrD1
         d8a9dUyoNTIfoMgezR/gV6XXmBBZmno3DpL+5NIBnmmNDGnOCUJaPlDin/MXCj6cQtEb
         SNjUHaQZ9VN4mMzVT303bTs1E8lQbM0LJ55RQBNUXaJInrAsKB6g0Mw+5AqWhsqfh9GV
         7uUN+Am2lSWWrqKa1d6TvE8fZ8pbJOctF5Tbh4SXEANrF/ZxxQJL2IFWgKR3UiEwAdGN
         vYxbXejRMM/zWef2yXVFz9pLmeBRqr0E5u7fL00jQ0TRUt5oyMn13hcVsjQhUFKm0s/L
         iApg==
X-Forwarded-Encrypted: i=1; AJvYcCX3CC687tVURE+/5IF5WEHRM69BcWZPnpARq0ZqzllkRkjFA4250ugTQAR8vs62NjTou1dXn60sugRQhpBi@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Am6+gjj2VaJjaw+s2DtUPdHcEaDC+8YpO9py+FI/1CvIFJjh
	brU5Vb+GPHo/Xj/wTw4xAKLemIUW2QFgt8Hr25no9RRs9P+TYtOq
X-Gm-Gg: ASbGncvGlkTTUOcsBBcf8OLhLqjyMAtoRGwijdrCnVznRCNkEQ2rukXLVaeNVpt1ZEN
	ba7op7T3PGwiA9PikpOWo7xP/+fV++NPF+oBVwkbd96x0Tbv7IbVUmw9WH02BjEPOnJ/5g/aMBs
	1XWzxno9S6eMVw4QK0+mbUVKqFC5O/wC9KwiL90JIo3qu6f7KboIYK97Atl7zRJadr/eE3+sMzB
	sL01Hzg5jRjvD6hGeL2gQ1pesTPMf4Xc94B1oniDTjAco8hPDUxsvhi8xQmBIaOq34PTtb9By3u
	kofU5oqJ2bOhAobkaDU71nKSZtwdZzX67OQwY3TzoA+giOHPeFSFl/PDGMgWBJvRd0nZCfqGe6P
	H8EaSDECT0xj4zxxrkiX7Ot7JrU5jwCu9L1Eg4pKPSw==
X-Google-Smtp-Source: AGHT+IHCM4GFHrqLzCuXGvJtYiJ+sz0TLUSZ7cD5w2ZfAg+Zob4lIioiAohN91+y3+aCYpbr7nJM2g==
X-Received: by 2002:a17:906:c156:b0:ac6:fec7:34dd with SMTP id a640c23a62f3a-ac738bac797mr191222966b.52.1743258795940;
        Sat, 29 Mar 2025 07:33:15 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac719223e12sm344871866b.14.2025.03.29.07.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 07:33:15 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 0/2] [gs]etfsxattrat() followup patches
Date: Sat, 29 Mar 2025 15:33:10 +0100
Message-Id: <20250329143312.1350603-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Andrey,

These patches are based on your [gs]etfsxattrat() patcehs [1].

I think that the first patch should be enough to allow Pali to later
extend the API for new flags. Please add it to your patch series.
I have only sanotify tested the ioctls, have not tested the syscalls.

The second patch is an RFC of how the API could be extended to query
filesystems for supported flags and allow userspace to set a subset
of flags and fields.

It plumbs in the fsx_xflags_mask semantics without implementing any
filesystem that reports non-zero mask. Obviously, I did not test this
pluming with no filesystem support, so this is mainly posted as a
reference design or for Pali if he has time to add his filesystem
support patch [2] and test it.

If the semantics of zero mask meaning no mask are not acceptable,
that I had also considered changing FSXATTR_SIZE_VER0 to 20 for the
first release, so initially users will need to pass usize that does
not include fsx_pad, until we decide on the way to extend the API.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20250321-xattrat-syscall-v4-0-3e82e6fb3264@kernel.org/
[2]https://lore.kernel.org/linux-fsdevel/20250216164029.20673-4-pali@kernel.org/

Amir Goldstein (2):
  fs: prepare for extending [gs]etfsxattrat()
  fs: add support for custom fsx_xflags_mask

 fs/inode.c               |  4 +++-
 fs/ioctl.c               | 46 +++++++++++++++++++++++++++++++++-------
 include/linux/fileattr.h | 23 +++++++++++++++++++-
 include/uapi/linux/fs.h  |  3 ++-
 4 files changed, 65 insertions(+), 11 deletions(-)

-- 
2.34.1


