Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C2D3712A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 10:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhECIva (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 04:51:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:56996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230490AbhECIv2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 04:51:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DF0D9B008;
        Mon,  3 May 2021 08:50:34 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 70c33aec;
        Mon, 3 May 2021 08:52:05 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>
Subject: Re: fuse: kernel BUG at mm/truncate.c:763!
Message-ID: <87bl9std3d.fsf@suse.de>
References: <20210312131123.GZ3479805@casper.infradead.org>
        <YE8tQc66C6MW7EqY@suse.de>
        <20210315110659.GT2577561@casper.infradead.org>
        <YFMct4z1gEa8tXkh@suse.de>
        <CAJfpeguX7NrdTH4JLbCtkQ1u7TFvUh+8s7RmwB_wmuPHJsQyiA@mail.gmail.com>
        <20210318110302.nxddmrhmgmlw4adq@black.fi.intel.com>
        <YFM5mEZ8dZBhZWLI@suse.de>
        <20210318115543.GM3420@casper.infradead.org>
        <YFRoqYYqATd6R9GF@suse.de> <YGGXhomAy9SF3VwN@suse.de>
        <20210329120532.GB351017@casper.infradead.org>
Date:   Mon, 03 May 2021 09:52:05 +0100
In-Reply-To: <20210329120532.GB351017@casper.infradead.org> (Matthew Wilcox's
        message of "Mon, 29 Mar 2021 13:05:32 +0100")
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Mar 29, 2021 at 10:01:58AM +0100, Luis Henriques wrote:
>> On Fri, Mar 19, 2021 at 09:02:33AM +0000, Luis Henriques wrote:
>> > On Thu, Mar 18, 2021 at 11:55:43AM +0000, Matthew Wilcox wrote:
>> > > On Thu, Mar 18, 2021 at 11:29:28AM +0000, Luis Henriques wrote:
>> > > > On Thu, Mar 18, 2021 at 02:03:02PM +0300, Kirill A. Shutemov wrote:
>> > > > > On Thu, Mar 18, 2021 at 11:59:59AM +0100, Miklos Szeredi wrote:
>> > > > > > > [16247.536348] page:00000000dfe36ab1 refcount:673 mapcount:0 mapping:00000000f982a7f8 index:0x1400 pfn:0x4c65e00
>> > > > > > > [16247.536359] head:00000000dfe36ab1 order:9 compound_mapcount:0 compound_pincount:0
>> > > > > > 
>> > > > > > This is a compound page alright.   Have no idea how it got into fuse's
>> > > > > > pagecache.
>> > > > > 
>> > > > > 
>> > > > > Luis, do you have CONFIG_READ_ONLY_THP_FOR_FS enabled?
>> > > > 
>> > > > Yes, it looks like Tumbleweed kernels have that config option enabled by
>> > > > default.  And it this feature was introduced in 5.4 (the bug doesn't seem
>> > > > to be reproducible in 5.3).
>> > > 
>> > > Can you try adding this patch?
>> > > 
>> > > https://git.infradead.org/users/willy/pagecache.git/commitdiff/369a4fcd78369b7a026bdef465af9669bde98ef4
>> > 
>> > Good news, looks like this patch fixes the issue[1].  Thanks a lot
>> > everyone.  Is this already queued somewhere for 5.12?  Also, it would be
>> > nice to have it Cc'ed for stable kernels >= 5.4.
>> 
>> Ping.  Are you planning to push this for 5.12, or is that queued for the
>> 5.13 merged window?  Or "none of the above"? :)
>
> Sorry, dropped the ball on this one.  This patch is good for that point
> in the patch series, but I'm not sure it works against upstream in all
> cases.  I need to spend some time evaluating it.  Thanks for the reminder.

Gentle ping :-)

Any chances of getting this into 5.13?  (And tagged for stable kernels.)

Cheers,
-- 
Luis
