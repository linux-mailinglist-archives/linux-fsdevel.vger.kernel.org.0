Return-Path: <linux-fsdevel+bounces-66935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0673C30E96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 13:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1A6422B8D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 12:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49852F0C7B;
	Tue,  4 Nov 2025 12:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4tghsQD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7352EFDA0;
	Tue,  4 Nov 2025 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258361; cv=none; b=ueza7Jbh9TTycl0yetsKSqp/CDjHfVpiaZ5qivwz6t3cK2J8WPjmVQ6aTSH3OKlomuN3KBhpdziOk4MgOh51m9f4CNWuTfMR1Hx8zCfxrZ7c1NB2jdQMPTv7DFPCInGJUhhxO3WgUrmPvwAKqM8lMCDS9HPc8OvpBihMtLzokp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258361; c=relaxed/simple;
	bh=R9BumAJaVt8SSfVFac0I71M+gKfDkpFXl4eTAQt6ZqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i9hMfnRuxX/JIFe3yUzhKyVrhLLMBLuf5cYMuQoxhQYdkxhfVoH59jkHiK5dVR5UYIn3emOKinoUeaya3xWOYA+51Vxe3iTRX+iW1cn5rJ4c0KUwoUcCsJsCDbfSBScYYOWO95wH+j79jq5uuw7OVowo9JRH3FiEugqutt2X/vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4tghsQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3043EC116B1;
	Tue,  4 Nov 2025 12:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762258360;
	bh=R9BumAJaVt8SSfVFac0I71M+gKfDkpFXl4eTAQt6ZqY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i4tghsQDIVg9EBaaogHhvz22ThJT9+YaRKsNZPaNGHtwYFTzwEvxOiG1Yc2y4hEaZ
	 kB86BDZejeuTlN51EzpBPKckHJIVP5S2E5P/VjFCCEeOzZoE4FZvhysXoALJl64Oqi
	 S9c8r65Vw95AN/079zaTXCG5AtlUJ8pl3aAGM3tpFLxUd+xlb4LpZmFU3UTkyZgZ2u
	 xo6MHpFmbsnPcgHUv4UqOA1edE/IiJkp9S5tOWRnA/kHvBvtHQDNfRtn/rWETm5qnx
	 1/mqiMOQ1rWpI5Fx+/JOUkBNGumxe+HyPjYYZOBndnHOyXyIIpDTl6bkNlkeXNeHp6
	 w2XiQ+ACGSXag==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Nov 2025 13:12:30 +0100
Subject: [PATCH RFC 1/8] fs: add super_write_guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-work-guards-v1-1-5108ac78a171@kernel.org>
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
In-Reply-To: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-xfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=664; i=brauner@kernel.org;
 h=from:subject:message-id; bh=R9BumAJaVt8SSfVFac0I71M+gKfDkpFXl4eTAQt6ZqY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyvt1i11e4tOq+15XbDXOm+Qt2TNJdpFp4JeHyLQWOW
 4wO1p8aOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZi1sPwP/2qpNEp9tc2Dv2G
 Hb/lrtxay/lCP/br/E+Cgtd3XhWq92Fk6K1faJjLvsTZc+8n27TI61JxiYUddxZ6603ePe3Jkqc
 XeAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/fs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c895146c1444..9d403c00fbf3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2052,6 +2052,11 @@ static inline void sb_start_write(struct super_block *sb)
 	__sb_start_write(sb, SB_FREEZE_WRITE);
 }
 
+DEFINE_GUARD(super_write,
+	     struct super_block *,
+	     sb_start_write(_T),
+	     sb_end_write(_T))
+
 static inline bool sb_start_write_trylock(struct super_block *sb)
 {
 	return __sb_start_write_trylock(sb, SB_FREEZE_WRITE);

-- 
2.47.3


