Return-Path: <linux-fsdevel+bounces-43836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C94A5E66F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 22:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E41168A12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 21:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313621EF0B5;
	Wed, 12 Mar 2025 21:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Rc1pNXbF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB3B1E260A
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814575; cv=none; b=PuQ5/EjAAGgJrxVhHiyua/UUghUKAaBGs02+Hwbg9cWjTJmQ8XnSNbtA+uj6u3Loo30Tfu2g/EJczgd39AuoAFjs3GNiZqDPlmQaPPslcskvrgg+IuRK/rvSkM0X7/lv5J6mxCjBmV4wEQRn1BBxuaFJfBkbI+wTnsQagPJjFGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814575; c=relaxed/simple;
	bh=6cBhe/0J0x7XG16Ij8KWWPYPemaK8pVTxylYk+O6p0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dTQ/5dUqoJWaxztuV9WAG2x/HE90x8XOJORb/iI2cknla+HguwP+DvnQoh6RnVzQYgxKVbSr8HGCJTQf54YFy2KzHahcUGsQz9eEdAtkx5oQzw3GT4tEob8dUUafJWAdjl64XKonT+inmlq/a2r1GHdSbNG2xsgQ9jGB2yKeI90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Rc1pNXbF; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EAF583F5B6
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 21:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814563;
	bh=UYHE7PfrFzAetCRzPVVNsPinECVfo2Zm0WG/ZDMIyJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=Rc1pNXbFbnXXCbTzwMpSkrJv9F+x6BA5D2j9tVs9bxHaaOP4BoMneWMVkCzwLrRy8
	 4WunHHnuh+eTZghZZI9PZXrKjPeVPfOOFB5V4ef0D05pbWwmbarOQ9u2c6bazz5A+O
	 oLKtEWr7+pdiZEJrzWL/m9edy983t18LjHo8oZOVt0jpo4HnVFXmHmN2lMCgWoXU2N
	 kpW8goWoxVlE9pY4GF5RIBymc4B5G2CIwLrMsnaNwM2ztsModpVt0S+x/JJkS590+G
	 frN21DvvN4WsboKU4MixRfr7VXhM9xIZ3QJJr+9TfXvqJV9EGrU8ZHELYC4Pi31/J9
	 qS0jv52lhsDCA==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3011c150130so466220a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 14:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814562; x=1742419362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYHE7PfrFzAetCRzPVVNsPinECVfo2Zm0WG/ZDMIyJE=;
        b=Gethqv5uWkT7prca7d37ykUhHDTKJP0Ye6+uBVS1JU7uxdWsolexIqSdJYmEnsXDi8
         rVK04LMA3PI4VEv22IXP5uaLnQr17HWkG+Vz6IvkJc1kDGNMAQsQTUn3PBGVWtt0pq19
         B2glGRUEDxpWvLgx6OtxwNKKH11K0rRROIIvENczcLDJGO8fbRy/NZgBdCyhE0Doj4ob
         C799iSbmaxTZ1T8rhaJSnM1e1bgw+AFOU2FRsaahwHUI8E2qwjnp3G5wNeUnrd6uOX/7
         gzjk3NxQkxyJpBO5A4As3X5FVbMAUx29Rpsnkdz5faBiRk4GL2CRNzGdPsTYA75tek7q
         Rc8w==
X-Gm-Message-State: AOJu0YxuzBhM5Nj6OXOyXam6bQlrX5zrSkUijS4kf+4ajyfvYw+wktNV
	zV2fP2X61v+kFqPKuX0fmKTuaW2921NsfuH/fwGO7cD0WCHIqulek82o1b/TwwluNYeZGcsK31P
	AUaPyQDl3osR9NPj6Mn+Zb4lxF9Ieu5syyepAglfWjgHtlO1CHya+bz0EFuF2aqiU1A+o6Hzb2O
	oXuAX43P9oDsHIfA==
X-Gm-Gg: ASbGncttCD9aKKnuXjTwYuy5kQaaC//NZLBd1QKkQ5M807o/vmKIwEUxFRc9RaNEkTg
	9909hdwwC/P5Dg0fPk2WkW+HjoYN4DuDOG1ttPYAZKpigGs5JHKyhwgPuM3dFOkpI8cCC6aK1cj
	8Vux9xw1GY6BHt2vq+ltDbSt8b33BPd59Y7hTMzur6/DvF8H45zo9YKAQ1kNEe7wzJLxD1YUB/c
	UIkSwIzUR654sXr5MBPwViQ7RCNXBX5jcmraxbIVYBrXazxnc3yXzs2GOflUwmHHJv0IqoywtNr
	sjS6gKh3DwSFwqx53VtKBwEXhXDoyHJtGRZ2q14Vt4dHiqigNJyVweKlIuWqhhCYztm5ewo=
X-Received: by 2002:a17:90b:1d8c:b0:2ee:f677:aa14 with SMTP id 98e67ed59e1d1-2ff7ce6ff9dmr33955126a91.13.1741814562174;
        Wed, 12 Mar 2025 14:22:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESqd74aQLaRYMlhUC52mOCTMPtX58VJpqPHYNlhWsmVgCtfWUR4bux5MtYAMon8vBiSS29gA==
X-Received: by 2002:a17:90b:1d8c:b0:2ee:f677:aa14 with SMTP id 98e67ed59e1d1-2ff7ce6ff9dmr33955108a91.13.1741814561871;
        Wed, 12 Mar 2025 14:22:41 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:41 -0700 (PDT)
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
Subject: [RFC PATCH 0/6] fs, lsm: mediate O_PATH fd creation in file_open hook
Date: Wed, 12 Mar 2025 14:21:40 -0700
Message-ID: <20250312212148.274205-1-ryan.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calls to the openat(2) family of syscalls are mediated by the file_open LSM
hook, but the opening of O_PATH file descriptors completely bypasses LSM
mediation, preventing LSMs from initializing LSM file security context
blobs for such file descriptors for use in other mediation hooks.

This patchset enables mediation of O_PATH file descriptors through the
file_open hook and updates the LSMs using that hook to unconditionally
allow creation of O_PATH fds, in order to preserve the existing behavior.
However, the LSM patches are primarily meant as a starting point for
discussions on how each one wants to handle O_PATH fd creation.

Ryan Lee (6):
  fs: invoke LSM file_open hook in do_dentry_open for O_PATH fds as well
  apparmor: explicitly skip mediation of O_PATH file descriptors
  landlock: explicitly skip mediation of O_PATH file descriptors
  selinux: explicitly skip mediation of O_PATH file descriptors
  smack: explicitly skip mediation of O_PATH file descriptors
  tomoyo: explicitly skip mediation of O_PATH file descriptors

 fs/open.c                  |  7 ++++++-
 security/apparmor/lsm.c    | 10 ++++++++++
 security/landlock/fs.c     |  8 ++++++++
 security/selinux/hooks.c   |  5 +++++
 security/smack/smack_lsm.c |  4 ++++
 security/tomoyo/file.c     |  4 ++++
 6 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.43.0


