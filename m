Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28EE378108
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2019 21:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfG1TT3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Jul 2019 15:19:29 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:37163 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfG1TT2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Jul 2019 15:19:28 -0400
Received: by mail-io1-f50.google.com with SMTP id q22so5741359iog.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jul 2019 12:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CxXi1gGsI1ogOoMQUEQarvFA0NFQX+Sndydm64MaxuM=;
        b=X0v0dAhRdiAwtjL9qbpc30qf/af1cChojG14950jCegSEWJLYjFHbkzwW7mFGWOgha
         CF5+Wie8PV1iohmaOd+yiOArRCIrrAJ206qm0IvIKzD1Z9965Dr1eqUW+bK8MGAqbj2+
         lZgO1nVHkM20H7lM9ZvFu5uSK9ae2zXfO/E9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CxXi1gGsI1ogOoMQUEQarvFA0NFQX+Sndydm64MaxuM=;
        b=fSFDiU7XbuI8mavO740Jixl8nAjQcF6XKHY47UsNFRL/kVCVjhVeSwcXyLKzsyX4IW
         Udzou8gpu70Pbl9lNyKgmulXFxkfwZJna+PzZ6LZov+jqA2uB5fkewiYWIon+kJH8aAD
         9Jxu5B1C7J4pE8bqG+I4nd/FCcbtEu9pSgK/rb21FBCTsyk56p9Jw+K6wJyUcadiz5mv
         FMglvpJO1vfdcZ+N1d978Vd6+T3S6noYfMkXsxD7zcP/hUMVuIrjrBorHxsgxRNfJAJy
         ouAambAhqIGbzJpZNuoWf6y5KHWI88Xj2xf9xx6yQCc9vtpI3MpDNaZE/VtIw8wLpcAE
         2O9A==
X-Gm-Message-State: APjAAAXI+7jUmMBunWWD8p5eULuYOhDdIiZ9j6Vo8ufDMrCB7beZZO1M
        1iUmwU5qnvKJdZ6hJvQ2MiNpyg==
X-Google-Smtp-Source: APXvYqzV3WAWM4GYL2Pt+2FnH9ArFneYwzPusoPmHXlF60eUekoYCHhQiQKwqoTMS0hvpsChN+IkQA==
X-Received: by 2002:a5d:9c46:: with SMTP id 6mr40067114iof.6.1564341568028;
        Sun, 28 Jul 2019 12:19:28 -0700 (PDT)
Received: from teton.8.8.8.8 ([50.73.98.161])
        by smtp.googlemail.com with ESMTPSA id q13sm52974886ioh.36.2019.07.28.12.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jul 2019 12:19:27 -0700 (PDT)
From:   Steve Magnani <steve.magnani@digidescorp.com>
X-Google-Original-From: Steve Magnani <steve@digidescorp.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Steve Magnani <steve@digidescorp.com>
Subject: [PATCH] udf: prevent allocation beyond UDF partition
Date:   Sun, 28 Jul 2019 14:19:12 -0500
Message-Id: <1564341552-129750-1-git-send-email-steve@digidescorp.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The UDF bitmap allocation code assumes that a recorded 
Unallocated Space Bitmap is compliant with ECMA-167 4/13,
which requires that pad bytes between the end of the bitmap 
and the end of a logical block are all zero.

When a recorded bitmap does not comply with this requirement,
for example one padded with FF to the block boundary instead
of 00, the allocator may "allocate" blocks that are outside
the UDF partition extent. This can result in UDF volume descriptors
being overwritten by file data or by partition-level descriptors,
and in extreme cases, even in scribbling on a subsequent disk partition.

Add a check that the block selected by the allocator actually
resides within the UDF partition extent.

Signed-off-by: Steven J. Magnani <steve@digidescorp.com>

--- a/fs/udf/balloc.c	2019-07-26 11:35:28.249563705 -0500
+++ b/fs/udf/balloc.c	2019-07-28 13:11:25.061431597 -0500
@@ -325,6 +325,13 @@ got_block:
 	newblock = bit + (block_group << (sb->s_blocksize_bits + 3)) -
 		(sizeof(struct spaceBitmapDesc) << 3);
 
+	if (newblock >= sbi->s_partmaps[partition].s_partition_len) {
+		/* Ran off the end of the bitmap,
+		 * and bits following are non-compliant (not all zero)
+		 */
+		goto error_return;
+	}
+
 	if (!udf_clear_bit(bit, bh->b_data)) {
 		udf_debug("bit already cleared for block %d\n", bit);
 		goto repeat;
