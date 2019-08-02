Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 582097EE21
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 09:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390550AbfHBH4T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 03:56:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390522AbfHBH4T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 03:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=F/U4RF9BWHk0NEnwlESdSBl0fNvIrEH3x91nEkfBj0s=; b=AroLgI03kPrunxjAUUNLPYV1H3
        TY2FcCliV84FPetqGsDrGQIB1YHeGEtq136f9fHRgArJ1FZB3u6MuN1yZp9ss2fNLJgleH4V+G6w6
        h2N3lXQJ5Zjc2kZ7cInHAA4AXzk+GbX4y6qd9hMLl9NVYJ+hJygShEumgsQZ3rQrGiolVnClyvdTe
        eEsZwhFKQQ1aJgb8rPmz+kKfko+6kIJKf8u47ByPJh9hwk7PkAn72aLooNLKhm6pnJk/16lxyl/xR
        QEszcatR8lr7FGMsFu32CkCbOEKQ1OuJdTpMXcxM9ibcjNxuHzCy1JlMsZubGrSR8aHsjqENeCTjT
        UcsThg4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1htSQ8-0006iu-RB; Fri, 02 Aug 2019 07:56:12 +0000
Date:   Fri, 2 Aug 2019 00:56:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Joel Becker <jlbec@evilplan.org>
Subject: Re: [patch V2 0/7] fs: Substitute bit-spinlocks for PREEMPT_RT and
 debugging
Message-ID: <20190802075612.GA20962@infradead.org>
References: <20190801010126.245731659@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190801010126.245731659@linutronix.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Thomas,

did you look into killing bіt spinlocks as a public API instead?

The main users seems to be buffer heads, which are so bloated that
an extra spinlock doesn't really matter anyway.

The list_bl and rhashtable uses kinda make sense to be, but they are
pretty nicely abstracted away anyway.  The remaining users look
pretty questionable to start with.
