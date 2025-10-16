Return-Path: <linux-fsdevel+bounces-64372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC7ABE38C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 14:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88561887AE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 12:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A313376B3;
	Thu, 16 Oct 2025 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XT8SVxg+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13BF335BB2;
	Thu, 16 Oct 2025 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619499; cv=none; b=Trn+PG6kn0FdgyKw9wzkhSEcZxEGUQ0bI7fb8A/mBi1mEhDRdDlBRCnqrEOAiTGILmUJxX/nugIAi+mGzWCFUx49mPB5atC13C1W4PP30ON+WM8P4SOM2bFluLdWwE8GX0KEpHx797j4rlXDjsXcqgoTypmyBPA/bFyHDC6KAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619499; c=relaxed/simple;
	bh=GZxezoIkNwtwUcjJV0zafwxh2Mgp77M2WJpzEUZyXTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z+GSifhZXfD+NFKDU3Hes9rC3jr2Ugo0kvkEdlvoeKZclc/A08xdzPBEPXUZSpT19/NENxYA9FOuFOmh88+Ihzs2okOl1pIN3+x7i7ESgIaKD8Jh1+G1UHW/ZexTMWxHsLheJPg7eFyxN/1GjnNPtaVDPrraMp/osOjsrS1kKcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XT8SVxg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87800C4CEFE;
	Thu, 16 Oct 2025 12:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760619499;
	bh=GZxezoIkNwtwUcjJV0zafwxh2Mgp77M2WJpzEUZyXTw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XT8SVxg+3t9Vr8NQeEy1aZw3F2kmXp3iYsCJCgWMRB9ozBnPKoq6x/gY0Ya6126RS
	 oUPFyBHRtn5rBPGTYmQqtUzyQR3Mp1TzHHl+aY/iSX/w1fwy6JdUuR97ckKaIFRQPc
	 TlczOC5+9o5m+ipG1I4XfiTK/tT3bb49+C+h/H+Uz1TPeb5sR643bNhOyAicM9jnPo
	 buwtATpKszeXZxwbLbOMS7OxcoBher8D0TrtdWzdQQu5zLjhIYj/ebhDh6J4mxVn2E
	 AHV6JeWifrQriOdoMSBpdcIfS29pkTyzMo4/9mqcHQVQaNqDh3+lnziddFWbN1m58t
	 CCV0xhyaQm8kQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AB8CCD19A;
	Thu, 16 Oct 2025 12:58:19 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 16 Oct 2025 14:57:52 +0200
Subject: [PATCH v2 06/11] sysctl: Create converter functions with two new
 macros
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-jag-sysctl_conv-v2-6-a2f16529acc4@kernel.org>
References: <20251016-jag-sysctl_conv-v2-0-a2f16529acc4@kernel.org>
In-Reply-To: <20251016-jag-sysctl_conv-v2-0-a2f16529acc4@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6511;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=GZxezoIkNwtwUcjJV0zafwxh2Mgp77M2WJpzEUZyXTw=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGjw6+U2gAH5Q4bjSsqY0prw3ON75hJYy2/sr
 oqMiRbdnjYdN4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo8OvlAAoJELqXzVK3
 lkFPSVYMAJZ0vrWt5wqVg2OvhDt9jd0kyPIqHy/JufEx98PcxUyK2Gujpyoat5UPewHp47zp7LF
 8d/jyPAdovdFIH/54231gBqfKXH8FhJHPjcEoDdOLP9yQrcyGOUC1EjCQi7Jzbsx25GOydcSzI/
 4CT0y7L0lmTqX6QMaP3ZSoTacR938id6YbM79ljHeiaW+cr3rWNARjKPMyYJNrdXqFO9qx3qQoy
 8ptZPgL0jj+50L62tCFuXBZS2lnMQpN4um6DhlNKxvCU3k6K16pgF8ankfQHuMnXC5FKTXEaUSF
 f9S4edjy1uLAy0zKPkkQMx9TVJ2jLSvMDBQ1x57IPJm6yI9wuBIBvG2CNB0xrvfakY8Lq2Adezl
 JteR7/3hMmhknwJvRLylNYec0rnpu7l5tzU2jpbx3qq0MNl2CB6kwzxXa4tBRJQ1wlmvjO3i125
 sFgM4NbHNajyB3q1uMlLa3700jAk1/4EmfROvtCWnfBBBvone2F4OGBX1AA0K0AM4GOIhHoq0Y6
 iU=
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



