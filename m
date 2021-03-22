Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96449344697
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 15:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhCVOFY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 10:05:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33785 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229728AbhCVOFL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616421910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=QPkSFGAEFwyxkIsg8U3iEYvQY5nY02tfAo9JoeH500U=;
        b=by2PYNeIThLlhcBBIBgso7RVuA0oT2sbTfsrbejt15LOK5/V16bAdE4ikqmK5GnaiKaTzm
        QA794U5dYmmKy1CJqAhx6ARo2U4dEQ38i4AVBrtCVOniVPIcjawqmBCtLNY0rt4hv+VwiU
        /kSTSVjxxG+LhazBBkW0Kjs6pB23AYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-q7E0KdvfM_C12LWdMVHd9w-1; Mon, 22 Mar 2021 10:05:08 -0400
X-MC-Unique: q7E0KdvfM_C12LWdMVHd9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F147887A826;
        Mon, 22 Mar 2021 14:05:06 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A88CB5B6A8;
        Mon, 22 Mar 2021 14:05:06 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 12ME56RX020189;
        Mon, 22 Mar 2021 10:05:06 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 12ME556x020185;
        Mon, 22 Mar 2021 10:05:05 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 22 Mar 2021 10:05:05 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>
cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH] buffer: a small optimization in grow_buffers
Message-ID: <alpine.LRH.2.02.2103221002360.19948@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch replaces a loop with a "tzcnt" instruction.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c
+++ linux-2.6/fs/buffer.c
@@ -1020,11 +1020,7 @@ grow_buffers(struct block_device *bdev,
 	pgoff_t index;
 	int sizebits;
 
-	sizebits = -1;
-	do {
-		sizebits++;
-	} while ((size << sizebits) < PAGE_SIZE);
-
+	sizebits = PAGE_SHIFT - __ffs(size);
 	index = block >> sizebits;
 
 	/*

