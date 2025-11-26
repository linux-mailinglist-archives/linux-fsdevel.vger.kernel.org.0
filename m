Return-Path: <linux-fsdevel+bounces-69856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7192DC87E23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 03:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 251FE4E2A51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 02:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6F530DD08;
	Wed, 26 Nov 2025 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4QV7Uqe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2AC30BF6B
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 02:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764125738; cv=none; b=P8HFbtUq4pTFHsD82KICPn4xwzZd8PGAqV+3d73mQrE0UO0pmiBaoW1M028mFmHnnFes6JX3Oz+Oh0tfJWu399lVQXzdQe9rpmf8F1l4zKfMbFZCovfb6nmQHx1ZeurmElzsYeoNNHwnMwXvZRaAyWL0WPsUowNs+3OaLERpamY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764125738; c=relaxed/simple;
	bh=flQQ+p9EPZBsRnUUjNajnPPbgxqkevBix7E0+4gZ/48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NyMUALNjBaAomTdPRhIRZbLAZsrX7WEQ4ZYQPhN2ffc0sBZMNvma4kiOGve8kx8F91mgioBJIWvFvfw8CwRi6Cg8KJoqUfdrcwIYUYNkI2YttFP350XkigbfO6+9NLeBC3QbTjxhiATqt4mjFr8PFTZk/pSIfyDbd7AZ+FYtgRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4QV7Uqe; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so5702216b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 18:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764125736; x=1764730536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOi2SSx6yNBsrEeWui+Quc5HTWSCmGH/Tx4kBkU2ROo=;
        b=T4QV7UqeAuWhVv+m4paD7HMDCeUXgRkZQSJ2GYPTGV1f3bfTZGZWV8LFXdwPx7nHwm
         TstgiyAnTdkF4mKe39sxM1sk7cYLW7C5h81/tKsgUxXQ1BV1Koka3z2hkWkRMVvtcufR
         J9UFwODyZfrYuSckNGcKvR53x1Vl1I/59m5EQRoQItR40XgCoOgv0l09zq0gT1LXsteQ
         0RDRkFIsGUifz5XGwCV7Oq2z8wiLzAQ6eANreD20J9u6x1p8cjXG/CfqBEHu1DqEhNCF
         e4i4QFUGw7SzHzRYp7qYmXgUei8MKW/o6lSGksVJF3I21MH1SYpG9qU6cUGRB5CWW2s+
         Zqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764125736; x=1764730536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hOi2SSx6yNBsrEeWui+Quc5HTWSCmGH/Tx4kBkU2ROo=;
        b=c+nCHsyI4UJe9hp8M4jK1CVt3cBUu2hU1lW3FKHo6GZnYi9H+zJ830ZIrJPP5nb2hJ
         ljQICmfdeNuqD1Il2MGUX9IHWn4BrGKI1lCXAuhj3PsQDdt567AhUNCvjAHU640ES4oC
         AuZw6Uhwlqy+KzL6+DpjFTNxsNXQhTGi+iMfRcl3rFpzI6VbVJw3FZfvVisOgDBiLb0q
         pHMP69vdK3NNGhjmhEHxJ+u4BbChXzB9tO3TeAc0nt135bSCfZD80VkhMw8t6zHoFxmA
         z+AvZnOEMqVFv4emEr8uZPjD4RH8za75a5ifpW9GnsZxNwbNdMpbLJSU0146fQIlcuU0
         Gzsw==
X-Forwarded-Encrypted: i=1; AJvYcCVvJ8hFdjXIQvHCS3B7iVkRM3qS2x5WLe2G55m3Y+4ucoyHyrwk9j+iVCBo+KJfnUTmp9OPLsyYlCF//xaU@vger.kernel.org
X-Gm-Message-State: AOJu0YyuD67k7J+jsoqKZc2Sh/oQUe5dSu57PWcH3epb80JhyKIPDFq8
	o8kkkDORkNkkkHtG/i037Jxj4ugEd9mc8tfwkz2LN+7+ST0RIpt8H3F0YybcbinS
