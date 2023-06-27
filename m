Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3303740384
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 20:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjF0SlP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 14:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF0SlO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:41:14 -0400
X-Greylist: delayed 150 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Jun 2023 11:41:11 PDT
Received: from resqmta-c1p-023463.sys.comcast.net (resqmta-c1p-023463.sys.comcast.net [IPv6:2001:558:fd00:56::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CF1E71
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 11:41:11 -0700 (PDT)
Received: from resomta-c1p-022590.sys.comcast.net ([96.102.18.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by resqmta-c1p-023463.sys.comcast.net with ESMTP
        id E995qt6uIQXqBEDaLq3deX; Tue, 27 Jun 2023 18:38:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1687891121;
        bh=94QU1Lz6O8jA238L1MaHwRkrP9WJSQCpit+sMNPmhDE=;
        h=Received:Received:From:To:Subject:Date:MIME-Version:Message-ID:
         Content-Type:Xfinity-Spam-Result;
        b=I0KrfkmkmYAq/gsFR1lev3lYy9HAAYPo0miZGCwxnCLSQfYjEKBtKM3bkUVonkucE
         9CZab5ENOS/u3kxuCkEJUEar7BygDxapFWFCVACdbdPsBw2FIARvE4A8E7ycislw0K
         jBtORqyO5pvBqSFpNgHRiuTINJjYwGk+ii2dgVEg/N5a6QBNVGoC4jJZVFC+H2AxZR
         qUQ/UlbDhXu1lzrQWTxNlOrOl5nIBddvGz8VzESTVCznGLtyLXAGzthb26TEhES/Nv
         MaT8u6+Vt4MH5ZoeEhPz4y6ephE2R4/t5Yl6R0okmWbUdD4aBXQ2rV69MzaMbMyUzN
         KlAyRJJxrJF8A==
Received: from localhost ([IPv6:2601:18c:9082:afd:219:d1ff:fe75:dc2f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by resomta-c1p-022590.sys.comcast.net with ESMTPSA
        id EDaDq9DN9890VEDaFqL7np; Tue, 27 Jun 2023 18:38:38 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Matt Whitlock <kernel@mattwhitlock.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        <linux-fsdevel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [Reproducer] Corruption, possible race between splice and =?iso-8859-1?Q?FALLOC=5FFL=5FPUNCH=5FHOLE?=
Date:   Tue, 27 Jun 2023 14:38:32 -0400
MIME-Version: 1.0
Message-ID: <992abc31-c052-435d-b9e4-a55dccb03a73@mattwhitlock.name>
In-Reply-To: <ZJq6nJBoX1m6Po9+@casper.infradead.org>
References: <ec804f26-fa76-4fbe-9b1c-8fbbd829b735@mattwhitlock.name>
 <ZJp4Df8MnU8F3XAt@dread.disaster.area>
 <ZJq6nJBoX1m6Po9+@casper.infradead.org>
User-Agent: Trojita/v0.7-595-g7738cd47; Qt/5.15.10; xcb; Linux; Gentoo Linux
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,MIME_QP_LONG_LINE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tuesday, 27 June 2023 06:31:56 EDT, Matthew Wilcox wrote:
> Perhaps the problem is that splice() appears to copy, but really just
> takes the reference.  Perhaps splice needs to actually copy if it
> sees a multi-page folio and isn't going to take all of it.  I'm not
> an expert in splice-ology, so let's cc some people who know more about
> splice than I do.

As a naive userspace coder, my mental model of splice is that it takes=20
references to the pages backing the input file/pipe and appends those=20
references to the output pipe's queue. Crucially, my expectation is that=20
the cloned pages are marked copy-on-write, such that if some other process=20=

subsequently modifies the pages, then those pages will be copied at the=20
time of modification (i.e., copy-on-write), and the references in the=20
spliced-into pipe buffer will still refer to the unmodified originals.

If splice is merely taking a reference without caring to implement=20
copy-on-write semantics, then it's not just FALLOC_FL_PUNCH_HOLE that will=20=

cause problems. Indeed, *any* write to the input file in the range where=20
pages were spliced into a pipe will impact the pages already in the pipe=20
buffer. I'm sure that makes perfect sense to a kernel developer, but it=20
violates the implied contract of splice, which is to act *as though* the=20
pages had been *copied* into the pipe.

Obviously, I'm not asking for splice to actually copy the pages, as=20
zero-copy semantics are a large part of the motivation for preferring=20
splice in the first place, but I do believe that the pages should be made=20
copy-on-write such that subsequent writes to those pages in the page cache,=20=

whether by write or mmap or fallocate or otherwise, will force a copy of=20
the pages to be made if the copy-on-write reference count of the modified=20
pages is non-zero. Note, I say, "copy-on-write reference count," as=20
distinct from the ordinary reference count, as you would need to properly=20
handle the case where there are multiple *shared* references to a page that=20=

*should* observe any changes made to it, while there may also be multiple=20
*private* references to the page that *must not* observe any changes made=20
to it.

Just a thought: if you're going to implement bi-level reference counting=20
semantics, then you could make MMAP_PRIVATE actually take a snapshot of the=20=

mapped pages at the time of mapping. Currently, mmap(2) says, "It is=20
unspecified whether changes made to the file after the mmap() call are=20
visible in the mapped region," so you have the latitude to make the private=20=

mapping truly isolated from subsequent changes in the backing file, using=20
the same plumbing as you could use to isolate spliced pages.
