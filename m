Return-Path: <linux-fsdevel+bounces-11754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA18D856ED7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 21:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4746CB25028
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 20:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2653313B2B9;
	Thu, 15 Feb 2024 20:48:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705F713B295
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 20:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708030093; cv=none; b=CSMwyijUE4EiFwdanndaTDxW0xxPrD5ObYkgDrlSsLe+GVPnpYOSNa10SRozM0NDAQtQCw6sSLQx/gYwp/G7ItMB9ntUVjgKlMcN0guATOBUo+ck90e6DRr84bfSa+/uMwJqWZG0i4xUkSmmbB4SZcZ7kB5vM+oIxExYNikfFew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708030093; c=relaxed/simple;
	bh=f/Q6G19ZNOl2uKqfFfJD9macDzm9JG/y0nzig0r42Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pTyA26obWqVzjfNwUYQYUuj02MOCY1kME6dJDo0ZGojMPQoTsE7/suDSd+YusPHOaLJ19uah20p82RnuhCEH2bSCefhUgvEQoy9OvXRJoq6gwsJaH1zYNMALFvKT33seO4TMGIhJW8ys3KFzah9WFYy48RU4353bgsWMFLOXZt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cedfc32250so1112417a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 12:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708030092; x=1708634892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sVAtnaJJc56o1kfSb+wWZs5qp0J0D7VRhJw2nLSCgTU=;
        b=GyRpzKE7fwpOK5SLrDVCsAfSxeg0ctxdxN9yTVVqYA1rSBRWfqkyZyMyjKowdzT27c
         TY3ttDZK2MAL0OSeGyLvY9PK1YwkhR8o/XLtZyGbNMGYjCpj2TAqCveW5lMRGWqDgjhV
         a4S6F5kFrQE3PYCd2+CvJ+iZe/RHxbllsWlB25wa1js2xoSyTpTHEO+37AyZAIFcfN6L
         QJuiy2NP+HXnQQUnnaezqmpWCUBTGar7mydYBXK59UCWpxKqUJMDLJQQulTWSL6tzpSr
         HwO3qjddAz+xGZVfhH6raw8euqhh+kYHuoxcBQrEVDsf2LUKnu/w+Wj+ECBhcs8nfHV+
         6Uhw==
X-Gm-Message-State: AOJu0YzrF0ALxIJrWDudvNgO9VOLqdb6E/8QknqkeuYSBPjEMXjt1Yti
	yJ8P/C7uBKiGDdZsulEtd+HbIfwuMEeQGqX2Lc3+eMe6HHzKYPTJhv8euVKU
X-Google-Smtp-Source: AGHT+IHp+4VcaMM3YGm4GynFkuEL3y4fjiNBJRJwqR+ERCQ74fhV9FsBuNn2os2SoqfqsNTa3RFbxg==
X-Received: by 2002:a17:902:eb84:b0:1d8:f394:da39 with SMTP id q4-20020a170902eb8400b001d8f394da39mr3929863plg.65.1708030091589;
        Thu, 15 Feb 2024 12:48:11 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:3612:25f8:d146:bb56])
        by smtp.gmail.com with ESMTPSA id v22-20020a170902e8d600b001db5e807cd2sm1677703plg.82.2024.02.15.12.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 12:48:11 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 0/2] Fix libaio cancellation support
Date: Thu, 15 Feb 2024 12:47:37 -0800
Message-ID: <20240215204739.2677806-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christian,

This patch series fixes cancellation support in libaio as follows:
 - Restore the code for completing cancelled I/O.
 - Ignore requests to support cancellation for I/O not submitted by libaio.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes between v3 and v4:
 - Restored libaio cancellation support.
 - Changed the approach to marking libaio requests with a flag in struct kiocb
   instead of adding a new operation in struct file_operations.
 
Changes between v2 and v3:
 - Removed libaio cancellation support instead of trying to fix it.

Changes between v1 and v2:
 - Fixed a race between request completion and addition to the list of
   active requests.
 - Changed the return type of .cancel_kiocb() from int into void.
 - Simplified the .cancel_kiocb() implementations.
 - Introduced the ki_opcode member in struct aio_kiocb.
 - aio_cancel_and_del() now checks .ki_opcode before accessing union members.
 - Left out the include/include/mm changes.

Bart Van Assche (2):
  fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio
  fs/aio: Make io_cancel() generate completions again

 fs/aio.c           | 36 +++++++++++++++++++-----------------
 include/linux/fs.h |  2 ++
 2 files changed, 21 insertions(+), 17 deletions(-)


