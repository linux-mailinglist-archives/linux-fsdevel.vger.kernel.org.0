Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86ECC9674B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 19:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfHTRR0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 13:17:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54588 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729852AbfHTRR0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oHwVFXFTd/4J3FUGeiOCXpDuyqqKxUu9Uqvxt0jCufw=; b=Gml1tOhZGhEvUuyIfqUo3p3+e
        saftgBze6Guzy9ncyc4b+AB/n7VrfDXKku9z2zRtgEdRVIhRbxeIRxIittvFu8wOk/9TBrQvfi93g
        nhbfy25U75aW0qZjIMywMpc2dX675S2ScjoLdBF7qkLTi8uOpuhZy+Vk6ryvWOFR/MryUCGhmOPJ5
        q6/jfAbdrwXlFNEc3TMptLDkMsEMwyDkDOsALHFKkksAfKjVQDqEXwhnw0ts++VLjHXlpEwCtzBR6
        ry2fUWXdPD4/jOuMPJ4ifPilscj3I+4NIuFK3IF6NCxZ+BJ1UZeTj5VgVpM0oSqXTa9rbS+6V3Dcf
        Ohr12cOCA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i07l3-0001ii-DJ; Tue, 20 Aug 2019 17:17:21 +0000
Date:   Tue, 20 Aug 2019 10:17:21 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Sebastian Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joel Becker <jlbec@evilplan.org>
Subject: Re: [PATCH] fs/buffer: Make BH_Uptodate_Lock bit_spin_lock a regular
 spinlock_t
Message-ID: <20190820171721.GA4949@bombadil.infradead.org>
References: <20190820170818.oldsdoumzashhcgh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820170818.oldsdoumzashhcgh@linutronix.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 20, 2019 at 07:08:18PM +0200, Sebastian Siewior wrote:
> Bit spinlocks are problematic if PREEMPT_RT is enabled, because they
> disable preemption, which is undesired for latency reasons and breaks when
> regular spinlocks are taken within the bit_spinlock locked region because
> regular spinlocks are converted to 'sleeping spinlocks' on RT. So RT
> replaces the bit spinlocks with regular spinlocks to avoid this problem.
> Bit spinlocks are also not covered by lock debugging, e.g. lockdep.
> 
> Substitute the BH_Uptodate_Lock bit spinlock with a regular spinlock.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [bigeasy: remove the wrapper and use always spinlock_t]

Uhh ... always grow the buffer_head, even for non-PREEMPT_RT?  Why?

