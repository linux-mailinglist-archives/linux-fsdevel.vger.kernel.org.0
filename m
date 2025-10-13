Return-Path: <linux-fsdevel+bounces-63966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41975BD332A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 15:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CCD3C5D3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 13:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C138306B3F;
	Mon, 13 Oct 2025 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqjsPkvF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929633064BA;
	Mon, 13 Oct 2025 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361946; cv=none; b=H/D2UJXk0EERVwf03DNg+EqSqHzwXJZZo4mczifz0uMTI2D+A5nCxN1M8A5EtM+ViKLd2mAEwjnkTjp3DUADsb8J59rFcPhIQgAfQYMQRXFvFoHewhFO/VSDsWcykTtjhOEgB7y89SZuaH7l6Edu3DAEMiX9HkV92gXP1bXjGXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361946; c=relaxed/simple;
	bh=caF6LtqiOd2vBnpLGcm75cb9MaprTYO9NBhODSG8Pjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rvaE8Q3xuDi5+VpiIDRXChZhtc+T5tP7ntQ3dJGeSK4Aum8OInvRm99Ya1JxEoPCHDXCRCyodJyuxrPJLDzbjH+bifaeMlglIzvXIRt8T9SLeHkJMebUou5RWbq5Vx6WA4ydN/7YXsDSQV2jgIRo9TO3cdJk1tGByO10tUQ+TI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqjsPkvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DD96C2BC87;
	Mon, 13 Oct 2025 13:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760361946;
	bh=caF6LtqiOd2vBnpLGcm75cb9MaprTYO9NBhODSG8Pjs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZqjsPkvF7NZXKG04vrFy/XkXu60etzOQnoF8mQ8xV9VKyByu+27Gn2J4fSiyCiF8M
	 HAu9m0ALm+GBNykuvuy8kP3UuTuGCB1jIjkO4IQ3/b2CjOuQ2fRxtIiW/R7zhNYvtm
	 a8e7OoK3qG6unKBk0vhqjzHx1f5hZM5y9Q+N58XLPnJhPTOs0Y38fSqz3muoNr2Iwu
	 AZGUtKx+17AXi3l4qbdft4aouAyzLK35Gf+MqelrejpywvxupML6ExixCLI1haK3hb
	 vaMEc5Y4VFDaf7IpWDTlVGzP4k9sjnyZUioT2Z9JbER6qXXhUy1fgojr4jNcJU75Jm
	 hIym82XvOKqKQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26599CCD18D;
	Mon, 13 Oct 2025 13:25:46 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 13 Oct 2025 15:24:55 +0200
Subject: [PATCH 5/8] sysctl: Discriminate between kernel and user converter
 params
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-jag-sysctl_conv-v1-5-4dc35ceae733@kernel.org>
References: <20251013-jag-sysctl_conv-v1-0-4dc35ceae733@kernel.org>
In-Reply-To: <20251013-jag-sysctl_conv-v1-0-4dc35ceae733@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10487;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=caF6LtqiOd2vBnpLGcm75cb9MaprTYO9NBhODSG8Pjs=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGjs/dUeDnpsGyIH0+uQfHFCHVtxdMaukP4tN
 sX0f0nHgFfm64kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo7P3VAAoJELqXzVK3
 lkFPO9cL/3dkThP9AoTTf0gZUBxLU+lUJJ6WhDLKY5zadECEF9vMGg6vlZHheD25w4l1LkuQ4YQ
 sPfjKROIFnVTDOzjNzMfs0nddP/dRVlI+HAII8+62gGdYR/lPevS34eBNgO5mxW+LHqQI7aPlxC
 4PuMpWwH8WFfCj+m8+LfHnghd6U8fA+f6C6ew6aj1dALSD901QR5tImp18qRzw/ZdxhZ1eB7Ad4
 g98zGlFXk7Mq1N+ze9uF8jWV3hznfElS1qe78hzPVrGvJTtATqBJacaOsKjmDbWZqzEgJTUlVNs
 arU+4nFLnwJ+3MjRudmlcNnv2kiZlPD9xXjCbDWokSvOr5Jvic/ESrEfD8j5NeAbsZaKrNs+bEl
 hZThSTDYFOb0rr9R3rmWFBv1aZSX1OCjMwqC01x5z7xbqHO9jbzN5M7cgGKOP0VAP3IOgSCBV+c
 /2wPZmRmf6ADyhV6TiIwplgea0ScBCJ7YoE3Zq9+bmiOkJBNdAr3usdxkpfSZumCuy+bEUfAbE8
 iQ=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Rename converter parameter to indicate data flow direction: "lvalp" to
