Return-Path: <linux-fsdevel+bounces-24524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A05F694022E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 02:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD1D28357C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 00:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F974A3F;
	Tue, 30 Jul 2024 00:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbrdNizC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2224A2D
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 00:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722299337; cv=none; b=YXiAdjwKtXLzrCRqJlqJgCMj1pgoc6v2GOhwAeRofjAVnDtr6AdX62Afl8c03HkR1LoxpHDkmJmoMsGz6KdmDcXIiCZvJ8d+Byb9+NcF4DijzOVeORN1cYpIit69R2S0cMSR42URlr8tEvPm0Gv4NTzDo/hhAY/RDNaJ959pBMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722299337; c=relaxed/simple;
	bh=sbMzlcWt7rtoI/j4zmxNW/ruwZDbhjI/rNrJ9LyzIAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CfV4Fwqm871nKFDcZCGCJl3ENsS4cW9ut07f+Mgq8j4jaaZM57nhsT74A8B1Cap/RsISiL8ee7GW4ZtyPDf6qtO8ENdbdPQ3lVDFm+uo5pzLkBG/94e2dkceyCnozrN+Jhk9axkIOlmh83HfiebTC9/qsusVL4dgEQ0vuE52hqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbrdNizC; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6512866fa87so20103927b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 17:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722299335; x=1722904135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t5BX6539t7LilvEjy4XyPow8vpJZSGLp9CHXCX/xNA8=;
        b=ZbrdNizC+BIiZCq6U+qzZ67wCZFsvHrR4sy5rXEy5V70wgy5KFSXFbWayB/F+PUVNG
         1qKwJlvEjM87eMXvuDCF3JK9WPWqH2G50B68cH1cirPllL/x4gIfo9WGGjod53TXXnuJ
         7jBCVmO1WA7N9vEvmm5EmuUNKotAoDN71AbbzsN1COWiccYTiHpzA5/RVl0H6E0jOytR
         lWojCVl9xg9/SQJqpGtm0xo/E3ELKRHKWztbIFU2Aal1thYycrM8zsvpKBG37uUMvxWV
         7C9EzGtg3Jmv6cyywUtFPdB73n0M5/mKB9a5YhlliZq/oqgJ24V/zvC+RY+g1/Gn7leI
         d7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722299335; x=1722904135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5BX6539t7LilvEjy4XyPow8vpJZSGLp9CHXCX/xNA8=;
        b=FtgXEFtZembkOy9OYzzL4rIlpQlbwkhqIdVM3wpC96aIL3tMeXGDRVfx7LN+izDzME
         spJ+iVFd0lrrcb5ExIEY9EpEP0WJaqg5nxlJYMzFBIbDWAuhj+qtn/Hz1aFVDcZH7sVQ
         SOeDyzP5bKxjyVWKxhnYXVCEOiv4xfExeGy6NJeDSSQZKDetZQusmXU7XR6SY7ZsttjB
         jLi7WeFRYaRqVqOSXEfCWKwz7iJNIoHYbhAsQwqGhbrVZf76CF11EnP+Nc6shVqxVI3A
         Iab/nr3kVByA0kKNKN5/TgKNIHOUGq1s0NhK+Yi3HsEE6otjfKk/qcoVrebtQiY1vmvb
         MpVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXieiBxvaSnd+fnu55eLa0TVBOstS4MbnibOJIc+2V7h/yBqcDm1gFiVAal5PXhXgdtC4HYZvfIwGPoB0TcKFHngNqVFfIfd/dxEAIIHw==
X-Gm-Message-State: AOJu0YzK8D871ExfR5MB6Nl/UbV2Sx+VbYTG980eGl6jOHIz8h+Ppp4l
	Ui6GuacOURpKbZ9gQHhKnaCugZyalPFMuMMFYODtD/b+WT+aHhpR
X-Google-Smtp-Source: AGHT+IGEN9Cy3lSRvA7PyfUpmE1j2v7jyiEXyWgS3yJQGwmPeeO7xrU80YBhx8+9oi/JrnYpiAThnA==
X-Received: by 2002:a05:690c:3805:b0:64b:5cc7:bcbc with SMTP id 00721157ae682-67a0919afe6mr84437997b3.32.1722299335375;
        Mon, 29 Jul 2024 17:28:55 -0700 (PDT)
Received: from localhost (fwdproxy-nha-008.fbsv.net. [2a03:2880:25ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756b024bafsm22959057b3.100.2024.07.29.17.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 17:28:55 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	laoar.shao@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v2 0/2] fuse: add timeout option for requests
Date: Mon, 29 Jul 2024 17:23:46 -0700
Message-ID: <20240730002348.3431931-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are situations where fuse servers can become unresponsive or take
too long to reply to a request. Currently there is no upper bound on
how long a request may take, which may be frustrating to users who get
stuck waiting for a request to complete.

This patchset adds a timeout option for requests and two dynamically
configurable fuse sysctls "default_request_timeout" and "max_request_timeout"
for controlling/enforcing timeout behavior system-wide.

Existing fuse servers will not be affected unless they explicitly opt into the
timeout.

v1: https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-joannelkoong@gmail.com/
Changes from v1:
- Add timeout for background requests
- Handle resend race condition
- Add sysctls

Joanne Koong (2):
  fuse: add optional kernel-enforced timeout for requests
  fuse: add default_request_timeout and max_request_timeout sysctls

 Documentation/admin-guide/sysctl/fs.rst |  17 +++
 fs/fuse/Makefile                        |   2 +-
 fs/fuse/dev.c                           | 187 +++++++++++++++++++++++-
 fs/fuse/fuse_i.h                        |  30 ++++
 fs/fuse/inode.c                         |  24 +++
 fs/fuse/sysctl.c                        |  42 ++++++
 6 files changed, 293 insertions(+), 9 deletions(-)
 create mode 100644 fs/fuse/sysctl.c

-- 
2.43.0


