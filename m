Return-Path: <linux-fsdevel+bounces-43837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3C5A5E677
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 22:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1BB3B1510
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 21:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154AB1EFF9A;
	Wed, 12 Mar 2025 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="uI6awYxi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D068C1EF099
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814577; cv=none; b=B3ojBVf8e+dBJ6idKcKcNps1S1IW5YjlHHXpRwSF+SiNg3l9IvqrLIeimjkCFpluS5X9d6CeZiRHV/ILejI/koe0g2tLItF56i4XNFgg+y/sKHl1rnammBUvY1BMXl6MIkQDWyozN4UgD6FP3aBIivwHf5Vsvp5Aoy0bLowLVQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814577; c=relaxed/simple;
	bh=mvIFvWIp9NnNpqjlb78s7uPPK/9pOen0F/aXj53TS9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLEGP1P5iZ/qiZRblCFIJRKtZvurkM3WytutlCnPyGqNRgFEVH4xT8IYZH0luf2yyc73LkFKY2BA1RLpfJ4QJeecGrr7l5IcKjqxH4ZI/DOzId3B5LsNzKCvfUPO2P8bo3vRTNjrbeT6FBsgUveha/vigppWYVVufHciuyN3vXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=uI6awYxi; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2BE743F715
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814566;
	bh=JJCUu0nnTlIAwhQtLazst1i1S2GtJ41RAYnP5gniTzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=uI6awYxim82/z5f5cvID+u84PqHGP29jae936qURO6TZh3kPt3VKdd6QkBG0BPfDN
	 nUFwZr5tefTaOWSeS2C1nLfySfDhDJYGEOMPcNLyo1JercStvR0sjcr8JcA3BSP8CK
	 CXfGsdg1q9o4/fLkUpopNjz8jQFiSWePp5XRQ71WBH3tEa46uHhl24Z4Tk0xb6yvNP
	 VGn10AfZCM+I28zcs3gUYpiRDmr/i5RXMMN9X4f7mX78WGGTZha8SQN7PG23HA38h/
	 cJTkaQFJ0AFxLq54T1zwnCLYIE7CCBh9gYTmcOsNK5LZUHECkkY8JzkQWJrF+Y0+Jh
	 h412IuCb3sapA==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2240a960f9cso4453795ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 14:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814564; x=1742419364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJCUu0nnTlIAwhQtLazst1i1S2GtJ41RAYnP5gniTzw=;
        b=Z5Ufd1k+/pEgNr1oXS5wvu3Prs3vZNHUJDe0PS2NLD8TZEuCjJPE4yWX162MJrHr7A
         retL2qujJ18VhsgbxjNCETxM9N0EXXuFcjEXFy71Zw9kGzt4BY5KR/zMSh60W+VYv+Zi
         myBEDW3pecEXXk+nd89wlbeTsZLmR/CIkZOR6Aant1lMP9Xe2lF/ZvxUTfSjtz6XcRTr
         bEzba4zFzGnvFdvA5UM91h5Fdqp84mv94y7o6q9HS1qSZWcm6nhnCaIeDVM1kLtqwGhb
         cWkTN1q6/xBCsPjrrnVa7Hfpfeq99PyKZuEGHwmgjeEFIjP4A05vGFOW4cVEylcu/CNd
         naXg==
X-Gm-Message-State: AOJu0Ywaz13phxZCGTknuLRoJYGFLAnsHTRNrqOMJ2+Vyo/cx2Ea45Ze
	H8PY3oDAxaBqcvgn5VrpQ4CrnovsVWKBt5hL7oUVTG+Dr4LPXjAH1189Esn5NZaYHPKC8hUAWHg
	L8buhA918jJHxqje9q03JbaB9VqYS9cEeHHhxa2+DE1oacEFZU+XrqrFqMT4i93dvYOEzZapLWK
	wX3yxNAx7QsDuQgQ==
X-Gm-Gg: ASbGncsQn9ZBqgxjSvxj5QGHDxbc9RZoEzaa14y+KDGPSVVKjTlOtDIuFVhHOKDpB3k
	eey0u4/Fb689BunHJT1bTDDaAk+Xp/kJrzYh+JQY9gya8v+LiFeg3Ug5cyy0XuTeJ9AM8Ov/DmD
	X3er3VKYvM9CFBtZeOD/LerKHz7ibcpJmWCpiybTY37C4VLDdX2FQCi22Re0LDBGchBKNl2+wRo
	i+rGqxj7vn67U18KJALRpgS4UAJGsMM04+ksjRH+DebFJB9LAjL70DqIPUeDq9b/8XhFCsOJa7j
	uji9hb13AN2IUdNbUOsrtOhNJC/aMxRMdosRngymjARm52IVEotFyW7sq8i6uFi2y7qCnn8=
X-Received: by 2002:a17:902:ea07:b0:224:a79:5fe4 with SMTP id d9443c01a7336-2242888681cmr334106835ad.2.1741814564403;
        Wed, 12 Mar 2025 14:22:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjVvzREwSOFKw0Hfsl/h89sadLsPdTTQZ/I/XFETV/GwxC6RNVuLWxGdk5FbZ6Djc3RCsmNQ==
X-Received: by 2002:a17:902:ea07:b0:224:a79:5fe4 with SMTP id d9443c01a7336-2242888681cmr334106495ad.2.1741814564101;
        Wed, 12 Mar 2025 14:22:44 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:43 -0700 (PDT)
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
Subject: [RFC PATCH 1/6] fs: invoke LSM file_open hook in do_dentry_open for O_PATH fds as well
Date: Wed, 12 Mar 2025 14:21:41 -0700
Message-ID: <20250312212148.274205-2-ryan.lee@canonical.com>
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

Currently, opening O_PATH file descriptors completely bypasses the LSM
infrastructure. Invoking the LSM file_open hook for O_PATH fds will
be necessary for e.g. mediating the fsmount() syscall.

Signed-off-by: Ryan Lee <ryan.lee@canonical.com>
---
 fs/open.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 30bfcddd505d..0f8542bf6cd4 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -921,8 +921,13 @@ static int do_dentry_open(struct file *f,
 	if (unlikely(f->f_flags & O_PATH)) {
 		f->f_mode = FMODE_PATH | FMODE_OPENED;
 		file_set_fsnotify_mode(f, FMODE_NONOTIFY);
 		f->f_op = &empty_fops;
-		return 0;
+		/*
+		 * do_o_path in fs/namei.c unconditionally invokes path_put
+		 * after this function returns, so don't path_put the path
+		 * upon LSM rejection of O_PATH opening
+		 */
+		return security_file_open(f);
 	}
 
 	if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ) {
-- 
2.43.0

base-kernel: v6.14-rc6

