Return-Path: <linux-fsdevel+bounces-58259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED8BB2B933
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 08:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F8C1960FB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 06:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EAE271450;
	Tue, 19 Aug 2025 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giMbf/qk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD65F26B973;
	Tue, 19 Aug 2025 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755583995; cv=none; b=NUj7Dysx1shps1h4VJCEXlMyIvVGc5k2yJiXYMoVSOxd5Gb1Cc/K9YheUi1Z6V70/ZqHl3w9FToYVNdYIJt1ahooGHYQR4xSRiAlfUbXX4AOjLFqKqICl6V+Y0OrjQrUQiAHAnzefC/gcD/BXXwpC7b7A8FNxyDb+WrtB47iE5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755583995; c=relaxed/simple;
	bh=QvbQ3Yi9pFPzh0dk01am7J13l7ixDhkVqrIdUZUGhb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEU/JAWN3Y0J7/MXbu0+f8Y7fzv7VRekVjnwfNuHk5hGOr6oafdEgpWmJ17KwzE9GjW5oEP1BtnxZhDI+AcZ1JsTMWQ4a2sZLnd64XCWZRkX70wph7BtjQ4yC1jDw+j0Ljy5FoVsj4Bob44Fz/PnOSl9Rffmbq941uwrYLS/6lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giMbf/qk; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-323267872f3so4187396a91.1;
        Mon, 18 Aug 2025 23:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755583993; x=1756188793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaZrleaHbOR6yTEtT9sf3iBhWN1ohy2mL86EbvZxfqc=;
        b=giMbf/qkvmcbFgDlZeB8PjN9ltBG5uzCwODffV2cKS9+hyGhLof9vKkU5NXQOPYLUw
         f07KPyTfkNkV/QIw0JZaHg0L/8Wq3i4VpukQK9L4YAl/dAVehZwqT0FrIwEd9aLmHXn6
         W36Fsj66PSn4JTkmizKtyjfAhRuXr5lSyyDfhLPy+XRKQC2B0wZCYB6HooXxvBnqcm2x
         TKqhTTGZuTuunks8YU9RbGUi6YVl0NbNLLjP8TKKeOm3pa82N7XwnfWfOVV+WP4d+Fyb
         xI3u09kA9ShBOUBpK+7oCECZ+WaCjRIvFTaflVp0tDW7+yJU7LUDzlASa0cNK2tk1obH
         WDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755583993; x=1756188793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaZrleaHbOR6yTEtT9sf3iBhWN1ohy2mL86EbvZxfqc=;
        b=dLpVQOF2eduoqtdIotwx5AB+4WZnB3nZnrqFfU1XdwxmifM+Ay9pMEbfNoraxR8owg
         VFCj3SLiGY2W/dRzzJbzSz48XpGGM4sVuQDOyGQJzav1NJT+UazoSQhV6T+gt5D+72J9
         02H/RZ/u4RkZjiBS7YhCEbNrrzrgdfX6w1ZL4RVkO5v8u3uf/ofYxbvPMXX6sP6ISJ+N
         tVe4nEIetN1AzXFsz8i6psQBMkV5x0oCieEc+4Cq40y213sk3RvYzsO0yRQFVGC5nvek
         xbgem0FL7MwQo0rLev7otbC/cqOexhYJ/QN62u1bvEBb5CJsR8Ec8M5wrje5dosszb1n
         rgWA==
X-Forwarded-Encrypted: i=1; AJvYcCUASrYPSIJTgsU1EY47zMq9pLqZ3S1t7Z50G1TUDfJnt+1Lng5h+pHZStoANH9UsueaQ58WCWYdC70=@vger.kernel.org, AJvYcCVhq83z8xeptADKu/wOY7gzBQuyNY9qp9sNlBXz6Q4REFw2n9J8COgO6pDf14h8x9+VkuEj/oQhjxim0IB8gA==@vger.kernel.org
X-Gm-Message-State: AOJu0YymB7/37ZjWaogGXHcgAmPWaNFxOYPtzxlUeUUoS7yTQByMl22D
	CK7s+s2ZOdhtYRFPj1UKys15Fv+nToCiI+AYs0zazvmQmBtikSoO1v7P
