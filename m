Return-Path: <linux-fsdevel+bounces-46597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EDAA90E7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 00:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4993AB11F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 22:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D6320299D;
	Wed, 16 Apr 2025 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDdU7yqh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABD92DFA42;
	Wed, 16 Apr 2025 22:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744841804; cv=none; b=F6R7v2MNEmEeot1VfwyeowIVikuvEYFQh1xR1ib9MIVQwSyNEgHoNF8TuCZ2tgQzbHuS6KWkOYZoCLfakMiD5ubZ1Efz2LZGmNPZb7D4wmwGNEjWOS5fL69kJC0BKh6bUF7lZW+gEDF4x5pNqc5FUhTX8E3kjEvuxJE8/V79G88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744841804; c=relaxed/simple;
	bh=nSmmzdD+pQetXo9lVLPsZ5t/jfAADgeWQITWfkNK9bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxCtXaahA7GtWOGuLE9+KwsRRDr6MJJOoLGiUZXsbIVP0py6KNOT4UyugmMqrpnquiC/62YigxYjuXaZ7MOibAe839a2Uf5yzQgnDFqp//3SJdDDZF77yG+mkwYHfyMtFY0mUuEPdj23vnDNvBZuQ/eT80PuuRPVD6Lci35FzBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDdU7yqh; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac345bd8e13so21359766b.0;
        Wed, 16 Apr 2025 15:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744841800; x=1745446600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEz6h0gt1CPxDzmuBdENeEBNB0I85Lt72JrHUOpOfHY=;
        b=jDdU7yqhKe/qBShKMsGuOsxYA+WveL4BZf4SOob2YPjA/Iu6/3sXDNr1yi7mFkxfKE
         IsNUoxFn0rhAMl1SOAxe0RNN6i8H0IJTeKOzA4QrpZfGys6Sb4u0TBSwhYbOYOw54LF4
         rW8tb2qOA70sHbZyurGK9+aBHC0EccCPodm2SCHcw+1yuuMy8gt96fBkXJhh+wUn6g53
         FFGxwioNMTIgLm2WPjNbyLCp9NNcq6CrmsW1ZAbMmuYaI2bVhulHZrWQENWVydMf0kAg
         lQO2nOpC4NQrnB5DKr3QGqQvQCh3MQuNgfFgvx1bM3wSikJfyOEVD7a1C7KLS8WCmRdO
         BRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744841800; x=1745446600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEz6h0gt1CPxDzmuBdENeEBNB0I85Lt72JrHUOpOfHY=;
        b=kd/N4dxBKRgQeEVRGyCKc5yhYcJ/AcqbBAOvhBkIOpyAjXSnjsqhcYWRfBfskPNKrT
         6RPTinn8EG5bH3G0aD9mv4YOEBXvRiTnfvsNoCeCRsXhbCadt+ThJA4DCcJkTK4vxGg9
         uhZbbNp9rAdsGKDEMsTXrsscKfZq/XbZJrvnnoiAM96CpFmaql2weDsa1k07yweQF/X2
         ttMk2nvEdZIXLBU3JZiww1yycepmKQKIcPzCrOlh5d/44wMfbPC3HPyznKFQ7j6z2U80
         K2YJwIEUKQORyiNs07apGC1cEOqKsauGUWsjBA5+H6KXmcoUuQaBT4yBEqNCL7DgeKMk
         WVaA==
X-Forwarded-Encrypted: i=1; AJvYcCVke+X8wJOFhBAN9NVA0i607m/NOLzjGQCiIy4yxnpbzIFuaNcdypyzMiD2lmabfRIOGWnMaLq6v65r1zNP@vger.kernel.org, AJvYcCWXGlgJqirjqijSY98riXg1BnaDdivHc4vI3PkU078btiE1gCmV6m0y9R0UuIBxm4QiMVjH0uqRZT7fryN7@vger.kernel.org
X-Gm-Message-State: AOJu0YyF6Pzip6lp788A1QzDPwW+4Lm4M+YsMNTvyPoFTfT1A3ABa+yj
	HyeDu2GGaaXWW77Culm8bBFSu+8u7yw3lIFHK6uAD/5zLoaP/7iI
X-Gm-Gg: ASbGncvWBMPXQj46n2FihN6ncFbOfZZqizSg/iXWU5/oZ6ciAblT5NfIDN6qDt1nQVL
	POUQ1c1rkXYl4Li4+qmu+76NZ2GusFA+cIOme6GWzTE+8UCjJfX14RLbcZlomavbsurb9X9P8a+
	m00dL0MYvHC9gtHdgPV57VCtambuclbNN4lItc3XO2HzRucwXmRG/zjXIJcq63QEufoTRnY2Bqi
	0aRWJjTrb0OfNBurK0OnQWzbAa6xLzxo3B801EqN/oZap8azZOedom6eTa5QAQRSQ2okyX6VHv8
	8Yn8ED50oLUcu2KnML0z7Gtb9peb5QLU3uQRg6dzHObX0mACCChO8AOwCgk=
X-Google-Smtp-Source: AGHT+IHOCpOZZnR+Coe4nDj31jsfrIf2WEG6UCdI5UpFUGQaUUJESSP1MXBj5F3+YIPFwVBOnC0J7A==
X-Received: by 2002:a17:906:c450:b0:acb:5f17:624d with SMTP id a640c23a62f3a-acb5f176accmr15187566b.57.1744841800529;
        Wed, 16 Apr 2025 15:16:40 -0700 (PDT)
Received: from f.. (cst-prg-69-142.cust.vodafone.cz. [46.135.69.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3d128c9esm194762866b.108.2025.04.16.15.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 15:16:39 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/2] fs: touch up predicts in inode_permission()
Date: Thu, 17 Apr 2025 00:16:25 +0200
Message-ID: <20250416221626.2710239-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416221626.2710239-1-mjguzik@gmail.com>
References: <20250416221626.2710239-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The routine only encounters errors when people try to access things they
can't, which is a negligible amount of calls.

The only questionable bit might be the pre-existing predict around
MAY_WRITE. Currently the routine is predominantly used for MAY_EXEC, so
this makes some sense.

I verified this straightens out the asm.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index daebc307c1a3..cff69c12d6fd 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -571,14 +571,14 @@ int inode_permission(struct mnt_idmap *idmap,
 	int retval;
 
 	retval = sb_permission(inode->i_sb, inode, mask);
-	if (retval)
+	if (unlikely(retval))
 		return retval;
 
 	if (unlikely(mask & MAY_WRITE)) {
 		/*
 		 * Nobody gets write access to an immutable file.
 		 */
-		if (IS_IMMUTABLE(inode))
+		if (unlikely(IS_IMMUTABLE(inode)))
 			return -EPERM;
 
 		/*
@@ -586,16 +586,16 @@ int inode_permission(struct mnt_idmap *idmap,
 		 * written back improperly if their true value is unknown
 		 * to the vfs.
 		 */
-		if (HAS_UNMAPPED_ID(idmap, inode))
+		if (unlikely(HAS_UNMAPPED_ID(idmap, inode)))
 			return -EACCES;
 	}
 
 	retval = do_inode_permission(idmap, inode, mask);
-	if (retval)
+	if (unlikely(retval))
 		return retval;
 
 	retval = devcgroup_inode_permission(inode, mask);
-	if (retval)
+	if (unlikely(retval))
 		return retval;
 
 	return security_inode_permission(inode, mask);
-- 
2.48.1


