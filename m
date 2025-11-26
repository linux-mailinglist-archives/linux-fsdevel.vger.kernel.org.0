Return-Path: <linux-fsdevel+bounces-69857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8BEC87E2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 03:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68E0B4EAF9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 02:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0A030BF79;
	Wed, 26 Nov 2025 02:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7mk5ndj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1151730C631
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 02:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764125739; cv=none; b=T765ln9ldATJETYDJIos3USz9RB1bL6VQBMX9OHJiGG9QVIlFjxNu11mRWjj6/kzQ1cHabtLgs+cU6eaTwh3XjbEEphQgYbeTADXIBrIf60t48qq2wHNrsh2GRN5gs4o5TTvwbELkcOZQpDqzLrvh0D74qJAdoLYn1uxba6qahU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764125739; c=relaxed/simple;
	bh=eu8w/L4jetrWzX8S8bCyHzu61RjFwW0nWHCcZCg8Aqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUkb+vp4/n0pm0RuWD+m9JmDtoCIUiiM7zPk82WQ64xPAYlJQ61CiVKPaSiV9reoaSJ7rLq8RAVWvDuqgotUA0BzMQMmXzKMuXFfQz25iMCHlcecEP4iCVNK1NjJjuzFdcnAYx+ggSvkOTThd9WUiCKuio1qXZALBWeCLUJhU6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7mk5ndj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so6502506b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 18:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764125737; x=1764730537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KeByN8pZJtcs9SgGB87hOBvkHQ9/iNV4qXnrYiyH/k=;
        b=e7mk5ndjZ3AXGNPvYflkSdGXyBgzMoUu910q7gadD2a5tasV5fN2kzWA4103bnLIuZ
         RV+0Oxie7XGiRFdVxs4AcDdWugMYjnTBpoufo95KNgQjwQUFI7HMdxlbNFf1mb4URUkd
         8s2bzNxTdIihf4sTy2jux73sBntgcyK5n5oEIaoRBJHok2tHLy1EBiP3U4I7pyxQ467F
         RV+IjcVyzu2JD24sCisuT34NFJjv6W78LI4rI1GUuhdQsvkerGj0jcjU/M6ful0HjSXJ
         RhCRHXL8H+eVbHnIA3uv6zCXRD+RUOPU61xp/iuNQZnVE92x9bsv2/pkvKAT0yznCBCP
         Jm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764125737; x=1764730537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+KeByN8pZJtcs9SgGB87hOBvkHQ9/iNV4qXnrYiyH/k=;
        b=ZkN/PDcAQ1VJc50GGmtzAHzkV7UNWRzPkf1uwaditAIxxC7F1E331vX/IJMcWvhSOS
         mDyJYIFL1K9R4do5dF2zK0kw6Z0YtkJed4bHqio6SzxjXfi52ucJHhLHxKSEc8IsQes4
         4fgNkmJEulIco2LufDtHpXRwgd/yZMO0G/DHnbjPupEKpjg72FR/0SmwW/D3viqZa5rx
         UY9jcA1z6UGmLlhgceoGbG4Ml+27kwK1v2eI5Q9UwlTkS9LCnTv/ARlTPWvQn7FelUER
         oQECi9Po2nKjURZjIbppJPwgP+ua9Jtlrd+nlHunCvS+/Wk+WeEqUe0WZg75NXP1Tko+
         j0OA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ/6vdH+bwhxu2XuPf4xkx/sCXZtJ+RBOcxf6rBO9zR/mo129/UU9EEK3IfZhTXibmMmGFzVRMziMs5nrc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx71rgnXTLICsd+Ni/D0bCEN2yjIy8CEccj3EzStrFfPmnrcXNx
	f78UfEmR4OTZrjYw2X7w2b5be2MEz57yebfoCnGHvseZ++AaFZWM1q66
X-Gm-Gg: ASbGnctBbMXUPjYHFsGJh2vKhWptRCbNujoklfWjuvrht41p3C5nGe9PdK7zbp2//+O
	CLL3IFNNoj6jlxkmCI2itZ7RNQRQhtM5GJ+BWH1NDNY6Rj/7OI56mnOzUHxVTgKxQVNjoZdRC4k
	zRF0yzn9fBaBHkClCuhbChRsl9HtJ4Gr0gFdlJkUEAzX/9jDkoBYfaHQ8FVgOHv61f74a/YxtMb
	3dpeCD++8EnHK3OTSPI+vMtGmoElByjLOOK/i9YZRDrC4fG4KoWINTC0ZTHm2bWDsglI9YL50jd
	nKTE+eqsfG/jsen1bWKjwExia1lIIdmoHhl65CQZzUNiI1l9hk/Xazahzw0GWiIfNCHsVsQFiZb
	5HoVj0A71ju5khfGjuicLE+IwduYBdEXwkdH80Jg//QpXZnERPYISHps2PV1LG/aAq7O4FnQ90F
	wKQuIqvoBFSUs=
X-Google-Smtp-Source: AGHT+IHIifJejiWbRdt3S7poUuZWmIaesVFBZv1qrOM6SPQ2pCnhHKZv1D2NutmEuZZmsqcvSOMpWA==
X-Received: by 2002:a05:6a20:3ca3:b0:334:8759:5016 with SMTP id adf61e73a8af0-3614ed933eemr20913143637.28.1764125737333;
        Tue, 25 Nov 2025 18:55:37 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed471f8dsm19859188b3a.23.2025.11.25.18.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 18:55:36 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id EF70D483269A; Wed, 26 Nov 2025 09:55:24 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux AFS <linux-afs@lists.infradead.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Daniel Palmer <daniel.palmer@sony.com>
