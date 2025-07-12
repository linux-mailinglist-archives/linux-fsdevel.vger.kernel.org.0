Return-Path: <linux-fsdevel+bounces-54760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F08B02C1D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 19:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7AF4E06DC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 17:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EAC288C37;
	Sat, 12 Jul 2025 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="k2k4mPnG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED94276028
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Jul 2025 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752340727; cv=none; b=MMmHxl10dTW06vrxav5CSSvnuynnpR/nPOyZATNZf6RsKIA0iKEbcSN5thpSDMJfAu/JPh7/Y8konPMTXGZuFT5EQP4VdT0K0b8lpZJ0BWBpWtYJygOvXxZhV2x1AjsjJaFJ7xL0bcPR80HiPubqfi7OaQCLU4G5UAHusfEDSik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752340727; c=relaxed/simple;
	bh=CI/29I4HnP+KA5wdMqNmhhyumNm0Sc3YRQX0npJoLrw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lgwkW1iG0eqK8Omk7jOqv35cr32ekUeBpWnFbcA+lN3lDPEh25+tSysf7pAGNT2Yw/yftn6mFclOMwIthId7esgZlCCOnXxgERHLZJ7ieYmUjpxiBvyM8vbKdlovMzvQ4S3EvVt1IMu3jDfWuSDpUSIByF3nwE9sz9wBWTGr08A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=k2k4mPnG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=QUkjCSXjZkV+xv8TyBZwrxFPJ/hxX85e0OkPrrO7rPs=; b=k2k4mPnGdcsBwolL17mXiUW6Br
	STrWoEX2Yj0WFfH+SqTmssufGThxOcmce2HleaJqEB1UV4kTibM/Tgamn+0fYtXY7ZB6ZBtIII6s4
	eod5GPYUXfKdkmQpkDSEomjCtX4YATAKeMzF/LtDrYnODxmLztkExshpoE8huqtMrIZ+Ua2mJPuHc
	Axktdl2mFXo4GU4VGeeGrOToMR+i8+8rujgYPGeUMXR0ZihezEOi+bO/7XY/42oUbHjubM4okghF2
	yJI0OHA8Ki/FLeLmVAZBNkofZ6UUSai5a05amrCurBOIARn08QzD8i4KGMlBlY5sE/a5CqHFKb5JO
	FTFj78gA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uads3-000000094B4-0oHf;
	Sat, 12 Jul 2025 17:18:43 +0000
Date: Sat, 12 Jul 2025 18:18:43 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
Subject: [PATCH] fix a leak in fcntl_dirnotify()
Message-ID: <20250712171843.GB1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[into #fixes, unless somebody objects]

Lifetime of new_dn_mark is controlled by that of its ->fsn_mark,
pointed to by new_fsn_mark.  Unfortunately, a failure exit had
been inserted between the allocation of new_dn_mark and the
call of fsnotify_init_mark(), ending up with a leak.
    
Fixes: 1934b212615d "file: reclaim 24 bytes from f_owner"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/notify/dnotify/dnotify.c b/fs/notify/dnotify/dnotify.c
index c4cdaf5fa7ed..9fb73bafd41d 100644
--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -308,6 +308,10 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned int arg)
 		goto out_err;
 	}
 
+	error = file_f_owner_allocate(filp);
+	if (error)
+		goto out_err;
+
 	/* new fsnotify mark, we expect most fcntl calls to add a new mark */
 	new_dn_mark = kmem_cache_alloc(dnotify_mark_cache, GFP_KERNEL);
 	if (!new_dn_mark) {
@@ -315,10 +319,6 @@ int fcntl_dirnotify(int fd, struct file *filp, unsigned int arg)
 		goto out_err;
 	}
 
-	error = file_f_owner_allocate(filp);
-	if (error)
-		goto out_err;
-
 	/* set up the new_fsn_mark and new_dn_mark */
 	new_fsn_mark = &new_dn_mark->fsn_mark;
 	fsnotify_init_mark(new_fsn_mark, dnotify_group);

