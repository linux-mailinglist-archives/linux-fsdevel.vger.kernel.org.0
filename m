Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD8FB13B251
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 19:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgANSrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 13:47:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55594 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgANSrL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:47:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4Puk4Pgh+JhY8rl1OTT+GzFNEp0YuWY6wSf3flBS7Ow=; b=OVJUbcVFDftKB5Eo3F2KjOn/c
        eTVxMFe3bAKYYiMsJZC4Yu+o8V1cEc3oTyou++4dL3yqQzkTr0fqY3uCgydpp0xhnS34GDKpYPPdB
        J2TZMMYEWcn1XQR2Xjrn/UeOPjrNVLlBokSa22SxrQPQGeWNXW8bgiueP94uPIwXcBtn2mlfl4zvU
        psdND3rkQqFxgSup4Uphqkehw+zeDMkzfpEJytWJSSPwy5ehu26ZS06+63HhzlDc29Y+1NAjkd5jC
        BG+XXj4w257y2aYtcuSsXEQ3VYr2FTHDQ/5BwAVvthAg0HM+L0ryMcn36U3a37N2tHlEFX6ObooKf
        Bw4p2nuKA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irRDX-0006t8-Mm; Tue, 14 Jan 2020 18:47:07 +0000
Date:   Tue, 14 Jan 2020 10:47:07 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: RFC: hold i_rwsem until aio completes
Message-ID: <20200114184707.GA10467@bombadil.infradead.org>
References: <20200114161225.309792-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114161225.309792-1-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 05:12:13PM +0100, Christoph Hellwig wrote:
> Second I/O
> completions often come from interrupt context, which means the re-acquire
> is recorded as from irq context, leading to warnings about incorrect
> contexts.  I wonder if we could just have a bit in lockdep that says
> returning to userspace is ok for this particular lock?  That would also
> clean up the fsfreeze situation a lot.

It would be helpful if we could also use the same lockdep logic
for PageLocked.  Again, it's a case where returning to userspace with
PageLock held is fine, because we're expecting an interrupt to come in
and drop the lock for us.

Perhaps the right answer is, from lockdep's point of view, to mark the
lock as being released at the point where we submit the I/O.  Then
in the completion path release the lock without telling lockdep we
released it.

That would catch cases where we inadvertently returned to userspace
without submitting the I/O, for example.
