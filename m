Return-Path: <linux-fsdevel+bounces-43840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B58DEA5E685
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 22:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A75597ABCDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 21:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64091F1517;
	Wed, 12 Mar 2025 21:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="vmL06F9F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93F41F0E4F
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 21:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814582; cv=none; b=Y8GskxNpcjRDsw9CcZUHhTMv0trG+gkbx3HzbQV/+11HMqEaWdm1k+siIh2mDzq6z8P4UuEYXurGbm+5XErCtoBhsLEI1ndju148WmtqQTtGZKj781RGbKaXqpln4mSek5GkpCL6wdEBz8agYENW0c7/YOloGe8XoBzzSr9aC/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814582; c=relaxed/simple;
	bh=YKJUOhSAlbceCTtQeFmVs8IFwOcyWaVLfzVCuOajKmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnqYsL9/erPW7DR7ZtGztLEvF2aXmkkJkeHTtQ8htyDpFhTTz5OGtI0Ukch+WWpp8BhZOsykTooN4FJrQUv0e7n7Zo0UgO7XFSPZQ/MTT3YpBo+eZAfXQYpqcvXl92mlB0G277STJhat/JSMPqWvQ0QucLDtkktD8+KOk5ntQik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=vmL06F9F; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2E7693FCDD
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814570;
	bh=bQ5ilq+qjctbW08HSKcwKvLmj0dzCcpGagg2F3uVrL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=vmL06F9FBtpJLaaYr55tRaWWAuRysWlSghmlHws+4ccfGIOKu/r09XtkJ0t2XeANd
	 i6mp2xCB2TcwZfGBQQko9G7AptQBV6tAVGPPt+Ny/IdmUxR3AsLJcRYT2JF93t6Tbr
	 KPIAH1xPhRWNs9Yaat8RznLCojnUFhn1uD77B3EU+nWlfhWXPS9b7txWNmiy7XJQSN
	 VEq4ftfPlpUlroju6uaPfkAmUVq4lAYrho/T2qX/+pcv+/MHxlKcIfnPIKu7pMUieM
	 I0sgw/skR3jkjn7NgU72gDmhz8J2SOkyySW3W8l80To2O+b7ga9qDH1LkXYoZkSmiq
	 C1faCZS04BR3A==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-301192d5d75so804187a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 14:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814568; x=1742419368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQ5ilq+qjctbW08HSKcwKvLmj0dzCcpGagg2F3uVrL4=;
        b=EwlCecXyQ9/dvlC+iwAwH63fR804OydrCjaEibPoGqF1K6DefjVVU7VDXd7bjGOaT+
         xl76ooaSKosPO3FzsHcyy7gopZu9oVv8ROjvRpBlmrKRcJULJWsNcWzRJjnBIDspE58k
         Oq3gPFCKu/rW8VsE7NJMfYSQ35+9Ty6gY7JKI88vA+m4p0ic1yqr9YFfxy22UHN4qK00
         nU8abWeAVRh4L+qFVYjGGXdRFK4EVUpesY7nID7FZuEIsSGtTXBDP/3EdieXAqcv/xvE
         /EOli/UU7K1+h03OzJIkJT1kvR/jFYLoR/RHQOrAwWFj2BzSPnngXYyvHPME24xtVe5G
         Bb0g==
X-Gm-Message-State: AOJu0YzNx8nF6nftdHi1SYynKifuMl2ScR4L7lxb6o+4xym4+5VHxaU4
	pfUIrzBjvSEkOLyIgwGqF6dxxgx3YLITxvcZLbPfSs/mvfXYd4y+9HdCbFYWuYT3sS37MX85gL7
	ID/wAzP8cwN0fdpwgcCMwhsg+jGTmqbvR7NeK+3Cok9HN4cEX7dBQC5brgrpB1ev3UNuiIq46L8
	kjjljHp5lvKNqfsA==
X-Gm-Gg: ASbGnctsk1aGp2FKRHgFs7CmUoL/rBrS/CZUkIAipgnyfJ57BhH7WXSsP8c1MwoFfnr
	y6wucI6ggHAWASyQIvsmYt/5MZzAP7EKu0k+ksbptQ4PS7iVam4fRKdrzidxtwhdzQkhTwFeH6p
	UYqrxg20BJTI67Ixw8VsVm8cI3WoQQya9vOO/FOsG0M5LP4BI9va/FbVBVWl/l2nbo1Nx8IAP7M
	rJsNbyl/bxGomryARxFzhAe0bEXO3Nw0tnzRpPRSNY67dnnFIjrC5g6Ldz2P3OGBlN17gIq4I6f
	lCZQArvfiKU8kkU8yP11UDxafn8VyY3CDSDYWNZtC1camFBOXjEperoa2bJoTmR9bMgnZW0=
X-Received: by 2002:a17:90b:38c8:b0:2ee:74a1:fba2 with SMTP id 98e67ed59e1d1-2ff7ce84c7bmr34243259a91.20.1741814568678;
        Wed, 12 Mar 2025 14:22:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6kNFGkR2Ar2yfV2Wm7/OWkigwZeggzkNDef+VFj2HbCWbxEzVxXle+EcNd+qkPs6JAUusng==
X-Received: by 2002:a17:90b:38c8:b0:2ee:74a1:fba2 with SMTP id 98e67ed59e1d1-2ff7ce84c7bmr34243239a91.20.1741814568350;
        Wed, 12 Mar 2025 14:22:48 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:47 -0700 (PDT)
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
Subject: [RFC PATCH 3/6] landlock: explicitly skip mediation of O_PATH file descriptors
Date: Wed, 12 Mar 2025 14:21:43 -0700
Message-ID: <20250312212148.274205-4-ryan.lee@canonical.com>
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

Landlock currently does not have handling of O_PATH fds. Now that they
are being passed to the file_open hook, explicitly skip mediation of
them until we can handle them.

Signed-off-by: Ryan Lee <ryan.lee@canonical.com>
---
 security/landlock/fs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 0804f76a67be..37b2167bf4c6 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1522,6 +1522,14 @@ static int hook_file_open(struct file *const file)
 	if (!dom)
 		return 0;
 
+	/*
+	 * Preserve the behavior of O_PATH fd creation not being mediated, for
+	 * now.  Remove this when the comment below about handling O_PATH fds
+	 * is resolved.
+	 */
+	if (file->f_flags & O_PATH)
+		return 0;
+
 	/*
 	 * Because a file may be opened with O_PATH, get_required_file_open_access()
 	 * may return 0.  This case will be handled with a future Landlock
-- 
2.43.0

base-kernel: v6.14-rc6

