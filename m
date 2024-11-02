Return-Path: <linux-fsdevel+bounces-33521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7579F9B9CF9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02FE8B221ED
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB50B176240;
	Sat,  2 Nov 2024 05:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oiavVFxp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B87A14A4FB;
	Sat,  2 Nov 2024 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524113; cv=none; b=JiDnEUkc226U7SjNPyAWtb7Dv5OZhLDTygQ9mvBj+IiQCdxdaV2AR0Kiv2iUdthHK4eUlYyNjmP2yroG5ISi6fC1+ZOC8aeLF04r2Nlcb998pNRPiVPPFdrfAL4MIIeZckzLrMztihr95zggHEhMWsj8T11daRFbkiYna/HFF0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524113; c=relaxed/simple;
	bh=AbWgiEoFsCDPSvk9UBSB7TM6sLazsCj+HOpWxlLzRLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ee+Ou6gmdZaGaXNTDqPeGyjEmkiMjqbQk9CdM9a/rSKOf++cBpm3KS7hAFM1GVd+rbJh6dK2lGJK/vnStwbWAOtbBA9XKNXOwDn6f1kGaOtDZb7higf7a3nl9Mf7PoT1UX6OJL53fZ1NbjMAj+TaTq/BQd47pZM23aeGeOgOX/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oiavVFxp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fpTFwC1cwbG/GhgZYQIkCsdmSnGXxenEp8xwckVr6H4=; b=oiavVFxpxIY1eBpfr61Z69z5H0
	OmjZcEesBViQjOMkS81gEV7eSKlZ54AjUBSLDecYX+Jfi3Z8SuQPW+UDHe5lwFD8+42CBj4GEImMC
	yyi+UDfgfjUcRTll8EMCaT9FRhpiRFHaPhIVNUxc6srWFfa2kjCnEcj/WJLTzJrwg/YsdEuZdhViU
	TTwfzNu+/U9b0IUiDhhJAVaxIp9KSkBdnTnDX820Tp1K58SaZekSkjHbD7pxrdEVDBXVD9pSyZYXD
	p9ueSFJRqe//E8J2shI3Hw5Ngx48kyDXU33x37kZhtRVquVDhFY22xVzf57weAwkQaLapn0RXLoPi
	dbM9l+DA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76NC-0000000AHnm-0BKA;
	Sat, 02 Nov 2024 05:08:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 20/28] convert media_request_get_by_fd()
Date: Sat,  2 Nov 2024 05:08:18 +0000
Message-ID: <20241102050827.2451599-20-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

the only thing done after fdput() (in failure cases) is a printk; safely
transposable with fdput()...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/media/mc/mc-request.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/media/mc/mc-request.c b/drivers/media/mc/mc-request.c
index e064914c476e..df39c8c11e9a 100644
--- a/drivers/media/mc/mc-request.c
+++ b/drivers/media/mc/mc-request.c
@@ -246,22 +246,21 @@ static const struct file_operations request_fops = {
 struct media_request *
 media_request_get_by_fd(struct media_device *mdev, int request_fd)
 {
-	struct fd f;
 	struct media_request *req;
 
 	if (!mdev || !mdev->ops ||
 	    !mdev->ops->req_validate || !mdev->ops->req_queue)
 		return ERR_PTR(-EBADR);
 
-	f = fdget(request_fd);
-	if (!fd_file(f))
-		goto err_no_req_fd;
+	CLASS(fd, f)(request_fd);
+	if (fd_empty(f))
+		goto err;
 
 	if (fd_file(f)->f_op != &request_fops)
-		goto err_fput;
+		goto err;
 	req = fd_file(f)->private_data;
 	if (req->mdev != mdev)
-		goto err_fput;
+		goto err;
 
 	/*
 	 * Note: as long as someone has an open filehandle of the request,
@@ -272,14 +271,9 @@ media_request_get_by_fd(struct media_device *mdev, int request_fd)
 	 * before media_request_get() is called.
 	 */
 	media_request_get(req);
-	fdput(f);
-
 	return req;
 
-err_fput:
-	fdput(f);
-
-err_no_req_fd:
+err:
 	dev_dbg(mdev->dev, "cannot find request_fd %d\n", request_fd);
 	return ERR_PTR(-EINVAL);
 }
-- 
2.39.5


