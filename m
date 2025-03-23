Return-Path: <linux-fsdevel+bounces-44821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC241A6CE25
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 08:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB2657A4EAC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Mar 2025 06:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2338F20127A;
	Sun, 23 Mar 2025 07:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih52ne1C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278053FD1;
	Sun, 23 Mar 2025 07:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742713237; cv=none; b=Im2dKCWs76QgW+OZbwylP75UKdVCDDMHEV/5TcCSUsFxylaIBr1XvvXhzbd0pfgdByMwuRH10gmQq5YKEUSYfkPqXhg0l5NjPljuCsbIpnHMLjM3puz+x8j3TwWQkEtsRz8hNUJCKSH5OLEpCr9TpnCAhVADr29Wh+2WC053/ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742713237; c=relaxed/simple;
	bh=eRj7ZyYdHApUuqrgnDlrZoak4fEqCjIc9LNCmw5Ib8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fnj/EvK/k13Ti+DdJU/uzg/lZ4BgQeiqSIOUDW4RGER4GD8yXdYxx1YXdAOIMnsYJCgtouGJRtPztj/RCgh692iS2L4InfkxWpwY7f6H2G7l4pjmWcVeymXQy3E9+lp3nRC145UoVPyZxcKBxAZwHF5ZCW3DYCTx+xUZRTgRb+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih52ne1C; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-226185948ffso64207525ad.0;
        Sun, 23 Mar 2025 00:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742713234; x=1743318034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmGMB0N7I4U2fl8kJydMFtAwhymEfbcfkap4BCaT23g=;
        b=ih52ne1CLgl36pO2Ra3wEsoxjHpgbAFCkxSrbbLczL9j8hyOL4XVGZZ3sL94zsSdJL
         2AGb03cb4xN1NuIbyIBG0Yk+GaC0orSdIeChBg2JffaJYZPcET/bOcGerDAY2zizyA2g
         uxfRGwN+wnbd3/jeU/HV5NzqwXIgEBKtvSPYcn5wWcYdopHkRCMDV7eeKZsFqDeAH+rI
         3AiusZjaROI+mDlAjGRCjnkVMZGiSuelbh2dPf9fEemNiEY9zm6g73KQKJCd4BH/Q+ov
         wkXKHs4l1es5R5Vh4/ets1C/Dz9XbNcsNEMHGRFrEM2n8jBxHzPGqUASYMAV54sGV5ia
         hAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742713234; x=1743318034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmGMB0N7I4U2fl8kJydMFtAwhymEfbcfkap4BCaT23g=;
        b=I/FKA8+cHylMxnMJ4OLMPAuzRB6flNaSzmm9+fAfBDn8/B1pgsv3uG+YOGAkQJi7wr
         aHm4vPD82IxZQcgb5c+0iqek/hMA51qyTibCt9Rj4dSCmoSCQqRSVqVqvknSe5i7VcuL
         7eGL1f/s7eBZfhnziU8omRdJXawEyXYY15UMy+K1a1e2dhn3c+0bdQ7/9QlWdf0KGrAu
         U+4AZ4ALS1EXuUpgop70ZSoWJ2iQfNiC/D6Pk/bGsSSntOJpBhkslYlasKnIKVsKXmQb
         ESJLZfQJ321dQlrRoJa/Ps73Itoa0jfr7w8otL+pMkQ0yEfAEHzr+eOfi4AhLWadmXms
         8RAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEbRVqRPUJtMabjPMvNzu372Ob1Rt96WIxov0TI+bMU9C9pTMEQHmzx3X298cPAWoZgCYYhva7ATM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrq9jRJhW/uVYKpxB9z5GkK0RWdfrkoJoLKqGE05mtn/D0Ytsp
	68OrQYfyxTU671FfN0AInX2KDLFpfPXfi36c8QLOSVOCoFM4rUUdeJl0gQ==
X-Gm-Gg: ASbGncv+EBK7uihY1SVBUpXxx+xCzHVyVxNG9kV2GRhXpwm8ElBjpi5nh5MwlUOlC0p
	RWKnm+3CZx6uqcsLquhsexT2metPV0mRecCruptJ4MkcHh9d6F/Ea26vc16tCPaAHz89FAnxYEZ
	QWZ8I/Em/ho3huPec+ZoQBbdzXPTQuUxmqPH5O9Z4nbt3r1YiDP1zetqigXM6bJEjMNcsjpyrNg
	CsazyTh+sru15EHtC+oSSeyKFawI6LcxvtYfWzrpKnzpyyMkoaQ0scAJADd9er0U/8s2oL3Fhvv
	eYJOtqc9SCGp7+ne9asjdCY4qx2lsPgK0vipV/IJd1e8eHukjPc=
X-Google-Smtp-Source: AGHT+IGXcZVKTGQcTJ9vF9fuL563f/7jX7j63B5aelTw0DiAlqKRY7jWfkq1zWwAVQopQCEHT2lVFw==
X-Received: by 2002:a05:6a00:4b12:b0:736:755b:8317 with SMTP id d2e1a72fcca58-73905a501e4mr12816549b3a.21.1742713234143;
        Sun, 23 Mar 2025 00:00:34 -0700 (PDT)
Received: from dw-tp.. ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611d21dsm5168717b3a.118.2025.03.23.00.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 00:00:33 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv1 0/1] EXT4 support of multi-fsblock atomic write with bigalloc
Date: Sun, 23 Mar 2025 12:30:09 +0530
Message-ID: <cover.1742699765.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <Z5nTaQgLGdD6hSvL@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <Z5nTaQgLGdD6hSvL@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an RFC patch before LSFMM to preview the change of how multi-fsblock atomic write
support with bigalloc look like. There is a scope of improvement in the
implementation, however this shows the general idea of the design. More details
are provided in the actual patch. There are still todos and more testing is
needed. But with iomap limitation of single fsblock atomic write now lifted,
the patch has definitely started to look better.

This is based out of vfs.all tree [1] for 6.15, which now has the necessary
iomap changes required for the bigalloc support in ext4.

TODOs:
1. Add better testcases to test atomic write support with bigalloc.
2. Discuss the approach of keeping the jbd2 txn open while zeroing the short
   underlying unwritten extents or short holes to create a single mapped type
   extent mapping. This anyway should be a non-perfomance critical path.
3. We use ext4_map_blocks() in loop instead of modifying the block allocator.
   Again since it's non-performance sensitive path, so hopefully it should ok?
   Because otherwise one can argue why take and release
   EXT4_I(inode)->i_data_sem multiple times. We won't take & release any group
   lock for this, since we know that with bigalloc the cluster is anyway
   available to us.
4. Once when we start supporting file/inode marked with atomic writes attribute,
   maybe we can add some optimizations like zero out the entire underlying
   cluster when someone forcefully wants to fzero or fpunch an underlying disk
   block, to keep the mapped extent intact.
5. Stress test of this is still pending through fsx and xfstests.

Reviews are appreciated.

[1]: https://web.git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs.all&id=4f76518956c037517a4e4b120186075d3afb8266

Ritesh Harjani (IBM) (1):
  ext4: Add atomic write support for bigalloc

 fs/ext4/inode.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++--
 fs/ext4/super.c |  8 +++--
 2 files changed, 93 insertions(+), 5 deletions(-)

--
2.48.1


