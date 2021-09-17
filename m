Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B7740F182
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 06:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244752AbhIQFAO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 01:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhIQFAO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 01:00:14 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD056C061574;
        Thu, 16 Sep 2021 21:58:52 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g11so7771395qtk.5;
        Thu, 16 Sep 2021 21:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RSETynYAaWok9lyPkYvwwM94kyTjrnU1juJzOUQ8/Ug=;
        b=NunvM/6Wbbyifoo1x2DoS8ywUoYMV7Ef2gqEsZwJpIrZliHOL7Ch7d3hhu3RKN2htf
         ErJmoucdcDqIUBkfqQ5q8335G40t7FCKEGMKvv0OpiQrbAtTXmVQ+LNvDFL1kAg4xHUU
         F3PHosOc7kxFEyl+fJZvEAzUcbDADZs2EbcAXu5bgkEHccQzlYCEK3OVRu1emmHyZmnT
         /LtFHPdg1p/st0PUObAgAWOe3G9GKpLZ1yA7OjRvizom+rL441NTW0a+w+TCh9gv8qnW
         mfRrvLZGtXfro1jUlztAJY4Bnj+zhtha8z71CHUCfcstfujQ5BzLKy64xBkAvM3cPXYA
         GPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RSETynYAaWok9lyPkYvwwM94kyTjrnU1juJzOUQ8/Ug=;
        b=4OEI2cgzBhHWnuldDpuPiLUQi+gGLDwV8emGaZIrnqYD67yp3htoODo1u2IOhUitNn
         wWKoqifXxFG7rPDsLf+8tC/pdXpXfb8yOApvw1Eka9lJecnqglPFhKY+hclmjhF5594i
         8ZtOBEZ3hSy6xw3Rx1Yt68Rzoeapuwf0vawihqhO7YuAyengj/z+fNL4DJXSCFfJUBTF
         Igc3TkN/xVHYszYSpHKDKqb1KkiJlEDKkzZH9GNxqGtCBlRBIVFLfeTk8/XK+nSc6/o7
         zUvAX9s13CWHG9cZyuaYYsdbEVfBsw3+8jARjVbhjvOhd2ZFXbngZj9cj1Jvxr/RxE/u
         L2Mg==
X-Gm-Message-State: AOAM533bpuUN5GciQzas3s3ExnJHX/hC8ONfPJdypAyMVU2O85w+zzZu
        oiCbKiemLtkH10zKlRwPYA==
X-Google-Smtp-Source: ABdhPJw6JWEXhbwhWdB/W/tXio2pi7htD4NuLH/7NvepOVgP4ZPM+X79LJn2/sc8YA3yBZAHB2arxg==
X-Received: by 2002:ac8:5710:: with SMTP id 16mr8329969qtw.393.1631854731874;
        Thu, 16 Sep 2021 21:58:51 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id x9sm4059552qko.125.2021.09.16.21.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 21:58:50 -0700 (PDT)
Date:   Fri, 17 Sep 2021 00:58:48 -0400
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
Message-ID: <YUQgiLD5axq4CTEp@moria.home.lan>
References: <YUIwgGzBqX6ZiGgk@mit.edu>
 <f7b70227bac9a684320068b362d28fcade6b65b9.camel@HansenPartnership.com>
 <YUI5bk/94yHPZIqJ@mit.edu>
 <17242A0C-3613-41BB-84E4-2617A182216E@fb.com>
 <f066615c0e2c6fe990fa5c19dd1c17d649bcb03a.camel@HansenPartnership.com>
 <E655F510-14EB-4F40-BCF8-C5266C07443F@fb.com>
 <33a2000f56d51284e2df0cfcd704e93977684b59.camel@HansenPartnership.com>
 <YUOX0VxkO+/1kT7u@mit.edu>
 <YUOmG+qNxAxI9Kyn@moria.home.lan>
 <YUPyfWKG3CG8+zkn@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUPyfWKG3CG8+zkn@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 16, 2021 at 09:42:21PM -0400, Theodore Ts'o wrote:
> On Thu, Sep 16, 2021 at 04:16:27PM -0400, Kent Overstreet wrote:
> > So I think we're still trying to answer the "what exactly is a folio"
> > question....
> 
> > However, Johannes has been pointing out that it's a real open
> > question as to whether anonymous pages should be folios! Willy's
> > current code seems to leave things in a somewhat intermediate state
> > - some mm/ code treats anonymous pages as folios, but it's not clear
> > to me how much....
> 
> Kent, you raise some good questions, and good points.  However, it
> seems to me that one of the other sources of the disagreement is the
> question of whether this question needs to be answered at all before
> the Folios patch can get merged.

...

> It seems that part of the frustration is that people seem to agree
> that Folios does make things better, and yet they *still* are NACK'ing
> the patch series.  The argument for why it should not be merged yet
> seems to be that it should be doing *more* --- that it doesn't go far
> enough.

Yeah, I agree 100%, and I've expressed my own frustrations with how the folios
discussions have been going (and I could, and will, express some more of those
frustrations - later).

But, that's water under the bridge. For now, I'm really just trying to drive the
technical discussion. I'm not Andrew or Linus, it's not my say whether folios
get merged, I'm just trying to dig to figure out what the _actual_ technical
points of contention are (and it's taken some real digging...)

And having done so, I think the question of whether or not anonymous pages are
becoming folios actually is extremely cogent - I think there's a lot of meat to
that discussion, and it definitely impacts _squarely_ in MM internals land.

So, let's just try to be more forward looking, try to forget the acrimony, and
get into that discussion, and remember that we'll all be having beers with each
other whenever the fsck LSF actually happens again.
