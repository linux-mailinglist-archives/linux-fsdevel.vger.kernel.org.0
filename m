Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7183A9056
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 06:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhFPELo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 00:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhFPELo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 00:11:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C85C061574;
        Tue, 15 Jun 2021 21:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+hJYay8JR5Szrm3esdkGPPnSrjDyFQjXCxZ0d9ypRKM=; b=n0s17+QbCeywB7tT55kKef7453
        IRB44+PDdtgICy2G0YMcftFVm199pSyAdpJGLKekmgdDBZ6XuffMxQMX36hOLOXe28uAJsKKfDKko
        FgkgOoBPpT+eEqyG+epXsLvvuUqfdJL6RVTgTnRfMA2AIuN7I3jFsrqBQ2x/0gbyZD/CPxj1eKJxL
        ElbswIIRhKlBbbiBiG7O14d0EA2iO3poptdiTrI+Td/PVfTWXo8LEs20orcm9ZuI+/Fcdk16HSbDc
        KC3M91MxPVUHrVsFUE3HxZt9AdJ5Oad68ELIZPI7ZVTOuGQ1zl3x3qOXLlmEGjVVvc2qeqW5fFSBn
        II4beYog==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltMrV-007ZmS-MR; Wed, 16 Jun 2021 04:09:11 +0000
Date:   Wed, 16 Jun 2021 05:09:09 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
        jaegeuk@kernel.org, chao@kernel.org, ebiggers@google.com,
        drosen@google.com, ebiggers@kernel.org, yuchao0@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v8 4/4] fs: unicode: Add utf8 module and a unicode layer
Message-ID: <YMl5Zf1+Q7fop4Qj@infradead.org>
References: <20210427062907.GA1564326@infradead.org>
 <61d85255-d23e-7016-7fb5-7ab0a6b4b39f@collabora.com>
 <YIgkvjdrJPjeoJH7@mit.edu>
 <87bl9z937q.fsf@collabora.com>
 <YIlta1Saw7dEBpfs@mit.edu>
 <87mtti6xtf.fsf@collabora.com>
 <7caab939-2800-0cc2-7b65-345af3fce73d@collabora.com>
 <YJoJp1FnHxyQc9/2@infradead.org>
 <687283ac-77b9-9e9e-dac2-faaf928eb383@collabora.com>
 <87zgw7izf8.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgw7izf8.fsf@collabora.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 02, 2021 at 08:07:07PM -0400, Gabriel Krisman Bertazi wrote:
> I wasn't going to really oppose it from being a firmware but this
> detail, if required, makes the whole firmware idea more awkward.  If the
> whole reason to make it a firmware is to avoid the module boilerplate,
> this is just different boilerplate.  Once again, I don't know about
> precedent of kernel data as a module, and there is the problem with
> Makefile rules to install this stuff, that I mentioned.
> 
> We know we can get rid of the static call stuff already, since we likely
> won't support more encodings anyway, so that would simplify a lot the
> module specific code.

Well, another thing we can do is a data-only module.  That is a module
that just contains the tables, with the core code doing a symbol_get
on them.
