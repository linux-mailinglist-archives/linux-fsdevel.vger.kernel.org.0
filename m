Return-Path: <linux-fsdevel+bounces-63965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 196CABD331B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 15:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E23F04F1D3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 13:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01989307491;
	Mon, 13 Oct 2025 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A42pY3nu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9289C3064B8;
	Mon, 13 Oct 2025 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361946; cv=none; b=loHT3dPsS5tvhrGyPGJxB8gmUgTznKIZJkBNw7nBBonET91WYizy6HNxO/Kbj3AHM7C+g+UuTlihJhnxx/IzoTbaCluuxqrQs9q4enVJXEofQ7cA6l+n65soyZRZGV6DMSWsfRhW25L2juJPFhaGKZi8ZyKKUEcGI3MQw5XmEMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361946; c=relaxed/simple;
	bh=GZxezoIkNwtwUcjJV0zafwxh2Mgp77M2WJpzEUZyXTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YwTCXbLMiG0XQYatmUqYIWG9jrLGNf5LOxoZ2CH7r0m5ZBU+Czs/wSae+LiqAha0g1mD2fza3AyUme09ERAHuZ76eZIz4fQLKBr6mYPM9rMDS4OHu+Ag0Y7fnJh2rnE66quiQSIEe/3t9id/tviEVoCe/djeOwk05pd25pBo5c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A42pY3nu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B6D9C4AF0F;
	Mon, 13 Oct 2025 13:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760361946;
	bh=GZxezoIkNwtwUcjJV0zafwxh2Mgp77M2WJpzEUZyXTw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A42pY3nuW2rf41L7M965hz9nx5OcefhDY3GmuII++y6ifAMpxvEA+evp5/KdJ5sYU
	 41880VRamgDWy7ijUpNfUvJ9bfjb2vZVuOp3VkRn4ztDmGT2elAAcxzJ4Xnr7k4/hE
	 WVc1p2PNG4YfgSN014J6YBVJT9INifeRQlhInQP9OEtb0V2TQQ/zhkKTdmZFk6rBjZ
	 VuElQmCG5FMRcc0EOevbjOd8n8rBf9/Nop8bSU1Dgv7rVr3IBP62EJMvTGswGU3Yyt
	 8AoCJheQMlxOreSjI1u8Q/hoRj0MZiSZG7RHA9HAphAxt9cTSf9u4NjJygmft9cJ4o
	 G22XuT6RPWsDQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32606CCD18E;
	Mon, 13 Oct 2025 13:25:46 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 13 Oct 2025 15:24:56 +0200
Subject: [PATCH 6/8] sysctl: Create converter functions with two new macros
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-jag-sysctl_conv-v1-6-4dc35ceae733@kernel.org>
References: <20251013-jag-sysctl_conv-v1-0-4dc35ceae733@kernel.org>
In-Reply-To: <20251013-jag-sysctl_conv-v1-0-4dc35ceae733@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6511;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=GZxezoIkNwtwUcjJV0zafwxh2Mgp77M2WJpzEUZyXTw=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGjs/dZC3kufkk8orzLfy7bRcGMF98YLAho53
 x58t6KK+A06Q4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo7P3WAAoJELqXzVK3
 lkFPjFwL/2xX6bnDW0Hm5sw8n9KH8UTqwpqSY4bjUXrWPWdv/yFmFJur/1NfFTfi118ziuFL7Mq
 fgzu34VoHYI9JUkpGwg4DTnPnwkAuXpeY1bSWhEVzm8dNfiq2lfBq2ZMwn+bTvXADPCzjjzH3vo
 uVgtPvJzNGcldTTdeZHkzmjUz/eRFzsXEAk227ggobNnNsCOtclivbDxQ8xOeUlReO6BAshCTws
 PKA2sVCq12wGz7MEdYS/X+L51O+GulGm8JJYSsI/Q1vaMgowfVrGwhGe/vpuo9Lc+8A42DyrPi/
 OchULIIMOZC6sU1L23jc7jZMnlhOC0n00scRFxrtLUWaMlomE900k/Z+lUNo5RReTKdXI1Wq6dd
 C6fOJqZNxSYutinQzgo2cznC69yOsdL7hy4FfNzSIIPkeiuY1Lv0e6EHPP+2D7h7oEHY25AxF6A
 VnWUG82YhqjWXPO3qN+FxnYhyZxyTlSuhUg6RDZyHV7msXZ3Qfc3yVV29jnsQmETl+NQ7tI4a36
 7A=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Eight converter functions are created using two new macros
