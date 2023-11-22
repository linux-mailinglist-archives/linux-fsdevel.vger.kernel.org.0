Return-Path: <linux-fsdevel+bounces-3421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B9F7F4687
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1612810AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7590525570;
	Wed, 22 Nov 2023 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMEo5TU/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60484D10B
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 12:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707C9C433C8;
	Wed, 22 Nov 2023 12:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700657093;
	bh=ywdTcUvaozDd7EU4HLLywRq55zrYlwPX2QMajKhAJng=;
	h=From:Subject:Date:To:From;
	b=XMEo5TU/oMYoMjSwidS3oyyawRDEzlGtoEQ/XaOM+hqhuWV0fm5srcuHnen8crVex
	 ktIx00BzjYxEWk4ynRkz2t8csr+AAwGPf0eYmFg421rT0+ScnCsn4/kcQ20+hYncPR
	 TVwDHcd7b2HiEyP2WafIRfxD4dDf9/IOKqNUTl4WLvTPOdpjecFE+hTV9blNaW6yh1
	 aDL/Qx0BCzBAqHHMOhmvsLxRr3+7DQXVTu7r8T/7BE+xXYIBrf8VmUUmA9nI4iAs13
	 2+rOfOxTEDkT8sPmkFxohhZczaA5Nl0jK1gQAnh87oyy6vXfwvJBOKdRtpNNRP379y
	 /s98GWEAV0GdA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/4] mnt_idmapping: decouple from namespaces
Date: Wed, 22 Nov 2023 13:44:36 +0100
Message-Id: <20231122-vfs-mnt_idmap-v1-0-dae4abdde5bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALT3XWUC/x3MTQrCMBBA4auUWTslSdWiVyki+ZnYWSSWmVKE0
 rsbXX6L93ZQEiaFe7eD0MbK79pgTx3E2dcXIadmcMYN1hqLW1YsdX1yKn7BOITxYlw+m1uC1ix
 CmT//3/RoDl4Jg/ga59+leF1J+u3ajyjRwnF8AaP0MCmBAAAA
To: linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-26615
X-Developer-Signature: v=1; a=openpgp-sha256; l=648; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ywdTcUvaozDd7EU4HLLywRq55zrYlwPX2QMajKhAJng=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTGfj+cIv4lpM4q4sPh2QteHVE60vdJVsG4vM9CsWJ/9
 qsPzdvEO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYy7wHDX3G3ZyqXXDNttvHW
 BzFfnfZKcp3xF8l5Zl/X7i7YrDJZazUjw9uM5UfPLkmeekeF73/Yk6n3q2Ys4WzjlD2TeofJMWx
 6AS8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

This is a tiny series to fully decouple idmapped mounts from namespaces.
We already have a dedicated type and nothing matters from a namespace
apart from it's permissions. So just get rid of it. Also means we could
extend this to allow changing of idmapping completely independent of
namespaces in the future. There's no need to tie them that close
together.

Survives xfstests for btrfs, ext4, xfs and specifically the idmapped
mount tests.

Thanks!
Christian

Signed-off-by: Christian Brauner <brauner@kernel.org>

---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231101-vfs-mnt_idmap-c3b7502f409d


