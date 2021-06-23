Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADA93B1974
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 13:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhFWMA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 08:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhFWMA6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:00:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED8CC061574;
        Wed, 23 Jun 2021 04:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=if+5vcxnYg39PHn7QTmtFHoajkkKrnrnAav0TjgSnZ4=; b=svVwbyrReSA0bEdCFvAQL0nRR6
        pd6rdU+J/z/Uh7KtI6XWF1ddX4S6fLjMN7Ru1DAXN7TxPiqkBI6iJXlTKRC7i9Q0dG5Q1dRIqm0xJ
        LQ6zjTzMlqnPtrU99PboitgP3+uHj+mBV3EuT0OaU+JZtX5RQ4nYXI+OvgwRRJ65Rzn8aPH4n7Vib
        DaoFcSDaxmxLSFRhBD/L7bCK+CadMc7hL7T4zLFHNvI2R26zNrnzLsVyTfAEX6//KSbZ81KmCOPey
        +gJJZpDjgOvNbPHrZ5O1J5lC6I2Du2zRvDe33C6lDrZvo7m0Ahc1MlYNrFoGJN0IWDvrrZpByPx5+
        QUIeC9nQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw1Vw-00FO5h-Jw; Wed, 23 Jun 2021 11:58:01 +0000
Date:   Wed, 23 Jun 2021 12:57:52 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier Gonz??lez <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v3 6/6] loop: increment sequence number
Message-ID: <YNMhwLMr7DiNdqC/@infradead.org>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
 <20210623105858.6978-7-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623105858.6978-7-mcroce@linux.microsoft.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 12:58:58PM +0200, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> On a very loaded system, if there are many events queued up from multiple
> attach/detach cycles, it's impossible to match them up with the
> LOOP_CONFIGURE or LOOP_SET_FD call, since we don't know where the position
> of our own association in the queue is[1].
> Not even an empty uevent queue is a reliable indication that we already
> received the uevent we were waiting for, since with multi-partition block
> devices each partition's event is queued asynchronously and might be
> delivered later.
> 
> Increment the disk sequence number when setting or changing the backing
> file, so the userspace knows which backing file generated the event:

Instead of manually incrementing the sequence here, can we make loop
generate the DISK_EVENT_MEDIA_CHANGE event on a backing device (aka
media) change?
