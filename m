Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB9340EB7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 22:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbhIPUR5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 16:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhIPURw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 16:17:52 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1904CC061574;
        Thu, 16 Sep 2021 13:16:31 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id m21so10287792qkm.13;
        Thu, 16 Sep 2021 13:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EnmtHDIgEU5AIyAVvTub3Y0dA33iDlqEv0u4PQic5Jo=;
        b=lfBlWu94PetKCzbXPYqsSJAD5UXFZ1Cv6XGtXDueSN8sctCBHHvlYlG9e+djmQVo7V
         vc7i00QAwoF2TifDGiYiNobLh2TMDxxXOS2g+8DRGt13tNv63/oWJtTU86bdur6/PrKk
         sJ89Q3dx7FcmKBfAThlBwm3TeuyAk6EiNvv5qbso7GzrMpvlsu3ILKIqPRfEwe0wcg6v
         4uAoQp3mAT/K+yMeEN7MFTQur02Sz0E5AITfflpWEnBdXfco1ukkMvNQYK3G4swXyUXR
         VKThCIJ1yrBd6GEQNDqWX9Ibx3hVtX0tOvvoY8st7lqNLyTW0ITXj7lIdkQ+9T1t1L7/
         ieeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EnmtHDIgEU5AIyAVvTub3Y0dA33iDlqEv0u4PQic5Jo=;
        b=t3Kl64RNAZXwzv4QGKN/cvTYLu2yWVoMtYCpaSN5ZA4vuHYHnq0gzFqrvTdEwmbwcN
         s5abGE/Q+AzCw45wo/xsgWptZTCn8+VygwDtnQtVgyMXeEt+HvobOoF7GlUx4M9yl5IL
         g4Gjy5MLBA6RE7M9w/0xzvc2+jlhCesYI2Rcwo3IMs251Pho5p9DO9+wzLIGDpAaa9Qo
         mOA/zwoFUhzyDn0L52YW2zxHcei2Z9X+nSBnHeN6W/1xIxSB73WZjbi5tAroaDAetfMz
         NJBhLLS6/zkdUULVv+6R1wWSnWglKUKfhU4xW2OeL5u+SvVPGtqaB1lLXl340n/WG2AH
         5O/A==
X-Gm-Message-State: AOAM532QKxK6p5roy0kwVGqES3xrNY5XE3SwCsBobSPLLXENKd0iqXpb
        WtJXOWwPT4XuqDu79QtrPg==
X-Google-Smtp-Source: ABdhPJyxLMWlNQt4t1JYmMy92Wyl/4WjbhUidFiBXHL48J3CwY9R/9y1OYCe/YrWySQCmTa61dSkVw==
X-Received: by 2002:a37:f610:: with SMTP id y16mr6780165qkj.518.1631823390127;
        Thu, 16 Sep 2021 13:16:30 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id p22sm3125543qkj.16.2021.09.16.13.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 13:16:29 -0700 (PDT)
Date:   Thu, 16 Sep 2021 16:16:27 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>
Subject: Re: [MAINTAINER SUMMIT] Folios as a potential Kernel/Maintainers
 Summit topic?
Message-ID: <YUOmG+qNxAxI9Kyn@moria.home.lan>
References: <YUIwgGzBqX6ZiGgk@mit.edu>
 <f7b70227bac9a684320068b362d28fcade6b65b9.camel@HansenPartnership.com>
 <YUI5bk/94yHPZIqJ@mit.edu>
 <17242A0C-3613-41BB-84E4-2617A182216E@fb.com>
 <f066615c0e2c6fe990fa5c19dd1c17d649bcb03a.camel@HansenPartnership.com>
 <E655F510-14EB-4F40-BCF8-C5266C07443F@fb.com>
 <33a2000f56d51284e2df0cfcd704e93977684b59.camel@HansenPartnership.com>
 <YUOX0VxkO+/1kT7u@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUOX0VxkO+/1kT7u@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 16, 2021 at 03:15:29PM -0400, Theodore Ts'o wrote:
