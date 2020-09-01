Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EAC25869C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 06:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgIAEIs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 00:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgIAEIC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 00:08:02 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29A5C0612FE;
        Mon, 31 Aug 2020 21:08:01 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCxaL-008SmC-D3; Tue, 01 Sep 2020 04:07:53 +0000
Date:   Tue, 1 Sep 2020 05:07:53 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <cai@lca.pw>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+61acc40a49a3e46e25ea@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        tom.leiming@gmail.com, paulmck@kernel.org
Subject: Re: splice: infinite busy loop lockup bug
Message-ID: <20200901040753.GF1236603@ZenIV.linux.org.uk>
References: <00000000000084b59f05abe928ee@google.com>
 <29de15ff-15e9-5c52-cf87-e0ebdfa1a001@I-love.SAKURA.ne.jp>
 <20200807122727.GR1236603@ZenIV.linux.org.uk>
 <d96b0b3f-51f3-be3d-0a94-16471d6bf892@i-love.sakura.ne.jp>
 <20200901005131.GA3300@lca.pw>
 <20200901010928.GC1236603@ZenIV.linux.org.uk>
 <20200901033227.GA10262@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901033227.GA10262@lca.pw>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 11:32:28PM -0400, Qian Cai wrote:

> I used a new debug patch but not sure how to capture without
> printk_ratelimited() because the call sites are large,

	if (!strcmp(current->comm, "bugger"))
		printk(KERN_ERR....
and call the binary you are running ./bugger...  And I'd slap such
printk into the beginning of iterate_iovec() as well, if not into
the entry of iov_iter_copy_from_user_atomic().  That BS value of
n must've come from somewhere; it should expand to 'bytes'.
What we have in the beginning is

	const struct iovec *iov;
	struct iovec v;
        size_t skip = i->iov_offset;
        size_t left;
        size_t wanted = bytes;

        iov = i->iov;

        __v.iov_len = min(bytes, iov->iov_len - skip);
        if (likely(__v.iov_len)) {
                __v.iov_base = iov->iov_base + skip;
                left = copyin((p += v.iov_len) - v.iov_len, v.iov_base, v.iov_len);
                __v.iov_len -= left;
                skip += __v.iov_len;
                bytes -= __v.iov_len;
        } else {
                left = 0;
	}

and something leaves you with bytes bumped to 22476968.  What was in that first
iovec?  Incidentally, what's in 'wanted'?  And...  Timestamps don't look like
that crap has come from generic_perform_write() - it's about 4 seconds later.

While we are at it, there are other users of iterate_all_kinds(), and some of them
can very well get large sizes; they are not copying anything (iov_iter_advance(),
for starters).  There that kind of values would be just fine; are you sure those
printks came from iov_iter_copy_from_user_atomic()?
