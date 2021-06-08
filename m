Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECAC39EE17
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 07:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhFHF15 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 01:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhFHF14 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 01:27:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D27AC061574;
        Mon,  7 Jun 2021 22:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qYIZGAIz3HgfqAZWN050/r4nlncXneSeHvNxj3vdJTQ=; b=Lct2bmMY1MUo8xT53kwRmcMl5S
        zvTOsNipToRMW9uhAXEtD2lBpUUSrntGZMigN9/ic0m/GBk/KVJYZpYwVOb+haJfXDXFGP/zvOcWR
        oesx/tsgYmHrAnitLCESh0OpZZr7ME1O2Gc63oQCVtxZs1YxuSpVlJ/AwrHU9O/haD84U0E18BBUd
        alRq5A/NeVqy2udBPifo++5LtpzIu2aCE0TYSX0HmKSq3jsCTpKKvMeKvOUkdd+3Na23zGO3PTsdD
        c55AexPIiZ+lTAWSTjUyifdlCtmQczUSTP7uJX/UbbowmXV2A+OGf457J8AN4r1bfAXdmqEQAiE08
        Q5TYu6lA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lqUEs-00Gann-2j; Tue, 08 Jun 2021 05:25:26 +0000
Date:   Tue, 8 Jun 2021 06:25:22 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [RFC][PATCHSET] iov_iter work
Message-ID: <YL7/Qv/CBvXIUlKT@infradead.org>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
 <CAHk-=wj6ZiTgqbeCPtzP+5tgHjur6Amag66YWub_2DkGpP9h-Q@mail.gmail.com>
 <CAHk-=wiYPhhieXHBtBku4kZWHfLUTU7VZN9_zg0LTxcYH+0VRQ@mail.gmail.com>
 <YL3mxdEc7uw4rhjn@infradead.org>
 <YL4wnMbSmy3507fk@zeniv-ca.linux.org.uk>
 <YL5CTiR94f5DYPFK@infradead.org>
 <YL6KdoHzYiBOsu5t@zeniv-ca.linux.org.uk>
 <CAHk-=wgr3o6cKTNpU9wg7fj_+OUh5kFwrD29Lg0n2=-1nhvoZA@mail.gmail.com>
 <CAHk-=wjxkH79DcqVrZbETWERxLFU4xoPSzXkJOxfkxYKbjUaiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjxkH79DcqVrZbETWERxLFU4xoPSzXkJOxfkxYKbjUaiw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 07, 2021 at 04:35:46PM -0700, Linus Torvalds wrote:
> Thinking more about this thing, I think it means that what we *should*
> do is simply just
> 
>   void iov_iter_init(struct iov_iter *i, unsigned int direction,
>                         const struct iovec *iov, unsigned long nr_segs,
>                         size_t count)
>   {
>         WARN_ON_ONCE(direction & ~(READ | WRITE));
>         iWARN_ON_ONCE(uaccess_kernel());

Yes, exactly! (except for the spurious i above, of course).
