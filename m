Return-Path: <linux-fsdevel+bounces-64375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D79C8BE38DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 14:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370F1585B48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 12:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672253376BF;
	Thu, 16 Oct 2025 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsbxhnL/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260E0335BD0;
	Thu, 16 Oct 2025 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619500; cv=none; b=bs2U2IdrZaHz6lj1csoKmxmYmygcqZZoYYrYLbeMV6uIrrbrFpAEdBYx+8yU+g07vLgsvh/FWyueCrbk2vKvHSGRm6V/VMyHc6IMa+LysBx/+ZFxLnV3PDpaT16/l5UBc/SUo7lBAVksCP8KvgVx7KW+/dQ1CP4Gb2Obce2xZxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619500; c=relaxed/simple;
	bh=807u6LnyL+s222km/1YbC0VDQY1tikVb8paVLNFnzfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MjOfVbGH6V/ZNOK7vUW+7g/YpNN/BfaFbptDIWOMO60n20Zxf0R+jEnDe9gMVtCiGBRy2RORIuod15yTSVay12q5fpi2fcSIAPKSxuvYtc90q0NfEJ0iT1vwX0k6pCRmoWT7nbOAlWKQGVih7/VNGzfF69gxkJ26UI97Ft74o94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsbxhnL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8D73C116B1;
	Thu, 16 Oct 2025 12:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760619499;
	bh=807u6LnyL+s222km/1YbC0VDQY1tikVb8paVLNFnzfk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PsbxhnL/3s6Vi1YB3ERAMoFq86Ym0LXpiL2zGMpk6a9EP5V93PEQrNKjhjgO98REw
	 N7VAQbJqyXu+Hvq4+eOdv09s1asjFA5zymqC5XmDj9D+n8qJagF6I4C4A/n1ENeTLo
	 nXBcHA7qlwpkKEkyaqV5w2l9rkeWcfJn4dd1kGOuY93lAXADAdOq/P/Ga0T9UFAA1f
	 SrzSrg9d07FDqlsqtYg3ExGxLmntPznTu6OAxYYPxKvL0cYQI5nJHzWbbslzVmQmN0
	 nsf8lwiWi1zBx0ozK5ZhC1DPtaybLwF3MXf8Ic3JruEEmyWswvsg7PFbBb3+CuRLCZ
	 Vheee534lUtig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CF6CCD1A1;
	Thu, 16 Oct 2025 12:58:19 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 16 Oct 2025 14:57:56 +0200
Subject: [PATCH v2 10/11] sysctl: Add optional range checking to
 SYSCTL_UINT_CONV_CUSTOM
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-jag-sysctl_conv-v2-10-a2f16529acc4@kernel.org>
References: <20251016-jag-sysctl_conv-v2-0-a2f16529acc4@kernel.org>
In-Reply-To: <20251016-jag-sysctl_conv-v2-0-a2f16529acc4@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4062;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=807u6LnyL+s222km/1YbC0VDQY1tikVb8paVLNFnzfk=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGjw6+eTUKQbCUSkbHbRE0+Az7i9xGiVeVcvA
 xeWh+qnCwwyDIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo8OvnAAoJELqXzVK3
 lkFPt8cL/0vpcOq2QdjRCUe3WFO8q06gLl5OJNA4GA0+5wIv7V2aS0dzFzirbX8X0vwjFQYu2F6
 FYyyQV9X28WS9x+ItZM/D3p1x/w62ifyPUq2jxyGnFFh6d8qUNoogicIawSw23kSYO8cwf3scJV
 NnQq25tVDcJMyCzxfh0/+rcbGHw+bY6PiZKIoyKDrg+woCUnDfIcyc8rAGL5frqW4g9vXXhNYXW
 QpwvM7cnSB1N9gOW7CTHr9pgVogBKV/CDCHHjn5zgpTT5ZobEoM5bo3ipzdK2IvgGpLAlLuUygc
 UP4w63ZhG5oX/+CZKXbaxIqobNaVNHXHzx8n1534oiBQ7UNf5AmK5awTVqocJs5TCzfuO6Q2w8m
 iqvaCvAxIEVBdMre3YeC1T4yQbtjIU/7hh9/4mtiO4kkwshDBZXzAMD/HtSiO6Ni2ltka/LEbl9
 kZpqgScvZSVcylVKqMYXa3Oa2SCND7/YzTvPpZoLJMDnZkHMaIKP432jjLfHp5/ouyvgUirNPD7
 l4=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Add k_ptr_range_check parameter to SYSCTL_UINT_CONV_CUSTOM macro to
