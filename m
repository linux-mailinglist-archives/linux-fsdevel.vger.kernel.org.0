Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3525B125184
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 20:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfLRTLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 14:11:18 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45706 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfLRTLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:11:18 -0500
Received: by mail-qk1-f196.google.com with SMTP id x1so2480694qkl.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 11:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=23ZvkjIG/EjeOvv/IiXorV2L8ygoo30YiUe3fEAEBO0=;
        b=aadTJzLqMHUGPj43zbLbdhaVyBaYvIr3B7kn2Up/Nd6CaENakb0glhrqNbXwpI2A0P
         Cx13Gbb47+hcMiDDqeS4LIO8DUWSaE2N1qcA5HIj+EBT4UrAyUaf41ysLmVgnajs3KpN
         4MGeMNc+3nV4DjLf6tb1TZPbmpQoDx6wXkCG1jE6dtKGgClb7whIi2nzIKuUP3fePPVM
         rGjCjqj8w3G3PV0VjzsQ4IFk8A+4l7srCnF96YWplAmjLvYcHZcniUj0SyrG5b/IdkcI
         YLMqVssXJFC50/HcEJFsgY7equjLpGi0sWjK0OEZqQ4XNzRkytCSzxzPEgTPsqFPLAIY
         2i8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=23ZvkjIG/EjeOvv/IiXorV2L8ygoo30YiUe3fEAEBO0=;
        b=WMEVWFsyvirTayIAY5HkZUSEpS/Xs2KQFXnsvd2zcObexkvHYpGN+l0M6FkwCJgQsH
         kQcWyVWkAPIWB4xnQ456EUcVFhwub+m57euAs9Tt+/Zzw0sySY6EeL3VOOiTWO+065pu
         NPCZb0t15WsxvmWwqLbgytI2llYZYZ3UVZwmA4CdSEvnEwsPhUUFAfF5MIbuM/jkE3Nd
         W27uVOaTLSTZIOeMfgOBlx6LvzVYyBobGEydClUlGVv01NnCBD/sdbt+otnxLiUv/j97
         BSYo2Y0eiApUVVqmxYPFd8uix4JHsIrB+n+/y6zaQcJOX0OLOO3q/m2RRNE2Qw9xJ3aN
         6Trg==
X-Gm-Message-State: APjAAAVMiV2HtUzAAEmGnM9oQwkPpsrZf6O2dkvnYNsDKm75gVu33o0h
        PFY+wVCexImibBBWPSL5O2qNZrA=
X-Google-Smtp-Source: APXvYqxtqsiLCdfnlLyhLrKRp3JZBH4X6xEKG79yjLCYMLnP/k1U+2QVhzgfIq57U8u74e57qoiSrQ==
X-Received: by 2002:a37:814:: with SMTP id 20mr4230794qki.314.1576696277193;
        Wed, 18 Dec 2019 11:11:17 -0800 (PST)
Received: from moria.home.lan ([2601:19b:c500:a1:7285:c2ff:fed5:c918])
        by smtp.gmail.com with ESMTPSA id b35sm1059699qtc.9.2019.12.18.11.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 11:11:16 -0800 (PST)
Date:   Wed, 18 Dec 2019 14:11:14 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>
Subject: RFC: Page cache coherency in dio write path (was: [LSF/MM/BPF TOPIC]
 Bcachefs update)
Message-ID: <20191218191114.GA1731524@moria.home.lan>
References: <20191216193852.GA8664@kmo-pixel>
 <20191218124052.GB19387@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218124052.GB19387@quack2.suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 01:40:52PM +0100, Jan Kara wrote:
> On Mon 16-12-19 14:38:52, Kent Overstreet wrote:
> > Pagecache consistency:
> > 
> > I recently got rid of my pagecache add lock; that added locking to core paths in
> > filemap.c and some found my locking scheme to be distastefull (and I never liked
> > it enough to argue). I've recently switched to something closer to XFS's locking
> > scheme (top of the IO paths); however, I do still need one patch to the
> > get_user_pages() path to avoid deadlock via recursive page fault - patch is
> > below:
> > 
> > (This would probably be better done as a new argument to get_user_pages(); I
> > didn't do it that way initially because the patch would have been _much_
> > bigger.)
> > 
> > Yee haw.
> > 
> > commit 20ebb1f34cc9a532a675a43b5bd48d1705477816
> > Author: Kent Overstreet <kent.overstreet@gmail.com>
> > Date:   Wed Oct 16 15:03:50 2019 -0400
> > 
> >     mm: Add a mechanism to disable faults for a specific mapping
> >     
> >     This will be used to prevent a nasty cache coherency issue for O_DIRECT
> >     writes; O_DIRECT writes need to shoot down the range of the page cache
> >     corresponding to the part of the file being written to - but, if the
> >     file is mapped in, userspace can pass in an address in that mapping to
> >     pwrite(), causing those pages to be faulted back into the page cache
> >     in get_user_pages().
> >     
> >     Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> 
> I'm not really sure about the exact nature of the deadlock since the
> changelog doesn't explain it but if you need to take some lockA in your
> page fault path and you already hold lockA in your DIO code, then this
> patch isn't going to cut it. Just think of a malicious scheme with two
> tasks one doing DIO from fileA (protected by lockA) to buffers mapped from
> fileB and the other process the other way around...

Ooh, yeah, good catch...

The lock in question is - for the purposes of this discussion, a RW lock (call
it map lock here): the fault handler and the buffered IO paths take it it read
mode, and the DIO path takes it in write mode to block new pages being added to
the page cache.

But get_user_pages() -> page fault invokes the fault handler, hence deadlock. My
patch was for avoiding this deadlock when the fault handler tries locking the
same inode's map lock, but as you note this is a more general problem...

This is starting to smell like possibly what wound/wait mutexes were invented
for, a situation where we need deadlock avoidance because lock ordering is under
userspace control.

So for that we need some state describing what locks are held that we can refer
to when taking the next lock of this class - and since it's got to be shared
between the dio write path and then (via gup()) the fault handler, that means
it's pretty much going to have to hang off of task struct. Then in the fault
handler, when we go to take the map lock we:
 - return -EFAULT if it's the same lock the dio write path took
 - trylock; if that fails and lock ordering is wrong (pointer comparison of the
   locks works here) then we have to do a dance that involves bailing out and
   retrying from the top of the dio write path.

I dunno. On the plus side, if other filesystems don't want this I think this can
all be implemented in bcachefs code with only a pointer added to task_struct to
hang this lock state, but I would much rather either get buy in from the other
filesystem people and make this a general purpose facility or not do it at all.

And I'm not sure if anyone else cares about the page cache consistency issues
inherent to dio writes as much as I do... so I'd like to hear from other people
on that.
