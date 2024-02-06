Return-Path: <linux-fsdevel+bounces-10503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 629FC84BB29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 17:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3518B2588C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A579610B;
	Tue,  6 Feb 2024 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="jJTGrxPM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26324A08;
	Tue,  6 Feb 2024 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237653; cv=none; b=TQR4XQJx3dxJ5hfC8Si61oHeh0fyw1f9YcuTPxk4qlAbxArD/Gak2187kf+6oKF1sLe/QMlOISBcesPcsLXA7DQUwxvRr/1MXHjAIp2x+zdJ8PxKgwdTCEJoOVL3NvoZmDVlzshV7q/6wSWLMiaWFrgh+R9EymHg8cUbk7fZBKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237653; c=relaxed/simple;
	bh=1TTnethT9ACWbE+2/u7LuqUNvlepRYWJQLWF5PV4eVo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=rXAXcGKewsNXlLq6YeFIesywAd2x+MBX4+5YKsFVeCMGFkm0PuaiOMED4gIgcZ192NRp89ozHpUG1mRS/vbniLKlk3ujJ3YM5Xjj3NzDT+gXxciK7PPqTnIFiwHOSZwkd3sqK1eTNSfLiogMtwfQYeBtJvNQi97qxW/32dNpoKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=jJTGrxPM; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1707237338;
	bh=nq8N3iJKzTg/aO9s2k31bxowdIKIrZYsvIlCVzu6Hsk=;
	h=From:To:Cc:Subject:Date;
	b=jJTGrxPMkWKgIPx/Lt8hzE0b+hk0gRCHObtmBodsyn5bkf/rJeeG0tEishDin6CpU
	 0BsL+oHt/WwJBjDWUmOeQoDm+/Nk1HbQ2FrIyAcE5enoPDnUKemO7etI9aJZQTAcOp
	 mNF8GkGva/BL73BWBifepzsVsU8g99II1JPiIUK0=
Received: from localhost.localdomain ([2409:8962:5b2:1ce9:ee76:89e4:5983:4db0])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 8E113278; Wed, 07 Feb 2024 00:35:33 +0800
X-QQ-mid: xmsmtpt1707237333tgwzpj2kr
Message-ID: <tencent_10AAA44731FFFA493F9F5501521F07DD4D0A@qq.com>
X-QQ-XMAILINFO: NKv2G1wnhDBn0Qeh0KEAELRU5PYymkJtjrJl0x9WPh7uY2FwQzhHGIHIUWLC+F
	 9FTchisw4zfIsnJod27XT91951dwj1nw8gua0iYpm6z0susMJjdrMtjZZ380LYrjlX+wNkPNlwde
	 TQTebx3ih0f7TTayCpVB7ENm9xf9Ki0WaEUxp7YRYSjQavgepJwA2JnHxoDAKDgk0eKPZ/JNqv9G
	 CR7ShxvokbDpzgW+VokAJiZXd1nM8JovPS0kKNJpS5Z4Z/cSi7EhwYBAjH5am2NV3af9BtaCO66W
	 Qi8N5E6gjB1esSulFhp2DI/hxozXirRN1mItweYx/XMhH+QWPFiiPWeck/wFORWpriUNw0vzYgG5
	 r5vcQemzDaAZ5bUW5Q0ae1rPpTXxyU+wi+Q1YF8+cB08622la1N3exP8lA+Am6jkBQ5+R8t1/zgt
	 Yr4eVxROlPP9bimPPbxciyq2/pLLX8xJDKxervzmf9IIq1UDWQV/Kgw0ua9BuDqaldOL8MikkCQw
	 x8Op2sQfD97ORuELvNyL95EdMAmfz5bKvCEJDeeH8Zh1agCqXhunlmfQbBHi2KjlrEHP7+s1jx+G
	 08K8b27J2cOqszbAYygspb1E3z+zQW2pNgtcr7k1hvjFAkbvCNN3T9bNd2R4m7jgSkIf9+6mzayT
	 0TSstqJusKSZ04oc3V6N1kI+4SZ5jhykzHX4wVRoVuxE5RP9hG9Xqa2IwFIv55Dx/7YJKLC5F5l5
	 im5iVya06TUKbVd44+DkEYyD8mUZV6Hnmha3A9n63ZR5LwTINrg5EMyzzka1kPS/WL2/2N0nAJ1r
	 g+WjIT6jPeTiVi3Cb0lZPh2AB/Uxad7X3ePSmCd+I6BFX+qOUMyV6N3vm1pYpdG0U+geAvMXAziu
	 88jC5oa8XQRL+NAUsfUnciGliz+W5x+tP/SzPQ5q5ye2xudAAnriscZhHdUa9qSKypxtQcH/2njb
	 gq2nVhigbnxNUSH8Rf1JhVyDRTUaVWmy4Kiflf9IarASsirh88Fi9BCsFzAfEgYCfyHn6lzFoWGj
	 /JgsXFqZAMK1IX9+o6JTAu5hNlXCcHQ0lypBVY3w==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: wenyang.linux@foxmail.com
To: Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	Jan Kara <jack@suse.cz>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Matthew Wilcox <willy@infradead.org>,
	Eric Biggers <ebiggers@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] eventfd: strictly check the count parameter of eventfd_write to avoid inputting illegal strings
Date: Wed,  7 Feb 2024 00:35:18 +0800
X-OQ-MSGID: <20240206163518.3811-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

Since eventfd's document has clearly stated: A write(2) call adds
the 8-byte integer value supplied in its buffer to the counter.

However, in the current implementation, the following code snippet
did not cause an error:

	char str[16] = "hello world";
	uint64_t value;
	ssize_t size;
	int fd;

	fd = eventfd(0, 0);
	size = write(fd, &str, strlen(str));
	printf("eventfd: test writing a string, size=%ld\n", size);
	size = read(fd, &value, sizeof(value));
	printf("eventfd: test reading as uint64, size=%ld, valus=0x%lX\n",
	       size, value);

	close(fd);

And its output is:
eventfd: test writing a string, size=8
eventfd: test reading as uint64, size=8, valus=0x6F77206F6C6C6568

By checking whether count is equal to sizeof(ucnt), such errors
could be detected. It also follows the requirements of the manual.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Eric Biggers <ebiggers@google.com>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
---
 fs/eventfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index fc4d81090763..9afdb722fa92 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -251,7 +251,7 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 	ssize_t res;
 	__u64 ucnt;
 
-	if (count < sizeof(ucnt))
+	if (count != sizeof(ucnt))
 		return -EINVAL;
 	if (copy_from_user(&ucnt, buf, sizeof(ucnt)))
 		return -EFAULT;
-- 
2.25.1


