Return-Path: <linux-fsdevel+bounces-63591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3FFBC4E8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 14:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA942342D3D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 12:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956D325742F;
	Wed,  8 Oct 2025 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bf1Sk55+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F5E22128A
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927468; cv=none; b=Eb0SI0vJ2J0Q+LxM2sKncup1SjXDUXIfiCeMR0ZXAoTESBzw9yBUcrdJzHDkhfyEvT/9yPvMbU6SKUn+mDh6dhvi6S8FOgwjwEU6GqoHIdLgPJG4RekFn7bJYUFKaJqcKDhHswJYmKRw3KPNAseqdRZQSplmlQgkuzX7C9Pl6PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927468; c=relaxed/simple;
	bh=J0rcHYqkXUQdeIfOqOASx3V8jB86T/gKqv9OJQeeD7I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a9Y9xXUum+PXcfA6FUM9KOPrcvDB1kYgyQ6qoU1iJVOX4W4A+vnScQI9JDm0AzwlsL3EFGhEayqy9hXsab91BtdM86ofUbjfHbxIZYXONRtaWmAzEC7Cainj1eteoDhj0/tZUl/obyu+ZKmwzBETjnQJy1Qm3w+KQZgQr8IIaLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bf1Sk55+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759927465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rVKpcwPEfSYv/1RGY/1E+W+n5PoXfbCIlc7Ok0Wkf48=;
	b=bf1Sk55+XL/oh0WYvR9gCD1SBryxAxNQY6vnDTaHRtk+0Rh396Bnch4d7pY1YpDexuBZgy
	XDCGzjTRruF31I2PIuleF71+PywC0oluZHL3r/K21aXpmUMRgI1l5U0XoSagwWYS9sW4rU
	1eRyoDcpJtWlRa7XeUV0ne7wJrfUnlk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-iEJY2LzZMt-EAa5jOfpkEA-1; Wed, 08 Oct 2025 08:44:24 -0400
X-MC-Unique: iEJY2LzZMt-EAa5jOfpkEA-1
X-Mimecast-MFC-AGG-ID: iEJY2LzZMt-EAa5jOfpkEA_1759927463
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e31191379so43094035e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Oct 2025 05:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759927463; x=1760532263;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVKpcwPEfSYv/1RGY/1E+W+n5PoXfbCIlc7Ok0Wkf48=;
        b=O5So5QHp8qhzl0hDeLDkUSFyGJAIRDjH/tanhgXOSnhkDGUU9DSUJY0WNu1XWPKWxj
         2sQEk1CJi6YSEAzLASFBd94Gydg8byT51ZLejaTl2EQPgCQ/l4YL6KnOuE/wtJBwCI9A
         4ks/vZ1lMPurPlu3+cz+uULvPX2z/296UUFohyjXXUZFvzA85tRXpq9p4txJiR63G/tE
         geJ+9gDr/wbfkGQjw0oSo8YUgMYr4Yp0a0UhW+prwzV5BmYg+iXEKuNAtqUyIwjdKZ+H
         L7OXgh1lmIOrZ/Jaa0yITn/OZ6rZ0kKR0iO7FMeBPb6kpCirgQsqungZrZX1IIt+kjxZ
         yNxw==
X-Forwarded-Encrypted: i=1; AJvYcCV6RJ87zkCFlRp5jbhPXPJkbIubhocOWtbi6Me9ev/dU/9xkIZrUk1GSU3xYucjPwOfBcfw1BMobpaw9/k6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9wUwUsH1n6WZ6hDsUUQ7jLKPCnuFLBj3yxoPHwlw0JaTguzCb
	FSfM1U4LKFRQY519Ojc5R3pcXqfIaNGJgAeNquZPywGs8P7QAyi7lfKtgTWaeYefYrbQkT3qBDM
	ILUbmmoREye/MaJLXbHinJ0Fp2hR7dVaCBmLbgGZS6wnwbQfwZ+mxl3bVbfIsNBCXtQ==
