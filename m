Return-Path: <linux-fsdevel+bounces-72312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F45CED051
	for <lists+linux-fsdevel@lfdr.de>; Thu, 01 Jan 2026 13:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 157883032AC5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jan 2026 12:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045AE2D0C7E;
	Thu,  1 Jan 2026 12:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifn4pcIE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947C3221FA0;
	Thu,  1 Jan 2026 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767272242; cv=none; b=NDxve96uMy7b0wE5Qzri1wr//VKT8MvBQOXB6O3oegKI2DyZ45Rbc+0MtLzoUnXSs1GyVQp2mIOKCtJ5x6vD7Tfd8Rni13SHy6t/3NSlcXIsTzpwWlr459Mx9V3bYKkGxlOCcYiteA2K6kHaRt8YYoQuaiAZ0x8nN5P0BrPjrgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767272242; c=relaxed/simple;
	bh=DoeOUcfzBiDemYNQ6HSUnBzBoU1D+S+RU5qQ3unL1OE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FN6Q1y6s/dHGXIucgL65edGj1kf5D46ajACSJiNJZ9Z4b2lscFRCKvLpkT6ICD9KpmEakWd8cFazypX+Y3cRiJ0jQn6DPNpjBmIrhEyyx+QgLeGHDJp3/jocEeYjYv7pv42fp8HJmSEWHeefZ3/qJfdfmEIcL6LoDFblEBgDVYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifn4pcIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BFD5C2BCB1;
	Thu,  1 Jan 2026 12:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767272242;
	bh=DoeOUcfzBiDemYNQ6HSUnBzBoU1D+S+RU5qQ3unL1OE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ifn4pcIE/GIPyDgTSioM1+bdaFedZPhmA+wyzJ7hOGRv0Wo1/JUJ1TcBZzoYJeoTp
	 kmbp7AuXKut25metyouCuYOM6cmOXl2x56USfm63Ip2ddXns035krc7PMkQcb9KQep
	 dAXc4wYMDHIC040DBiHOqaATj3QpbCFfRflYjwLixn/0JLMoUSXVg1G2jI1Ug32Xz3
	 BCfX7oWvQXb/i0pLOdjVtEqaZ7bt86EsSLuatAyyJ+H5a74asQL8jBNZ4FhtuK+sdp
	 VklKzH1LkCSgIkYZW5Ua91y0lV/YxGyCN2E8S7orz665vDCWnbRFlLVuqel9dbGcdB
	 WmEXcS4TIRmvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE84EED601;
	Thu,  1 Jan 2026 12:57:22 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 01 Jan 2026 13:57:09 +0100
Subject: [PATCH v2 5/9] sysctl: Generate do_proc_douintvec with a
 type-generic macro
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-jag-dovec_consolidate-v2-5-ff918f753ba9@kernel.org>
References: <20260101-jag-dovec_consolidate-v2-0-ff918f753ba9@kernel.org>
In-Reply-To: <20260101-jag-dovec_consolidate-v2-0-ff918f753ba9@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3960;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=DoeOUcfzBiDemYNQ6HSUnBzBoU1D+S+RU5qQ3unL1OE=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlWbyyE/WewKrBIth60d6n12M+u4EPc/LR75
 B2+D4kcqkE2HokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpVm8sAAoJELqXzVK3
 lkFP3a8L/0C/D4LGj2mVPk0AbEsW6y30apYmMJKNFpm3EHkwLZ+52I4siB6o9XjhWP6wJft+P/F
 GoL2ZqVkI1IQ3712BJDhpjOpSGtlN8uXgwF3aGG8k6f1qHJvowrXxKwoxYBpfWdj1dCrwSSAud2
 qII6NkL0xhSXCOBmg4ihljummrYghwezSDt19DxXw9GwVTkDZkCmOucuJ+06F5eBWaE67kMBmns
 zZeFCszDMUX2XFhZd5ddo+t1gkL3d0QrUqkFBnFTpz9A6v6OXR8iDCA2YwKOH7BClBGoS/9MyrV
 eHJhePRCZ57fKfl6oIEbv0OPDnmAhEyeNPc/8uPb/fFamc3PELHRaqMXXkpnkfPlAr9CJVrkiUf
 vffqXAWm5cBK0Jcjt8cPs3Pvz+ZJoYd08hTDpmHI3/Odpnq5+qHndXt10xUCcWV+MS7K7YRDXSK
 usGRtcm8faSwqWonxSIH5NeYcNiGe9/6AMI/ROJxEA6RLTcQ3J75DfZtuosh/4/HHfHy+1OxIU6
 Nc=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Generate the behavior in do_proc_douintvec{,_w,_r} functions with
