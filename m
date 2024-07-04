Return-Path: <linux-fsdevel+bounces-23099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAB8927286
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 11:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A870228D7A6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 09:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6191ACE7F;
	Thu,  4 Jul 2024 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cus41wZb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8FD1ACE79
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083527; cv=none; b=QRdkCKFQ+gHxx8jOaWx/wvtRXv1OAlTHBwI/0Wlv5+zpwFpW2jGTZyvXySnFlBwz7SNcuQgYkl4UuaGt4VL5Se6y1Dr+uggPJzPIeMErB/bky8v1bCGujaAYtDVWT5RSL5FgFbM0C5mEr6sB0t69rJSEIZuRNTcIrCXLcZTuFqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083527; c=relaxed/simple;
	bh=UJG1wOqcCiDuQkY/WXPl68e+MxRoorI7DelKNreEbU8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AZJtL2JTJKR8BKJyeh+FUF+Ha/QlUH6sUNu0F4TW4pU+4AUdMNEyJYdRFGcGVwuSGwPVt4wFRkvXDGE74q7pykaQ0QEw77r0ubEmvp4hcgYYyIH5+nkS/q3HPdI5CHNOPD95ecBc1kQCEd35bngzQIvXkgV1S++eXY6ZsOyCJM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cus41wZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EC0C4AF0B;
	Thu,  4 Jul 2024 08:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720083527;
	bh=UJG1wOqcCiDuQkY/WXPl68e+MxRoorI7DelKNreEbU8=;
	h=From:Subject:Date:To:Cc:From;
	b=cus41wZbAgS3WO5yd/0uSUH3FxhT+LKCH2xD1ma7t/9TNIojzfxZPRVuYdul6e+h3
	 XC618VXJrbTWZLVQHKk28/eopmLh46BR8UgN/UafT2SIFR1LTOYBOgsFgO90Cab+ty
	 3842FabFS1FvEEAlTOIraaACaB00RJEoEk1j69h2CzY1rRBz1kOVOo0RAFMTnW62RH
	 jeKOC3U0q1Knehes67LddjYaoxVH3ukZ7YC1YDDJsVahicj0CbMQ31730JZlImEg/0
	 8IENCopsgVkkLlgk1tiVaI74jom3KEsgq8kw9y4spcf8tAIp7lLTFF0zlzVFOYBktV
	 Bzw0aeVBT7PMA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] Reject invalid mount id values early
Date: Thu, 04 Jul 2024 10:58:33 +0200
Message-Id: <20240704-work-mount-fixes-v1-0-d007c990de5f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADlkhmYC/x2M0QrCMAwAf2Xk2Wg3ChN/RXxou3QLzlQSncLYv
 1v3eBx3Kxgpk8GlWUFpYeMiFdpDA2kKMhLyUBk613nXO4+fond8lLe8MPOXDFP0Q3/2oc3RQc2
 eSruo1fVWOQYjjBokTf9RUR5ZMMzzacl23E+wbT8oPtbriQAAAA==
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Karel Zak <kzak@redhat.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=openpgp-sha256; l=329; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UJG1wOqcCiDuQkY/WXPl68e+MxRoorI7DelKNreEbU8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS1pbhct/A95vO5XUOsq7Pi8W6vKoeYq3dcdkeKT9lU2
 /NsD5dARykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQkVjMyLOLcKPKr7KybQXJo
 Ydly16mfY092KzuqcIRdvLD+U5PoXkaGq82JKV+OtW/7+U48VPf628nB6eLHV1T+yWBYqlmyk6+
 dEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Two small fixes to avoid doing unnecessary work if userspace provided
invalid mount id values to either statmount() or listmount().

Thanks!
Christian

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
---
base-commit: 682d12148c264484562f130f0c8584839ebc36fc
change-id: 20240704-work-mount-fixes-cb4d784a1fb0


