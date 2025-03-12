Return-Path: <linux-fsdevel+bounces-43838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C726CA5E67F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 22:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 495423B88AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 21:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070501F12EA;
	Wed, 12 Mar 2025 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="wXHZQnMA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CCD1F03D6
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814580; cv=none; b=T5zjaohg2rKgS2e+omOv7ZPVgC49XVzHTZJnTy+qLsYsK4FXHKOh3WoYbtSxgWmFoXKax7NPv6lS1BtmX+vT+b1jNzr51HHhlgWBG0S3N1qNfWuG9xvPYaLB1SMxRIMLaggiuIQlbXQ7lJ4SCxndQI2MWyiZsqlcf23qZMEvbjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814580; c=relaxed/simple;
	bh=b4+VVCuulTVS3lasReYQ2g8sMWbZpqYEurik+q7TDIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVR6aWcMxQYZv8tHv8XIwl2rJ7S31LA7a/gtXOSkDhT6DwWOyHPjNC+8xEONpzDw7h3dmWErctV7wEnYMbg+Dz46P1DGDLqpAXVPXbaYa/xNrvBHm7Aan/HugoiIeiaUQIL536/Ke5E61Yj4CMvXjHLvv7KCAaHrwaHuTX/N+NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=wXHZQnMA; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D1D413FCD3
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814567;
	bh=uqtVwBDq5g90YIrppYWGT9PUS27SLEfARyjY6b0CvJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=wXHZQnMAbweFyixm/4yjK71qO9242A1HNYoXX/nCd8p+RYITpNU5PZTBrcIvtgw7s
	 3Cfua9ykXolkNe8sqNhQTewpZzDEo9hJ8v22TSgfp936vThetM6T14br6KexQGwp4n
	 +Isc3riXaRUo2ZotDauFSLzZeYnIW3I/SI1Qh0dY1yv3rC2RXh+bC5LeZLkAE2z9vL
	 hBoLp6v0DiHX9j0JXXrgUEsBEpHG2OiqmOdkIOiyl5ArlJK/AmmvedXelZbphpQSgx
	 kr72q+roBfgDo+g6bXTg0/Ix14ooarH0l/+izy2fDMvlut42EknAd7q6yoQjnPB6Vv
	 WerhTrb8BANqA==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso764367a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 14:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814566; x=1742419366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqtVwBDq5g90YIrppYWGT9PUS27SLEfARyjY6b0CvJw=;
        b=LqUn+RTlAK3RH4uLLuLGHb25llXRiExIw7qQ1H1uXoUAlHxPB6GK/dNXCjZE5s5dV4
         MrU97MmafsW1LPw0cC4Y9rnstwCjjoCN3SdSTxV7ic6Oqy8A2Y/foizr2WbbjIlckAaN
         p+oxM7uo+xYHD5vrFua0DVKqeVLn8xetDXVCFxiUCLxj5n5ElNgLXXcpFAfXKk7IE/FJ
         nc36fQ76DmazEs1i6Oh3P+GTkojj8vYr+Sv9PxVymv/PLUCs0NJqpcOhVS/pe9BgfP5W
         JGkyzpowM3wx3r8pn47SKI4G3GTihvdm6+2p+aFJ3xe7xVGdwqla4tERjgXOu78ewwrP
         Z7HA==
X-Gm-Message-State: AOJu0YyrRbZq9EBoCvQgXpy9m5NGTDpj3Uu1rk2sOcPK06/jCgxHWlHR
	iaEsahAfY7o1WvBVK5HzqS58kRD4C41u5jh2k2kJmPPxw1Sr99yHgx+WbcGzK019obpBrV8lHSO
	g7FAYLt4TPvoqdtVrlgYGx+k+8egY2eAkSFrxsdRMCUHGZy5ZFzisNPvNMUVQsDLhAE8nmplPxp
	6CWVpFEQ60zTRtfA==
X-Gm-Gg: ASbGncsVhLBxwZ3lVKsO84Cvd0Tw8JEHslrsWYdWqn5TXJJ3omCfJTifFhcMpsNuZaD
	6ws93/Qjrw7f/EbacLFrT/c8NTu7YpbmIquF7maPixMCBIoXo2vbZp0I5lVT3dS5OfJv5l+hDkt
	/4qi/WatTUdtaPpYWlzeonRae4VGpSIpGKmcNtS3V/wfpZjv28Ac/CMsNPjsx8v1IVuqmL+d8Ub
	/kGy/B8JJcyLRAjxQSRSWqD7CbBVeXha54ZBIceuqDq83k6eOxB4R72jah5oY5RRvUKaZraRPkJ
	BZE6DL378Qs7F0B+XRFGm9Alt4VmQ2ZqAcvo/oLQxjLt1J0l/MIDimz9WENnwtcgnWwlhNo=
X-Received: by 2002:a17:90b:38c7:b0:2ff:62f3:5b31 with SMTP id 98e67ed59e1d1-2ff7cf2a4dfmr33760027a91.29.1741814566526;
        Wed, 12 Mar 2025 14:22:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAh7edf+w4rzXzQLR0fkq9YMtlXCTroL93A1jr+Tsldo2r/RTEDBE9CJvpxWToVeKTIWZWGQ==
X-Received: by 2002:a17:90b:38c7:b0:2ff:62f3:5b31 with SMTP id 98e67ed59e1d1-2ff7cf2a4dfmr33760017a91.29.1741814566237;
        Wed, 12 Mar 2025 14:22:46 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:45 -0700 (PDT)
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
Subject: [RFC PATCH 2/6] apparmor: explicitly skip mediation of O_PATH file descriptors
Date: Wed, 12 Mar 2025 14:21:42 -0700
Message-ID: <20250312212148.274205-3-ryan.lee@canonical.com>
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

Previously, we saw O_PATH fds only when mediating fd inheritance on exec,
but because they would have no request associated with them, we would
unconditionally let them be inherited. Until we have better handling of
O_PATH fds, preserve the existing behavior of unconditionally allowing
them.

Signed-off-by: Ryan Lee <ryan.lee@canonical.com>
---
 security/apparmor/lsm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 11ace667cbbf..2349a1dd41f4 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -647,6 +647,16 @@ static int apparmor_file_open(struct file *file)
 		return 0;
 	}
 
+	/*
+	 * Preserve the behavior of O_PATH fd creation not being mediated.
+	 *
+	 * TODO: we weren't handling O_PATH fds in aa_inherit_files anyways
+	 * (all-zero request -> fds unconditionally inherited), so proper
+	 * mediation of those will require changes in multiple places.
+	 */
+	if (file->f_flags & O_PATH)
+		return 0;
+
 	label = aa_get_newest_cred_label_condref(file->f_cred, &needput);
 	if (!unconfined(label)) {
 		struct mnt_idmap *idmap = file_mnt_idmap(file);
-- 
2.43.0

base-kernel: v6.14-rc6

