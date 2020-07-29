Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423AB232677
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 22:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgG2Uuu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 16:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2Uuu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:50:50 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB0DC061794;
        Wed, 29 Jul 2020 13:50:50 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0t24-005CZh-9W; Wed, 29 Jul 2020 20:50:36 +0000
Date:   Wed, 29 Jul 2020 21:50:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/23] fs: don't change the address limit for
 ->write_iter in __kernel_write
Message-ID: <20200729205036.GA1236929@ZenIV.linux.org.uk>
References: <20200707174801.4162712-1-hch@lst.de>
 <20200707174801.4162712-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707174801.4162712-9-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 07, 2020 at 07:47:46PM +0200, Christoph Hellwig wrote:
> If we write to a file that implements ->write_iter there is no need
> to change the address limit if we send a kvec down.  Implement that
> case, and prefer it over using plain ->write with a changed address
> limit if available.

	You are flipping the priorities of ->write and ->write_iter
for kernel_write().  Now, there are 4 instances of file_operations
where we have both.  null_fops and zero_fops are fine either way -
->write() and ->write_iter() do the same thing there (and arguably
removing ->write might be the right thing; the only reason I hesistate
is that writing to /dev/null *is* critical for many things, including
the proper mail delivery ;-)

However, the other two (infinibarf and pcm) are different; there we
really have different semantics.  I don't believe anything writes into
either under KERNEL_DS, but having kernel_write() and vfs_write() with
subtly different semantics is asking for trouble down the road.

How about we remove ->write in null_fops/zero_fops and fail loudly if
*both* ->write() and ->write_iter() are present (in kernel_write(),
that is)?

There's a similar situation on the read side - there we have /dev/null
with both ->read() and ->read_iter() (and there "remove ->read" is
obviously the right thing to do) *and* we have pcm crap, with different
semantics for ->read() and ->read_iter().
