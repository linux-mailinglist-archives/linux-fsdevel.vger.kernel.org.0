Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A600153188
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 14:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgBENPx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 08:15:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55826 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727868AbgBENPx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580908552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=g8TxjMjdDgDCUyu7/G3TWJNbh6bnJjiPtkFZUOj4jDI=;
        b=VtpalEdUXxb9774UrsUo4vHSc2L2hhWYcltmhI+hsyKmKiICoXcEzM9yEGzUTxuzEMT1p3
        vka337guvQky/w/eiHfI4IdKV6xLyZ7GEz3Db2aGO2EKmNNYVda80124nSxJJV3NxCPDwL
        6I+U2wUGRctZyTqU06VCmDelDL6T1J4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214--lSpBqgnOMmZ-wBempVB6g-1; Wed, 05 Feb 2020 08:15:48 -0500
X-MC-Unique: -lSpBqgnOMmZ-wBempVB6g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B25901137841;
        Wed,  5 Feb 2020 13:15:47 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68516790C1;
        Wed,  5 Feb 2020 13:15:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 04F3A2202E9; Wed,  5 Feb 2020 08:15:46 -0500 (EST)
Date:   Wed, 5 Feb 2020 08:15:46 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] fuse: Support RENAME_WHITEOUT flag
Message-ID: <20200205131546.GA14544@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow fuse to pass RENAME_WHITEOUT to fuse server. Overlayfs on top of
virtiofs uses RENAME_WHITEOUT.

Without this patch renaming a directory in overlayfs (dir is on lower) fails
with -EINVAL. With this patch it works.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/dir.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: rhvgoyal-linux-fuse/fs/fuse/dir.c
===================================================================
--- rhvgoyal-linux-fuse.orig/fs/fuse/dir.c	2020-01-02 12:52:13.706585709 -0500
+++ rhvgoyal-linux-fuse/fs/fuse/dir.c	2020-02-05 08:03:32.953158410 -0500
@@ -818,7 +818,7 @@ static int fuse_rename2(struct inode *ol
 	struct fuse_conn *fc = get_fuse_conn(olddir);
 	int err;
 
-	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE))
+	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
 		return -EINVAL;
 
 	if (flags) {

