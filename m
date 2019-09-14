Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72BC4B2CDA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2019 22:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbfINUES (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Sep 2019 16:04:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:60322 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfINUER (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Sep 2019 16:04:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i9EHE-0007ZA-Cc; Sat, 14 Sep 2019 20:04:12 +0000
Date:   Sat, 14 Sep 2019 21:04:12 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "zhengbin (A)" <zhengbin13@huawei.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, renxudong1@huawei.com,
        Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH] Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Message-ID: <20190914200412.GU1131@ZenIV.linux.org.uk>
References: <b5876e84-853c-e1f6-4fef-83d3d45e1767@huawei.com>
 <afdfa1f4-c954-486b-1eb2-efea6fcc2e65@huawei.com>
 <20190909145910.GG1131@ZenIV.linux.org.uk>
 <14888449-3300-756c-2029-8e494b59348b@huawei.com>
 <7e32cda5-dc89-719d-9651-cf2bd06ae728@huawei.com>
 <20190910215357.GH1131@ZenIV.linux.org.uk>
 <20190914161622.GS1131@ZenIV.linux.org.uk>
 <CAHk-=whpKgNTxjrenAed2sNkegrpCCPkV77_pWKbqo+c7apCOw@mail.gmail.com>
 <20190914170146.GT1131@ZenIV.linux.org.uk>
 <CAHk-=wiPv+yo86GpA+Gd_et0KS2Cydk4gSbEj3p4S4tEb1roKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiPv+yo86GpA+Gd_et0KS2Cydk4gSbEj3p4S4tEb1roKw@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 14, 2019 at 10:15:22AM -0700, Linus Torvalds wrote:
> On Sat, Sep 14, 2019 at 10:01 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > I thought of that, but AFAICS rename(2) is a fatal problem for such
> > a scheme.
> 
> Duh. You're obviously correct, and I didn't think it through.

Getting the cursors out of the list is obviously tempting; if we could make
simple_rename() take care of those it might be worth doing.  I played with
having them hashed by middle bits of target dentry address (we have enough
fields unused for cursor dentries), but the problem is that we'd need to
scan the full hash chain on simple_rename() for that to work.  Or keep the
chains ordered, but that's even more painful - moving cursors would become
costly.  That approach needs something to represent the following
data and primitives:
	non-intersecting sets Cursors(dentry) (empty for most of dentries)
	by given cursor find dentry such that cursor \in Cursors(dentry)
	remove given cursor from the set it belongs to
	add given cursor to Cursors(dentry)
	move everything from Cursors(dentry1) into Cursors(dentry2)

An obvious approach would be to have them sit in the lists hanging off
dentries, with pointer to dentry in the cursor itself.  It's not hard
to do, with "move" costing O(#Cursors(dentry1)) and everything else
being O(1), but I hate adding a pointer to each struct dentry, when
it's completely useless for most of the filesystems *and* NULL for
most of dentries on dcache_readdir()-using one.

We could try to be smart with ->d_fsdata, but at least autofs and debugfs
are already using that ;-/  Hell knows - in any case, that's far too
intrusive by that point in the cycle, so I decided to leave any work
in that direction for later.  I might be missing something obvious, though,
so any suggestions would be welcome.
