Return-Path: <linux-fsdevel+bounces-64072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2C6BD74BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 06:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2373E8697
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 04:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5043B30BBA3;
	Tue, 14 Oct 2025 04:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="WIZ0o9hy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BF519C54F;
	Tue, 14 Oct 2025 04:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760417056; cv=none; b=Nc8sZuURoNENDMLCXc2p/dJrYVVYkms7bAqsEYqnX2QWTcwlf+yB6xxanSIDTioyYCuytvjv4aVZv1rl8TFQDKha5HMQIcYvM1exgyum50aD/ADWoM4S07WqQ671uv2GdFEoaZ4N3Vw8Lng8bbsxDmFtLjOyAFJyM6bAyVpf6x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760417056; c=relaxed/simple;
	bh=zKiwJfzMvHS/QbUfSFeCkbnCzRpt5pcFlJvifHD5JOM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ETENJaaeg5bezlJzawDA6kaesIJgxD2rjyX/naauIMQJY+HovCCzKZxn6KXAzefzTXVzHyJbHVPr8KggcIvArCWnO04D2GPPA0VAT8NSG5GRrz23GcHMqGscTtPAuDgPSPxAF6Q0yGLIEwE+Haw6DZ30VF7nYw4c9CeTyfZx3mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=WIZ0o9hy; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1760416744; bh=I+65QEBcd7H6PlnqPuwAGZyL3ndjZTrNUq6FwaoC8FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WIZ0o9hy1N8A0r2oYZvYgpoe9apVsClJCpeyiUbO8iMYLgpRK4Rjv/R4fZ86OroY/
	 +XUc3i+YlHfKqsAAJr59xILEsjfl020Imvut3SfRp7D5fR2/PN3IRq9QLjd+ru1OaM
	 HnSk/aLyL45YXgvqYCNSkd96027al3Kd51o1aIZ8=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 9C21BC66; Tue, 14 Oct 2025 12:39:02 +0800
X-QQ-mid: xmsmtpt1760416742tgp00js5y
Message-ID: <tencent_EF3C9D37FE967C36364A3E748F77F966C009@qq.com>
X-QQ-XMAILINFO: MeukCuWaRbQlTbLyzIn3stJpwARYTxBo/aVqr571p22XLIT1HQWfEM9qy5Q3i3
	 6XRK4IB7fDVeWHHP+4LRw8ki3L3CW4mZJVTf9cOmcZiT83n7LFmaoz5EQ7e6zvF9NH6cfbhNWXGx
	 3QSaXdmC1JMlvxLsR1RF5KC8jYUqw4Znc5BHTauPGHHgjuhugz33CQ/ISCdvQcl6pPwj4dwAzayg
	 WQnumXPBe2Q1KVuGFs/69aDqO2yKANwWdnJzOcW59Ht6a2OTjZijF4JpFv52ichRCUNeyzTSz+x+
	 fo5NjFrtMRwkTGg9g/vgSveXxHbbI3+R4O8vSwdf8Y5A9+9F8GBi4dhHms0ziO6AlO7e8yqLt/A1
	 +9Oab9JaWWp4K3X9j53/Veby9koFVDhHpw80pVD2cgl1WRSGf7aay/hmb8+AoUHHCaPqnMxhhuy5
	 yKLuCvXf+XNK/hNtVaAPIPb+w8dR9mLFByty25g63G3TKLbQEHzZnFGnlsGhdx/u2wQQvxc11mXF
	 TvW5Irb6XTClAgAIdBid5TBEwXAu1Io48IeJc07S1qoxfbJ9lnitk2d8ahYm/OENAQlTXToQ2HuY
	 n9TaX+jBMTp4gygemS+rRER9AZxBQOCC7aceJtD69b71XfEyyd4VVAuHAhxX1KdWRhuGjswTtppj
	 0XTwsnbzdL4aTT1DPBrnPpvXjcmQpW5DAUmKIe/iRl0co4SWDYcGANdKBnVEhaJQILXBmOLOXQvw
	 gj2LmLTqobYnyWACtUoGPdZMZqah5yxmxHHu1acHL4hh1FeWiBIpFmpyDZYYvHNMKZOELD/V9ehA
	 lRBn9pjtWnVIVIVJlxDFRy6WbbFFuT1nQFbqm3Y7O+sTXF9QrQNrFDbz16VkAEZY7nmOtpQSXeWf
	 iQF8jzg1TxV41MTsWV/WOQZqGa73vtb2sOSuqpg0nEbDyspn+8H00FIcF5Nru0qg1/k9h42Js/H0
	 0cPRMe+UrjznJRs/UPODKiCD8hRMBa8v696KtOQytukERinbuVnUzGVBsmpBqQC1zwo2c1ja4=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+29934710e7fb9cb71f33@syzkaller.appspotmail.com
Cc: ethan.ferguson@zetier.com,
	linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sj1557.seo@samsung.com,
	syzkaller-bugs@googlegroups.com,
	yuezhang.mo@sony.com
Subject: [PATCH] exfat: Use str length when converting to utf16
Date: Tue, 14 Oct 2025 12:39:02 +0800
X-OQ-MSGID: <20251014043901.33142-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68ed75c7.050a0220.91a22.01ee.GAE@google.com>
References: <68ed75c7.050a0220.91a22.01ee.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syz reported a stack-out-of-bounds Read in exfat_nls_to_ucs2. [1]

Although general ioctl supports label of FSLABEL_MAX chars, when operating
on label passed in by the user, we should use strnlen to obtain the actual
character length instead of FSLABEL_MAX.

[1]
BUG: KASAN: stack-out-of-bounds in exfat_nls_to_ucs2+0x706/0x730 fs/exfat/nls.c:619
Read of size 1 at addr ffffc9000383fcc8 by task syz.0.17/5984
Call Trace:
 exfat_nls_to_ucs2+0x706/0x730 fs/exfat/nls.c:619
 exfat_nls_to_utf16+0xa6/0xf0 fs/exfat/nls.c:647
 exfat_ioctl_set_volume_label+0x15d/0x230 fs/exfat/file.c:524

Fixes: d01579d590f7 ("exfat: Add support for FS_IOC_{GET,SET}FSLABEL")
Reported-by: syzbot+29934710e7fb9cb71f33@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=29934710e7fb9cb71f33
Tested-by: syzbot+29934710e7fb9cb71f33@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/exfat/file.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index f246cf439588..c4001e1c289d 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -509,8 +509,8 @@ static int exfat_ioctl_get_volume_label(struct super_block *sb, unsigned long ar
 static int exfat_ioctl_set_volume_label(struct super_block *sb,
 					unsigned long arg)
 {
-	int ret = 0, lossy;
-	char label[FSLABEL_MAX];
+	int ret = 0, lossy, len;
+	char label[FSLABEL_MAX] = {0};
 	struct exfat_uni_name uniname;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -519,9 +519,10 @@ static int exfat_ioctl_set_volume_label(struct super_block *sb,
 	if (copy_from_user(label, (char __user *)arg, FSLABEL_MAX))
 		return -EFAULT;
 
+	len = strnlen(label, FSLABEL_MAX);
 	memset(&uniname, 0, sizeof(uniname));
 	if (label[0]) {
-		ret = exfat_nls_to_utf16(sb, label, FSLABEL_MAX,
+		ret = exfat_nls_to_utf16(sb, label, len,
 					 &uniname, &lossy);
 		if (ret < 0)
 			return ret;
-- 
2.43.0


