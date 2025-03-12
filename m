Return-Path: <linux-fsdevel+bounces-43839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5541A5E683
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 22:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680F916F814
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 21:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940D51F12FC;
	Wed, 12 Mar 2025 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="MtivOH+6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321121F03ED
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814581; cv=none; b=dkf07oz/TS4NHOOI95pTQcUWKxng0LslWurVAQHTJ7XRZQm3E+bi/otB3EzltsHxvKfGUotvL9/3wMhtZM8K3GQep8dzATO0bUIDVIpf9q2C+8+At1JoA7Bg7bRm/PaTEAmlmw+1YgMZdct0QaESJ1xSJj6HJ7a3zw27i4Xm9ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814581; c=relaxed/simple;
	bh=nQa75EiYN3ygFHWP5CltgBdCU2YvLoFl9S3DeRklaTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSFXuKY8p1nGjE8Mlpqqdu/0Ult2c+JuRyiYgLPSl1VDU4uT8/XreFMvo4M7vBr5LIz2V8CgyMcHPxELjLC6PJyR+ZWAXYWUtUaKQrBqiGSw5dEH4USrvIUwBh+TuebNV22MU9pdxOScOwfSlCPc8mAYW4e8NZZvYeRhb3W2GNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=MtivOH+6; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8C8753F718
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814576;
	bh=sxXlT+NKuH/R8o+IpND8qEtQPr3+MVFoHvHlcLQeNOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=MtivOH+6oH6UTK+4oGyQtFWdgYBGpW1BvdIHgh7/qBgWgjWjFrGWySzoHsGKl+Wi1
	 fYnl06dylR21woajIXp6AXVh9C8ZXl04c1KymASkPC5WuZZvkcBm0TylCB5hKHWSKp
	 0nHMhzpPgd8O0aqjmT0ROyGy92jzeVKpOuGR9SxD7bxJZphLTSzozF//tMsXqRSU5c
	 0wTSbuyKJ9bPxuwydT0jholChSKtU0CYNBty8n8j3/wOnjMVxjcWitVhBIqWMBpGPb
	 i1acZ3ZFESWEkR+tosN3uSDjCZZMe67TmqC/IrO8gRxKhOR7FgynA9yqqT3A9yVR2J
	 XIhth+M5B7NnQ==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff4b130bb2so535180a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 14:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814575; x=1742419375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxXlT+NKuH/R8o+IpND8qEtQPr3+MVFoHvHlcLQeNOw=;
        b=dxjyBpJ/qBhevSn5KM/YQyb+OLRmGH8ztYUjTtg0CDK+FvhXzznu7KBWzEDMZZxHIu
         mbLQjwI3A8q3HADxUTnwgC8CtMeyw5PR5hr4XzP3Otc5x5UDh0le5On9v4xL8J9gvQiG
         Dwuo3iehI2gbY5GzpNXk82uQz4doBTAU/t/gb/L0DCrsgz1MprOkXZbSMFK3CKjXTVOc
         LWpIiGCC65d3sKi0t27HI/874vUkXf9fnFEUYs3wMYMcst46ym2M4bgJEpMDDqKk0ZAM
         PxlGqwfD0XmqRAFVMfPOD76RImhwK6/4GOxZHw+CCv8EvZiUghNEwrTXbwEZTfdEfAwo
         HoSQ==
X-Gm-Message-State: AOJu0YxXbNqn8qW2QqTfkD+sZth5pZ1HWpOlNyzIL33QZiw0VhIOoTC8
	q3vMAX96xttwvbWpiSGYvSYBY6ylxqNRe0v0FQBKoQnCpvAxWvBjW0CBf1R8+bequkIKoFreZrr
	4fVhzfoB4gS4/f/YJP4P8ml2ZdFlMtEyQMivCQtBICF40vLxh7HRdoJGWJvNz5LDMg7MJCSKJbM
	66qwrI7aI0pibvHg==
X-Gm-Gg: ASbGnctJ0HCJCWGqUTLUCyjAnKLYqhnswo8nbGyTOqTKFrjKLXQMgn+vJUEapclrLhx
	l0l9UzA/8dwbU4RzZZsaWvYG6ZJ+hg6qAMSAZmfWKLnYmz5v4ulGxO7lukF+Sy+LaEwOgn/V7ue
	25luMsGGihC4CCuSF5NP84s1a/eoHYpx74iS2Grisodu8yeSI9Yr/p8LiD82zEEEi8nIeIh2xov
	hKgE3ueJOcnaATR/htMuKRQV/gOYsQnqchiX0o57XnTUOv8xl19EoYYfesphhkdIaTibsO30A0w
	cGUd476yhOM4Qry+vXw8jZAdBhqBNN68uHcrKPR6UYFFt04vOv4aefYLImYraC2oV0fVL1I=
X-Received: by 2002:a17:90a:7345:b0:301:1bce:c255 with SMTP id 98e67ed59e1d1-3011bcec36fmr4989215a91.27.1741814575224;
        Wed, 12 Mar 2025 14:22:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7VJ3I6Ag0U5c89zoKAvdV8xkokC+gkGPKK5VTC7ZbVdDme14D+x+zHYl4u3ZWPKhOLxMFvA==
X-Received: by 2002:a17:90a:7345:b0:301:1bce:c255 with SMTP id 98e67ed59e1d1-3011bcec36fmr4989199a91.27.1741814574931;
        Wed, 12 Mar 2025 14:22:54 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:54 -0700 (PDT)
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
Subject: [RFC PATCH 6/6] tomoyo: explicitly skip mediation of O_PATH file descriptors
Date: Wed, 12 Mar 2025 14:21:46 -0700
Message-ID: <20250312212148.274205-7-ryan.lee@canonical.com>
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
 security/tomoyo/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/tomoyo/file.c b/security/tomoyo/file.c
index 8f3b90b6e03d..efecfa7d15b2 100644
--- a/security/tomoyo/file.c
+++ b/security/tomoyo/file.c
@@ -762,6 +762,10 @@ int tomoyo_check_open_permission(struct tomoyo_domain_info *domain,
 	};
 	int idx;
 
+	/* Preserve the behavior of O_PATH fd creation not being mediated */
+	if (flag & O_PATH)
+		return 0;
+
 	buf.name = NULL;
 	r.mode = TOMOYO_CONFIG_DISABLED;
 	idx = tomoyo_read_lock();
-- 
2.43.0

base-kernel: v6.14-rc6

