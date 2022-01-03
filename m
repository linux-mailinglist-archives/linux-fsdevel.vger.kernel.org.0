Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFD44866FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 16:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240774AbiAFPp6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 10:45:58 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47258 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240605AbiAFPpr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:45:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5B94E1F3A2;
        Thu,  6 Jan 2022 15:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641483945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w/PgkW2cPat4KGguQxeoKi+4KGWRYkW9ay1Wjr//6jw=;
        b=hn8YBD/pVwqHlbNUrMWZX8dXU0TGN/GujSFwd9fI+wd7wMxX/lDpgsIq1NEfsUqVwbDXAi
        e635nFsuJLZswhXLKwkeMOaP2FXm5/DiW6CsolMLoKGqARhudkrXCAqjwF4kEF+Djf/HmR
        CMqMzmINhrARuJOP3nwQwe7SegotLyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641483945;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w/PgkW2cPat4KGguQxeoKi+4KGWRYkW9ay1Wjr//6jw=;
        b=SqSvAG9tjwB0yPW7GASetEG8hCY9bm/YebO67Ftkg2NNVDUzx64j3n88F5Rhj1usvwojKf
        MQVPXXLsrNXBLKAg==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 42205A3B87;
        Thu,  6 Jan 2022 15:45:45 +0000 (UTC)
Received: by localhost (Postfix, from userid 1000)
        id D7E5EA05C7; Mon,  3 Jan 2022 16:20:23 +0100 (CET)
Date:   Mon, 3 Jan 2022 16:20:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     August Wikerfors <august.wikerfors@gmail.com>,
        Mohan R <mohan43u@gmail.com>, uwe.sauter.de@gmail.com,
        almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev,
        Jan Kara <jack@suse.cz>
Subject: Re: Bug using new ntfs3 file system driver (5.15.2 on Arch Linux)
Message-ID: <20220103152023.evkgkitqkxsgsn2m@quack3>
References: <CAFYqD2pe-sjPrHXGsNCHa2fcdECNm44UEZbEn4P5VgygFnrn7A@mail.gmail.com>
 <YaJFoadpGAwPfdLv@casper.infradead.org>
 <CAP62yhUh2ULCaD4+RX6Lj_QZmJN+uh5L46xzb7NvrWU3vHeCfw@mail.gmail.com>
 <Ycu2MGt/raXJ+wCb@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ycu2MGt/raXJ+wCb@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 29-12-21 01:13:20, Matthew Wilcox wrote:
> On Tue, Dec 28, 2021 at 10:00:53PM +0100, August Wikerfors wrote:
> > (resending from gmail due to bounce with outlook)
> > 
> > Hi, I ran into a bug with a very similar call trace, also when copying files
> > with rsync from a filesystem mounted using ntfs3. I was able to reproduce it
> > on both the default Arch Linux kernel (5.15.11-arch2-1) and on mainline
> > 5.16-rc7.
> 
> Hi August!  This is very helpful; thank you for putting in the work to
> figure this out.  I am still a little baffled:
> 
> > [  486.361177] RIP: 0010:0xffffff8306d925ff
> > [  486.361192] Code: Unable to access opcode bytes at RIP 0xffffff8306d925d5.
> > [  486.361214] RSP: 0018:ffffaa9ec0f8fb37 EFLAGS: 00010246
> > [  486.361232] RAX: 0000000000000000 RBX: 00000000000002ab RCX: 0000000000000000
> > [  486.361255] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > [  486.361279] RBP: ffaa9ec0f8fbf800 R08: 0000000000000000 R09: 0000000000000000
> > [  486.361302] R10: 0000000000000000 R11: 0000000000000000 R12: ff99687f5746e000
> > [  486.361324] R13: 00000001112ccaff R14: fffcbb8097368000 R15: 00000000000001ff
> > [  486.361349]  ? page_cache_ra_unbounded+0x1c5/0x250
> > [  486.361369]  ? filemap_get_pages+0x117/0x730
> > [  486.361386]  ? make_kuid+0xf/0x20
> > [  486.361401]  ? generic_permission+0x27/0x210
> > [  486.361419]  ? walk_component+0x11d/0x1c0
> > [  486.361435]  ? filemap_read+0xb9/0x360
> > [  486.361451]  ? new_sync_read+0x159/0x1f0
> > [  486.361467]  ? vfs_read+0xff/0x1a0
> > [  486.361489]  ? ksys_read+0x67/0xf0
> > [  486.361503]  ? do_syscall_64+0x5c/0x90
> > 
> > $ scripts/faddr2line vmlinux.5.15.11-arch2-1 page_cache_ra_unbounded+0x1c5/0x250
> > page_cache_ra_unbounded+0x1c5/0x250:
> > filemap_invalidate_unlock_shared at include/linux/fs.h:853
> > (inlined by) page_cache_ra_unbounded at mm/readahead.c:240
> 
> So ... Jan added this code in commit 730633f0b7f9, but I don't see how
> it could be buggy:

I don't think the problem is with my code. The address
page_cache_ra_unbounded+0x1c5/0x250 is from the stack which means it is a
return address for the function that's currently executing or just to be
called - presumably from read_pages(). And note that we crashed because we
tried to call / jump to invalid address. So most likely aops->readpage(),
aops->readahead(), or aops->readpages() was the bogus address
0xffffff8306d925d5. How it got there I don't know but I'd closely look into
the ntfs3 driver...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