X-Gm-Gg: ASbGncsji8TEcerppzVzzZXzLDzFTEkwGyj0SzIxI9N0BN7GFvo722B40DCD/ttKYdl
	5FW8gGC5S55SaJHEKCdycQCI2MTM5oxW8QUT7XSNlmhMDyAUrBSDFhh7tJYahG8UB/bXAv0iN0p
	Tzqh8gSvvum4dDwK0n6aF1NVm/92zHYkzy+Dmkd49oRNIfgf44f5Z6vLfyuThTRo3bmADUPWhqn
	EfLZdZ5urv98ZRGoMbppeTnRivdFFRO/0BF8wkdJfdWHlg2RkGYln+dxyg+WCa06hY0DTOAltTe
	y2M1dH/l86YSOGHmg/FXBtQmr38hm6JcVRJvWxOu1e7CzBelRR9t0QKsk3nvJX4PFtiynHyJ96v
	b13l1YRqwV4rDWO4gLfy6B3zaFhtkPT8o
X-Google-Smtp-Source: AGHT+IGU58wwfT/quTp7EuntTbg1eQWm60+JbZHn0Oeg/m29Gae1PjVVDhcgaza6WxCqdYYE47E1Vw==
X-Received: by 2002:a17:90b:4ccd:b0:312:f0d0:bc4 with SMTP id 98e67ed59e1d1-32476a4a623mr1950322a91.5.1755583992736;
        Mon, 18 Aug 2025 23:13:12 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b473ce25dafsm7160306a12.17.2025.08.18.23.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:13:11 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 55FC64650015; Tue, 19 Aug 2025 13:13:04 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 5/5] Documentation: sharedsubtree: Convert notes to note directive
Date: Tue, 19 Aug 2025 13:12:53 +0700
Message-ID: <20250819061254.31220-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819061254.31220-1-bagasdotme@gmail.com>
References: <20250819061254.31220-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2074; i=bagasdotme@gmail.com; h=from:subject; bh=QvbQ3Yi9pFPzh0dk01am7J13l7ixDhkVqrIdUZUGhb8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlLRF7etkiJrHvRG+XVubXLzmdL8ob4RuZ0lbXldTWbP BVfXXLqKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwEQufGH4n3B1OvstuxMTdToZ Ojrk7ViFkp98vJBgfsT+bccMoR0qyYwMjUf3NPDWn9wue5j3zRrT+ojGRqHygxXi/s8b7GsOSvZ zAwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

While a few of the notes are already in reST syntax, others are left
intact (inconsistent). Convert them to reST syntax too.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/sharedsubtree.rst | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/sharedsubtree.rst b/Documentation/filesystems/sharedsubtree.rst
index b09650e285341c..8b7dc915908377 100644
--- a/Documentation/filesystems/sharedsubtree.rst
+++ b/Documentation/filesystems/sharedsubtree.rst
@@ -43,9 +43,10 @@ a) A **shared mount** can be replicated to as many mountpoints and all the
 
      # mount --make-shared /mnt
 
-   Note: mount(8) command now supports the --make-shared flag,
-   so the sample 'smount' program is no longer needed and has been
-   removed.
+   .. note::
+      mount(8) command now supports the --make-shared flag,
+      so the sample 'smount' program is no longer needed and has been
+      removed.
 
    ::
 
@@ -242,8 +243,9 @@ D)  Versioned files
 The section below explains the detailed semantics of
 bind, rbind, move, mount, umount and clone-namespace operations.
 
-Note: the word 'vfsmount' and the noun 'mount' have been used
-to mean the same thing, throughout this document.
+.. Note::
+   the word 'vfsmount' and the noun 'mount' have been used
+   to mean the same thing, throughout this document.
 
 a) Mount states
 
@@ -885,8 +887,12 @@ A) Datastructure
    non-NULL, they form a contiguous (ordered) segment of slave list.
 
    A example propagation tree looks as shown in the figure below.
-   [ NOTE: Though it looks like a forest, if we consider all the shared
-   mounts as a conceptual entity called 'pnode', it becomes a tree]::
+
+   .. note::
+      Though it looks like a forest, if we consider all the shared
+      mounts as a conceptual entity called 'pnode', it becomes a tree.
+
+   ::
 
 
                         A <--> B <--> C <---> D
-- 
An old man doll... just what I always wanted! - Clara