"u_ptr" indicating a user space parsed value pointer. "valp" to "k_ptr"
indicating a kernel storage value pointer. This facilitates the
identification of discrepancies between direction (copy to kernel or
copy to user space) and the modified variable. This is a preparation
commit for when the converter functions are exposed to the rest of the
kernel.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 118 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 69148fe7359994b85c076b7b6750792b2d1c751e..2091d2396c83ac68d621b3d158ce1c490c392c4b 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -368,44 +368,44 @@ static void proc_put_char(void **buf, size_t *size, char c)
 	}
 }
 
-static int do_proc_dointvec_conv(bool *negp, unsigned long *lvalp,
-				 int *valp, int dir,
+static int do_proc_dointvec_conv(bool *negp, unsigned long *u_ptr,
+				 int *k_ptr, int dir,
 				 const struct ctl_table *table)
 {
 	if (SYSCTL_USER_TO_KERN(dir)) {
 		if (*negp) {
-			if (*lvalp > (unsigned long) INT_MAX + 1)
+			if (*u_ptr > (unsigned long) INT_MAX + 1)
 				return -EINVAL;
-			WRITE_ONCE(*valp, -*lvalp);
+			WRITE_ONCE(*k_ptr, -*u_ptr);
 		} else {
-			if (*lvalp > (unsigned long) INT_MAX)
+			if (*u_ptr > (unsigned long) INT_MAX)
 				return -EINVAL;
-			WRITE_ONCE(*valp, *lvalp);
+			WRITE_ONCE(*k_ptr, *u_ptr);
 		}
 	} else {
-		int val = READ_ONCE(*valp);
+		int val = READ_ONCE(*k_ptr);
 		if (val < 0) {
 			*negp = true;
-			*lvalp = -(unsigned long)val;
+			*u_ptr = -(unsigned long)val;
 		} else {
 			*negp = false;
-			*lvalp = (unsigned long)val;
+			*u_ptr = (unsigned long)val;
 		}
 	}
 	return 0;
 }
 
-static int do_proc_douintvec_conv(unsigned long *lvalp,
-				  unsigned int *valp, int dir,
+static int do_proc_douintvec_conv(unsigned long *u_ptr,
+				  unsigned int *k_ptr, int dir,
 				  const struct ctl_table *table)
 {
 	if (SYSCTL_USER_TO_KERN(dir)) {
-		if (*lvalp > UINT_MAX)
+		if (*u_ptr > UINT_MAX)
 			return -EINVAL;
-		WRITE_ONCE(*valp, *lvalp);
+		WRITE_ONCE(*k_ptr, *u_ptr);
 	} else {
-		unsigned int val = READ_ONCE(*valp);
-		*lvalp = (unsigned long)val;
+		unsigned int val = READ_ONCE(*k_ptr);
+		*u_ptr = (unsigned long)val;
 	}
 	return 0;
 }
@@ -415,7 +415,7 @@ static const char proc_wspace_sep[] = { ' ', '\t', '\n' };
 
 static int do_proc_dointvec(const struct ctl_table *table, int dir,
 		  void *buffer, size_t *lenp, loff_t *ppos,
-		  int (*conv)(bool *negp, unsigned long *lvalp, int *valp,
+		  int (*conv)(bool *negp, unsigned long *u_ptr, int *k_ptr,
 			      int dir, const struct ctl_table *table))
 {
 	int *i, vleft, first = 1, err = 0;
@@ -487,8 +487,8 @@ static int do_proc_dointvec(const struct ctl_table *table, int dir,
 
 static int do_proc_douintvec_w(const struct ctl_table *table, void *buffer,
 			       size_t *lenp, loff_t *ppos,
-			       int (*conv)(unsigned long *lvalp,
-					   unsigned int *valp, int dir,
+			       int (*conv)(unsigned long *u_ptr,
+					   unsigned int *k_ptr, int dir,
 					   const struct ctl_table *table))
 {
 	unsigned long lval;
@@ -540,8 +540,8 @@ static int do_proc_douintvec_w(const struct ctl_table *table, void *buffer,
 
 static int do_proc_douintvec_r(const struct ctl_table *table, void *buffer,
 			       size_t *lenp, loff_t *ppos,
-			       int (*conv)(unsigned long *lvalp,
-					   unsigned int *valp, int dir,
+			       int (*conv)(unsigned long *u_ptr,
+					   unsigned int *k_ptr, int dir,
 					   const struct ctl_table *table))
 {
 	unsigned long lval;
@@ -570,7 +570,7 @@ static int do_proc_douintvec_r(const struct ctl_table *table, void *buffer,
 
 int do_proc_douintvec(const struct ctl_table *table, int dir, void *buffer,
 		      size_t *lenp, loff_t *ppos,
-		      int (*conv)(unsigned long *lvalp, unsigned int *valp,
+		      int (*conv)(unsigned long *u_ptr, unsigned int *k_ptr,
 				  int dir, const struct ctl_table *table))
 {
 	unsigned int vleft;
@@ -679,18 +679,18 @@ int proc_douintvec(const struct ctl_table *table, int dir, void *buffer,
 				 do_proc_douintvec_conv);
 }
 
-static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
-					int *valp, int dir,
+static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *u_ptr,
+					int *k_ptr, int dir,
 					const struct ctl_table *table)
 {
 	int tmp, ret, *min, *max;
 	/*
-	 * If writing, first do so via a temporary local int so we can
-	 * bounds-check it before touching *valp.
+	 * If writing to a kernel variable, first do so via a temporary
+	 * local int so we can bounds-check it before touching *k_ptr.
 	 */
-	int *ip = SYSCTL_USER_TO_KERN(dir) ? &tmp : valp;
+	int *ip = SYSCTL_USER_TO_KERN(dir) ? &tmp : k_ptr;
 
-	ret = do_proc_dointvec_conv(negp, lvalp, ip, dir, table);
+	ret = do_proc_dointvec_conv(negp, u_ptr, ip, dir, table);
 	if (ret)
 		return ret;
 
@@ -699,7 +699,7 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 		max = (int *) table->extra2;
 		if ((min && *min > tmp) || (max && *max < tmp))
 			return -EINVAL;
-		WRITE_ONCE(*valp, tmp);
+		WRITE_ONCE(*k_ptr, tmp);
 	}
 
 	return 0;
@@ -729,16 +729,16 @@ int proc_dointvec_minmax(const struct ctl_table *table, int dir,
 				do_proc_dointvec_minmax_conv);
 }
 
-static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
-					 unsigned int *valp, int dir,
+static int do_proc_douintvec_minmax_conv(unsigned long *u_ptr,
+					 unsigned int *k_ptr, int dir,
 					 const struct ctl_table *table)
 {
 	int ret;
 	unsigned int tmp, *min, *max;
 	/* When writing to the kernel use a temp local uint for bounds-checking */
-	unsigned int *up = SYSCTL_USER_TO_KERN(dir) ? &tmp : valp;
+	unsigned int *up = SYSCTL_USER_TO_KERN(dir) ? &tmp : k_ptr;
 
-	ret = do_proc_douintvec_conv(lvalp, up, dir, table);
+	ret = do_proc_douintvec_conv(u_ptr, up, dir, table);
 	if (ret)
 		return ret;
 
@@ -748,7 +748,7 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 		if ((min && *min > tmp) || (max && *max < tmp))
 			return -ERANGE;
 
-		WRITE_ONCE(*valp, tmp);
+		WRITE_ONCE(*k_ptr, tmp);
 	}
 
 	return 0;
@@ -953,19 +953,19 @@ int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 }
 
 
-static int do_proc_dointvec_jiffies_conv(bool *negp, unsigned long *lvalp,
-					 int *valp, int dir,
+static int do_proc_dointvec_jiffies_conv(bool *negp, unsigned long *u_ptr,
+					 int *k_ptr, int dir,
 					 const struct ctl_table *table)
 {
 	if (SYSCTL_USER_TO_KERN(dir)) {
-		if (*lvalp > INT_MAX / HZ)
+		if (*u_ptr > INT_MAX / HZ)
 			return 1;
 		if (*negp)
-			WRITE_ONCE(*valp, -*lvalp * HZ);
+			WRITE_ONCE(*k_ptr, -*u_ptr * HZ);
 		else
-			WRITE_ONCE(*valp, *lvalp * HZ);
+			WRITE_ONCE(*k_ptr, *u_ptr * HZ);
 	} else {
-		int val = READ_ONCE(*valp);
+		int val = READ_ONCE(*k_ptr);
 		unsigned long lval;
 		if (val < 0) {
 			*negp = true;
@@ -974,21 +974,21 @@ static int do_proc_dointvec_jiffies_conv(bool *negp, unsigned long *lvalp,
 			*negp = false;
 			lval = (unsigned long)val;
 		}
-		*lvalp = lval / HZ;
+		*u_ptr = lval / HZ;
 	}
 	return 0;
 }
 
-static int do_proc_dointvec_userhz_jiffies_conv(bool *negp, unsigned long *lvalp,
-						int *valp, int dir,
+static int do_proc_dointvec_userhz_jiffies_conv(bool *negp, unsigned long *u_ptr,
+						int *k_ptr, int dir,
 						const struct ctl_table *table)
 {
 	if (SYSCTL_USER_TO_KERN(dir)) {
-		if (USER_HZ < HZ && *lvalp > (LONG_MAX / HZ) * USER_HZ)
+		if (USER_HZ < HZ && (LONG_MAX / HZ) * USER_HZ < *u_ptr)
 			return 1;
-		*valp = clock_t_to_jiffies(*negp ? -*lvalp : *lvalp);
+		*k_ptr = clock_t_to_jiffies(*negp ? -*u_ptr : *u_ptr);
 	} else {
-		int val = *valp;
+		int val = *k_ptr;
 		unsigned long lval;
 		if (val < 0) {
 			*negp = true;
@@ -997,23 +997,23 @@ static int do_proc_dointvec_userhz_jiffies_conv(bool *negp, unsigned long *lvalp
 			*negp = false;
 			lval = (unsigned long)val;
 		}
-		*lvalp = jiffies_to_clock_t(lval);
+		*u_ptr = jiffies_to_clock_t(lval);
 	}
 	return 0;
 }
 
-static int do_proc_dointvec_ms_jiffies_conv(bool *negp, unsigned long *lvalp,
-					    int *valp, int dir,
+static int do_proc_dointvec_ms_jiffies_conv(bool *negp, unsigned long *u_ptr,
+					    int *k_ptr, int dir,
 					    const struct ctl_table *table)
 {
 	if (SYSCTL_USER_TO_KERN(dir)) {
-		unsigned long jif = msecs_to_jiffies(*negp ? -*lvalp : *lvalp);
+		unsigned long jif = msecs_to_jiffies(*negp ? -*u_ptr : *u_ptr);
 
 		if (jif > INT_MAX)
 			return 1;
-		WRITE_ONCE(*valp, (int)jif);
+		WRITE_ONCE(*k_ptr, (int)jif);
 	} else {
-		int val = READ_ONCE(*valp);
+		int val = READ_ONCE(*k_ptr);
 		unsigned long lval;
 		if (val < 0) {
 			*negp = true;
@@ -1022,23 +1022,23 @@ static int do_proc_dointvec_ms_jiffies_conv(bool *negp, unsigned long *lvalp,
 			*negp = false;
 			lval = (unsigned long)val;
 		}
-		*lvalp = jiffies_to_msecs(lval);
+		*u_ptr = jiffies_to_msecs(lval);
 	}
 	return 0;
 }
 
-static int do_proc_dointvec_ms_jiffies_minmax_conv(bool *negp, unsigned long *lvalp,
-						int *valp, int dir,
+static int do_proc_dointvec_ms_jiffies_minmax_conv(bool *negp, unsigned long *u_ptr,
+						int *k_ptr, int dir,
 						const struct ctl_table *table)
 {
 	int tmp, ret, *min, *max;
 	/*
-	 * If writing, first do so via a temporary local int so we can
-	 * bounds-check it before touching *valp.
+	 * If writing to a kernel var, first do so via a temporary local
+	 * int so we can bounds-check it before touching *k_ptr.
 	 */
-	int *ip = SYSCTL_USER_TO_KERN(dir) ? &tmp : valp;
+	int *ip = SYSCTL_USER_TO_KERN(dir) ? &tmp : k_ptr;
 
-	ret = do_proc_dointvec_ms_jiffies_conv(negp, lvalp, ip, dir, table);
+	ret = do_proc_dointvec_ms_jiffies_conv(negp, u_ptr, ip, dir, table);
 	if (ret)
 		return ret;
 
@@ -1047,7 +1047,7 @@ static int do_proc_dointvec_ms_jiffies_minmax_conv(bool *negp, unsigned long *lv
 		max = (int *) table->extra2;
 		if ((min && *min > tmp) || (max && *max < tmp))
 			return -EINVAL;
-		*valp = tmp;
+		*k_ptr = tmp;
 	}
 	return 0;
 }

-- 
2.50.1



