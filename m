Return-Path: <linux-fsdevel+bounces-43841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D14ECA5E68E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 22:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5DC188FC6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 21:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3631EF376;
	Wed, 12 Mar 2025 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="NusxHpgG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39DD1F1307
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814583; cv=none; b=rAaWv7tK2SmjfwEEFNhE5rduU8xquaCzKehrkDLnKO6NzE4M0A1/n1WeoHfjD7cHDUtqt/PfkpWJ/ZrVEiFQwDKG8Hu49M3aYXuLpqazRr5hjQ9LyLzY9K9XRXwMZ5iT/FqKQYnMuOVk8r5CJJxaO1Jztd0/Qv5pWRSko7rmdkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814583; c=relaxed/simple;
	bh=UQi4jGJd9JPX9q54M13Eyu1joQsCWppMerqI6/F5Zeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjRjsJY21M752U7+mn4kMr5VOSWEA/ALuGBpHw5FJcQ7MVHuSyI8GEtVr8yZSJRRlme15oBXLZOnOVMw8q8kFyaY9IXHafMCYCXl+yikL1/NpKtWDY/84qvkwfzxgdgA5T4RZRFeXQDsmrePVKhH8E15XHTsqA22FG4oaiTn1WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=NusxHpgG; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B4B663FCE9
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814574;
	bh=vkBChevR2KYwwFZBDZ6M820pfzcyPKZb2PO3mstNSrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=NusxHpgGw0gxX62Mk9uf3yyp/VTF1wyvz0njNHfAiqmFtaE2rBE95UKz8pNvd3AK5
	 G3GZ3EOrs+/vJei6clUU1hr71nYggBLhji5hORdQ6u8XQyVu+kdEeKrUX3fPX6eoC+
	 iHRkYC31hxN1ir/AU4zwAMH57EfuEXF5uLE1JnUf5wOIIEwIBDa+yTUd0UnkwIv6O5
	 xhNL/Z5BBDhdsIxa8ss/SBMtFOo0m5FwttJGFjP+Axof9yt5Bv3dccgRa2enJ0kCVj
	 /yxWC60mQMg6g8POZq/N7/3VimD4nYSmzVVSc60IfiKHf3x1dY8agRiIth74JfQlKK
	 3tf1eaWBPCzfg==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso734410a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 14:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814571; x=1742419371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkBChevR2KYwwFZBDZ6M820pfzcyPKZb2PO3mstNSrA=;
        b=qiSys3FRix4HsgX6Bh1BnSM7stJ+BLHmQWI7qgSQoi8Teq0jMylvNTSrgOz8g2M5tr
         4wIpqhoQk6Sv0HrzAhIjFZtcVfr0oesRwby6esSJK0Ffh293FzuPxQvHws4fXZFBrhc1
         ccTvsvxju7/LwEAjc9Zu2PuQCfolBXGDvRIUXdobUnqJkFY83SaBSRHX15wmYM96rIQk
         8YItf2ZJmrjXl6hS25voHv8BsfEw7bxfy9cHcrQMFf2PdSSMyUWQ7oi+pdFdf0jfx+hF
         UoABGk3UsXq1wLos5L2MWza+l4kBqk30gqcxdciwRSC6Lvnv3BfelVJputpUFCGclyqV
         h+3w==
X-Gm-Message-State: AOJu0YxqG78h3v5Nbbn4WLNuNrT2GVmEZbDOY2c4yS2CwPNuW3yNHa/H
	v1NHpZHS9WFw2JRmmq729rawVLQjEkfsiJkBPrbfSZjqmiuQ8uvGyRXB/hIRPV2lITU3C6Mtkx8
	eJ4PpezT+Yk/KVmYxVjhYyiHHnkqrwPFw/oweD7Tx4kC26wwD+87wizR11RUqeksnwEH51tbfY+
	xc096d0L+xoM7P8A==
X-Gm-Gg: ASbGncv81D+v+mhnb6rGGh+31H80GNrwXlxpnHO/fofnGeynjb4IYazFP1S+9VtzCD6
	IkroYT+NPyIOCqgBxmyFyPd09tdLknDZoNaHbt7CyAauBRhtSsjUtYfgB+Upm+BFmfDdn8JL2h7
	eYjU0RDdiexi5iweVQqa/z0b96MaHGeCqECT0lKZaAUetfLgLwjgyeSaq4eaxTETXNecvhMP611
	hVE7/npyxEOznrl010GqbF+X1Z/VoNHxCo1pzyVGZL3Pmy2Yg3yhmvDC7lb3NgwsnFm/mgeU/no
	XmUKpzKzOXDNRax4z/zH4FMnb2Gb1Pps6myqlISH/Zc4AFuzkCwroijXSujAJ7F/uLFmq/Q=
X-Received: by 2002:a17:90b:1b05:b0:2ee:8427:4b02 with SMTP id 98e67ed59e1d1-2ff7cef76acmr32847514a91.28.1741814570792;
        Wed, 12 Mar 2025 14:22:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2zy2F9PoKbQMeK6fUS3X/Yt717KlC839Q5G4xkP4Nr8/wnDbMYJ8pDxU6TgdAPfQxzzejkA==
X-Received: by 2002:a17:90b:1b05:b0:2ee:8427:4b02 with SMTP id 98e67ed59e1d1-2ff7cef76acmr32847501a91.28.1741814570519;
        Wed, 12 Mar 2025 14:22:50 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:50 -0700 (PDT)
From: Ryan Lee <ryan.lee@canonical.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Cc: Ryan Lee <ryan.lee@canonical.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 4/6] selinux: explicitly skip mediation of O_PATH file descriptors
Date: Wed, 12 Mar 2025 14:21:44 -0700
Message-ID: <20250312212148.274205-5-ryan.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312212148.274205-1-ryan.lee@canonical.com>
References: <20250312212148.274205-1-ryan.lee@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that O_PATH fds are being passed to the file_open hook,
unconditionally skip mediation of them to preserve existing behavior.

Signed-off-by: Ryan Lee <ryan.lee@canonical.com>
---
 security/selinux/hooks.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 07f71e6c2660..886ee9381507 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4009,6 +4009,11 @@ static int selinux_file_open(struct file *file)
 	 */
 	fsec->isid = isec->sid;
 	fsec->pseqno = avc_policy_seqno();
+
+	/* Preserve the behavior of O_PATH fd creation not being mediated */
+	if (file->f_flags & O_PATH)
+		return 0;
+
 	/*
 	 * Since the inode label or policy seqno may have changed
 	 * between the selinux_inode_permission check and the saving
-- 
2.43.0

base-kernel: v6.14-rc6

