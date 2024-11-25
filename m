Return-Path: <linux-fsdevel+bounces-35804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8E69D8777
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C610C168A00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132291B4149;
	Mon, 25 Nov 2024 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5cTmRdu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFC91B413B;
	Mon, 25 Nov 2024 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543837; cv=none; b=uXHuVawDYnWY2g/CRkoXOBhe/iX4apaKUCVgOGnC6DTGrFmAcQJiMVeuooJbqShnFNyToNkUO51bpaq9Qx1Vt7oFokHmnetVDay2ik6ypn1j+LhwPnKtILRIqnwPz/7tQQlg3QjqaI6a8b/Sz4TPE0XGNFEdRL3tX5wHjwwbC+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543837; c=relaxed/simple;
	bh=7ABz71xzGONh3/Bpv6qrDvJuKIRj9Il7TEoVcJoZhTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m+I9NcV72nX43Ai3vkdTNXhptKU8sY0BOJZqFV8o1Xi2ye2kCeMp6YUXI86ElXaPNkFztASoDQmPxyoA654fe57qpUIrXHx9DQuBWdQM3l+JywSXcwrGjpZvkrjV/JA4yLBAg/13RM4534Mi4yJozjlWaD8nbB3z2C37dOtSJAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5cTmRdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725DEC4CECF;
	Mon, 25 Nov 2024 14:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543837;
	bh=7ABz71xzGONh3/Bpv6qrDvJuKIRj9Il7TEoVcJoZhTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b5cTmRduE0eu/rkwtgk/RB5jMzTJUeXFG82QO4+InDGHUp0mGbehJsECe7NJyk9am
	 +su+p82ufNczzt1r6fYrWIzCENy5zsgsAN3SpOd2Pi3qUc5KGWi486fN4ETA9Xc77X
	 CFQpl7De9aZTckpAAQCTMiTPvz5X5Z6vlJp6HEnbUDQb69ZzYcP6Ye88nIQxl6Sb2V
	 jQzbNXiTqP1PtlLpoie4M9Pd4NSIWVMsA6gEv7L7Wqf7Gj6LgCuOlFpXKOZXyixQmW
	 +sATPZSmqiWDjD20Yl5lhvHa3ASsCqqX0VJ4rcPEA0TYj4X3EPH3hyxYSGb/dOrUJg
	 gco1dT70iqfgg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:03 +0100
Subject: [PATCH v2 07/29] firmware: avoid pointless reference count bump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-7-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7ABz71xzGONh3/Bpv6qrDvJuKIRj9Il7TEoVcJoZhTc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHrU74vTUd6W4F9TeKFhV6T2vs8brE/O+M/OuUjg2
 4z3cpXbOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayag4jQ4dzXFRQLr/t2qfJ
 1302RM3c/vep8aKD9vP051Tejl35bQ0jw9nopbPLT67h86s/s1fQJsjcW4j56PfkkFvXTmx8WOS
 ezQcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The creds are allocated via prepare_kernel_cred() which has already
taken a reference.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/base/firmware_loader/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 96a2c3011ca82148b4ba547764a1f92e252dbf5f..324a9a3c087aa2e2c4e0b53b30a2f11f61195aa3 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -912,7 +912,7 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 		ret = -ENOMEM;
 		goto out;
 	}
-	old_cred = override_creds(get_new_cred(kern_cred));
+	old_cred = override_creds(kern_cred);
 
 	ret = fw_get_filesystem_firmware(device, fw->priv, "", NULL);
 
@@ -944,7 +944,7 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 	} else
 		ret = assign_fw(fw, device);
 
-	put_cred(revert_creds(old_cred));
+	revert_creds(old_cred);
 	put_cred(kern_cred);
 
 out:

-- 
2.45.2


