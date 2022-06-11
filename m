Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3291454760A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jun 2022 17:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiFKPTO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jun 2022 11:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbiFKPTL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jun 2022 11:19:11 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FF1532F4
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jun 2022 08:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wGPqBG6QROc7wGr2dAVFjZMoM713TxZD0kORS5OQD0Y=; b=nkXuAnE9/SQez/HHivi1NLK8if
        fSWTa5FaJQuK7v+HmclOnC7LVaWVwxWq4TnG0ns1BGEwOiIrwMgwxuMRhZpyqeGKGXYtQr8gbJen0
        hqVk5nSa5hyy1+K0wPPd4mZx1O17xVBnK+YgNapApDmi3tVSmGFteBkr18tQSIzPSFp5/wJ56WRLb
        iQyjNkmvWzYxwjKN5T6ZCmVg97RIJFMErLINc7KkpqJUIVncVmIDb6mySfx1a8knlHBd/rTYSfJRd
        gnlC+UyrAdy4i6jh4GI9GhrBZXHfMPpVAaq61IkEVHIz5yMb4x/YE/J3ckNr4PlN4PfUzDIR0qRji
        ZPynrW+Q==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o02tH-00691K-Bq; Sat, 11 Jun 2022 15:19:07 +0000
Date:   Sat, 11 Jun 2022 15:19:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [RFC][CFT] handling Rerror without copy_from_iter_full()
Message-ID: <YqSyaz0GNdZbu1bx@zeniv-ca.linux.org.uk>
References: <YqDfWho8+f2AXPrj@zeniv-ca.linux.org.uk>
 <YqSYWgeQqenOYwVf@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqSYWgeQqenOYwVf@codewreck.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 11, 2022 at 10:27:54PM +0900, Dominique Martinet wrote:

> That makes me wonder just how much use we get for the legacy
> protocols -- I guess we do have some but all the filesystem-y
> implementations that I would expect to be main users for large
> IOs/zc are 9P2000.L as far as I know -- especially considering
> virtio is pretty much limited to qemu? Are there other 9p virtio
> servers?

Client can trivially force its use - -o version=9p2000.u and there
you go...

> So would it make sense to just say "not .L? tough luck, no zc",
> or am I just being lazy?
> 
> > Had that been in fixed-sized buffer (which is actually 4K), we would've
> > dealt with that the same way we handle non-zerocopy case.  However,
> > for zerocopy it doesn't end up there, so we need to copy it from
> > those pages.
> > 
> > The trouble is, by the time we get around to that, the references to
> > pages in question are already dropped.  As the result, p9_zc_check_errors()
> > tries to get the data using copy_from_iter_full().  Unfortunately, the
> > iov_iter it's trying to read from might *NOT* be capable of that.
> > It is, after all, a data destination, not data source.  In particular,
> > if it's an ITER_PIPE one, copy_from_iter_full() will simply fail.
> 
> Silly question, in case of a pipe we'll have written something we
> shouldn't have, or is it not gone yet until we actually finish the IO
> with iov_iter_advance?
> (my understanding is that reader won't have anything to read until
> someone else does the advance, and that someone else will have
> overwritten the data with their own content so no garbage wlll be read)

More than that, pipe is locked through ->read_iter(), so transient garbage
in it doesn't matter - we will either advance it by zero (it's an error)
or, with iov_iter_get_pages_alloc() switching to advancing variant,
we'll revert by the amount it had reserved there (error is the same as
extremely short read).

> ... With that said though your approach here definitely looks better
> than what we currently have -- my main issue is that truncating is fine
> for the original 9p2000 but for .U you'd be losing the ecode that we
> currently trust for being errno-compatible.

No, we wouldn't - this
                len = req->rc.size - req->rc.offset;
		if (len > (P9_ZC_HDR_SZ - 7)) {
			err = -EFAULT;
			goto out_err;
		}
in p9_check_zc_errors() means that mainline won't even look at that value.
And we'll get the same -EFAULT when we get to
                err = p9pdu_readf(&req->rc, c->proto_version, "s?d",
				  &ename, &ecode);
in p9_check_errors() and see that the length of string is too large to
fit into (truncated) reply.
