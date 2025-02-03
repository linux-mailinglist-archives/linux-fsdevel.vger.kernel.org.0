Return-Path: <linux-fsdevel+bounces-40680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2B1A2669C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 23:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801351659EC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 22:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D42D20F06B;
	Mon,  3 Feb 2025 22:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkkVc5UX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442FF1FF5EF
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 22:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738621934; cv=none; b=EpuMijshSUEoA6i4yq9yVoK2QhvCayQ1NsOwWVe9frOpSUg//wSDcIlRBNGjz4dmUZ6pjdmOCHkRUAqqIyuUEXbj+vtqoliGj4bwNUwGI3ppLAovfGlGDSiLYtt3S7Cn6wyGqQYuIRfRinKm1VasU69crobgCc5FL7+c0oNK3kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738621934; c=relaxed/simple;
	bh=JFkgfJCrkb7EH1m1AesPeGONSf+yn0H59ISBObBD5wA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cSLUDwNG3A3IX7kE30ojv7Vv5YK1ubtJ6O+7GbZNU3bSYnuDl70IhbgmuSLSPjHfoJuRaWyYNaq5+SQXkKefaoY5hvA9UWyncOMV+GdHP0CGS/suSrEQtowjNIWIYGIe54FcWwDvucLmT4iYI11G5wSWWKJqst+3INmQH6tQiZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkkVc5UX; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5db6890b64eso9518754a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 14:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738621931; x=1739226731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1cCAu8RQEgpaNrRcNNb2CfmjkqDb/C9813jMwVPLNFA=;
        b=dkkVc5UX8H6N2r1G+Qa5DY6qLkfmimZ2kpe92oy1yK2eG2hXRfP74MmHHnxERNO1FP
         yFUF0ltWmZPOWsisjbmm4ueT0RXOaXo5nNlAWrUJpSplhTi5iYbmVox/blzV1hWADAIe
         lt/R4MrlvYUqB8oUjOojfFj1nf86N7/9q2JmN+n1bRefJs+TQYUIu2ixiTCxI7AgODqE
         bOK1xPc+D0J5prKwHUd4NCeAL8ydlOxTqeexYWfcLZOYuBhTeVPaqu3cphXv003IAsat
         /sJ7bXrxUSEeecW0JmZ9Y64RRZr3PlMhIWLj3gHDKhygD731crBDd1GRlyQZOzkp+N9G
         g5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738621931; x=1739226731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1cCAu8RQEgpaNrRcNNb2CfmjkqDb/C9813jMwVPLNFA=;
        b=QLdvJoYYNK2z9zJeH7uJPrzXH4Q/Vj83EbAVXuLFG9absbeHPCK8f1LcrfP9MXu418
         bCuOMaS7no9PttXm/0QMujXy78BcjmpWfGXLh/A2kH/dPZ4PPMcAwj90bpCzg0uFX0WO
         H/V5+1iv/YL2CTapk+Jdl+646qXiJXP3XIpV1buvtKRlU+i9Us+M1no0zZJxh/iNPfyr
         cNqz49BeP9c1DXWZnJeljzxV2doJkGFvGZ+7/TF0pP6mGSzyp3Z0JwNxvdearc1cW4E9
         BKPTRMbXtO9S7oTY3NYnMFh9lvaKlIPF8XvdfPhRSETuqbklxl4jGy1HVaqZ4MEqKkzG
         PgMg==
X-Forwarded-Encrypted: i=1; AJvYcCUclyB9mF+SKDxEAGThiIPyjJtt8swQT0v6v1MkJSHyZP+TQWYANP1Z6vtQ2bYixA+Z3nTd471rzWlyhIv4@vger.kernel.org
X-Gm-Message-State: AOJu0YyKKqXx9nRpocvsh9kG7KQc07aJTCWe6rOWeSbudE0dFHUFOjZ2
	nDR8J5c0xdGHvL1ecTdal40J37wywhmi4+tPgVnoxfedkpWJU+2z
X-Gm-Gg: ASbGnctYGN2WKVhGw4fCgB6VOKRvMPPGZSwn3YC6Rr86WRMNOGeaf8ukdZu6W9E5U1C
	5ocOdLk8EPX5TtdeeBcGcUK+DjWGpf3jA30a1Cl4QNV1De7YuSTw0Fn7D7KCJsoOWV9lqP+7PRW
	jPiWYLiiU7DsYrweNmsA3iaCwNUZROzuii8/KXBfpVyo+35v+cArgsK3NxuPpCfDY0unZ+Mv2J2
	W6jitPu6XmEXdQmeiWlMWeVM2vnOpaKwBAHXTz8E1dQ8pyjRZWtPgZQ9S5cFN3Yt0b0noOdzM3b
	dl1zlj8V6rJBR1gm4Lxj6BxpVSlIrXvk+CdEBjZ9z0uz5ejVUOWjpLYVYkKSDFII9xbBB2nSYRL
	SiAFttdMHeQC0
X-Google-Smtp-Source: AGHT+IEj7bk7eCOJgmH7MVwANklLvcQfAiHwoa6wxFiEhQDT0KF/sJGAsplvxfzOzZATfeGs6hqDLg==
X-Received: by 2002:a05:6402:390c:b0:5dc:8ff2:8b67 with SMTP id 4fb4d7f45d1cf-5dc8ff28d4emr14668741a12.27.1738621931004;
        Mon, 03 Feb 2025 14:32:11 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724a9c5fsm8339651a12.54.2025.02.03.14.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 14:32:10 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Alex Williamson <alex.williamson@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/3] Fix for huge faults regression
Date: Mon,  3 Feb 2025 23:32:02 +0100
Message-Id: <20250203223205.861346-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Christian,

I thought these fixes could go through your tree, because they are
mostly vfs/file related.

Hoping that Jan could provide an ACK.

The two Fix patches have been tested by Alex together and each one
independently.

I also verified that they pass the LTP inoityf/fanotify tests.

Thanks,
Amir.

Amir Goldstein (3):
  fsnotify: use accessor to set FMODE_NONOTIFY_*
  fsnotify: disable notification by default for all pseudo files
  fsnotify: disable pre-content and permission events by default

 drivers/tty/pty.c        |  2 +-
 fs/file_table.c          | 16 ++++++++++++++++
 fs/notify/fsnotify.c     | 18 ++++++++++++------
 fs/open.c                | 11 ++++++-----
 fs/pipe.c                |  6 ++++++
 include/linux/fs.h       |  9 ++++++++-
 include/linux/fsnotify.h |  4 ++--
 net/socket.c             |  5 +++++
 8 files changed, 56 insertions(+), 15 deletions(-)

-- 
2.34.1