(SYSCTL_USER_TO_KERN_INT_CONV & SYSCTL_KERN_TO_USER_INT_CONV); they are
called from four pre-existing converter functions: do_proc_dointvec_conv
and do_proc_dointvec{,_userhz,_ms}_jiffies_conv. The function names
generated by the macros are differentiated by a string suffix passed as
the first macro argument.

The SYSCTL_USER_TO_KERN_INT_CONV macro first executes the u_ptr_op
operation, then checks for overflow, assigns sign (-, +) and finally
writes to the kernel var with WRITE_ONCE; it always returns an -EINVAL
when an overflow is detected. The SYSCTL_KERN_TO_USER_INT_CONV uses
READ_ONCE, casts to unsigned long, then executes the k_ptr_op before
assigning the value to the user space buffer.

The overflow check is always done against MAX_INT after applying
{k,u}_ptr_op. This approach avoids rounding or precision errors that
might occur when using the inverse operations.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 131 ++++++++++++++++++++++++++------------------------------
 1 file changed, 61 insertions(+), 70 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 2091d2396c83ac68d621b3d158ce1c490c392c4b..f47bb8af33fb1d2d1a2a7c13d7ca093af82c6400 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -368,31 +368,65 @@ static void proc_put_char(void **buf, size_t *size, char c)
 	}
 }
 
+#define SYSCTL_USER_TO_KERN_INT_CONV(name, u_ptr_op)		\
+int sysctl_user_to_kern_int_conv##name(const bool *negp,	\
+				       const unsigned long *u_ptr,\
+				       int *k_ptr)		\
+{								\
+	unsigned long u = u_ptr_op(*u_ptr);			\
+	if (*negp) {						\
+		if (u > (unsigned long) INT_MAX + 1)		\
+			return -EINVAL;				\
+		WRITE_ONCE(*k_ptr, -u);				\
+	} else {						\
+		if (u > (unsigned long) INT_MAX)		\
+			return -EINVAL;				\
+		WRITE_ONCE(*k_ptr, u);				\
+	}							\
+	return 0;						\
+}
+
+#define SYSCTL_KERN_TO_USER_INT_CONV(name, k_ptr_op)		\
+int sysctl_kern_to_user_int_conv##name(bool *negp,		\
+				       unsigned long *u_ptr,	\
+				       const int *k_ptr)	\
+{								\
+	int val = READ_ONCE(*k_ptr);				\
+	if (val < 0) {						\
+		*negp = true;					\
+		*u_ptr = -k_ptr_op((unsigned long)val);		\
+	} else {						\
+		*negp = false;					\
+		*u_ptr = k_ptr_op((unsigned long)val);		\
+	}							\
+	return 0;						\
+}
+
+#define SYSCTL_CONV_IDENTITY(val) val
+#define SYSCTL_CONV_MULT_HZ(val) ((val) * HZ)
+#define SYSCTL_CONV_DIV_HZ(val) ((val) / HZ)
+
+static SYSCTL_USER_TO_KERN_INT_CONV(, SYSCTL_CONV_IDENTITY)
+static SYSCTL_KERN_TO_USER_INT_CONV(, SYSCTL_CONV_IDENTITY)
+
+static SYSCTL_USER_TO_KERN_INT_CONV(_hz, SYSCTL_CONV_MULT_HZ)
+static SYSCTL_KERN_TO_USER_INT_CONV(_hz, SYSCTL_CONV_DIV_HZ)
+
+static SYSCTL_USER_TO_KERN_INT_CONV(_userhz, clock_t_to_jiffies)
+static SYSCTL_KERN_TO_USER_INT_CONV(_userhz, jiffies_to_clock_t)
+
+static SYSCTL_USER_TO_KERN_INT_CONV(_ms, msecs_to_jiffies)
+static SYSCTL_KERN_TO_USER_INT_CONV(_ms, jiffies_to_msecs)
+
 static int do_proc_dointvec_conv(bool *negp, unsigned long *u_ptr,
 				 int *k_ptr, int dir,
 				 const struct ctl_table *table)
 {
 	if (SYSCTL_USER_TO_KERN(dir)) {
-		if (*negp) {
-			if (*u_ptr > (unsigned long) INT_MAX + 1)
-				return -EINVAL;
-			WRITE_ONCE(*k_ptr, -*u_ptr);
-		} else {
-			if (*u_ptr > (unsigned long) INT_MAX)
-				return -EINVAL;
-			WRITE_ONCE(*k_ptr, *u_ptr);
-		}
-	} else {
-		int val = READ_ONCE(*k_ptr);
-		if (val < 0) {
-			*negp = true;
-			*u_ptr = -(unsigned long)val;
-		} else {
-			*negp = false;
-			*u_ptr = (unsigned long)val;
-		}
+		return sysctl_user_to_kern_int_conv(negp, u_ptr, k_ptr);
 	}
-	return 0;
+
+	return sysctl_kern_to_user_int_conv(negp, u_ptr, k_ptr);
 }
 
 static int do_proc_douintvec_conv(unsigned long *u_ptr,
@@ -952,31 +986,14 @@ int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 					 lenp, ppos, HZ, 1000l);
 }
 
