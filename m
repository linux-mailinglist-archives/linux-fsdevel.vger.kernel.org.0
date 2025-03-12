Return-Path: <linux-fsdevel+bounces-43842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976D2A5E68A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 22:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18842170132
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 21:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF001F192B;
	Wed, 12 Mar 2025 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="e8JsmYR+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6BE1F130D
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814583; cv=none; b=joRMYHKs5o57c4gfJcttWr/pAW7vmp6N3vyBvfhdebNwNxcLVPBKm8T32FNFPEYEULOZq24VwzEo/nW8St7X1G4JxXddKNmy3H1vP15eJqJfhGO9hZ5DfhjXR3ppOu76s2lqiWPOjoVSMEHN2Sq5Qdqwbbo6tVo5p3j7ehQA+uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814583; c=relaxed/simple;
	bh=G2e3iolvH9qEslV/akG34i7cS7UuqJvA1p2iiSDOzVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PthjYb635uazI0uc2HJ0fxTT2/YeSktAUk0HK7VL9y002r542DnQXTt6e4gWqS3Sf7UMb+Xuyi0lSrzbvPnVfs0LXBPoTEKWsGoUxkn51NhI/Ryb3izJXojK/Kz7C+HSXwFR4KlKG3yRSdm7KU6PNiB2FFaqzmig97WVoQnE4aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=e8JsmYR+; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 46CFC3FCEF
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814576;
	bh=yf0KmmK+2JCiuqTR1dE5uJSectdXjdHO7BaOi/Ze5/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=e8JsmYR+bmqnDO8ig/JUHN+ga3YznlIadNIojqds0ZG1L7WDRwkxHIzpzFsneg+E5
	 0srcB3RsuXrVQ5MG3MWonPvlf8gfMjjod2u4SMJ1jKnC0UuERRgmiAAHp8yoB2HPqZ
	 OxVkH+9w2zXikhY0F60PuuRqZ8yIxDBNw270dYrgm8x5ikmqkOuzFuopIOVY+vBCWl
	 2kfer8F4Vb1RE2Bndr4A8Gvfo81TDQvmFaoy3spv8NzsLJOeWyRc6y7rGm46EJwmsh
	 c5kDw25JpC45ZMERGVjT1glEyxSBt7zUpxa9mPK25tYo4HOZVYsTDlJ0RimYfqc0Av
	 HWF62R3YHdccw==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff6943febeso480138a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 14:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814574; x=1742419374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yf0KmmK+2JCiuqTR1dE5uJSectdXjdHO7BaOi/Ze5/Q=;
        b=WY/7DgGIxhxKT2Ehv9WOkNEt3/NvqaifTkUp1MP2tJgcTN+r650oSUmlIyNq0f0HuX
         k2RB+SnW7Tf8NS5z24TH4riCTaLEvIqooAZVWomrd1OVimQPdmixUgO1K3rqlextP/pm
         cQIg0hJYegZ+z0MMB8lfmBcWpiWX8a2d5RknXvOGQIF4c5xEx4vI7n93DS57YY3fKb71
         aVb3kpOtp9EqGX1PExEXc6M1Fr8Ft8NtGwAOMBoRmRewTlD4mDzBxQ1WEUZTl3Mg4Jbo
         BeLdMvGuPWjgnaDl7qhJBTw1jj2N4XsjqL1uorEPla13LbErQMnvCByjnxlY8B77LaBH
         jL/A==
X-Gm-Message-State: AOJu0YyZma9Hzpz0MoUvXuxTaoqMcNxiLsFpJeLJAPVdLjrLXpsm39Il
	3fkq60KJeLXv6BGgs5Sp/YtkUtTFyQx/exn/j6dx7EfVFj+aoCU4pr5uDmyioCdouSPNx5cBK+5
	fULjHxcfQ4AeeT+FkoAQ4jWe95FgEo3gy/qyiw7nq7Aqr69cHjqN6JKp8dZQoY7t5Fer2gp49Xs
	nPVmFnRHeS/rnn+A==
X-Gm-Gg: ASbGncvxPmttEKGSXsXKRceMVnHsidjhfbPXtVqxSz0aIIvC9zPF56tvIfAndBJ8Hid
	3PvwiSGHiIF/q+Hl2pjXaL7usA6qecD6VgSXLX73UNGLcQLFtH8d6ZKVuqlESmJ78kMceGQpeOX
	eEuqd5v/rVMoEzAQmrWrFAb1XtziD2i7fmvAnGAbOuk0ro5iWxLhW+pOdTFtL/DNaJmvMy02Fo6
	MITxSm8hrYQAASlGp4apqeLhypMMH7DrGyU/ldrY8X5vzu8h+ovBmQqbbrCM6D4MiBHPlNUUpTV
	QenTmYJHAzLzJQ2oJfDVl0NWaEPzmuB53/UkgIeKf/c7QqZKml28Yhae7FTHv8AElya9zt8=
X-Received: by 2002:a17:90b:3bce:b0:2ef:ad48:7175 with SMTP id 98e67ed59e1d1-30135f6037cmr88389a91.15.1741814573786;
        Wed, 12 Mar 2025 14:22:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwAw+1MiMC/B8BNZEJ4oppU1sIELS1vCTl7SNsacHdi/KdGlgg9CgoB/KGdKxX2Zf2vFxSyQ==
X-Received: by 2002:a17:90b:3bce:b0:2ef:ad48:7175 with SMTP id 98e67ed59e1d1-30135f6037cmr88319a91.15.1741814572564;
        Wed, 12 Mar 2025 14:22:52 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:52 -0700 (PDT)
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
Subject: [RFC PATCH 5/6] smack: explicitly skip mediation of O_PATH file descriptors
Date: Wed, 12 Mar 2025 14:21:45 -0700
Message-ID: <20250312212148.274205-6-ryan.lee@canonical.com>
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
 security/smack/smack_lsm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 2f65eb392bc0..c05e223bfb33 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2062,6 +2062,10 @@ static int smack_file_open(struct file *file)
 	struct smk_audit_info ad;
 	int rc;
 
+	/* Preserve the behavior of O_PATH fd creation not being mediated */
+	if (file->f_flags & O_PATH)
+		return 0;
+
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PATH);
 	smk_ad_setfield_u_fs_path(&ad, file->f_path);
 	rc = smk_tskacc(tsp, smk_of_inode(inode), MAY_READ, &ad);
-- 
2.43.0

base-kernel: v6.14-rc6