X-Gm-Gg: ASbGncv5kJhGLFVfrUaca06gLTT7t/MhurHxyEMk72naggJTzvBzrD73pMNBTgi13Ai
	gntb1OWmQriRGPnal6+EO1XXCToeqGFzmwv9/vpBVvsf1l/t0IdUkI3xx9WqgOXNWjAxZGVl0ET
	vN/CQM6Ii2JI+XjedvgCqGd/Ws+z4puREdnA0zNAq6aUDAeAbAAmSe/1nd+Ngw+X/MOiFG1tOXe
	xwbFEoQrCMyacnH49DT+J4m1QKbhknh6/COU4kTUboRLwzhGjlZxe8gBvG4KIjGdbkU5iqmLJ7+
	Q7dAI4Ae1cLiAx1E0rOpqUxiWX4tyJYvARpYcH+kGuvTDZ2637oA2XYgYo6RflaNE3GPyJTp
X-Received: by 2002:a05:600c:a08b:b0:45f:2bc5:41c3 with SMTP id 5b1f17b1804b1-46fa9a8f261mr22409275e9.8.1759927462683;
        Wed, 08 Oct 2025 05:44:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpZOod60VGpL3LxeIqF3d6Uhr5luUS9rguzi/Rbgfb5kIOkUA+4Z+I6w9G9qetBDplM+qOKQ==
X-Received: by 2002:a05:600c:a08b:b0:45f:2bc5:41c3 with SMTP id 5b1f17b1804b1-46fa9a8f261mr22409055e9.8.1759927462212;
        Wed, 08 Oct 2025 05:44:22 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3d438fsm13918765e9.2.2025.10.08.05.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 05:44:21 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH 0/2] Fix to EOPNOTSUPP double conversion in
 ioctl_setflags()
Date: Wed, 08 Oct 2025 14:44:16 +0200
Message-Id: <20251008-eopnosupp-fix-v1-0-5990de009c9f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKBc5mgC/x2MQQqAIBAAvxJ7TliVMPpKdIhcay8qLkUg/j3pO
 AMzFYQKk8AyVCj0sHCKHfQ4wHHt8STFvjMYNJNGdIpSjknunFXgV3kTLAbv/Ows9CYX6vr/rVt
 rHygVUMRfAAAA
X-Change-ID: 20251007-eopnosupp-fix-d2f30fd7d873
To: linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Jiri Slaby <jirislaby@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=J0rcHYqkXUQdeIfOqOASx3V8jB86T/gKqv9OJQeeD7I=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMp7FLE2RfrRMMcBBwi375nZTs207zlW9vyDlsSc+o
 zM1g+PooiUdpSwMYlwMsmKKLOuktaYmFUnlHzGokYeZw8oEMoSBi1MAJjI1npFhocIZ6/Xs+9t/
 8C1U0pvbuvEn06GC1UITm9iPRGv5xX+7zPBP5/f7y93XzJStluR1KO9rLJDYMdVD96TI7sqUiw0
 6Vyw5AUdnR50=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Revert original double conversion patch from ENOIOCTLCMD to EOPNOSUPP for
vfs_fileattr_get and vfs_fileattr_set. Instead, convert ENOIOCTLCMD only
where necessary.

To: linux-api@vger.kernel.org
To: linux-fsdevel@vger.kernel.org
To: linux-kernel@vger.kernel.org
To: linux-xfs@vger.kernel.org,
Cc: "Jan Kara" <jack@suse.cz>
Cc: "Jiri Slaby" <jirislaby@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>
Cc: "Arnd Bergmann" <arnd@arndb.de>

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
Andrey Albershteyn (2):
      Revert "fs: make vfs_fileattr_[get|set] return -EOPNOTSUPP"
      fs: return EOPNOTSUPP from file_setattr/file_getattr syscalls

 fs/file_attr.c         | 16 ++++++----------
 fs/fuse/ioctl.c        |  4 ----
 fs/overlayfs/copy_up.c |  2 +-
 fs/overlayfs/inode.c   |  5 ++++-
 4 files changed, 11 insertions(+), 16 deletions(-)
---
base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
change-id: 20251007-eopnosupp-fix-d2f30fd7d873

Best regards,
--  
Andrey Albershteyn <aalbersh@kernel.org>


