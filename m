Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A55C74174C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 19:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjF1RhC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 13:37:02 -0400
Received: from resqmta-a1p-077723.sys.comcast.net ([96.103.146.57]:57259 "EHLO
        resqmta-a1p-077723.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231142AbjF1RhA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:37:00 -0400
Received: from resomta-a1p-077059.sys.comcast.net ([96.103.145.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by resqmta-a1p-077723.sys.comcast.net with ESMTP
        id EW6OqczzO8VViEZ5Aq7529; Wed, 28 Jun 2023 17:35:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1687973756;
        bh=s096MvujZjpOa9UyFJzRpfx/VZM1M4KtcrFaPgfqFpA=;
        h=Received:Received:From:To:Subject:Date:MIME-Version:Message-ID:
         Content-Type:Xfinity-Spam-Result;
        b=NDFuzWZxJfsiMtvQ/98XTseRdNSzQpbp9rxvvDK2bXRZ5drrTeVGTN8yJSQCMfOoa
         AtIEUcOhtpPCHaw5bYpVaWQhg1el6Nn9FwDgHlW4PffStCY5zWCWK6Qgx6mMSIWtxq
         2stBBwWngW0jCKTPmHq0PGBsZU9/eJVxPGllFzgSJWU/BCZi9HZaMJPnT1M/XxsQti
         jwdqxGiliUaTOWl7MOD/pH7Oa2XWmNe/yisMunBQ50d9u4jQqxWtcDKKjucCgipfm7
         wyUp/BJzXpxEd066pzD5LXIGcw2oZ3nBHLHCF6mkkbiyfUFeCntUYVY2aW4o+djDpC
         lTeUpc3tXhYow==
Received: from localhost ([IPv6:2601:18c:9082:afd:219:d1ff:fe75:dc2f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by resomta-a1p-077059.sys.comcast.net with ESMTPSA
        id EZ4iqF7Y1FQYAEZ4jq75Mm; Wed, 28 Jun 2023 17:35:32 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Matt Whitlock <kernel@mattwhitlock.name>
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        <linux-fsdevel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [Reproducer] Corruption, possible race between splice and =?iso-8859-1?Q?FALLOC=5FFL=5FPUNCH=5FHOLE?=
Date:   Wed, 28 Jun 2023 13:35:27 -0400
MIME-Version: 1.0
Message-ID: <a60594ef-ff85-498f-a1c4-0fcb9586621c@mattwhitlock.name>
In-Reply-To: <3299543.1687933850@warthog.procyon.org.uk>
References: <ZJq6nJBoX1m6Po9+@casper.infradead.org>
 <ec804f26-fa76-4fbe-9b1c-8fbbd829b735@mattwhitlock.name>
 <ZJp4Df8MnU8F3XAt@dread.disaster.area>
 <3299543.1687933850@warthog.procyon.org.uk>
User-Agent: Trojita/v0.7-595-g7738cd47; Qt/5.15.10; xcb; Linux; Gentoo Linux
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wednesday, 28 June 2023 02:30:50 EDT, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
>
>>>> Expected behavior:
>>>> Punching holes in a file after splicing pages out of that=20
>>>> file into a pipe
>>>> should not corrupt the spliced-out pages in the pipe buffer.
>
> I think this bit is the key.  Why would this be the expected behaviour?

Why? Because SPLICE_F_MOVE exists. Even though that flag is a no-op as of=20
Linux 2.6.21, its existence implies that calling splice() *without*=20
specifying SPLICE_F_MOVE performs a *copy*. The kernel is, of course, free=20=

*not* to copy pages in pursuit of better performance, but it must behave as=20=

though it did copy unless SPLICE_F_MOVE is specified, in which case=20
userspace is explicitly acknowledging that subsequent modification of the=20
spliced pages may impact the spliced data. Effectively, SPLICE_F_MOVE is a=20=

promise by userspace that the moved pages will not be subsequently=20
modified, and if they are, then all bets are off.

In other words, the currently implemented behavior is appropriate for=20
SPLICE_F_MOVE, but it is not appropriate for ~SPLICE_F_MOVE.
