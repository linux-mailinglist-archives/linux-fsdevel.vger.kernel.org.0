Return-Path: <linux-fsdevel+bounces-67797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEB2C4B9B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781701894F4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 06:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663B1296BB8;
	Tue, 11 Nov 2025 06:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="t80ElG2Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0MI1pVxU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A764A288C34;
	Tue, 11 Nov 2025 06:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762841125; cv=none; b=L41ZrSEeiy+4UaT2JbmBcNSHNzfUnnoyUDuDd3+jXIJIUMTJkUuNLqKIBAPdfnFYDWg37CEEn2MAEztrCxu5Zx4lNZpVV2PBiKs7Fps4Ex0rxf+B30ythWo+N379Z+lP2g+HFWL0d+jEuxN6P6JkLayLgWOjGllAdmm3scmyMdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762841125; c=relaxed/simple;
	bh=uiTxSEGBsQ1l76wvFYeax1OY2fDYVsM47J/jwqix4f4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClBffEYDnujrWi9DLdbgbB+uyrNMJjB0T6njb/RHmiDqlqApGa1EiXEX6Xgc0uj42fogtP9dTe79/McHQJKg1Imi3Jq0ODBjKXO/pR9tXDpIdginFm/XVu1Hk38bB6CcSRz6SpoOLqEhb5a4M3C3dQgkgdSzfKe/C7YMpQiX6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=t80ElG2Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0MI1pVxU; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 9CEBE1D00230;
	Tue, 11 Nov 2025 01:05:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 11 Nov 2025 01:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762841122; x=
	1762927522; bh=eDhL4iSqCzLIdSVrbnb+njLWZ1dhF39Ky+xApv/W9/4=; b=t
	80ElG2ZQ3o5OpF/KqHf7x6YjfGToT4mR4+0jDCLfJC9wQvrMcdRvxow7FNnjKQ0f
	Ad/EwJal6UrjG7ySvwpff+qKh0FKAA4HV1Sz89z2Ld/27nm+fyK8lixHTjMuSbbe
	lp5h0oYjsI1qHt0ulhFUVtIvSgVVfKA6wTKWxsrv3HpxKGQuInQhMdne0QNfoejm
	8V5IfozZK5YEP4VCXubA9+J+KAz0N9yPn3KzCGMD6UHXqdHtZb+PH+0o1pCS58G1
	Jepk7mX8Jum05XCQYLW76sIs9NCwx2+qw8YXJegotA83KVyH0fb0uBFnEnqjnpBI
	PK+fdb5+aF2WzcTzb6lGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762841122; x=1762927522; bh=e
	DhL4iSqCzLIdSVrbnb+njLWZ1dhF39Ky+xApv/W9/4=; b=0MI1pVxU2oE2r5vxs
	EVxfcCOB68simJ9ZBOdy9LaCN2URUSTKxko3AwKNoUnfW0bPnkhHV8WvoccYMoGq
	1QBx/Ww+HKKMfAKXhrETFH0asrILib/5Z5FVbxi4wnP/+F6DRZbCBnBdSQpcI4+L
	4w0FhuZd/CS+d2rVYCVXBeMIHQEVDaxKlondmx/e0BetU880ue5TdskJmVnsNBdR
	kFTFOFeLp/OKAkWG6f23bS5PKiecs5naujqz22CroY5BZkxsp5bYW17osIZQrkWv
	9M0UHrdZjFaEVvaV7NFC6jh3TsAtszUffNtVlY4rjExh6RzZ70iDtn2qO0osfBMA
	n/cww==
X-ME-Sender: <xms:IdISaa-nBjMx7PbWhb2e80scFXcbqFLgJWUMzYg7RV4s9mJHOw0fCw>
    <xme:IdISabYNgJrUjiFtWXAeAapEuD2zMusGzYrJoN0_t1Xb6hxl6gpsehms2JxuTVL7b
    _SKSkKDasKAlj0kb2kUmvWvugb8KaMVeQkkNKAEijarNSqB>
X-ME-Received: <xmr:IdISaeMuVJRo6J2oa_vgXXqCTP8Y-LZlFghfgMcrWbD0SmrxFl6bnhSnUnbtBPSvanYrLH7RzLiOU3ztgbaUtcIks0k2miKYfGN-3zKv2BHvbf04k_pyBuCHcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddtgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedule
    egueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirh
    hoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehlihhnuhigqdhk
    vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegruhhtohhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghv
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrvhgvnhesthhhvg
    hmrgifrdhnvght
X-ME-Proxy: <xmx:ItISaXBIiS9WcC3fwIVVyXdmkZHQAXqfxiHPL1lDlGNHLZHvTi9ljw>
    <xmx:ItISaVLTou8UQiLxRI937uqlU1_U5-yOks184XIFZa4XmFCYwyCEoQ>
    <xmx:ItISaQOhMMzw29ML9MV-w6gQaWHEg-glAcxc-WDfdhg0G7eK2g3R5Q>
    <xmx:ItISaT7-rT1W1tgkCR7hiJWxznc1gt4ET6hAOkAP_0FSharI4JDwjg>
    <xmx:ItISaVu7pNoJC6MxjA6SqocCdYq3KA6cA9ZwXl2sZq0_bXyE0r93kgPZ>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 01:05:19 -0500 (EST)
From: Ian Kent <raven@themaw.net>
To: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	autofs mailing list <autofs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Ian Kent <raven@themaw.net>
Subject: [PATCH 1/2] autofs: fix per-dentry timeout warning
Date: Tue, 11 Nov 2025 14:04:38 +0800
Message-ID: <20251111060439.19593-2-raven@themaw.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111060439.19593-1-raven@themaw.net>
References: <20251111060439.19593-1-raven@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check that determines if the message that warns about the per-dentry
timeout being greater than the super block timeout is not correct.

The initial value for this field is -1 and the type of the field is
unsigned long.

I could change the type to long but the message is in the wrong place
too, it should come after the timeout setting. So leave everything else
as it is and move the message and check the timeout is actually set
as an additional condition on issuing the message. Also fix the timeout
comparison.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/dev-ioctl.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index d8dd150cbd74..8adef8caa863 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -449,16 +449,6 @@ static int autofs_dev_ioctl_timeout(struct file *fp,
 		if (!autofs_type_indirect(sbi->type))
 			return -EINVAL;
 
-		/* An expire timeout greater than the superblock timeout
-		 * could be a problem at shutdown but the super block
-		 * timeout itself can change so all we can really do is
-		 * warn the user.
-		 */
-		if (timeout >= sbi->exp_timeout)
-			pr_warn("per-mount expire timeout is greater than "
-				"the parent autofs mount timeout which could "
-				"prevent shutdown\n");
-
 		dentry = try_lookup_noperm(&QSTR_LEN(param->path, path_len),
 					   base);
 		if (IS_ERR_OR_NULL(dentry))
@@ -487,6 +477,18 @@ static int autofs_dev_ioctl_timeout(struct file *fp,
 			ino->flags |= AUTOFS_INF_EXPIRE_SET;
 			ino->exp_timeout = timeout * HZ;
 		}
+
+		/* An expire timeout greater than the superblock timeout
+		 * could be a problem at shutdown but the super block
+		 * timeout itself can change so all we can really do is
+		 * warn the user.
+		 */
+		if (ino->flags & AUTOFS_INF_EXPIRE_SET &&
+		    ino->exp_timeout > sbi->exp_timeout)
+			pr_warn("per-mount expire timeout is greater than "
+				"the parent autofs mount timeout which could "
+				"prevent shutdown\n");
+
 		dput(dentry);
 	}
 
-- 
2.51.1


