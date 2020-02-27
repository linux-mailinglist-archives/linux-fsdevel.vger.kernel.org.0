Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4C051715EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 12:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgB0L2D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 06:28:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:36254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728846AbgB0L2D (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:28:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0AE02ABEF;
        Thu, 27 Feb 2020 11:28:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2FE701E0E88; Thu, 27 Feb 2020 12:27:55 +0100 (CET)
Date:   Thu, 27 Feb 2020 12:27:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 11/16] fanotify: prepare to encode both parent and
 child fid's
Message-ID: <20200227112755.GZ10728@quack2.suse.cz>
References: <20200217131455.31107-1-amir73il@gmail.com>
 <20200217131455.31107-12-amir73il@gmail.com>
 <20200226102354.GE10728@quack2.suse.cz>
 <CAOQ4uxivfnmvXag8+f5wJujqRgp9FW+2_CVD6MSgB40_yb+sHw@mail.gmail.com>
 <20200226170705.GU10728@quack2.suse.cz>
 <CAOQ4uxgW9Jcj_hG639nw=j0rFQ1fGxBHJJz=nHKTPBat=L+mXg@mail.gmail.com>
 <CAOQ4uxih7zhAj6qUp39B_a_On5gv80SKm-VsC4D8ayCrC6oSRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxih7zhAj6qUp39B_a_On5gv80SKm-VsC4D8ayCrC6oSRw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 27-02-20 11:06:18, Amir Goldstein wrote:
> > > So overall I think this would be better. The question is whether the
> > > resulting code will really be more readable. I hope so because the
> > > structures are definitely nicer this way and things belonging logically
> > > together are now together. But you never know until you convert the code...
> > > Would you be willing to try this refactoring?
> >
> > Yes, but I would like to know what you think about the two 6 byte holes
> > Just let that space be wasted for the sake of nicer abstraction?
> > It seems like too much to me.
> >
> 
> What if we unite the fh and name into one struct and keep a 32bit hash of
> fh+name inside?
> 
> This will allow us to mitigate the cost of memcmp of fh+name in merge
> and get rid of objectid in fsnotify_event as you suggested.

I definitely want to get rid of objectid in the long run but I wouldn't
necessarily tie it to this series.

What I had in mind to do for fanotify to speed up merging (in the light of
your report) was to associate a hash with each fanotify event based on
values we care about most (probably store it in the same word as fanotify
event type) and compare based on this hash first. Possibly, we could also
add a small hash table (say 128 entries) to each fanotify group based on this
hash to speed up looking up candidates for merging.

> struct fanotify_fh_name {
>          union {
>                 struct {
>                        u8 fh_type;
>                        u8 fh_len;
>                        u8 name_len;
>                        u32 hash;
>                 };
>                 u64 hash_len;
>         };
>         union {
>                 unsigned char fh[FANOTIFY_INLINE_FH_LEN];
>                 unsigned char *ext_fh;
>         };
>         char name[0];
> };

So based on the above I wouldn't add just name hash to fanotify_fh_name at
this point...

								Honza

> struct fanotify_fid_event {
>         struct fanotify_event fae;
>         __kernel_fsid_t fsid;
>         struct fanotify_fh_name object_fh; /* name is empty */
> };
> 
> struct fanofify_name_event {
>         struct fanotify_fid_event ffe;
>         struct fanotify_fh_name dirent;
> };
> 
> So the only anomaly is that we use struct fanotify_fh_name
> to describe object_fh which never has a name.
> 
> I think we can live with that and trying to beat that would be
> over abstraction.
> 
> Thoughts?
> 
> Thanks,
> Amir.
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
