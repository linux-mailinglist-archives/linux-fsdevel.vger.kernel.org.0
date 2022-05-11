Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23539523F94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 23:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348263AbiEKVoB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 17:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243914AbiEKVoA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 17:44:00 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFCE737B0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 14:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vcm/V672RtTM8vvm4J3KtX9NQnkGZta3Kq9vhuotm/A=; b=U3pn9iUc06fECU+PasECe4aWwQ
        Wu4rQLRIW2rEI4pXGQlVfnT9SW5jOHe2BqV9hsNZ3/nhL2E/FoPOfuZKnU//PBieXE9kW3rA2Xq3g
        1mRtJu7qMYHCSw8BO9nVnkCbT3jC9/1zC37fZbPXsJfb/Qe0WZzZhjqH6qs43Unt+j5GTWzSt3pzJ
        oTk0vz8TU/e/jdaEAgaWDipx+47FD8smVwT4OeIdCVNieazOQIrMTVjHOZdU9bZV924H2nfLPtPoq
        NP5XvRMhQ++aYd/KQ4PW3Lt/cZx3lFYyD9gTCTuJLiD7UBdMP0fI3wSgK6Xnc0KubGMtteDg2mkAu
        jGazVxqw==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nou7W-00E7QV-5e; Wed, 11 May 2022 21:43:46 +0000
Date:   Wed, 11 May 2022 21:43:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Chengguang Xu <cgxu519@mykernel.net>,
        linux-fsdevel@vger.kernel.org, Xu Kuohai <xukuohai@huawei.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH] vfs: move fdput() to right place in
 ksys_sync_file_range()
Message-ID: <YnwuEt2Xm1iPjW7S@zeniv-ca.linux.org.uk>
References: <20220511154503.28365-1-cgxu519@mykernel.net>
 <YnvbhmRUxPxWU2S3@casper.infradead.org>
 <YnwIDpkIBem+MeeC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnwIDpkIBem+MeeC@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[bpf folks Cc'd]

On Wed, May 11, 2022 at 07:01:34PM +0000, Eric Biggers wrote:
> On Wed, May 11, 2022 at 04:51:34PM +0100, Matthew Wilcox wrote:
> > On Wed, May 11, 2022 at 11:45:03AM -0400, Chengguang Xu wrote:
> > > Move fdput() to right place in ksys_sync_file_range() to
> > > avoid fdput() after failed fdget().
> > 
> > Why?  fdput() is already conditional on FDPUT_FPUT so you're ...
> > optimising the failure case?
> 
> "fdput() after failed fdget()" has confused people before, so IMO it's worth
> cleaning this up.  But the commit message should make clear that it's a cleanup,
> not a bug fix.  Also I recommend using an early return:
> 
> 	f = fdget(fd);
> 	if (!f.file)
> 		return -EBADF;
> 	ret = sync_file_range(f.file, offset, nbytes, flags);
> 	fdput(f);
> 	return ret;

FWIW, fdput() after failed fdget() is rare, but there's no fundamental reasons
why it would be wrong.  No objections against that patch, anyway.

Out of curiousity, I've just looked at the existing users.  In mainline we have
203 callers of fdput()/fdput_pos(); all but 7 never get reached with NULL ->file.

1) There's ksys_sync_file_range(), kernel_read_file_from_fd() and ksys_readahead() -
all with similar pattern.  I'm not sure that for readahead(2) "not opened for
read" should yield the same error as "bad descriptor", but since it's been a part
of userland ABI for a while...

2) two callers in perf_event_open(2) are playing silly buggers with explicit
        struct fd group = {NULL, 0};
and rely upon "fdput() is a no-op if we hadn't touched that" (note that if
we try to touch it and get NULL ->file from fdget(), we do not hit those fdput()
at all).

3) ovl_aio_put() is hard to follow (and some of the callers are poking
where they shouldn't), no idea if it's correct.  struct fd is manually
constructed there, anyway.

4) bpf generic_map_update_batch() is really asking for trouble.  The comment in
there is wrong:
        f = fdget(ufd); /* bpf_map_do_batch() guarantees ufd is valid */
*NOTHING* we'd done earlier can guarantee that.  We might have a descriptor
table shared with another thread, and it might have very well done dup2() since
the last time we'd looked things up.  IOW, this fdget() is racy - the function
assumes it refers to the same thing that gave us map back in bpf_map_do_batch(),
but it's not guaranteed at all.

I hadn't put together a reproducer, but that code is very suspicious.  As a general
rule, you should treat descriptor table as shared object, modifiable by other
threads.  It can be explicitly locked and it can be explicitly unshared, but
short of that doing a lookup for the same descriptor twice in a row can yield
different results.

What's going on there?  Do you really want the same struct file you've got back in
bpf_map_do_batch() (i.e. the one you've got the map from)?  What should happen
if the descriptor changes its meaning during (or after) the operation?
