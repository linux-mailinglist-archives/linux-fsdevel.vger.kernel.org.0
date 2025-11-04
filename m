Return-Path: <linux-fsdevel+bounces-66991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3370C32F83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 21:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E63C44EADCA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 20:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C16726056A;
	Tue,  4 Nov 2025 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bvxoo5i1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894B2D27E
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289502; cv=none; b=UpgUrOv3tV8GuCgTNlSc3BUfhXyidZwblgZ0AzVC20hemUzI5k6N4wFcTdaYqMs60X40B7dF7sfndqMPfaf2mf+Hi+/Uu2gwmClCySZxTy11cF8f4Pn0WjCF+UybkrIAHjn32AeXXdSkRHcLl+CwnaCWn0PMEAutz23kP2/hoHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289502; c=relaxed/simple;
	bh=0iDB89hk7fY/mV20LumPHKqJAkm/x2Z5dU36Ed7L1FA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R3rO1CL2kw1KBxC7x13HPr3E2oIWMHqNULsZTKi/JqrEBKEd5nVPGums2votakjs3IpZwmH538coV3gd82syoDlLVxm9tnE1OjTwFZj8mQL0tUG5yTvtHTGMBCKMQoo2hMOYj/Ep0KSsBm3UyZHRxm7KnECVCoR7+DWGkQ2udYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bvxoo5i1; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3407f385dd0so3935744a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 12:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762289501; x=1762894301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JZE3G5zAb9X1UhsupQgVh7Fa4ILHxySvQk+sPolDcXM=;
        b=Bvxoo5i1M5B0t5VkAMQ03Z0M2NaD68is1SXcHRr285qQkXXXEGMNSeIJNCH4EWwtjX
         Imqp6zlQWqhog+h3a2aoaAPbS1uZ2mlSA5JDWxaqxr6H5PV4ssQAI8Z7jlOLohweW9lN
         2K6LxzoW++sbwlCv9kEhVEPRiX8rWTCb60Wdv8gtT1dFtXAVpH8a93TAAPvEvq2GWID/
         AXKb0+LLV0G7p8C2e4sm5ZLlnP543e373k5KJ2hOHCYk/OeZLYnlUMNrYUGD5tZm/Eb5
         grETi1L8y8AfGY7ncwXGxK6BNI3pt2qeUUFXyjf36amPO/IEey5IHgHwJGySvjpUwAd3
         eNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762289501; x=1762894301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZE3G5zAb9X1UhsupQgVh7Fa4ILHxySvQk+sPolDcXM=;
        b=rkDkxQRRTV1PL2/YCL2gb5A9qBJIP2+aDPNEjufbZ/cRugGv452lOg2Ox/guIMa8eC
         7+OPIN2MYGjcEmA5cSl/PmJQxAVNJaYRo8DqRitKBnNVVgyuYvxHlpq1Arvya6YUVqR6
         0SzsINI1I3rO2RwLgHMUIN+Fwr9IDi+XEErzndKY0PIulPumCvRD2Lzh64iQwRD1qYXQ
         XgOe6yLMcHbte/8bURmz4ujaTRJ2AOvNjPZ5M+dO9683WZdHJEEVe24V/DIk0sIa1nE+
         J7ZlkjnknLTRTMoVSKYZTsxO44bwFtiAyeRxwHeWWxwI+eKrimItJQ8fTCPsNHK+w8vt
         1T/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6SFIGZCzV9EEEkGPPsD52lC/JF60Qv3Ta3+fFltp3hO/O9f0hYh3BZa3R0D3a6Q7ZqtRn2qJuIfebiMKN@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw14R24RxiiPEhZvKHcbYEDJQSTIFBPjGSEZ+c6lothYYTTehI
	hq3fuSMgkESBlb8yX/sq7vA1iQNprBZbd4YakYR1+bBIkeBHvb0/nO5p
X-Gm-Gg: ASbGnctFyVd80OKwE6hDRv1nCw6I1LWZMdQQ7CppU1L22f2ZvWs09eRFRFqPbaCijkS
	+nn/4eeZWMp2Iu96JIMVFjx/+gr4sVTMDDxhraXv3LpKb026s8gGXc2sb5lWzWhMqzTYbjR0vy+
	BvKScP6CtF+y5OObfMcdmVfXErdZAmdK5paJTicVLirR3MEHQR+qy4OADKcHuplo5mkn6REKvwW
	qaI4FX0nEzbBg3gERRYiBC8jDHeI8ZBVO/kEJqArjmXvyqooBuMJaZM2WGE94OxTgWcVJH3FUac
	hnoiNBL9qrdiZ7iRre1FFJTbxXl3QsVBXMYzcldX1Ox+8QpW++DJ4WHButS5PDkHjN3gNxnLN7b
	XnwCnokWOpEgTwgN+3ZBpUDdCCcmJ2WReU0HuC199nC/pjVNMDTaUu3tlvI9K1kBXxOsZjVwVau
	tv5wKN3a/ojyleXHcs9qjBOkMEuQ==
X-Google-Smtp-Source: AGHT+IGO1Sv01rK2xeDYRYwEm1MzcBShXe++7HDK/HEf9YIR06TGGZURgRTKBCqmB7Z8KR77ZtUUfQ==
X-Received: by 2002:a17:90b:4b0e:b0:340:6f07:fefa with SMTP id 98e67ed59e1d1-341a6dc8cf5mr676906a91.20.1762289500693;
        Tue, 04 Nov 2025 12:51:40 -0800 (PST)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a69b698asm444796a91.21.2025.11.04.12.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 12:51:40 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: hch@infradead.org,
	djwong@kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 0/8] iomap: buffered io changes
Date: Tue,  4 Nov 2025 12:51:11 -0800
Message-ID: <20251104205119.1600045-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


v2: https://lore.kernel.org/linux-fsdevel/20251021164353.3854086-1-joannelkoong@gmail.com/
v2 -> v3:
* Fix race when writing back all bytes of a folio (patch 3)
* Rename from bytes_pending to bytes_submitted (patch 3)
* Add more comments about logic (patch 3)
* Change bytes_submitted from unsigned to size_t (patch 3) (Matthew)

v1: https://lore.kernel.org/linux-fsdevel/20251009225611.3744728-1-joannelkoong@gmail.com/
v1 -> v2:
* Incorporate Christoph's feedback (drop non-block-aligned writes patch, fix
  bitmap scanning function comments, use more concise variable name, etc)
* For loff_t patch, fix up .writeback_range() callback for zonefs, gfs2, and
  block 


Joanne Koong (8):
  iomap: account for unaligned end offsets when truncating read range
  docs: document iomap writeback's iomap_finish_folio_write()
    requirement
  iomap: optimize pending async writeback accounting
  iomap: simplify ->read_folio_range() error handling for reads
  iomap: simplify when reads can be skipped for writes
  iomap: use loff_t for file positions and offsets in writeback code
  iomap: use find_next_bit() for dirty bitmap scanning
  iomap: use find_next_bit() for uptodate bitmap scanning

 .../filesystems/iomap/operations.rst          |  10 +-
 block/fops.c                                  |   3 +-
 fs/fuse/file.c                                |  18 +-
 fs/gfs2/bmap.c                                |   3 +-
 fs/iomap/buffered-io.c                        | 244 +++++++++++-------
 fs/iomap/ioend.c                              |   2 -
 fs/xfs/xfs_aops.c                             |   8 +-
 fs/zonefs/file.c                              |   3 +-
 include/linux/iomap.h                         |  15 +-
 9 files changed, 184 insertions(+), 122 deletions(-)

-- 
2.47.3


