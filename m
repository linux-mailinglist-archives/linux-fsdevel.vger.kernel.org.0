Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350611FCC41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 13:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgFQL1X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 07:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFQL1V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:27:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E399C061573;
        Wed, 17 Jun 2020 04:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EQDwNwkQqqmAjMVg8OwDjHllQ9nxS6lVeKEDqW17zmo=; b=p7IaWiaav60yVbFtaSc1bjCUwH
        mFA9gM3zQFp2w+up707C7CKlNH3o8i6oo63lzENXh3EevGk9qVi51tzbdEHic7i7U8v4iRqhtmfy2
        9IFrFesEIcCHLXBwWEW447ni/L2O7ZCF8Kl4xSrnuccWCZ10grBSkANEjSLDl1JEjVVI/pA8yNGui
        UnhuAC4FVr7Q1JojsqU5G0gMs0e/gX2+QO2UlgqUqp0yZXSqljpKz/mDl5pzEjLcnvFtMwFXdJC1h
        ekKChpDUAfQ9qfwyOmhLZyZlXo6CvO10Igh8zVt5FdQBkz0Dw1mJbrCW9EZT8gUuJ/J1CAXXZX1Cm
        uXT2opkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlWDw-0003Ue-Pa; Wed, 17 Jun 2020 11:27:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44B9430604B;
        Wed, 17 Jun 2020 13:27:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35A80203EE204; Wed, 17 Jun 2020 13:27:19 +0200 (CEST)
Date:   Wed, 17 Jun 2020 13:27:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] fs/namespace.c: use spinlock instead of busy loop
Message-ID: <20200617112719.GI2531@hirez.programming.kicks-ass.net>
References: <20200617104058.14902-1-john.ogness@linutronix.de>
 <20200617104058.14902-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617104058.14902-2-john.ogness@linutronix.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 17, 2020 at 12:46:58PM +0206, John Ogness wrote:
> The MNT_WRITE_HOLD flag is used to manually implement a per-cpu
> optimized rwsem using busy waiting. This implementation is a problem
> on PREEMPT_RT because write_seqlock() on @mount_lock (i.e. taking a
> spinlock) does not disable preemption. This allows a writer to
> preempt a task that has set MNT_WRITE_HOLD and thus that writer will
> live lock in __mnt_want_write() due to busy looping with preemption
> disabled.
> 

Why can't you use a regular percpu-rwsem for this?
