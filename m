Return-Path: <linux-fsdevel+bounces-34996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A119CFAE5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2024 00:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42943B38668
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 22:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761E6192D65;
	Fri, 15 Nov 2024 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chas17C1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78894192B75
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731710821; cv=none; b=AhUIrp4rulYbJgwsWLgJ8il/zZGIt0Mf9+kUHfT/ZcSMPVfXi3jdkbRLDlO5vckX/WtTEUcu9Y/1U+uzZCAcVgpLnGcQl8KPR3nPf9aFQEsRSboRBTG1Yt9UBkRqXw/r5YX2DMM3OjC+uBhwt5tlER/SESSKoZdXUqI1O7xFPDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731710821; c=relaxed/simple;
	bh=hhbPr+3h/kgYhAsAVvrf/o6qFIpb3++sEgUCG3cEM+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fhti9ahLMwFnTVge3iLiN6/irR6jl2bvaufNRJ3LjjR/OXsjIbfv8k50FPnQGBvqvHzfdY+3nrXUPRRtFSY39VY8rROVhmcDhC47dOyHpnlu7SM65qbHS+JByT1LS2Ju1zyQ0dH3mUOfPN7dSfbjlTMw1+sMSGosg1oj6vpsWlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chas17C1; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e387afcb162so490338276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 14:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731710819; x=1732315619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEjWA6vn5Xh3CAWPzY0RXH9AbB2HGrSJFRDx463rkA0=;
        b=chas17C1ycA8wpUASPn+rhoK56S6245Va4popzyVaQc5zJNWT1ZWICE4Vcjt2H+8pw
         5xnzK+yJRLfbxpzMzXBvmVxj0Pe4F5h1VxvRlK9InuePyunqLirRp8P++s+kpVuVjMSt
         YuM2ejNss1biTk7QyfsmlgdFNz1XurtlxDEfVXo6zmKtKQHhSXfcv7G0rHlzqYK4r8zA
         ovGFcS0oT4yiogN3LxFBKXBnXLjS5Rx3sdTPQ52fydbiP5VmW277SIDruPNLc5WcsU03
         j12BGiT0r2UMV6zNOApL4MGCMTRtfhqTDv3lGx7zlVtvXo6cqj7SiO6wpIZoZ31e9t2R
         90Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731710819; x=1732315619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEjWA6vn5Xh3CAWPzY0RXH9AbB2HGrSJFRDx463rkA0=;
        b=hE7pVm863s0ESL2xA0U5ZW2qXD+chbM6zdjc88L4ndnRUdkrG+BCW9gYg7qXtJKfdy
         J7S/dEXkXPkU3PJIU9LrIKynn3stUC1CxTHe/koRYLbCr0OC2pHG4QXNgqL/JGQAfAb0
         R7Z/a1aSIK6wuBniWLau2uVB8ZAP2Zim1+ZE7gizsSlLlt1aCMAprw2jSCCjG8ay8NO5
         IJ+sPZeZF+lufmEIRN/om4It51SGbMirQIoUqnvQeYo6lwtm5nYK/NYDwBSsBvAjblnA
         uCrjtnabFPD/3Cl+f26exourrfXMHNVYg5aIQZacaUp2UmG5kzvOzVsV4WePYrrYx7ms
         +SmA==
X-Forwarded-Encrypted: i=1; AJvYcCUCNMqeDxc+Z0q0FjB4NL6Ec/aiOBLCahwtlFfgdtb5OSujd3S5N0/apwShz3Wkp/UuzcEkvyGWXmzJB9P+@vger.kernel.org
X-Gm-Message-State: AOJu0YzA78NOfNmmmmOSM3mxzZR3arvGJ3ZElzSRZD0EV7ZWxLnsmnxX
	ZT3xk/Afijv8Ri5D9VYgisyIcw66S6qhsS/Rwc9mb1JGa2a5TBDC
X-Google-Smtp-Source: AGHT+IEkqbH2Xska95WleqplmUzi/TR1yFbkmLL2aUtOgoFdVaSIwP8XGbBOoG841NmPls+jC0AzZg==
X-Received: by 2002:a05:6902:114c:b0:e33:2605:f80b with SMTP id 3f1490d57ef6-e38263f1251mr3757204276.42.1731710819349;
        Fri, 15 Nov 2024 14:46:59 -0800 (PST)
Received: from localhost (fwdproxy-nha-005.fbsv.net. [2a03:2880:25ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e387e7419ffsm115897276.22.2024.11.15.14.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 14:46:59 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v5 4/5] mm/migrate: skip migrating folios under writeback with AS_WRITEBACK_INDETERMINATE mappings
Date: Fri, 15 Nov 2024 14:44:58 -0800
Message-ID: <20241115224459.427610-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241115224459.427610-1-joannelkoong@gmail.com>
References: <20241115224459.427610-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For migrations called in MIGRATE_SYNC mode, skip migrating the folio if
it is under writeback and has the AS_WRITEBACK_INDETERMINATE flag set on its
mapping. If the AS_WRITEBACK_INDETERMINATE flag is set on the mapping, the
writeback may take an indeterminate amount of time to complete, and
waits may get stuck.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 mm/migrate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index df91248755e4..fe73284e5246 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		 */
 		switch (mode) {
 		case MIGRATE_SYNC:
-			break;
+			if (!src->mapping ||
+			    !mapping_writeback_indeterminate(src->mapping))
+				break;
+			fallthrough;
 		default:
 			rc = -EBUSY;
 			goto out;
-- 
2.43.5


