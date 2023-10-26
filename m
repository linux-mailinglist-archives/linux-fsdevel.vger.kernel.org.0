Return-Path: <linux-fsdevel+bounces-1216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91C97D7ACD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 04:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1781E281D73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 02:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B258A8F5C;
	Thu, 26 Oct 2023 02:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YVaajfoB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48F623AE
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 02:18:44 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59883AB
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 19:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=w/vtrSvfYAGoVujMphd9w5k11xJnJNj0OcWihGXgYTs=; b=YVaajfoBiyUnK6zw8/ztnZTr1e
	MRuihgbObGdkpbTLhzKEJyk/EgQk2ggwOeP/nAucp5G6uMHmuZauCpmorm2stXy8+pqhmYGSphIcU
	P4Z0ypj6pUvWVJK217ajBCdvGTAU9ypJUWf3erHLZCGbL+EYf2ZN8tz/NQp9+h8DdqZnyfXUDu5fZ
	Pc+nKRv62u7aoT3fRAbu+kLWQ5ZoX115DTC6QFq80vHeA0XxjXu8Kp+lSefstHDqwtIBpDE+B0vYG
	hcZKF+O51vS1Z4yuN9ZgVah/TddBmbw3Q2U/Pc/Za1+a08RYnwtRCIUZGsGJQY8AYhrG8qOcoeQab
	Bu/cHd6Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qvpxI-005mjU-1f;
	Thu, 26 Oct 2023 02:18:40 +0000
Date: Thu, 26 Oct 2023 03:18:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <christian@brauner.io>
Subject: [PATCH] io_uring: kiocb_done() should *not* trust ->ki_pos if
 ->{read,write}_iter() failed
Message-ID: <20231026021840.GJ800259@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[in viro/vfs.git#fixes at the moment]
->ki_pos value is unreliable in such cases.  For an obvious example,
consider O_DSYNC write - we feed the data to page cache and start IO,
then we make sure it's completed.  Update of ->ki_pos is dealt with
by the first part; failure in the second ends up with negative value
returned _and_ ->ki_pos left advanced as if sync had been successful.
In the same situation write(2) does not advance the file position
at all.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 io_uring/rw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/rw.c b/io_uring/rw.c
index c8c822fa7980..08d94fb972f0 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -339,7 +339,7 @@ static int kiocb_done(struct io_kiocb *req, ssize_t ret,
 	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
 	unsigned final_ret = io_fixup_rw_res(req, ret);
 
-	if (req->flags & REQ_F_CUR_POS)
+	if (ret >= 0 && req->flags & REQ_F_CUR_POS)
 		req->file->f_pos = rw->kiocb.ki_pos;
 	if (ret >= 0 && (rw->kiocb.ki_complete == io_complete_rw)) {
 		if (!__io_complete_rw_common(req, ret)) {
-- 
2.39.2


