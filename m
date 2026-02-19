Return-Path: <linux-fsdevel+bounces-77739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA8kBMt6l2m6zAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 22:04:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D1716288C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 22:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C4F5302C916
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 21:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F62E326932;
	Thu, 19 Feb 2026 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHn0rmsF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BF2318EE2
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771535038; cv=none; b=dmLfcxbrUqVJqFK/rMfztK2DxHoPRWiSVLKNZ068TfzS3iDFDmgLLuqOPFAPWnZeY/PGmqQzXh/6nC8E8r+qZ0I1luqqtMBSG01hCyxxWpV/NfZL9KgEsN/hIg9rkOr9bIJoRq7YnUTtY4cnnac/NOOC632ye9PLbzcNUuLzT6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771535038; c=relaxed/simple;
	bh=pNvvwCxaWteDSrjz3ya2LND8dS5HAFVN2gK9oksO2ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mIV8gfaQPawFaOsNRQ4wAzCR5B0cAUjjaK+Eak8Qb+CaHn+vLGn3WS4K+OmZBts9V1O9fl9UImgK6eeYstH+S3AmAZMy1+Lh1Mj21YkJb/RZa44nZEh109GIoomiy6MHqFVY5408lrKJ26NX9RFs0AEh6br+TZA9rY8pIzlyPHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHn0rmsF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4834826e555so13466615e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 13:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771535036; x=1772139836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lAxExF3Bh85aqNqMomIsLZH79MhB2KBo6F6PX7ObPew=;
        b=SHn0rmsF50AYxL4vve23IsSI5TPwEOCPsbTgctziEi8TBxzvPbyCGWvjnoUCetMzrV
         jSzRs1BRKVpJOaxnBLxzmUmpVLMbhdpq4DWjKSfWW7JLPzq3qJoJGThg/02SkE3dFaza
         6ig3x6jxtVk8RzxLJjSCI01ugjq0jy3Qa0JVE9cj65LVI54z7ol5Jaf4P3jc7wpvJlJT
         r7fgE+LeHQlwlRsNS77HC0GtBGaKMTaP5o1NRQp5gEwlMLEccyLOQX5200TWJhsY7ve+
         fNPftuwq/ZosU1BJj/SDQbxYNP9GmQiWcx2FV+syM23YMrgUSQk6QZNNT8QqDidizHjo
         Evxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771535036; x=1772139836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAxExF3Bh85aqNqMomIsLZH79MhB2KBo6F6PX7ObPew=;
        b=mDJ1KQTDpNb0/kbEH6faLTt4wCuZ7J1rtFJuGTLizRnJccI5VH9Dsy5oula7xD0Xyi
         XawzJQ4/Jsc2ZeKwv1nf9F6e+mmZ4OuBLBb5zHCevT9RrP121y2UHrbT8E/Gg8Kgcmq4
         8QIfsaIAHZw6jVJW9MSOHzdmiW1LTYaSdHQMpnCFpRK0GWUthL6fMFhdGz3OVjIuy4Va
         m4Rf5iGVX9LRIxhw+RcNEwQ6jYESabeGiC8g+VLNzjOEPsc+aUJbEr28kiObUSs/ZGgM
         lrOZQ6mhHn57wUPRDPg/ObiGx2SAYgxD7SUkOsB+CL9cQZUbpzrMmlKXwfTmnu5hBt6+
         3NlA==
X-Gm-Message-State: AOJu0YxBvqIiReVZuYtZWhER2U72NJ0xINKVf+3msJohprrqs6fxNL5I
	g3BKkDfrKS5DkzTd8Z0Wx/PUb61A7IyYJ7bYo6W4R+xUubSWLx5qkl+6z5FS3g==
X-Gm-Gg: AZuq6aJMWn9JDHtsw5xmERUQDfQdWY9Se3iWIUcDZQXo6NfYjUwLrwkWu46gGl6vG/4
	wBvLkAK0O7FckoUto7ZnR9WUMbEdh9yd4nCaqByVeZbuaueOf0pmJg73IfezvlvY9He9EMRUVJC
	23WpzqraaPC0Oy/+JqFFnPjrU4DKqZhUDT3KHdeoJJjloXZlkfVdQ7/MYl4ro01kZ+pF1mjTI8w
	+vbjJkN41Wwwk3HXMW+bsCWKCmEPbUpPxHdKn4veaei+xwqycB+BRJ3RwwixQfET8MTnVm3lV3G
	IpEA1QawJc960DRs4JFKmX2nZvInCmlcumVAeAXZJf5ZOqGuYN7urcJIMZTJu08nDZe8oYAjDN+
	RyWI960aIi7QwYz+tmpMcOpPurwrUGTItBqQClyKVQdCwwFS1gZjkPU4vvh2pLQdVIIBEYkwpUO
	8b0MvpX1X0rS8JnQR3V9I=
X-Received: by 2002:a05:600c:848a:b0:483:aa2:6bce with SMTP id 5b1f17b1804b1-48379c00bf9mr264391715e9.30.1771535035717;
        Thu, 19 Feb 2026 13:03:55 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483a316eb08sm30113295e9.0.2026.02.19.13.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 13:03:55 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	initramfs@vger.kernel.org,
	Rob Landley <rob@landley.net>,
	David Disseldorp <ddiss@suse.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	patches@lists.linux.dev
Subject: [PATCH 0/2] init: ensure that /dev/console and /dev/null are (nearly) always available in initramfs
Date: Thu, 19 Feb 2026 21:03:10 +0000
Message-ID: <20260219210312.3468980-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77739-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61D1716288C
X-Rspamd-Action: no action

This patchset is for VFS.

See commit messages for motivation and details.

Askar Safin (2):
  init: ensure that /dev/console is (nearly) always available in
    initramfs
  init: ensure that /dev/null is (nearly) always available in initramfs

 .../filesystems/ramfs-rootfs-initramfs.rst    |  4 +--
 init/do_mounts.c                              | 11 ++++++++
 init/do_mounts.h                              |  2 ++
 init/initramfs.c                              |  2 ++
 init/main.c                                   |  6 +++-
 init/noinitramfs.c                            | 28 +++----------------
 usr/Makefile                                  |  2 +-
 usr/default_cpio_list                         |  6 +---
 8 files changed, 28 insertions(+), 33 deletions(-)


base-commit: 2961f841b025fb234860bac26dfb7fa7cb0fb122 (mainline)
-- 
2.47.3