X-Gm-Gg: ASbGncskFssynb5K0PLRV32wcdzv4WEvSFx94wZcn/YY4HDzcZPF6yhuebFf05dgFkj
	SrQiEaB+BwYZrGVHxeuNK2a9uo9G4L9HmA4/qbnJ67PTSgKGVuLsP0tLNTtDHqvoQJBSMIsVzbn
	5EEVKl39MOMhpD/O2Usc9WBhVB0/MO8Qy/KaDwZEGQzBiJtW4M/0K7DwMXrp3Oq+p39FjOSVbis
	TEKbc3ryfxfIzkXOfXxeaRr18VF89PbACJJ8ZYefcmLauzcZoVB6AheCMzm/BUBzPohozVNdHne
	1mLHYV83ZhlsEgMb84wpAB6SPtyF5qjkoHhUil7Awx3EP0+qVMLa3BCtQYk1U25xJ4jk9RGFUgC
	l3xIat0J5YzC6jzIrtu12dSwUj9zYs1QVxNuGv+Q1lvgVa2vtpaFcg4PyEjGeTuK12ZAbPEMj51
	ViuPvDtQFsMvI=
X-Google-Smtp-Source: AGHT+IEHBzWHbK0JtdGRu7LTkyTetWGV8Bp0c9o3CW5NTNaXLf45k4YycOLV9mqvKMkZ9DY6Jmqs4Q==
X-Received: by 2002:a05:6a20:9186:b0:350:1a0e:7fc5 with SMTP id adf61e73a8af0-3614eeb0d8emr18539845637.60.1764125736418;
        Tue, 25 Nov 2025 18:55:36 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd775ccabfdsm17407798a12.29.2025.11.25.18.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 18:55:34 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id A1EB6476D832; Wed, 26 Nov 2025 09:55:24 +0700 (WIB)
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
Subject: [PATCH 2/5] Documentation: dax: Coalesce "See also" filesystem pointers into list
Date: Wed, 26 Nov 2025 09:55:08 +0700
Message-ID: <20251126025511.25188-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251126025511.25188-1-bagasdotme@gmail.com>
References: <20251126025511.25188-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1213; i=bagasdotme@gmail.com; h=from:subject; bh=flQQ+p9EPZBsRnUUjNajnPPbgxqkevBix7E0+4gZ/48=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJlq2StvXp4xeUtVu3yxm+XhsunLZZi/K83SU/sTUfXDX q/gzfGTHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZhIygKGf2bGYZ9OLJZ6rnyi mCEv5of5mmu/0kte/71h41Kry7rK5Qkjw36HOxG1ez8uY7oStMN4eTHb389cjny3ry6ePCNm1ir pYi4A
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Filesystems for DAX implementation inspiration is listed in "See also"
admonitions, one for each filesystem (ext2, ext4, and xfs). Coalesce
them into a bullet list.

While at it, also link to XFS developer documentation in
Documentation/filesystems/xfs/ instead of user-facing counterpart in
Docmentation/admin-guide/xfs.rst.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/dax.rst | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/Documentation/filesystems/dax.rst b/Documentation/filesystems/dax.rst
index 5b283f3d1eb113..e0631d5f6251d4 100644
--- a/Documentation/filesystems/dax.rst
+++ b/Documentation/filesystems/dax.rst
@@ -234,17 +234,9 @@ exposure of uninitialized data through mmap.
 
 These filesystems may be used for inspiration:
 
-.. seealso::
-
-  ext2: see Documentation/filesystems/ext2.rst
-
-.. seealso::
-
-  xfs:  see Documentation/admin-guide/xfs.rst
-
-.. seealso::
-
-  ext4: see Documentation/filesystems/ext4/
+  * :doc:`ext2 <ext2>`
+  * :doc:`ext4 <ext4/index>`
+  * :doc:`xfs <xfs/index>`
 
 
 Handling Media Errors
-- 
An old man doll... just what I always wanted! - Clara


