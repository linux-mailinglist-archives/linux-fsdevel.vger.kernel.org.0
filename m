Return-Path: <linux-fsdevel+bounces-69855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DF7C87E0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 03:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E69863510E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 02:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AD42F3635;
	Wed, 26 Nov 2025 02:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMWkveQD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C6730BBBC
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 02:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764125737; cv=none; b=ZqSCI6Eoh3DtW950nj5W6ALY1JorfdrZNhrVrlCBEB7s6JIgDsio5en17KurqlBhlupSmYMCFbX18m/n+9Aaci0ajVLMSpVHtvEcE5qq4jEMWXcXZBVFbTv9mlsLQfLALtKYaGuB9hGezifrfHbGnzpLzlYwyRKlAd0sgrAPJZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764125737; c=relaxed/simple;
	bh=8nunAVieA4O9w37XssbSe19Y/uUHKYciNk0UZswTyQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fON5DNJqRyAYxMnE+XPuMlELi2nMItCr7VhVTPF3foH8EY5JtfGhqA8AGCvpaIbjhyE4wkMu5AqNqBbDBdVdX/dPodG8zI5LkxQzhQwfShSKZh7V/falZxRjqbkAW6nHHLdlKmuqp7BnR7sCZWdgsk1nugclZqqJ1fWy2Y+G6vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMWkveQD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso4917968b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 18:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764125735; x=1764730535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQ1v86AYgGbPvh9JwAml9Ork8fNwqowDeVVE0VvbE/k=;
        b=GMWkveQDJRBcjDRdRpl9ANuicTVI6vJO3LlkczqjTdF99BaMbmF1E8MzdGxhye+jMh
         ZKrKYgBBkDb3MQPqrTkDebOfQFEpcaldXzdiEHtZZL1pPzgHdCkoO4+BlrnoHZTtYj7i
         w6LnM9R548vKAr6Lwp57YgfuzSa0SHdPl1XxrtsOaHq2+ujXg6sr4bKJBB3sL1D7rTqv
         xO9KvPFmog7CwEEivGGHdyEkDqeLIXdIV/sDSC0rPw5oa+tvM/+0SXCFf+0HZZzrkIV9
         JTLV0OI125uflyOfDTFJeXOm8mVsj5mG/NDkvdTtALuUFjF64wHt8Yiq3tMzxWA3BYCN
         2MIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764125736; x=1764730536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NQ1v86AYgGbPvh9JwAml9Ork8fNwqowDeVVE0VvbE/k=;
        b=WJKFbHtsb45sWfevGR73B9Q0pqaqFe27zGGaPqASOeJjiC++FDvLZKxPUWczj9E+3u
         K31tFQ/C5zLHP10jslnC3WPmyPhkkzxkcaugCxn5Ame8kO8+34aa6LPIQc8l3SAT7KgY
         vAkfeail5dFhJjwjxgYfFPfEiKEetU5J12+akxepup0FkQt31cZqqCmvMJU+c8SogiIR
         G6gkFKQnKwbkU0QZjehbeN95H66Y1wgHySApGfrTv1qPtuMAOXufJKcX7XxIfAFDEb2V
         TNjcElRjSOuJHj0vKLz3EZZWjTizTqPiBYdeMmwFDkDvFVAxnU7ABG9qMiv9htezfBAB
         LZWw==
X-Forwarded-Encrypted: i=1; AJvYcCVLJhvo3A6VjtRv0mt5c5zjUiuoY60rb7pwFkf6rtyzOIwxes5fAl94/ZguCd5vFTIlkhk15e58+IVXHtzw@vger.kernel.org
X-Gm-Message-State: AOJu0YyxUhdvN1JfFfB5bH5POd4/Al3I3TMgVzUUDfwd1QbAtRwQJAr0
	SYKNL8g0MoBC3YPdmI/sqdwbwhwA3pesemw/pQSqFgVR/2SUNWffd9Pn
X-Gm-Gg: ASbGncuMFGBYnkY9tCdoukCynmCVQiAJAyJBHZWNCzIw9ZB9vm49F9+O/NZaCdJRLKd
	h0raV595ikB7SYMxm4iwMnzPrICV11DT1znrzbWiXyM6GhCZ20iUvI4f17wWm0ZuskU9IeFNBwP
	6Li3ewKQ5EONVfmPXlobMNnilJAnT+VFJkAdHYu9VavcjlAKU8A/hkGwgiZaIr4gxeGbWLG4mDe
	jUyIJ1M3TrG9Mvmp2wcCdjoOSAlWzXe86sdTw9U18c1Yw9TjuBZIYLEFEJ9Z8CZhAoiAXJu1pao
	yex+VmEXSEU2VakK/Luv2f4vDDMc41ggag5lhnoTndmA0VLdIt3syVght3dxIn2d1CnDji36Hp3
	CfdzmR5Nk1vNb0XcxJ6rrVznOqfZ5eOY2Ey5M9/lZTOl3Y0BCHlUeTooo+bOeqX6V/Z9EKkUpPW
	R5vX7+a6cfkNKgTY0XdrgGSQ==
X-Google-Smtp-Source: AGHT+IHVbc3ystjG28RtgjitLUwnGbdDdLuynpzu0r2WvQ0kwUE3uZgm5k7gSSYgMAKqWiy5okykew==
X-Received: by 2002:a05:6a20:a113:b0:35e:8b76:c960 with SMTP id adf61e73a8af0-3637e0b9e24mr5630671637.48.1764125735506;
        Tue, 25 Nov 2025 18:55:35 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed076853sm19509628b3a.2.2025.11.25.18.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 18:55:34 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id DB3254832699; Wed, 26 Nov 2025 09:55:24 +0700 (WIB)
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
Subject: [PATCH 4/5] Documentation: zonefs: Separate mount options list
Date: Wed, 26 Nov 2025 09:55:10 +0700
Message-ID: <20251126025511.25188-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251126025511.25188-1-bagasdotme@gmail.com>
References: <20251126025511.25188-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=699; i=bagasdotme@gmail.com; h=from:subject; bh=8nunAVieA4O9w37XssbSe19Y/uUHKYciNk0UZswTyQY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJlq2SsNV+7S11lwNj3sN9+CopKTmXL1y5st55zpvuSz3 cD5SZJERykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACbiv52R4W3lqqx/yYdn2+5j D+ltmfmhZOHfr5knp30VlAwpWJa/zorhf/3sop16Wutqd7Z9cup+8O+y0JEPAceWXC+vzUszsDU uZQMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Mount options list is rendered in htmldocs output as combined with
preceding paragraph due to missing separator between them. Add it.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/zonefs.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/filesystems/zonefs.rst b/Documentation/filesystems/zonefs.rst
index c22124c2213d5d..58cfb1183589dd 100644
--- a/Documentation/filesystems/zonefs.rst
+++ b/Documentation/filesystems/zonefs.rst
@@ -307,6 +307,7 @@ Mount options
 -------------
 
 zonefs defines several mount options:
+
 * errors=<behavior>
 * explicit-open
 
-- 
An old man doll... just what I always wanted! - Clara


