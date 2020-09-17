Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B76026E599
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 21:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgIQPMD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 11:12:03 -0400
Received: from verein.lst.de ([213.95.11.211]:56682 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbgIQPLO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:11:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5FF896736F; Thu, 17 Sep 2020 17:09:58 +0200 (CEST)
Date:   Thu, 17 Sep 2020 17:09:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, tytso@mit.edu,
        Junio C Hamano <gitster@pobox.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] sha1-file: fsync() loose dir entry when
 core.fsyncObjectFiles
Message-ID: <20200917150958.GA31693@lst.de>
References: <87sgbghdbp.fsf@evledraar.gmail.com> <20200917112830.26606-2-avarab@gmail.com> <20200917131605.GC3024501@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917131605.GC3024501@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 09:16:05AM -0400, Jeff King wrote:
> I've also often wondered whether this is necessary. Given the symptom of
> "oops, this object is there but with 0 bytes" after a hard crash (power
> off, etc), my assumption is that the metadata is being journaled but the
> actual data is not. Which would imply this isn't needed, but may just be
> revealing my naive view of how filesystems work.
> 
> And of course all of my experience is on ext4 (which doubly confuses me,
> because my systems typically have data=ordered, which I thought would
> solve this). Non-journalling filesystems or other modes likely behave
> differently, but if this extra fsync carries a cost, we may want to make
> it optional.

I hope my other mail clarified how this works at a high level, if not
feel free to ask more questions.

> >  sha1-file.c | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> We already fsync pack files, but we don't fsync their directories. If
> this is important to do, we should be doing it there, too.
> 
> We also don't fsync ref files (nor packed-refs) at all. If fsyncing
> files is important for reliability, we should be including those, too.
> It may be tempting to say that the important stuff is in objects and the
> refs can be salvaged from the commit graph, but my experience says
> otherwise. Missing, broken, or mysteriously-rewound refs cause confusing
> user-visible behavior, and when compounded with pruning operations like
> "git gc" they _do_ result in losing objects.

True, this probably needs to do for the directories of other files
as well.

One interesting optimization under linux is the syncfs syscall, that
syncs all files on a file system - if you need to do a large number
of fsyncs that do not depend on each other for transaction semantics
it can provide a huge speedup.
