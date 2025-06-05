Return-Path: <linux-fsdevel+bounces-50727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F09B7ACEF8C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 14:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C017217204B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 12:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F1F217719;
	Thu,  5 Jun 2025 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCGLc75J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6471E7C1B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749127862; cv=none; b=txLDCxEy5t0N4NwBd4BDXQJm2V9a9is4WjcedHBwECClJnXbh1+h5Grp+KF11/Fji0iymNrSxBFCwgwsqe85mcGPR9aBEAP9oHZl0OYOcb7rd4EJhsjfGC86avP+EKGDQDB04IsdAiFvoYFFgM5+t8sxF/xdCSynAJsX+p8B9Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749127862; c=relaxed/simple;
	bh=faUFHGH0Uza4QMGFdzglLRXguavVRPmjASNR2lBYRLs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gM1pJfaiej/a97oFMjbFbDVJNOBx2hp/bB0qsmXGsdQwGyVsXSPKvxsWvwwaFCVuW4Gel3stUtiR5nBgy2l7vaNGsDiCk6cLbYCLdGO85yaga0+LzKF4oZTe8mu6/Zp/eCsyH2c/OlVD5C8XBN68vSipwFWLXuJs9ONuIL9y1l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCGLc75J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4506DC4CEEE;
	Thu,  5 Jun 2025 12:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749127861;
	bh=faUFHGH0Uza4QMGFdzglLRXguavVRPmjASNR2lBYRLs=;
	h=From:Subject:Date:To:Cc:From;
	b=sCGLc75JRToFD/fIQmHNAd+k9zdFxJ+9vVzfoVS27855zBBFWOaBY3yHcAg2cJWrM
	 tlxbtsEvc+9mSDziqPhxowvJVAVEMRdTZ6TjLUFUlaNNZoBu9AVYXtD2U+oTvWo2xV
	 TxD5pcwquvJUAvAEKzPs25vm/9L+PT2BInjlIYe7TgWomNvTi0IppdQ1x3fXnRGXQE
	 tgwTMgbwbjYTZzfsjCDCXZYPDVNcGPc8AVrzpbVZ9v8sxdf4CSHn1a4Gt4NYl7VOa5
	 iQDpullHxTQLtDwbd5KwysZofL6jvNMrsmrUwHkoAwbgvqunoRA/mVzzb83hose7fC
	 nupuk8X57U6zQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] mount: fix detached mount regression
Date: Thu, 05 Jun 2025 14:50:52 +0200
Message-Id: <20250605-work-mount-regression-v1-0-60c89f4f4cf5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKySQWgC/x3MQQ6CMBBA0auQWTux1mCsVzEsWhhgYtqSmaImh
 LtbXL7F/xsoCZPCo9lA6M3KOVVcTg30s08TIQ/VYI1tzc20+MnywpjXVFBoEtKjQOvcdRjvlpw
 LUNtFaOTv//vsqoNXwiA+9fNxWxctQj6eo9dCAvv+A4oLVKiJAAAA
X-Change-ID: 20250605-work-mount-regression-2993df82e99b
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Allison Karlitskaya <lis@redhat.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=856; i=brauner@kernel.org;
 h=from:subject:message-id; bh=faUFHGH0Uza4QMGFdzglLRXguavVRPmjASNR2lBYRLs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ4Ttqctfqu48XVLgHCN1Zk6+1cFd2ULXkhIn9eQ9xdw
 49bGCK3dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykp4Phf8KjO18ebdztIS44
 1Zd33syF/Cf2hwiq/jzLkLpd1XfLzGmMDI92Xn7lZHM2eVrjX/9Not/WdDW88ui6qszkGBSzx7v
 oLS8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When we disabled mount propagation into detached trees again this
accidently broke mounting detached mount trees onto other detached mount
trees. The mount_setattr_tests selftests fail and Allison reported it as
well. Fix the regression.

Also fix the selftests for detached tree propagation now that we
disabled that again.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Christian Brauner (2):
      mount: fix detached mount regression
      selftests/mount_setattr: adapt detached mount propagation test

 fs/namespace.c                                     | 28 +++++++++++-----------
 .../selftests/mount_setattr/mount_setattr_test.c   | 17 +------------
 2 files changed, 15 insertions(+), 30 deletions(-)
---
base-commit: 5abc7438f1e9d62e91ad775cc83c9594c48d2282
change-id: 20250605-work-mount-regression-2993df82e99b