> On Thu, Sep 16, 2021 at 01:11:21PM -0400, James Bottomley wrote:
> > 
> > Actually, I don't see who should ack being an unknown.  The MAINTAINERS
> > file covers most of the kernel and a set of scripts will tell you based
> > on your code who the maintainers are ... that would seem to be the
> > definitive ack list.
> 
> It's *really* not that simple.  It is *not* the case that if a change
> touches a single line of fs/ext4 (as well as 60+ other filesystems),
> for example:
> 
> -       ei = kmem_cache_alloc(ext4_inode_cachep, GFP_NOFS);
> +       ei = alloc_inode_sb(sb, ext4_inode_cachep, GFP_NOFS);
> 
> that the submitter *must* get a ACK from me --- or that I am entitled
> to NACK the entire 79 patch series for any reason I feel like, or to
> withhold my ACK as hostage until the submitter does some development
> work that I want.
> 
> What typically happens is if someone were to try to play games like
> this inside, say, the Networking subsystem, past a certain point,
> David Miller will just take the patch series, ignoring people who have
> NACK's down if they can't be justified.  The difference is that even
> though Andrew Morton (the titular maintainer for all of Memory
> Management, per the MAINTAINERS file), Andrew seems to have a much
> lighter touch on how the mm subsystem is run.
> 
> > I think the problem is the ack list for features covering large areas
> > is large and the problems come when the acker's don't agree ... some
> > like it, some don't.  The only deadlock breaking mechanism we have for
> > this is either Linus yelling at everyone or something happening to get
> > everyone into alignment (like an MM summit meeting).  Our current model
> > seems to be every acker has a foot on the brake, which means a single
> > nack can derail the process.  It gets even worse if you get a couple of
> > nacks each requesting mutually conflicting things.
> > 
> > We also have this other problem of subsystems not being entirely
> > collaborative.  If one subsystem really likes it and another doesn't,
> > there's a fear in the maintainers of simply being overridden by the
> > pull request going through the liking subsystem's tree.  This could be
> > seen as a deadlock breaking mechanism, but fear of this happening
> > drives overreactions.
> > 
> > We could definitely do a clear definition of who is allowed to nack and
> > when can that be overridden.
> 
> Well, yes.  And this is why I think there is a process issue here that
> *is* within the MAINTAINERS SUMMIT purview, and if we need to
> technical BOF to settle the specific question of what needs to happen,
> whether it happens at LPC, or it needs to happen after LPC, then let's
> have it happen.

I would love to see us putting our energy into trying to have more productive
design discussions instead of getting more rules based. If someone feels
strongly enough to NACK a patch series, usually that's an indication of a
breakdown in communications and it means we need to put more effort into
figuring out what the real disagreement is. It's not like people usually NACK
things just to be petty - and if they are, that becomes apparent when we try to
communicate them to find out what the disagreement is and they don't respond
with the same effort.

And if people aren't being petty and are making a genuine effort to communicate
well and we're still not reaching a consensus - that does happen and there most
definitely are times when we just have differences of opinion and technical
judgement, and the maintainer will have to come to a decision. But before that
happens, we should make sure we've actually had a productive effective
discussion and figured out what those concerns and differences of opinion are,
so that the maintainer can make an _informed_ decision.

> I'd be really disappointed if we have to wait until December 2022 for
> the next LSF/MM, and if we don't get consensus there, ala DAX, that we
> then have to wait until late 2023, etc.  As others have said, this is
> holding up some work that file system developers would really like to
> see.

So I think we're still trying to answer the "what exactly is a folio" question.
As I see it, there's two potential approaches:

 - The minimalist approach, where folios are just pagecache pages

 - The maximalist approach, where folios are also anonymous pages. Potentially
   all pages that could be mapped into userspace would be folios, possibly with
   some work to unify weird driver things.

Network pages, slab pages aren't folios - they're their own thing. Folios are
also not a replacement for compound pages. Whichever way we go, folios are for
things that can be mapped into userspace.

Also: folios are a start on cutting up the unholy mess that is struct page into
separate data types. In struct page, we have a big nested union of structs, for
different types of pages. As I understand it from perusing the code, Willy has
been basically taking the approach of turning the first struct in the big
union-of-structs and (mostly?) making everything that uses that a folio.

I think that is reasonable, because it's basically adding types to describe the
world as it is - I would say that if it leaves things looking like a mess with
confused module boundaries between MM and FS, that's because the code was
already a mess, and while we should certainly work on cleaning that up those
cleanups shouldn't be done in _this_ giant patch series because that's how you
end up with bugs that you can't bisect.

However, Johannes has been pointing out that it's a real open question as to
whether anonymous pages should be folios! Willy's current code seems to leave
things in a somewhat intermediate state - some mm/ code treats anonymous pages
as folios, but it's not clear to me how much. And I still see a lot of
references to page->mapping; we should be clear on what's happening to those (if
the page is a folio, we should definitely not be referencing page->mapping or
page->index).

So: should anonymous pages be more like file pages? I think that's something
worth exploring, and potentially a lot of code could be unified and deleted with
that approach - a lot of the hugepage/transhuge code is doing similar stuff as
folios, but folios look to be doing it much cleaner. There's also things like
rmap.c, which is constantly asking is this page anonymous? is it file? and doing
different things that look somewhat similar (also KSM, but that's a whole nother
bag of crazy). Johannes things that anonymous pages differ too much from file
pages and that trying to unify them would be a mistake - perhaps he's right.
Perhaps we should create a new type analogous to folio for those pages - if all
the current places in the code where we're asking "Is this file? Is this anon?"
really do need to be doing that, then having our types match makes sense.