-
 static int do_proc_dointvec_jiffies_conv(bool *negp, unsigned long *u_ptr,
 					 int *k_ptr, int dir,
 					 const struct ctl_table *table)
 {
 	if (SYSCTL_USER_TO_KERN(dir)) {
-		if (*u_ptr > INT_MAX / HZ)
-			return 1;
-		if (*negp)
-			WRITE_ONCE(*k_ptr, -*u_ptr * HZ);
-		else
-			WRITE_ONCE(*k_ptr, *u_ptr * HZ);
-	} else {
-		int val = READ_ONCE(*k_ptr);
-		unsigned long lval;
-		if (val < 0) {
-			*negp = true;
-			lval = -(unsigned long)val;
-		} else {
-			*negp = false;
-			lval = (unsigned long)val;
-		}
-		*u_ptr = lval / HZ;
+		return sysctl_user_to_kern_int_conv_hz(negp, u_ptr, k_ptr);
 	}
-	return 0;
+	return sysctl_kern_to_user_int_conv_hz(negp, u_ptr, k_ptr);
 }
 
 static int do_proc_dointvec_userhz_jiffies_conv(bool *negp, unsigned long *u_ptr,
@@ -984,22 +1001,11 @@ static int do_proc_dointvec_userhz_jiffies_conv(bool *negp, unsigned long *u_ptr
 						const struct ctl_table *table)
 {
 	if (SYSCTL_USER_TO_KERN(dir)) {
-		if (USER_HZ < HZ && (LONG_MAX / HZ) * USER_HZ < *u_ptr)
-			return 1;
-		*k_ptr = clock_t_to_jiffies(*negp ? -*u_ptr : *u_ptr);
-	} else {
-		int val = *k_ptr;
-		unsigned long lval;
-		if (val < 0) {
-			*negp = true;
-			lval = -(unsigned long)val;
-		} else {
-			*negp = false;
-			lval = (unsigned long)val;
-		}
-		*u_ptr = jiffies_to_clock_t(lval);
+		if (USER_HZ < HZ)
+			return -EINVAL;
+		return sysctl_user_to_kern_int_conv_userhz(negp, u_ptr, k_ptr);
 	}
-	return 0;
+	return sysctl_kern_to_user_int_conv_userhz(negp, u_ptr, k_ptr);
 }
 
 static int do_proc_dointvec_ms_jiffies_conv(bool *negp, unsigned long *u_ptr,
@@ -1007,24 +1013,9 @@ static int do_proc_dointvec_ms_jiffies_conv(bool *negp, unsigned long *u_ptr,
 					    const struct ctl_table *table)
 {
 	if (SYSCTL_USER_TO_KERN(dir)) {
-		unsigned long jif = msecs_to_jiffies(*negp ? -*u_ptr : *u_ptr);
-
-		if (jif > INT_MAX)
-			return 1;
-		WRITE_ONCE(*k_ptr, (int)jif);
-	} else {
-		int val = READ_ONCE(*k_ptr);
-		unsigned long lval;
-		if (val < 0) {
-			*negp = true;
-			lval = -(unsigned long)val;
-		} else {
-			*negp = false;
-			lval = (unsigned long)val;
-		}
-		*u_ptr = jiffies_to_msecs(lval);
+		return sysctl_user_to_kern_int_conv_ms(negp, u_ptr, k_ptr);
 	}
-	return 0;
+	return sysctl_kern_to_user_int_conv_ms(negp, u_ptr, k_ptr);
 }
 
 static int do_proc_dointvec_ms_jiffies_minmax_conv(bool *negp, unsigned long *u_ptr,

-- 
2.50.1



