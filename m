Return-Path: <linux-fsdevel+bounces-42892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E3EA4B047
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 08:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477221753F9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 07:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB07A1E570D;
	Sun,  2 Mar 2025 07:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="a3fcY/iO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1641E492D;
	Sun,  2 Mar 2025 07:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740899916; cv=none; b=Y5TA8FznzDOA+Ru6bobyl9/8WDArEg6DKCcl2vRT/1QYpiRziJALEIbrjmWMaDr0Gs22t2t1I1i0zVllHXOng6PBjeVGrEVhSi6AVXN9Z0MtrotivSF3JMz4eewC0bJSjaBNhgOT4Lh0d9+DCZ3zbxuaJYMvAscK8HhmlVZTmJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740899916; c=relaxed/simple;
	bh=Q00tCGFagJqhJIqtMW6Th3WlIVSLLIlf2Ut0vWjxY0E=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SFv1quyue5b1sQNkFi14OXGlDg0XSFFjMX5daWw8ehoeBpwe+mVnE2wXKMbWnOV33SIdK9wwdYp3sFKdxqlbmk8Yx+MAXjZs19eBmoWwAK/THXvl9YvehX5Xcx9VbgR3/90skQSCu9TeV/QV/b8Yj/KIXS6UUb1PcVD73FhcomY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=a3fcY/iO; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:
	Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=f3DdERWXQrNySF6gvU6vinSO8q+qr1NUAtHdetDqJf4=; b=a3fcY/iONa33Ud5dQN0oQ3c0gf
	yDD75wEvhxl2aTZ2rDvDseIJ5EyhCdCJ+C0m8eIFf3NlZP28u5SHk7RtaW/UOBQbDdu+PuiO4evfo
	TPoBXIvZD5tF6i2j0JFtMlF9elpGl3C+YsBI7wvjpbFnHPyHikNt15dBNiHX5bI/nxZejVEBAYLNE
	zohytRJ+9SRo3ksFsXB596vLCJcm+O0IMfoXuQO7vIDuYz2MowNxrQLmRJXpNSAFgM45ay030+HNo
	gdz4qGRAYKsToUUV2206CDJHVlnXtfcwXlK3TMEPM3T7AnU4gW6JHVXPZwruE32bh3o6CpT5E1azX
	iJNcInUw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1todai-0030I5-0I;
	Sun, 02 Mar 2025 15:18:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 02 Mar 2025 15:18:24 +0800
Date: Sun, 2 Mar 2025 15:18:24 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] cred: Fix RCU warnings in override/revert_creds
Message-ID: <Z8QGQGW0IaSklKG7@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix RCU warnings in override_creds and revert_creds by turning
the RCU pointer into a normal pointer using rcu_replace_pointer.

These warnings were previously private to the cred code, but due
to the move into the header file they are now polluting unrelated
subsystems.

Fixes: 49dffdfde462 ("cred: Add a light version of override/revert_creds()")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 0c3c4b16b469..5658a3bfe803 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -172,18 +172,12 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
 
 static inline const struct cred *override_creds(const struct cred *override_cred)
 {
-	const struct cred *old = current->cred;
-
-	rcu_assign_pointer(current->cred, override_cred);
-	return old;
+	return rcu_replace_pointer(current->cred, override_cred, 1);
 }
 
 static inline const struct cred *revert_creds(const struct cred *revert_cred)
 {
-	const struct cred *override_cred = current->cred;
-
-	rcu_assign_pointer(current->cred, revert_cred);
-	return override_cred;
+	return rcu_replace_pointer(current->cred, revert_cred, 1);
 }
 
 /**
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

