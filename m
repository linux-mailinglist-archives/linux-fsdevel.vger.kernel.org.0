Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D5829AE09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 14:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900852AbgJ0Nza (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 09:55:30 -0400
Received: from casper.infradead.org ([90.155.50.34]:41550 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438386AbgJ0Nza (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RaIfHC7BLM4SW2hHIHWeJJ18AZKbmgeAZRKzDoH2DFk=; b=u3BI0eTHwiqt8yMwHim8BcwRqs
        wT0SyhzyBONY5MrN1aN/NK3iJctEBVEGEFbkfp/6LCLoKV/Q0Zw7vYHdM8I3q7s0iM3UTzuX+HrwX
        kzOjvWsf7KWwrO09ZUBl3C/HCyUiExt1ZCQl0gZ6GdAG71//8fdzZS/I31RnRXJSApavJ6v6tru1C
        VZ9n/BiVBkt2Y4so2ZttBOStebLJDz2uOZa0sqapoQGHONWmRYaBbL4n4/f1vunw2sdrJV5jkuLUe
        bIIFYXxDk2KlGDISrlhD9XZPq9/veawNUfY/2ZriN7BQR2+QooEA5T7zfumUS5+lLaRuSxQ4gGk3t
        8maXGEWA==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXPRe-00009V-3P; Tue, 27 Oct 2020 13:55:26 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat Linux))
        id 1kXPRd-002iLl-La; Tue, 27 Oct 2020 13:55:25 +0000
From:   David Woodhouse <dwmw2@infradead.org>
To:     bonzini@redhat.com
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] kvm/eventfd: Drain events from eventfd in irqfd_wakeup()
Date:   Tue, 27 Oct 2020 13:55:23 +0000
Message-Id: <20201027135523.646811-4-dwmw2@infradead.org>
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
 virt/kvm/eventfd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index d6408bb497dc..98b5cfa1d69f 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -193,6 +193,9 @@ irqfd_wakeup(wait_queue_entry_t *wait, unsigned mode, int sync, void *key)
 	int idx;
 
 	if (flags & EPOLLIN) {
+		u64 cnt;
+		eventfd_ctx_do_read(&irqfd->eventfd, &cnt);
+
 		idx = srcu_read_lock(&kvm->irq_srcu);
 		do {
 			seq = read_seqcount_begin(&irqfd->irq_entry_sc);
-- 
2.26.2

