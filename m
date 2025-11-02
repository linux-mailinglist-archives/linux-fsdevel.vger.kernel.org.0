Return-Path: <linux-fsdevel+bounces-66697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DF0C29988
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 00:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A9834E6F18
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Nov 2025 23:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9B1248F4D;
	Sun,  2 Nov 2025 23:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0XVdHps"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BCF239E60;
	Sun,  2 Nov 2025 23:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762125175; cv=none; b=fMjZ2k6b+OSuO9LukT0p0NpPgEufbHwEBX/9CVIql3dE8qeLLDFZFSWWlf40zBbErr15aXcLORty+artFvLf/YUzs+i1SCfgMWNEaNoRrJaMaLNqegEyxlTWA3OW79nTFzwY+cJRH8+r6ddjR0cU30MugAN8JyzKsP8StstGre8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762125175; c=relaxed/simple;
	bh=Wbna9iAQsjbNqL8L77AiF9Wj8kEUspZsbhAl8SO43Eg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Th5zX+GP4jUTFT0bdj7j5pGI8x2tL4ZsSDb70jO0dBQa7myV7jo8IswgMo7mQb3YC2NdATaVbzEfH2Axp4v4iCohvfaxwQ+CJRjnpiuwof3nigsg8wPgOclwMARqtxjrlY1R12OJ/Eyvr7D5+6sjzsv13A3mTu9r2hC2JOk5kQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0XVdHps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309E8C4CEF7;
	Sun,  2 Nov 2025 23:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762125175;
	bh=Wbna9iAQsjbNqL8L77AiF9Wj8kEUspZsbhAl8SO43Eg=;
	h=From:Subject:Date:To:Cc:From;
	b=E0XVdHpsPadkSM1kDtixeEtYiKYFAyzVRt4BV2afsggfrUtn6Ek9v8Ados3S9oDoJ
	 Ga/2VwXo9jb8PYhGv9xym3BgoPV1vODufyYoQfb7aOaRnEp8gdOmUskSdmDFbp0dsK
	 5mb2ODEULoxsIFowrZyzZZBOoIwDzZmZKA9cpk/JLjVi9c+q5plZd3eB9L19bAsK7Z
	 Nq6pYjqQds3ACGWatSYMiWEjDco1jlwdfxgyUfLfW5zechN2PjlnIccJxhBHyR0h78
	 jRtUm2kPG9b912D4777ykvAlP5pu+zBMGht3Bw2CGOjJ/mwct5o8tf4UAV8LjLckzV
	 eGHiPDrWAXRIA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/8] creds: add {scoped_}with_kernel_creds()
Date: Mon, 03 Nov 2025 00:12:39 +0100
Message-Id: <20251103-work-creds-init_cred-v1-0-cb3ec8711a6a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGflB2kC/x3Myw6CQAyF4VchXVtCuYzGVzHGDENHGuNAWoImh
 Hd3cHe+xfk3MFZhg2uxgfIqJlPKoFMBYfTpyShDNtRV3RFVDX4mfWFQHgwlyfI4JhK1se187c4
 uQr7OylG+/+ztnt17Y+zVpzAesbe3hbVcXUkX1NDAvv8A4J3NZokAAAA=
X-Change-ID: 20251103-work-creds-init_cred-114f45a2676f
To: Jens Axboe <axboe@kernel.dk>, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=2098; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Wbna9iAQsjbNqL8L77AiF9Wj8kEUspZsbhAl8SO43Eg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSyPy1t2r3TamnzjruLn5VEv03cwa59J3yPBW/kFtPP+
 dMbt7i/6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIyRJGhpZsH09b3yUL77B8
 sOFY6BbHrKe2Z2J4auzNHK37E6e6L2Fk+Hb1Rv70uGSt4Cu1BXOe8upsXPTO+Od5/w0F6rYCLkG
 P2AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

A few months ago I did work to make override_creds()/revert_creds()
completely reference count free - mostly for the sake of
overlayfs but it has been beneficial to everyone using this.

In a recent pull request from Jens that introduced another round of
override_creds()/revert_creds() for nbd Linus asked whether we could
avoide the prepare_kernel_creds() calls that duplicate the kernel
credentials and then drop them again later.

Yes, we can actually. We can use the guard infrastructure to completely
avoid the allocation and then also to never expose the temporary
variable to hold the kernel credentials anywhere in the callers.

So add with_kernel_creds() and scoped_with_kernel_creds() for this
purpose. Also take the opportunity to fixup the scoped_class() macro I
introduced two cycles ago.

I've put this into kernel-6.19.cred now. Linus, not sure if you're
paying attention but if you want you can give this a final look.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (8):
      cleanup: fix scoped_class()
      cred: add kernel_cred() helper
      cred: make init_cred static
      cred: add {scoped_}with_kernel_creds
      firmware: don't copy kernel creds
      nbd: don't copy kernel creds
      target: don't copy kernel creds
      unix: don't copy creds

 drivers/base/firmware_loader/main.c   | 59 +++++++++++++++--------------------
 drivers/block/nbd.c                   | 17 ++--------
 drivers/target/target_core_configfs.c | 14 ++-------
 include/linux/cleanup.h               | 15 ++++-----
 include/linux/cred.h                  | 18 +++++++++++
 include/linux/init_task.h             |  1 -
 init/init_task.c                      | 27 ++++++++++++++++
 kernel/cred.c                         | 27 ----------------
 net/unix/af_unix.c                    | 17 +++-------
 security/keys/process_keys.c          |  2 +-
 10 files changed, 87 insertions(+), 110 deletions(-)
---
base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
change-id: 20251103-work-creds-init_cred-114f45a2676f


