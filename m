Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365D629C1D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 18:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901270AbgJ0Ow0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 10:52:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37132 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1772926AbgJ0Oug (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:50:36 -0400
X-Greylist: delayed 3303 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Oct 2020 10:50:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zDE5jb9uxhVI9C4jlM6oDJI3APbjGF+q9+SWA/XVKeI=; b=2KemxEIJQODswF6tNzklkYfkjJ
        QQsUcrSXbVfL0tK+ihfcobzBVTVFg606C1qriUbY54A5Q5dcls5dJITJEyA944Ri74Bpwe4vdnFnH
        uImLAucbMEk9s5iV3n0WWOYFGZGDdevASSJOT7J+a70EK1RrlNjFfRLHwPfdRCvFwV6PCymq1cYze
        nCLYaH3laExlXMK7uO/adSWD8Zc9hJz6LKkSn545yYoGZR9hTCzzlM+3w7pULZs6/4Bu0GwggmBE+
        eVY2cqNAukipGfhJl04U/JvR2waVkO5t1pGdhVEOnCTywhcT8GLQf3xVnbbsyE4EAfLD+/LDv41ul
        rD4wBrgQ==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXPRe-00005c-KS; Tue, 27 Oct 2020 13:55:26 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat Linux))
        id 1kXPRd-002iLY-JP; Tue, 27 Oct 2020 13:55:25 +0000
From:   David Woodhouse <dwmw2@infradead.org>
To:     bonzini@redhat.com
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/3] Allow in-kernel consumers to drain events from eventfd
Date:   Tue, 27 Oct 2020 13:55:20 +0000
Message-Id: <20201027135523.646811-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <1faa5405-3640-f4ad-5cd9-89a9e5e834e9@redhat.com>
References: <1faa5405-3640-f4ad-5cd9-89a9e5e834e9@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by merlin.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Paolo pointed out that the KVM eventfd doesn't drain the events from the
irqfd as it handles them, and just lets them accumulate. This is also
true for the VFIO virqfd used for handling acks for level-triggered IRQs.

Export eventfd_ctx_do_read() and make the wakeup functions call it as they
handle their respective events.

David Woodhouse (3):
      eventfd: Export eventfd_ctx_do_read()
      vfio/virqfd: Drain events from eventfd in virqfd_wakeup()
      kvm/eventfd: Drain events from eventfd in irqfd_wakeup()

 drivers/vfio/virqfd.c   | 3 +++
 fs/eventfd.c            | 5 ++++-
 include/linux/eventfd.h | 6 ++++++
 virt/kvm/eventfd.c      | 3 +++
 4 files changed, 16 insertions(+), 1 deletion(-)


