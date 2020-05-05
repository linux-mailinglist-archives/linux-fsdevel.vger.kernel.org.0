Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9751C5D4E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 18:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbgEEQUb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 12:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730056AbgEEQU3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 12:20:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E34C061A0F
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2020 09:20:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u127so3019066wmg.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 09:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2ofUnhNRHIzcaSUijq5Z6dGV0CsGnW2PMJHsRfB+wRw=;
        b=LPeObwI2Z3tc2eoz472K3ToHnSxcdfr/YP9nf1tz8TjzB3KLLTsk7mEdleEDYsBFbW
         61Sm1DJwqP8+rf7JajW0rR3p4ZboLOxp/erwcP9AJoftyMrwcJNy1SoAvSF+03PTuuY5
         yMLe3taSdvzzzboS/PZ2ckey6MsAniTeerysVIE0h2WMalxIaMIenPx2VfOcZTczCGGu
         pwlrW7VefWS9T6hkmSimWLyyYY59O7V0MjyAufvGo9ctJXpkmZwosGdVBTjSUeHJZKgV
         q/mPiBUgoG5JQWb0wvCPIsnCLR0YsGfimXDGOLbOau/S+aazIECi7fy8AGCYAI89XM89
         r1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2ofUnhNRHIzcaSUijq5Z6dGV0CsGnW2PMJHsRfB+wRw=;
        b=O0Kxj/QPXzv2lJxqwBi1C4h7AIPog/1jM7aexwd9P2JM8/99PuX03QRHzSFtxYO1YF
         6LedlLB8CzHtV0w+pNRg3qlsaPzfCOr0fKTbWGJ7I2GFXe74WH9bN5qUDeV2IoXKtbZp
         Af33oOTHmyCgKsKjBVua056CcKKwzeUMDcsU7dA0XDI5Sq7HRoQbquEpOINezv/RQCUJ
         CssPch85t5kwyccFFkWHUdU16wEOADXspIggmxQOLH3rHeEZ2vxsiFfrEh/JrlBIzx5B
         BtrwYx0XKb0hvEo9abEk17X/sQTxjY6EV2THsRuhb75MQ2hbk3/SgX/DuDH+qjIXI1S4
         hW/w==
X-Gm-Message-State: AGi0PuYg0dC5SlujAhi0nAs6GPnNO0q3BCl1xR/4X0KkcGp7imlzHOAW
        iZiMN4JsI42/EjO9GhzJ9Ps=
X-Google-Smtp-Source: APiQypLjYFs21If/AXmYdmA3/IX31+7SHKw+IK4cN/FEWiBjNlZq9erW8626p+bj7wXfqh+2B7izWg==
X-Received: by 2002:a1c:3dd6:: with SMTP id k205mr4327137wma.138.1588695627407;
        Tue, 05 May 2020 09:20:27 -0700 (PDT)
Received: from localhost.localdomain ([141.226.12.123])
        by smtp.gmail.com with ESMTPSA id c128sm1612871wma.42.2020.05.05.09.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:20:26 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 4/7] fanotify: distinguish between fid encode error and null fid
Date:   Tue,  5 May 2020 19:20:11 +0300
Message-Id: <20200505162014.10352-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505162014.10352-1-amir73il@gmail.com>
References: <20200505162014.10352-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In fanotify_encode_fh(), both cases of NULL inode and failure to encode
ended up with fh type FILEID_INVALID.

Distiguish the case of NULL inode, by setting fh type to FILEID_ROOT.

This is needed because fanotify_fh_equal() treats FILEID_INVALID
specially and we are going to need fanotify_fh_equal() to return true
when comparing two null fids.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 1e4a345155dd..bdafc76cc258 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -282,8 +282,11 @@ static void fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	void *buf = fh->buf;
 	int err;
 
+	/* FAN_DIR_MODIFY does not encode object fh */
+	fh->type = FILEID_ROOT;
+	fh->len = 0;
 	if (!inode)
-		goto out;
+		return;
 
 	dwords = 0;
 	err = -ENOENT;
@@ -318,7 +321,6 @@ static void fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 			    type, bytes, err);
 	kfree(ext_buf);
 	*fanotify_fh_ext_buf_ptr(fh) = NULL;
-out:
 	/* Report the event without a file identifier on encode error */
 	fh->type = FILEID_INVALID;
 	fh->len = 0;
-- 
2.17.1

