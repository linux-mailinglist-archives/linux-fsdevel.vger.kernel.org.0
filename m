Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5388D369B22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 22:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243957AbhDWUJj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 16:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243874AbhDWUJj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 16:09:39 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE91C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Apr 2021 13:09:00 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id e13so41004264qkl.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Apr 2021 13:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=aK8iz3zm04xOuoxeCmMxLwgvro5ZujIcNZdrYiQYSqw=;
        b=CA/6bq0RQgR39iQYo3JaGJ3rhlMNTFg6Kp52Q9HfsiTEIksa18HN+fGFPH4Vpl9Lih
         VHl3FWjZ5xDxzUyrFLH7zB1fnKywzv5TKjJr3DeKTfyzYo9N6wxpIVpbFGvamk2mNH9l
         bNtBr5OD9aHHaEBZxo3Qsv4zXEQLTXvX0mHYageo00UQXDp3d/abDfjJmMuhHQOx0vIv
         EcUqYxQO7vq78dVd5OlBG0o7MP4T952lErPJut9Kl9OMTHpWUOtdazSW4RyOj2VdlJQn
         k63IbKsCqXPO0f9r8jT4f8/1fPqiCx7GydKYLn9fftipvTZ+EZY3Ftic4v0D3dsQvbEW
         KnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=aK8iz3zm04xOuoxeCmMxLwgvro5ZujIcNZdrYiQYSqw=;
        b=oVpp9nDoCp+rqcCf8l8mBDZAGvigLuqr9K12hm7eeHhXxTx68TZsvOvRKFT5v5aZDr
         JOePsyYjY1jZBPQLHPAnGoofGsoTDU99ELOQyMOraAsKW+faKe1E20C2Thz6EFnrBlh9
         QzRm2+2dvVLhXsPFBblVvWsA3WEsz1LQjKrlGUzFITtXrlgTC4gjK9L7TBVoYi4sOYl7
         t8vB61zQzesJNVbPEBp7rOx9HD9kcS7YtZv4255Zhfy+czhz+YP20AygpNg3xKn56pS0
         V2NQxcI9sENSCQVwwXQzAElfYxdVHMTsSwXhQHVNzS2VU8cgz+l7EUOcVc92GL2ZlXfH
         WY3g==
X-Gm-Message-State: AOAM531/5Giv8QcNwvt7YVSWxJwifbvWiNTIjuWNjiq8JTbQkiDflCWS
        GOzT8v/j3MfBD1qZQsffgrnc7w==
X-Google-Smtp-Source: ABdhPJyh9pNSKDLnATFK2Hm5RgriFDYoCipfaWR58npPvwxnUU+kGd/Y/FkZNtq7A1mgkBx15YVUmg==
X-Received: by 2002:a05:620a:1350:: with SMTP id c16mr5839252qkl.105.1619208539641;
        Fri, 23 Apr 2021 13:08:59 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i127sm5091592qke.71.2021.04.23.13.08.58
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 23 Apr 2021 13:08:59 -0700 (PDT)
Date:   Fri, 23 Apr 2021 13:08:43 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dchinner@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] mm/filemap: fix mapping_seek_hole_data on THP &
 32-bit
In-Reply-To: <20210423122940.26829dc784a4b6546349dac5@linux-foundation.org>
Message-ID: <alpine.LSU.2.11.2104231302530.19649@eggly.anvils>
References: <alpine.LSU.2.11.2104211723580.3299@eggly.anvils> <alpine.LSU.2.11.2104211737410.3299@eggly.anvils> <20210422011631.GL3596236@casper.infradead.org> <alpine.LSU.2.11.2104212253000.4412@eggly.anvils> <alpine.LSU.2.11.2104221338410.1170@eggly.anvils>
 <alpine.LSU.2.11.2104221347240.1170@eggly.anvils> <20210422160410.e9014b38b843d7a6ec06a9bb@linux-foundation.org> <alpine.LSU.2.11.2104231009520.18646@eggly.anvils> <20210423122940.26829dc784a4b6546349dac5@linux-foundation.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 23 Apr 2021, Andrew Morton wrote:
> On Fri, 23 Apr 2021 10:22:51 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
> > On Thu, 22 Apr 2021, Andrew Morton wrote:
> > > On Thu, 22 Apr 2021 13:48:57 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
> > > 
> > > > Andrew, I'd have just sent a -fix.patch to remove the unnecessary u64s,
> > > > but need to reword the commit message: so please replace yesterday's
> > > > mm-filemap-fix-mapping_seek_hole_data-on-thp-32-bit.patch
> > > > by this one - thanks.
> > > 
> > > Actually, I routinely update the base patch's changelog when queueing a -fix.
> > 
> > And thank you for that, but if there's time, I think we would still
> > prefer the final commit message to include corrections where Matthew
> > enlightened me (that "sign-extension" claim came from my confusion):
> 
> That's my point.  When I merge a -v2 as a -fix, I replace the v1
> patch's changelog with v2's changelog so everything works out after
> folding.

Oh, great, thanks: that was not clear to me, I feared you meant adding
"v2: remove unneeded u64 casts" to v1 when merging.

Hugh