do_proc_dotypevec(uint). The originals (do_proc_douintvec{,_w,_r})
where created in the same way as do_proc_dotypevec but for individual
values (no vectors). In this commit we use the existing macro
implementation to extend do_proc_douintvec to include vectors of values.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 118 ++------------------------------------------------------
 1 file changed, 3 insertions(+), 115 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8c0bbb82cfcbc8830a0f3a68326c002ac51d41a6..5bc1bd3d415be2552f085111852f63ddefb05894 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -451,8 +451,8 @@ static int do_proc_uint_conv(bool *negp, ulong *u_ptr, uint *k_ptr, int dir,
 			      proc_uint_u2k_conv, proc_uint_k2u_conv);
 }
 
-static int do_proc_uint_conv_minmax(ulong *u_ptr, uint *k_ptr, int dir,
-				    const struct ctl_table *tbl)
+static int do_proc_uint_conv_minmax(bool *negp, ulong *u_ptr, uint *k_ptr,
+				    int dir, const struct ctl_table *tbl)
 {
 	return proc_uint_conv(u_ptr, k_ptr, dir, tbl, true,
 			      proc_uint_u2k_conv, proc_uint_k2u_conv);
@@ -651,119 +651,7 @@ out: \
 
 do_proc_dotypevec(int)
 do_proc_dotypevec(ulong)
-
-static int do_proc_douintvec_w(const struct ctl_table *table, void *buffer,
-			       size_t *lenp, loff_t *ppos,
-			       int (*conv)(bool *negp, unsigned long *u_ptr,
-					   unsigned int *k_ptr, int dir,
-					   const struct ctl_table *table))
-{
-	unsigned long lval;
-	int err = 0;
-	size_t left;
-	bool neg;
-	char *p = buffer;
-
-	left = *lenp;
-
-	if (proc_first_pos_non_zero_ignore(ppos, table))
-		goto bail_early;
-
-	if (left > PAGE_SIZE - 1)
-		left = PAGE_SIZE - 1;
-
-	proc_skip_spaces(&p, &left);
-	if (!left) {
-		err = -EINVAL;
-		goto out_free;
-	}
-
-	err = proc_get_long(&p, &left, &lval, &neg,
-			     proc_wspace_sep,
-			     sizeof(proc_wspace_sep), NULL);
-	if (err || neg) {
-		err = -EINVAL;
-		goto out_free;
-	}
-
-	if (conv(&lval, (unsigned int *) table->data, 1, table)) {
-		err = -EINVAL;
-		goto out_free;
-	}
-
-	if (!err && left)
-		proc_skip_spaces(&p, &left);
-
-out_free:
-	if (err)
-		return -EINVAL;
-
-	return 0;
-
-bail_early:
-	*ppos += *lenp;
-	return err;
-}
-
-static int do_proc_douintvec_r(const struct ctl_table *table, void *buffer,
-			       size_t *lenp, loff_t *ppos,
-			       int (*conv)(bool *negp, unsigned long *u_ptr,
-					   unsigned int *k_ptr, int dir,
-					   const struct ctl_table *table))
-{
-	unsigned long lval;
-	int err = 0;
-	size_t left;
-	bool negp;
-
-	left = *lenp;
-
-	if (conv(&negp, &lval, (unsigned int *) table->data, 0, table)) {
-		err = -EINVAL;
-		goto out;
-	}
-
-	proc_put_long(&buffer, &left, lval, false);
-	if (!left)
-		goto out;
-
-	proc_put_char(&buffer, &left, '\n');
-
-out:
-	*lenp -= left;
-	*ppos += *lenp;
-
-	return err;
-}
-
-static int do_proc_douintvec(const struct ctl_table *table, int dir,
-			     void *buffer, size_t *lenp, loff_t *ppos,
-			     int (*conv)(bool *negp, ulong *u_ptr, uint *k_ptr,
-					 int dir, const struct ctl_table *table))
-{
-	unsigned int vleft;
-
-	if (!table->data || !table->maxlen || !*lenp ||
-	    (*ppos && SYSCTL_KERN_TO_USER(dir))) {
-		*lenp = 0;
-		return 0;
-	}
-
-	vleft = table->maxlen / sizeof(unsigned int);
-
-	/*
-	 * Arrays are not supported, keep this simple. *Do not* add
-	 * support for them.
-	 */
-	if (vleft != 1) {
-		*lenp = 0;
-		return -EINVAL;
-	}
-
-	if (SYSCTL_USER_TO_KERN(dir))
-		return do_proc_douintvec_w(table, buffer, lenp, ppos, conv);
-	return do_proc_douintvec_r(table, buffer, lenp, ppos, conv);
-}
+do_proc_dotypevec(uint)
 
 /**
  * proc_douintvec_conv - read a vector of unsigned ints with a custom converter

-- 
2.50.1



