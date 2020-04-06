Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6916419FBC5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 19:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgDFRj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 13:39:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgDFRj7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ighi/oMVp9tFTOBbBxmTii0DJ49JmSpk0alZtgjwyEE=; b=A14JlXhDhbCpugXDKFmJjxkAR1
        3FxwFK0ASLf1JXMVK3NNyPLaPDT/3cSBQAbIvS9KC/HcKlUt0tR9PJd0dduozFawoDCEsaiog7woQ
        MVk6pjT8OFvdUKVaP5Pa0RUm0nQ9vgnr0R+2HwysLODLyNYep2w2v55KnJ7jUHnz311KCyPZ2wdv/
        xu5Dw5wZewwIBA3kerLLfXnC0y8tVljROTKczdG1OIHFpmgYzbJ4EE1Xh4gmfaIf8zVwsucwE4q7H
        GfUL7yOaJr/KNw0T91jZm7VyqfkznbFBJZXE3XaNyKpAE3YSBxo4B8J6XIoRH1txvvJOkCeN0IfvZ
        +DPzvOJg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLVj3-0006Ck-Jn; Mon, 06 Apr 2020 17:39:57 +0000
Date:   Mon, 6 Apr 2020 10:39:57 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Sergey Alirzaev <l29ah@cock.li>
Subject: Re: [GIT PULL] 9p update for 5.7
Message-ID: <20200406173957.GI21484@bombadil.infradead.org>
References: <20200406110702.GA13469@nautica>
 <CAHk-=whVEPEsKhU4w9y_sjbg=4yYHKDfgzrpFdy=-f9j+jTO3w@mail.gmail.com>
 <20200406164057.GA18312@nautica>
 <20200406164641.GF21484@bombadil.infradead.org>
 <CAHk-=wiAiGMH=bw5N1nOVWYkE9=Pcx+mxyMwjYfGEt+14hFOVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiAiGMH=bw5N1nOVWYkE9=Pcx+mxyMwjYfGEt+14hFOVQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 06, 2020 at 10:04:11AM -0700, Linus Torvalds wrote:
> On Mon, Apr 6, 2020 at 9:46 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > POSIX may well "allow" short reads, but userspace programmers basically
> > never check the return value from read().  Short reads aren't actually
> > allowed.  That's why signals are only allowed to interrupt syscalls if
> > they're fatal (and the application will never see the returned value
> > because it's already dead).
> 
> Well, that's true for some applications.
> 
> But look at anybody who ever worked more with NFS mounts, and they got
> used to having the 'intr' mount flag set and incomplete reads and
> -EAGAIN as a result.

That's why you had me implement TASK_KILLABLE ;-)

> Are there apps that react badly? I'm sure - but they also wouldn't
> have O_NONBLOCK set on a regular file. The only reason to set
> O_NONBLOCK is because you think the fd might be a pipe or something,
> and you _are_ ready to get partial reads.
> 
> So the 9p behavior certainly isn't outrageously out of line for a
> network filesystem. In fact, because of O_NONBLOCK rather than a mount
> option, I think it's a lot safer than a fairly standard NFS option.

The NFS option has been a no-op for over a decade ;-)  I agree with you
that O_NONBLOCK is a good indicator the application is willing to handle
short reads (or indeed writes).
