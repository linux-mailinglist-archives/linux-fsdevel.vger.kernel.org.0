Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D4529AE10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 14:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368017AbgJ0Nzk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 09:55:40 -0400
Received: from casper.infradead.org ([90.155.50.34]:41596 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S367999AbgJ0Nzf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BqdW9CfmpKED8RdaKfg/p1LH4cUJNyLSfMPsnBACzrg=; b=ayd+EFaOHDonl9ijp5DaxXfLjC
        x5kSIVTA/AhbaI2jdhSvjseIlT2jMGyjSl9VDVpGyxazEiwMWFBWjpQ2DWPxBkWJf794aDW0r8hNm
        oGX6fACSuT5VYCB9PBMhZx524z7IHNwWf/6N5o6hWj3FqjbSFdLVJYRbbG/VQP8TrDKRUQeA/g269
        bd/nFkfqgGinbOqFca8N44SSwEDtRnCbyDldS7UkGYzWPQ+80cSoYIkbRDZcHoCi5q52QXs1Q7haG
        dRfdzIrrb/si5v/x5aPGwlWuFAklphNrI1/grS7BHw43WIhlBvl4vJBlEWxr4iGrc/H7won8SFPs6
        zHqDKCbw==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXPRe-00009U-2F; Tue, 27 Oct 2020 13:55:26 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat Linux))
        id 1kXPRd-002iLg-Ku; Tue, 27 Oct 2020 13:55:25 +0000
From:   David Woodhouse <dwmw2@infradead.org>
To:     bonzini@redhat.com
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] vfio/virqfd: Drain events from eventfd in virqfd_wakeup()
Date:   Tue, 27 Oct 2020 13:55:22 +0000
Message-Id: <20201027135523.646811-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027135523.646811-1-dwmw2@infradead.org>
References: <1faa5405-3640-f4ad-5cd9-89a9e5e834e9@redhat.com>
 <20201027135523.646811-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

Don't allow the events to accumulate in the eventfd counter, drain them
as they are handled.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 drivers/vfio/virqfd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vfio/virqfd.c b/drivers/vfio/virqfd.c
index 997cb5d0a657..414e98d82b02 100644
--- a/drivers/vfio/virqfd.c
+++ b/drivers/vfio/virqfd.c
@@ -46,6 +46,9 @@ static int virqfd_wakeup(wait_queue_entry_t *wait, unsigned mode, int sync, void
 	__poll_t flags = key_to_poll(key);
 
 	if (flags & EPOLLIN) {
+		u64 cnt;
+		eventfd_ctx_do_read(virqfd->eventfd, &cnt);
+
 		/* An event has been signaled, call function */
 		if ((!virqfd->handler ||
 		     virqfd->handler(virqfd->opaque, virqfd->data)) &&
-- 
2.26.2

