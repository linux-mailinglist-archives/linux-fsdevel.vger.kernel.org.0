Return-Path: <linux-fsdevel+bounces-21142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2764E8FF9C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 04:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB0D1F23885
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 02:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADB917BB4;
	Fri,  7 Jun 2024 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HgqLBh9V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7AE10799
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725601; cv=none; b=orTrvgocnmWBqV/waAs4VT4NWf1Ki2MMIcNu0ZUVlhna/l5G5YucgyQvtor5yjoP3A+dv3CFPVj4IgNHzIqR8UVyZcaFDXYaH54N/J/UWaLp9yAMLVjV7qjAN8CsWOZTAAB7+B+Ml6VaMs2ERq4cTcvFl4lONfDBlaV0ulHC9Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725601; c=relaxed/simple;
	bh=rXNOnVSRK3gEc8YZTYYL15FKmUqDUuU7MfQDWJDBw6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DBNGLqPJsFCoTTNlL3HEE1ZnxP2cA+zuBPmOMXjxC64bNooa6IqL+xZtL6JDje3k1eImfXTQQEtqkQXtlQxux4OgC6WjZLoK7zg+7AdUW96mfenhy4w/YJD24u4UY8JXyMM90Mtmh4sH0B9+45TkzHFF90sacUB6Wm2XXXYmQoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HgqLBh9V; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5P5SmCUL2PodzF+Lu2JJvnxyY+1rkGdldDypUbr/rxk=; b=HgqLBh9VeQ7azp3tOmWvBcZw7v
	ey7S9vTR+QyhyjS7VGJvDlXHQmjvtuWvMsdke+B7QoWUn3zMhZ83gAfW+RMHZwQ3ZRnXXTmPCyEG7
	8Bo68c6VTivsf3iF++hJ4RbYju1TDKxJKx6qwP4y3mJeZruaB9N49XbEOqukpQ6exO2tMFjeB7TfO
	iKeqeh88B0O0U27ttpx2Es7eQSC7cgatvlj1tQLj23E2hQZUi94j2kaav6J8SPPtPRpDQjBoZUQFb
	gUusIe8IWVW27TNe0/1CY/0bTSBF842UZxM1StXiXgp4PlIFKzbr3Z0+PDvfsWy4x0or29/y+KWnv
	zNLtGmKA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sFOtZ-009xBC-27;
	Fri, 07 Jun 2024 01:59:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 02/19] lirc: rc_dev_get_from_fd(): fix file leak
Date: Fri,  7 Jun 2024 02:59:40 +0100
Message-Id: <20240607015957.2372428-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

missing fdput() on a failure exit

Fixes: 6a9d552483d50 "media: rc: bpf attach/detach requires write permission" # v6.9
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/media/rc/lirc_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
index 52aea4167718..717c441b4a86 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -828,8 +828,10 @@ struct rc_dev *rc_dev_get_from_fd(int fd, bool write)
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (write && !(f.file->f_mode & FMODE_WRITE))
+	if (write && !(f.file->f_mode & FMODE_WRITE)) {
+		fdput(f);
 		return ERR_PTR(-EPERM);
+	}
 
 	fh = f.file->private_data;
 	dev = fh->rc;
-- 
2.39.2


