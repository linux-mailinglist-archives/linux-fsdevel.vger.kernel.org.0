Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17730558A1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 22:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiFWUcR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 16:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiFWUcP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:32:15 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD38A54BFE
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jun 2022 13:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FRpDpScrAooxEPpGhidPa25jURO54INRK8x2ThhAwSc=; b=Lm6sXjbBXY0Dp6vadWroncbSw3
        Q31PLZYgYDpmH/4OCR80hNmDarVYvP4w9DAnTK5viqXC7ayIX2AFYnu+PgZniyZFSY+Ojr7GCxAJN
        6yO16teyW0kHHP5Izv93YQnQ9fe7E7UJMIO91wApKFpEgkk03N2E/8DepO1MR3LNHcjIDfpGx1v1d
        Ob4joEiMhSVmSC21x4AdmMA9/5wjdhZ+2tdlO1foL9H9aUN/CmWBWwOMvM/f1uPC9jBmOZ5gj0jB1
        GV3Vlgjv4si3t3KloBhgaj7ALr7ICChU37tElokY6o2jY0vIZmF7eNcnNJ7SfMeWoYt4D8cB1pGOp
        pRCGhzbQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o4TUo-003fJk-Mm;
        Thu, 23 Jun 2022 20:32:10 +0000
Date:   Thu, 23 Jun 2022 21:32:10 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC][CFT][PATCHSET] iov_iter stuff
Message-ID: <YrTNyvGZhXZEULA0@ZenIV>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <1937818.1655997712@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1937818.1655997712@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 23, 2022 at 04:21:52PM +0100, David Howells wrote:
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > 
> > 13/44: splice: stop abusing iov_iter_advance() to flush a pipe
> > 	A really odd (ab)use of iov_iter_advance() - in case of error
> > generic_file_splice_read() wants to free all pipe buffers ->read_iter()
> > has produced.  Yes, forcibly resetting ->head and ->iov_offset to
> > original values and calling iov_iter_advance(i, 0) will trigger
> > pipe_advance(), which will trigger pipe_truncate(), which will free
> > buffers.  Or we could just go ahead and free the same buffers;
> > pipe_discard_from() does exactly that, no iov_iter stuff needs to
> > be involved.
> 
> Can ->splice_read() and ->splice_write() be given pipe-class iov_iters rather
> than pipe_inode_info structs?

Huh?

First of all, ->splice_write() is given a pipe as data _source_, which makes
ITER_PIPE completely irrelevant - those suckers are data destinations.
What's more, it will unlock the pipe, wait and relock once somebody writes
to that pipe.  And ITER_PIPE very much relies upon the pipe being locked
and staying locked.

As for ->splice_read()...  We could create the iov_iter in the caller, but...
Look at those callers:
        pipe_lock(opipe);
	ret = wait_for_space(opipe, flags);
	if (!ret)
		ret = do_splice_to(in, offset, opipe, len, flags);
	pipe_unlock(opipe);

You can't set it up before wait_for_pace(), obviously - if there's no
empty slots, what would that sucker work with?  And you can't keep
it past pipe_unlock().  So it's limited to do_splice_to(), which
is a very thin wrapper for ->splice_read().  So what's the point?