enable range validation using table->extra1/extra2. Replace
do_proc_douintvec_minmax_conv with do_proc_uint_conv_minmax generated
by the updated macro.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 69 ++++++++++++++++++++++++++-------------------------------
 1 file changed, 32 insertions(+), 37 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ca657d1bb958060ba72118aa156a43f8a64607eb..750c94313c1fd23551e03f455585d2dd94f3c758 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -462,15 +462,6 @@ static SYSCTL_INT_CONV_CUSTOM(_ms_jiffies_minmax,
 			      sysctl_user_to_kern_int_conv_ms,
 			      sysctl_kern_to_user_int_conv_ms, true)
 
-#define SYSCTL_UINT_CONV_CUSTOM(name, user_to_kern, kern_to_user)	\
-int do_proc_uint_conv##name(unsigned long *u_ptr, unsigned int *k_ptr,	\
-			   int dir, const struct ctl_table *tbl)	\
-{									\
-	if (SYSCTL_USER_TO_KERN(dir))					\
-		return user_to_kern(u_ptr, k_ptr);			\
-	return kern_to_user(u_ptr, k_ptr);				\
-}
-
 static int sysctl_user_to_kern_uint_conv(const unsigned long *u_ptr,
 					 unsigned int *k_ptr)
 {
@@ -488,8 +479,37 @@ static int sysctl_kern_to_user_uint_conv(unsigned long *u_ptr,
 	return 0;
 }
 
+#define SYSCTL_UINT_CONV_CUSTOM(name, user_to_kern, kern_to_user,	\
+				k_ptr_range_check)			\
+int do_proc_uint_conv##name(unsigned long *u_ptr, unsigned int *k_ptr,	\
+			   int dir, const struct ctl_table *tbl)	\
+{									\
+	if (SYSCTL_KERN_TO_USER(dir))					\
+		return kern_to_user(u_ptr, k_ptr);			\
+									\
+	if (k_ptr_range_check) {					\
+		unsigned int tmp_k;					\
+		int ret;						\
+		if (!tbl)						\
+			return -EINVAL;					\
+		ret = user_to_kern(u_ptr, &tmp_k);			\
+		if (ret)						\
+			return ret;					\
+		if ((tbl->extra1 &&					\
+		     *(unsigned int *)tbl->extra1 > tmp_k) ||		\
+		    (tbl->extra2 &&					\
+		     *(unsigned int *)tbl->extra2 < tmp_k))		\
+			return -ERANGE;					\
+		WRITE_ONCE(*k_ptr, tmp_k);				\
+	} else								\
+		return user_to_kern(u_ptr, k_ptr);			\
+	return 0;							\
+}
+
 static SYSCTL_UINT_CONV_CUSTOM(, sysctl_user_to_kern_uint_conv,
-			       sysctl_kern_to_user_uint_conv)
+			       sysctl_kern_to_user_uint_conv, false)
+static SYSCTL_UINT_CONV_CUSTOM(_minmax, sysctl_user_to_kern_uint_conv,
+			       sysctl_kern_to_user_uint_conv, true)
 
 static const char proc_wspace_sep[] = { ' ', '\t', '\n' };
 
@@ -783,31 +803,6 @@ int proc_dointvec_minmax(const struct ctl_table *table, int dir,
 				do_proc_int_conv_minmax);
 }
 
-static int do_proc_douintvec_minmax_conv(unsigned long *u_ptr,
-					 unsigned int *k_ptr, int dir,
-					 const struct ctl_table *table)
-{
-	int ret;
-	unsigned int tmp, *min, *max;
-	/* When writing to the kernel use a temp local uint for bounds-checking */
-	unsigned int *up = SYSCTL_USER_TO_KERN(dir) ? &tmp : k_ptr;
-
-	ret = do_proc_uint_conv(u_ptr, up, dir, table);
-	if (ret)
-		return ret;
-
-	if (SYSCTL_USER_TO_KERN(dir)) {
-		min = (unsigned int *) table->extra1;
-		max = (unsigned int *) table->extra2;
-		if ((min && *min > tmp) || (max && *max < tmp))
-			return -ERANGE;
-
-		WRITE_ONCE(*k_ptr, tmp);
-	}
-
-	return 0;
-}
-
 /**
  * proc_douintvec_minmax - read a vector of unsigned ints with min/max values
  * @table: the sysctl table
@@ -832,7 +827,7 @@ int proc_douintvec_minmax(const struct ctl_table *table, int dir,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return do_proc_douintvec(table, dir, buffer, lenp, ppos,
-				 do_proc_douintvec_minmax_conv);
+				 do_proc_uint_conv_minmax);
 }
 
 /**
@@ -876,7 +871,7 @@ int proc_dou8vec_minmax(const struct ctl_table *table, int dir,
 
 	val = READ_ONCE(*data);
 	res = do_proc_douintvec(&tmp, dir, buffer, lenp, ppos,
-				do_proc_douintvec_minmax_conv);
+				do_proc_uint_conv_minmax);
 	if (res)
 		return res;
 	if (SYSCTL_USER_TO_KERN(dir))

-- 
2.50.1



