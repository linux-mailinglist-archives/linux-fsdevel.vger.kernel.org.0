Return-Path: <linux-fsdevel+bounces-53731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BE0AF63EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 23:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C5C1711E7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 21:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B81C26CE18;
	Wed,  2 Jul 2025 21:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="X4AspTId"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F388E230268;
	Wed,  2 Jul 2025 21:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751491545; cv=none; b=gfd3EMD/6wlamMwuYs1ODUtMBuwQb6BzI4CZ+yYfYznavN396RF44S1t6ot/F8lznrPipCpG8KCSbeK7d3mr6CyfS41ePQrQmz9oh/01gHccOJEx5ypelGIJB/bw5R/5N5e80GBK2oEzkYIGNzEKuhhqIxF6sFRetMbDaMUZ6/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751491545; c=relaxed/simple;
	bh=m/rn8noWNQPIfBXKrGfHmVb2dM6W1UkWtrO/SOtCET0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0cTX86HEuqCyoHMTK/2wKyDLfnWiP91C3WReNv6TapSrs5zcAV0/vHiq/zGtwhv0ONjCmlmZOD8ORTiGdY2DGuxMuaSb0fGlDSTJdae7ZT4Q+FtNMvRoNLDzN35nDRDrc6JB6/x7o7QP/tXqr+i0UpHTuUuPhwSqqHB5de6MnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=X4AspTId; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D2qWpaip3f31L6c6ADO/UKCapKoI96YpHqRy3PS/oKs=; b=X4AspTIdrc//4kzgAQ1vMESKjH
	zryNsOpWUhR7taZ4CrEcsmbQdECO/2hOHdbhfY+k/tFqgdKySKvLtf+IBdUL979cY7cGiqRu208Cn
	O0dWBofJwG21/u0bpPKYxVwcONlLAW6xFCwT95RLKAlydo3lvansWkVaApzbI4aWr1K6mHznXV8j0
	1MhvDAikaNg2q022uoN7CTbi9kd6Y4RoiaaOfsfUF4Nc5IoTOOWTNr0sl0iSvdH0oUbIThUHbCDp9
	ovW7hv0G5ES9417VzVr3eT99JeRVACACQySwZri4WRV0C8/JInjX/6byKuvYYUfkNmexd7diOPlTG
	iH89mmXg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX4xa-0000000EOJP-2Q69;
	Wed, 02 Jul 2025 21:25:42 +0000
Date: Wed, 2 Jul 2025 22:25:42 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 08/11] fix tt_command_write()
Message-ID: <20250702212542.GH3406663@ZenIV>
References: <20250702211305.GE1880847@ZenIV>
 <20250702211408.GA3406663@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702211408.GA3406663@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

1) unbalanced debugfs_file_get().  Not needed in the first place -
file_operations are accessed only via debugfs_create_file(), so
debugfs wrappers will take care of that itself.

2) kmalloc() for a buffer used only for duration of a function is not
a problem, but for a buffer no longer than 16 bytes?

3) strstr() is for finding substrings; for finding a character there's
strchr().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/thermal/testing/command.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/testing/command.c b/drivers/thermal/testing/command.c
index ba11d70e8021..1159ecea57e7 100644
--- a/drivers/thermal/testing/command.c
+++ b/drivers/thermal/testing/command.c
@@ -139,31 +139,21 @@ static int tt_command_exec(int index, const char *arg)
 	return ret;
 }
 
-static ssize_t tt_command_process(struct dentry *dentry, const char __user *user_buf,
-				  size_t count)
+static ssize_t tt_command_process(char *s)
 {
-	char *buf __free(kfree);
 	char *arg;
 	int i;
 
-	buf = kmalloc(count + 1, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+	strim(s);
 
-	if (copy_from_user(buf, user_buf, count))
-		return -EFAULT;
-
-	buf[count] = '\0';
-	strim(buf);
-
-	arg = strstr(buf, ":");
+	arg = strchr(s, ':');
 	if (arg) {
 		*arg = '\0';
 		arg++;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(tt_command_strings); i++) {
-		if (!strcmp(buf, tt_command_strings[i]))
+		if (!strcmp(s, tt_command_strings[i]))
 			return tt_command_exec(i, arg);
 	}
 
@@ -173,20 +163,20 @@ static ssize_t tt_command_process(struct dentry *dentry, const char __user *user
 static ssize_t tt_command_write(struct file *file, const char __user *user_buf,
 				size_t count, loff_t *ppos)
 {
-	struct dentry *dentry = file->f_path.dentry;
+	char buf[TT_COMMAND_SIZE];
 	ssize_t ret;
 
 	if (*ppos)
 		return -EINVAL;
 
-	if (count + 1 > TT_COMMAND_SIZE)
+	if (count > TT_COMMAND_SIZE - 1)
 		return -E2BIG;
 
-	ret = debugfs_file_get(dentry);
-	if (unlikely(ret))
-		return ret;
+	if (copy_from_user(buf, user_buf, count))
+		return -EFAULT;
+	buf[count] = '\0';
 
-	ret = tt_command_process(dentry, user_buf, count);
+	ret = tt_command_process(buf);
 	if (ret)
 		return ret;
 
-- 
2.39.5


