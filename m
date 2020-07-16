Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D3A2223C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 15:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgGPNTf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 09:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPNTf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:19:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE501C061755;
        Thu, 16 Jul 2020 06:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WEQiCBMMUNKEUFHyzcb5Rpc/CbMmuXqhvIERsytx/G8=; b=EkZKARTO1n+Jc8mgTGW8iuFXhb
        thHBz9J+4zMmxQpyDabGDoVmIS+aKFLPIgfIr793sfNEChsxhi/PN5y1eigH5phu3iGPFbzJGpeqR
        oWY7QtkQtoHsfTCa+LyOhMgJBBXOWi1Htd4HpsmzuBTke/S9skePv4Ac7Tw7BVWdbB8XfZeg9HBQT
        1zvYZN/DZ42PisgHb9EBnmON5XGdXsQUJlUcQwT09HE1uBcvmxB4orvpi1CAg3ZbVeVzrEKrOWRt6
        tnP/Kpk4N0G45HJtUvYoZbiROd/+yKrns8So7a2yQj6IhynArheTfWxH+5ko4nBboUktV8FLikk5X
        otmiI6GQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jw3nN-0003AX-4f; Thu, 16 Jul 2020 13:19:29 +0000
Date:   Thu, 16 Jul 2020 14:19:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Dave Chinner <david@fromorbit.com>, akpm@linux-foundation.org,
        Marco Elver <elver@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        syzbot <syzbot+0f1e470df6a4316e0a11@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Will Deacon <will@kernel.org>
Subject: Re: KCSAN: data-race in generic_file_buffered_read /
 generic_file_buffered_read
Message-ID: <20200716131929.GL12769@casper.infradead.org>
References: <0000000000004a4d6505aa7c688a@google.com>
 <20200715152912.GA2209203@elver.google.com>
 <20200715163256.GB1167@sol.localdomain>
 <20200715234203.GK5369@dread.disaster.area>
 <20200716030357.GE1167@sol.localdomain>
 <1594880070.49b50i0a1p.astroid@bobo.none>
 <20200716065454.GI1167@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716065454.GI1167@sol.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 15, 2020 at 11:54:54PM -0700, Eric Biggers wrote:
> > >> > Concurrent reads on the same file descriptor are allowed.  Not with sys_read(),
> > >> > as that implicitly uses the file position.  But it's allowed with sys_pread(),
> > >> > and also with sys_sendfile() which is the case syzbot is reporting here.
> > >> 
> > >> Concurrent read()s are fine, they'll just read from the same offset.
> > >> 
> > > 
> > > Actually the VFS serializes concurrent read()'s on the same fd, at least for
> > > regular files.
> > 
> > Hmm, where?
> 
> It's serialized by file->f_pos_lock.  See fdget_pos().

What if we trylock either f_lock or f_pos_lock for readahead and just
skip all the readahead code if it's already taken?  I'd suggest that if
there are two readers using the same struct file, this is probably not
a workload that benefits greatly from readahead.

