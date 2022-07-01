Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F84562B83
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 08:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbiGAG0O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 02:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbiGAG0N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:26:13 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB5A44A0A
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 23:26:12 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 19633C01E; Fri,  1 Jul 2022 08:26:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1656656771; bh=8KuF7lCMeR+mJs7SOLEYTdl0pzoWYDAVyDksIv/MR9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yOuBZ0zruDJp1YYOYUFn0crbg3yBquFi/ZLPuQkXgusgOjBcg61L2WwAvimukWJQc
         kY2mfM2VeDc8bgS0Fqnh6RJ0b8jeUl5KjlBf8SLYQFbxTQAqf/WNI4gMu383S/Oelr
         9qek1R82CgtronQ3A53bdgcdSZwclsEtDkqJK5qb74F3jDLeqrfqerxG2phtwfxWIc
         1no7nzB3BUqJtAiZAxIP6tT65DJ2+dz567pz0vcI/bFAlYiqsz6YVqytPatvupXU5R
         N7W4LNiUkYws5BMdNcIKeETNzyvoVBJqRRAyUcDgaRthIAEyVd/KFxYhlYZtxehUYC
         P6z7awWOiAkQw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 3294DC009;
        Fri,  1 Jul 2022 08:26:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1656656769; bh=8KuF7lCMeR+mJs7SOLEYTdl0pzoWYDAVyDksIv/MR9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yKd0d/+Fx+Zuyzx49JTRyrfspYAW8eZ5bwr1VdCcFA8hM5cYN1sPRFOYO0Q1gp6Oa
         NEb5DXkqZnkQ9KFRCs/Fro2hV8hYoWZo+3zqJ6YyJRZOqM/ygEpjngfJrdbYaQGORB
         uqjDCHzcqibT7SOBtnW6aLAySGdZGmE111hSJF30fYC3pMnTzpZGmXo5XAJZfXfxoM
         pXU3Lq6lhdS+HCS+oNfwih2IME7SER/HQHRkd1Bibir3yvOw4aM+TFQL/hKLW82ECv
         zNMXgmrLQwKcfg2fIN5h4vpUA5H8pzAPvUshbIIm3ro/wP7/QleZ/3lhSZ2Pw/CUID
         JCybneRW5cHVA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 058b78c1;
        Fri, 1 Jul 2022 06:26:04 +0000 (UTC)
Date:   Fri, 1 Jul 2022 15:25:49 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH 01/44] 9p: handling Rerror without copy_from_iter_full()
Message-ID: <Yr6TbVQvu+noSzc8@codewreck.org>
References: <YrKWRCOOWXPHRCKg@ZenIV>
 <20220622041552.737754-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220622041552.737754-1-viro@zeniv.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


(sigh, I'm tired -- said I'd add Christian in Ccs and promply forgot to
do it. Sorry for double send to everyone else.)

+Christian Schoenebeck in Ccs as that concerns qemu as well.

The patch I'm replying to is at
https://lkml.kernel.org/r/20220622041552.737754-1-viro@zeniv.linux.org.uk

Al Viro wrote on Wed, Jun 22, 2022 at 05:15:09AM +0100:
>         p9_client_zc_rpc()/p9_check_zc_errors() are playing fast
> and loose with copy_from_iter_full().
> 
> 	Reading from file is done by sending Tread request.  Response
> consists of fixed-sized header (including the amount of data actually
> read) followed by the data itself.
> 
> 	For zero-copy case we arrange the things so that the first
> 11 bytes of reply go into the fixed-sized buffer, with the rest going
> straight into the pages we want to read into.
> 
> 	What makes the things inconvenient is that sglist describing
> what should go where has to be set *before* the reply arrives.  As
> the result, if reply is an error, the things get interesting.  On success
> we get
> 	size[4] Rread tag[2] count[4] data[count]
> For error layout varies depending upon the protocol variant -
> in original 9P and 9P2000 it's
> 	size[4] Rerror tag[2] len[2] error[len]
> in 9P2000.U
> 	size[4] Rerror tag[2] len[2] error[len] errno[4]
> in 9P2000.L
> 	size[4] Rlerror tag[2] errno[4]
> 
> 	The last case is nice and simple - we have an 11-byte response
> that fits into the fixed-sized buffer we hoped to get an Rread into.
> In other two, though, we get a variable-length string spill into the
> pages we'd prepared for the data to be read.
> 
> 	Had that been in fixed-sized buffer (which is actually 4K),
> we would've dealt with that the same way we handle non-zerocopy case.
> However, for zerocopy it doesn't end up there, so we need to copy it
> from those pages.
> 
> 	The trouble is, by the time we get around to that, the
> references to pages in question are already dropped.  As the result,
> p9_zc_check_errors() tries to get the data using copy_from_iter_full().
> Unfortunately, the iov_iter it's trying to read from might *NOT* be
> capable of that.  It is, after all, a data destination, not data source.
> In particular, if it's an ITER_PIPE one, copy_from_iter_full() will
> simply fail.
> 
> 	In ->zc_request() itself we do have those pages and dealing with
> the problem in there would be a simple matter of memcpy_from_page()
> into the fixed-sized buffer.  Moreover, it isn't hard to recognize
> the (rare) case when such copying is needed.  That way we get rid of
> p9_zc_check_errors() entirely - p9_check_errors() can be used instead
> both for zero-copy and non-zero-copy cases.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

I ran basic tests with this, should be ok given the code path is never
used on normal (9p2000.L) workloads.


I also tried 9p2000.u for principle and ... I have no idea if this works
but it didn't seem to blow up there at least.
The problem is that 9p2000.u just doesn't work well even without these
patches, so I still stand by what I said about 9p2000.u and virtio (zc
interface): we really can (and I think should) just say virtio doesn't
support 9p2000.u.
(and could then further simplify this)

If you're curious, 9p2000.u hangs without your patch on at least two
different code paths (trying to read a huge buffer aborts sending a
reply because msize is too small instead of clamping it, that one has a
qemu warning message; but there are others ops like copyrange that just
fail silently and I didn't investigate)

I'd rather not fool someone into believing we support it when nobody has
time to maintain it and it fails almost immediately when user requests
some unusual IO patterns... And I definitely don't have time to even try
fixing it.
I'll suggest the same thing to qemu lists if we go that way.


Anyway, for anything useful:

Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
Tested-by: Dominique Martinet <asmadeus@codewreck.org>

--
Dominique
