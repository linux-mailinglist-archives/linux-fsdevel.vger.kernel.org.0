Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4F34D468C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 13:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241888AbiCJMOb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 07:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241867AbiCJMOa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 07:14:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827EAA76FB;
        Thu, 10 Mar 2022 04:13:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13F35618C5;
        Thu, 10 Mar 2022 12:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F128C340F4;
        Thu, 10 Mar 2022 12:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646914408;
        bh=UKbNBOgnndbhaHzuo5wICJa7XmlyUEtQGp8bX6HrNe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4qbh3FrxVI2JPSZ4Jd44z+OtU7akB1h2LiFq2xkFqCAZ9WR6Fu9thwdicFr+iALm
         2X1CVvi/RBVtCvcgUYqS44gWR5u2uh2x8m7DoYIV6wjcSVE8rL+dHBwsSWetnLdjRu
         rpCyQLe48rFAkT/QWj7+3c3ES4J88a68XH+zIkl+s/WUaqWuRJ3utHxR8VtcWcshDH
         jgGItDtiMD774HBYbB/QQHEYcPNi0GGkpPov1Oz/HKyT+8gOVvaFSSo7/ThRLQe6UQ
         aWSM3TXF6ezSTVYC91gDfyOqpe6mj2HZK9Ug6tKWItJHf/x/VUGJRceZ7hBEUGO3jl
         N1Ht4/fONRSdA==
Date:   Thu, 10 Mar 2022 12:13:25 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Filipe Manana <fdmanana@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
Message-ID: <YinrZVoAnEU8/wpa@debian9.Home>
References: <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com>
 <CAHk-=wh1WJ-s9Gj15yFciq6TOd9OOsE7H=R7rRskdRP6npDktQ@mail.gmail.com>
 <CAHk-=wjHsQywXgNe9D+MQCiMhpyB2Gs5M78CGCpTr9BSeP71bw@mail.gmail.com>
 <CAHk-=wjs2Jf3LzqCPmfkXd=ULPyCrrGEF7rR6TYzz1RPF+qh3Q@mail.gmail.com>
 <CAHk-=wi1jrn=sds1doASepf55-wiBEiQ_z6OatOojXj6Gtntyg@mail.gmail.com>
 <CAHc6FU6L8c9UCJF_qcqY=USK_CqyKnpDSJvrAGput=62h0djDw@mail.gmail.com>
 <CAHk-=whaoxuCPg4foD_4VBVr+LVgmW7qScjYFRppvHqnni0EMA@mail.gmail.com>
 <20220309184238.1583093-1-agruenba@redhat.com>
 <CAHk-=wgBOFg3brJbo-gcaPM+fxjzHwC4efhcM8tCKK3YUhYUug@mail.gmail.com>
 <CAHc6FU5+AgDcoXE4Qfh_9hpn9d_it4aFyhoS=TKpqrBPe4GP+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU5+AgDcoXE4Qfh_9hpn9d_it4aFyhoS=TKpqrBPe4GP+w@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:08:32PM +0100, Andreas Gruenbacher wrote:
> On Wed, Mar 9, 2022 at 8:08 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Wed, Mar 9, 2022 at 10:42 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > > With a large enough buffer, a simple malloc() will return unmapped
> > > pages, and reading into such a buffer will result in fault-in.  So page
> > > faults during read() are actually pretty normal, and it's not the user's
> > > fault.
> >
> > Agreed. But that wasn't the case here:
> >
> > > In my test case, the buffer was pre-initialized with memset() to avoid
> > > those kinds of page faults, which meant that the page faults in
> > > gfs2_file_read_iter() only started to happen when we were out of memory.
> > > But that's not the common case.
> >
> > Exactly. I do not think this is a case that we should - or need to -
> > optimize for.
> >
> > And doing too much pre-faulting is actually counter-productive.
> >
> > > * Get rid of max_size: it really makes no sense to second-guess what the
> > >   caller needs.
> >
> > It's not about "what caller needs". It's literally about latency
> > issues. If you can force a busy loop in kernel space by having one
> > unmapped page and then do a 2GB read(), that's a *PROBLEM*.
> >
> > Now, we can try this thing, because I think we end up having other
> > size limitations in the IO subsystem that means that the filesystem
> > won't actually do that, but the moment I hear somebody talk about
> > latencies, that max_size goes back.
> 
> Thanks, this puts fault_in_safe_writeable() in line with
> fault_in_readable() and fault_in_writeable().
> 
> There currently are two users of
> fault_in_safe_writeable()/fault_in_iov_iter_writeable(): gfs2 and
> btrfs.
> In gfs2, we cap the size at BIO_MAX_VECS pages (256). I don't see an
> explicit cap in btrfs; adding Filipe.

On btrfs, for buffered writes, we have some cap (done at btrfs_buffered_write()),
for buffered reads we don't have any control on that as we use filemap_read().

For direct IO we don't have any cap, we try to fault in everything that's left.
However we keep track if we are doing any progress, and if we aren't making any
progress we just fall back to the buffered IO path. So that prevents infinite
or long loops.

There's really no good reason to not cap how much we try to fault in in the
direct IO paths. We should do it, as it probably has a negative performance
impact for very large direct IO reads/writes.

Thanks.

> 
> Andreas
> 
