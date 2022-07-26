Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC1F5809B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 05:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiGZDAs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jul 2022 23:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiGZDAq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jul 2022 23:00:46 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D1910575
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jul 2022 20:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zXfEeqIuexX/x4TQcULmyi+0wLIkqBHjopdfnljs7QQ=; b=RAXCP4sHky9VEvJxfQXbZJiZgt
        wd2MOu3SXrEEjZ5thj8YSUKQZoh2c4HGBwkpkbutlXvVA7ZtIAtSLFBpHUNXGIKOdwCpaFxL2M+rX
        /qDlD56KufkVSRydn+FyldSWEJPuaAVCk7SecTuILLVTBfcbZ0hk0NMsv1fxwIVKfvaZGi+FyIXLK
        0pt+evQVjcxu+uBsC15d0WKgeCm2P6dko84SWEdShlg9AEnRxpyxvJUXRXdHNazL5v5B7dqZsGEMv
        6fbASi9qPm8gf4dvaESO1YMt4cxiVtKfKbieVjKgzMibaAhAsuky3XppbQoQP1vh0sNwrontFYg7u
        bFH0yFXQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oGAoK-00Fpm4-2f;
        Tue, 26 Jul 2022 03:00:40 +0000
Date:   Tue, 26 Jul 2022 04:00:40 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/4] fs/dcache: Use __d_lookup_unhash() in __d_add/move()
Message-ID: <Yt9Y2JhqVHOP0vRT@ZenIV>
References: <20220613140712.77932-1-bigeasy@linutronix.de>
 <20220613140712.77932-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613140712.77932-4-bigeasy@linutronix.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 13, 2022 at 04:07:11PM +0200, Sebastian Andrzej Siewior wrote:
> __d_add() and __d_move() invoke __d_lookup_done() from within a preemption
> disabled region. This violates the PREEMPT_RT constraints as the wake up
> acquires wait_queue_head::lock which is a "sleeping" spinlock on RT.
> 
> As a preparation for solving this completely, invoke __d_lookup_unhash()
> from __d_add/move() and handle the wakeup there.
> 
> This allows to move the spin_lock/unlock(dentry::lock) pair into
> __d_lookup_done() which debloats the d_lookup_done() inline.

It also changes calling conventions for a helper that is, unfortunately,
exported.  Sure, nobody outside of fs/dcache.c and d_lookup_done() is
supposed to be using it.  But... export is export.

Rename that sucker, please - at least that way whoever's playing with
it will get a build breakage.