Subject: [PATCH 5/5] Documentation: zonefs: Format error processing table
Date: Wed, 26 Nov 2025 09:55:11 +0700
Message-ID: <20251126025511.25188-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251126025511.25188-1-bagasdotme@gmail.com>
References: <20251126025511.25188-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4941; i=bagasdotme@gmail.com; h=from:subject; bh=eu8w/L4jetrWzX8S8bCyHzu61RjFwW0nWHCcZCg8Aqo=; b=kA0DAAoW9rmJSVVRTqMByyZiAGkma6nIEzG2WLuzX7sWuVkmC2EQ7u/9SppXX70RrJ4lD8eoa Yh1BAAWCgAdFiEEkmEOgsu6MhTQh61B9rmJSVVRTqMFAmkma6kACgkQ9rmJSVVRTqMe+AD+O0Aw 4OxiUoP5/E9QIU7kvJ7hHIdfZawbesbNBBu9akYA/1IStx6I6qUi0O+8A1KIohdVsRkmrLXyVdq ed1VVzhcK
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Format zonefs I/O error processing table as reST grid table.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/zonefs.rst | 53 +++++++++++++++++-----------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/Documentation/filesystems/zonefs.rst b/Documentation/filesystems/zonefs.rst
index 58cfb1183589dd..a2e97bd69b6347 100644
--- a/Documentation/filesystems/zonefs.rst
+++ b/Documentation/filesystems/zonefs.rst
@@ -255,30 +255,41 @@ permissions.
 Further action taken by zonefs I/O error recovery can be controlled by the user
 with the "errors=xxx" mount option. The table below summarizes the result of
 zonefs I/O error processing depending on the mount option and on the zone
-conditions::
+conditions:
 
     +--------------+-----------+-----------------------------------------+
     |              |           |            Post error state             |
-    | "errors=xxx" |  device   |                 access permissions      |
-    |    mount     |   zone    | file         file          device zone  |
-    |    option    | condition | size     read    write    read    write |
-    +--------------+-----------+-----------------------------------------+
-    |              | good      | fixed    yes     no       yes     yes   |
-    | remount-ro   | read-only | as is    yes     no       yes     no    |
-    | (default)    | offline   |   0      no      no       no      no    |
-    +--------------+-----------+-----------------------------------------+
-    |              | good      | fixed    yes     no       yes     yes   |
-    | zone-ro      | read-only | as is    yes     no       yes     no    |
-    |              | offline   |   0      no      no       no      no    |
-    +--------------+-----------+-----------------------------------------+
-    |              | good      |   0      no      no       yes     yes   |
-    | zone-offline | read-only |   0      no      no       yes     no    |
-    |              | offline   |   0      no      no       no      no    |
-    +--------------+-----------+-----------------------------------------+
-    |              | good      | fixed    yes     yes      yes     yes   |
-    | repair       | read-only | as is    yes     no       yes     no    |
-    |              | offline   |   0      no      no       no      no    |
-    +--------------+-----------+-----------------------------------------+
+    |              |           +--------+---------------+----------------+
+    |              |           |        |        access permissions      |
+    | "errors=xxx" | device    | file   +---------------+----------------+
+    | mount        | zone      | size   |     file      |   device zone  |
+    | option       | condition |        +-------+-------+--------+-------+
+    |              |           |        | read  | write |  read  | write |
+    +==============+===========+========+=======+=======+========+=======+
+    |              | good      | fixed  | yes   | no    |  yes   | yes   |
+    |              +-----------+--------+-------+-------+--------+-------+
+    | remount-ro   | read-only | as is  | yes   | no    |  yes   | no    |
+    | (default)    +-----------+--------+-------+-------+--------+-------+
+    |              | offline   |   0    | no    | no    |  no    | no    |
+    +--------------+-----------+--------+-------+-------+--------+-------+
+    |              | good      | fixed  | yes   | no    |  yes   | yes   |
+    |              +-----------+--------+-------+-------+--------+-------+
+    | zone-ro      | read-only | as is  | yes   | no    |  yes   | no    |
+    |              +-----------+--------+-------+-------+--------+-------+
+    |              | offline   |   0    | no    | no    |  no    | no    |
+    +--------------+-----------+--------+-------+-------+--------+-------+
+    |              | good      |   0    | no    | no    |  yes   | yes   |
+    |              +-----------+--------+-------+-------+--------+-------+
+    | zone-offline | read-only |   0    | no    | no    |  yes   | no    |
+    |              +-----------+--------+-------+-------+--------+-------+
+    |              | offline   |   0    | no    | no    |  no    | no    |
+    +--------------+-----------+--------+-------+-------+--------+-------+
+    |              | good      | fixed  | yes   | yes   |  yes   | yes   |
+    |              +-----------+--------+-------+-------+--------+-------+
+    | repair       | read-only | as is  | yes   | no    |  yes   | no    |
+    |              +-----------+--------+-------+-------+--------+-------+
+    |              | offline   |   0    | no    | no    |  no    | no    |
+    +--------------+-----------+--------+-------+-------+--------+-------+
 
 Further notes:
 
-- 
An old man doll... just what I always wanted! - Clara


