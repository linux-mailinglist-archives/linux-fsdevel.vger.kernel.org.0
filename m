Return-Path: <linux-fsdevel+bounces-41735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FA0A36365
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 17:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3653ADF29
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 16:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226A3267739;
	Fri, 14 Feb 2025 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPSEadWe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D43524CEF1;
	Fri, 14 Feb 2025 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551559; cv=none; b=aMPSq+hXKQ9oeVce3z7P09MNPRJIaMNMoLDK2BLhkhwsQ0JFC4w/HUotnzcfReo9/bAv5qMtodMnw0ru9bH/BNBXa8y/qp6hy0omew1Rg2mVD+I2i/6ENrbWCVH5gb1PFfnR3nYAQK/QaOvXfSPphhVAYI094mKP1NVwTtnZl4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551559; c=relaxed/simple;
	bh=8PB31eYLgXKVC2RYia2q9wXFqiaOHSgHv5hAelggdvc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U0vOfOGpXpIR9nyfDbYfZ6tFOX5633yCUIpRwYQEcMwcMU0SaRoziaNUBSKKsnzUvCi+MzSfL+lnMdHQmf/Au9VrKBo+UDA7A2C/AR4EP1Pc8ChAVIbpmL7ss2zZx+Zbc3c1gNpZBfiEKGf0qrRrsiWB6iUrtpHl88OEsqLjggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPSEadWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38009C4CED1;
	Fri, 14 Feb 2025 16:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739551559;
	bh=8PB31eYLgXKVC2RYia2q9wXFqiaOHSgHv5hAelggdvc=;
	h=From:Subject:Date:To:Cc:From;
	b=JPSEadWegdTH+SpFowGniec0IxXtRVTvIuavAKK+/ESfmytrTZ9//wlP9mKX+/TY5
	 noxSO4otS3kj20olgvnqegt/MfmQH5ni7b7UgXoS7Khr/8JSwig85jNQCRlUYyT5lk
	 QGcmZ2Ek9vYFFFxSpOZyOy6mkr4HM6LGAuVofOYNI5NP2LLHgv2NNTOc7rw0uXrJcu
	 0EkIHmwRrN+uHgHVVFEyH1hPIlIfLIzUoYA1L9fMsrZGBLJvB7arCM8ffYjqlNMTMf
	 F42LVCuwWpBfWlRHG/UET//l4VzLuD/FMIRq5YjQF8n3seqKDbzHteA3VZGvhdzMmc
	 FOa4h5W5knEPw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/2] ovl: add override_creds mount option
Date: Fri, 14 Feb 2025 17:45:16 +0100
Message-Id: <20250214-work-overlayfs-v1-0-465d1867d3d4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB1zr2cC/x2MQQrCMBAAv1L2bEoTWgWvgg/wKj0km40NaiK7N
 iqlfzd6nIGZBYQ4ksC+WYCpRIk5VdCbBnCy6UIq+spgOjN0RvfqlfmqciG+2U8Q5QMG7NHvyHm
 o0YMpxPd/eIbT8QBjlc4KKcc24fR7ldptWz209zynJ6zrF4z8+aSGAAAA
X-Change-ID: 20250214-work-overlayfs-dfcfc4cd7ebd
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>
Cc: Gopal Kakivaya <gopalk@microsoft.com>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1661; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8PB31eYLgXKVC2RYia2q9wXFqiaOHSgHv5hAelggdvc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSvL3apk8/VbZu+Zqtt8T/GpzICm/z/ze6MCTx+5wrn3
 7l1PR5hHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5c4ORYUb6zcDnU7/VyJex
 HMvpfyiYqvhUdNv/8nyzxH/bzrAnbGf4w335gMSUeZdSpUVXquXbBLz0Utl6JLJ1r3yd4YTzExn
 U+AE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

Currently overlayfs uses the mounter's credentials for it's
override_creds() calls. That provides a consistent permission model.

This patches allows a caller to instruct overlayfs to use its
credentials instead. The caller must be located in the same user
namespace as the user namespace the overlayfs instance will be mounted
in. This provides a consistent and simple security model.

With this it is possible to e.g., mount an overlayfs instance where the
mounter must have CAP_SYS_ADMIN but the credentials used for
override_creds() have dropped CAP_SYS_ADMIN. It also allows the usage of
custom fs{g,u}id different from the callers and other tweaks.

I'm marking this as RFC since I've written this down pretty quickly and
I'm not sure I've thought enough about all the possible pitfalls. I
think overall the concept is sound but there might be additional changes
needed in ovl_fill_super(). Right now I'm just calling override_creds()
when creating the index and work directories.

Thanks!
Christian

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (2):
      ovl: allow to specify override credentials
      selftests/ovl: add selftests for "override_creds"

 fs/overlayfs/ovl_entry.h                           |   1 +
 fs/overlayfs/params.c                              |  25 +++++
 fs/overlayfs/super.c                               |  13 ++-
 .../filesystems/overlayfs/set_layers_via_fds.c     | 109 +++++++++++++++++++++
 4 files changed, 147 insertions(+), 1 deletion(-)
---
base-commit: 7a54947e727b6df840780a66c970395ed9734ebe
change-id: 20250214-work-overlayfs-dfcfc4cd7ebd


