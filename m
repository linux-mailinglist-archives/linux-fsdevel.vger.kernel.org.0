Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D27B369837
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 19:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhDWRXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 13:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhDWRXo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 13:23:44 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E86BC06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Apr 2021 10:23:07 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d6so18660209qtx.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Apr 2021 10:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ab9jbz5NwGYvcWYzomBqApXdriLZ2AGZKnvLPb80Lgs=;
        b=M88KIhhroqFdlNzBy1544DT7e2YEw9mbFHH30yeXQKwC6vbDM49367m9NJ573gXn6b
         fpGXo25Pw/E/tc2chnR7vMVy/f9qg4dnq2G7z/dF5NMXj2Olh2noyPDUZshmLsuJopno
         5cEWSCvSwG4hB5yoW+uHA5KqvLk4AfMXksRvqh408+FGsItAKv5soCRXegR7z+KPWgAK
         unaifcX3LCr+yWUoKVpWklJ8tEnm7w3FNNuywP9KYILwfAFvi9WH4fOSiS3UoSBjqieX
         36JdZug4uP0YfUDRvdBAQWDzpPzRij6QBdNnMdOifYTRMKeSrJ1GxUYGZ+7q2E4fND9b
         rDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ab9jbz5NwGYvcWYzomBqApXdriLZ2AGZKnvLPb80Lgs=;
        b=smgxwjdimXaHrarqDuWGNRMbbyfwEnajTXNGeKTBuFoVXM76Rmm/B+SJ1ckjSTM7tk
         X5cY1nDUPYnPYjYIcKFooIRE+T1w5Di/q+NQFMbknmsNET3NzeOBMmMKC8EzDnasd8XT
         viStaHfzmF4Mpaf6IDy3u1PhI/1tXtp/z2m+/7c+7BeO9UbLwgRqnSWvqkUz9vr1280c
         3oSnxoma4lBntDxnZlXZ+TSdduVdHNYLYpO4UDg3uauuxuTJ5DE32tWzlleZkP/OuEDw
         VQPVwYgs2BOoGZO7casB3AKCk8gcVUgfJTrRk0dT/X2hUCAxmrQalrX7idJN9g1I/Z1s
         jd8w==
X-Gm-Message-State: AOAM532Bov2hkymoYIg2KWYQnNVR1UDWTCx1x/ylF3h9ZzigMffpgjFM
        1Mu3z/KwdWa/rGHNBK828utQyw==
X-Google-Smtp-Source: ABdhPJyhg1NrKyy0mU3GPwfYJ3XT8v6NxDjIEhss5wsoThfwS9AzwafUUTLOgb402Lq554oXOMhYBQ==
X-Received: by 2002:ac8:6b49:: with SMTP id x9mr4808960qts.193.1619198586081;
        Fri, 23 Apr 2021 10:23:06 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x85sm4852092qkb.44.2021.04.23.10.23.04
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 23 Apr 2021 10:23:05 -0700 (PDT)
Date:   Fri, 23 Apr 2021 10:22:51 -0700 (PDT)
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
In-Reply-To: <20210422160410.e9014b38b843d7a6ec06a9bb@linux-foundation.org>
Message-ID: <alpine.LSU.2.11.2104231009520.18646@eggly.anvils>
References: <alpine.LSU.2.11.2104211723580.3299@eggly.anvils> <alpine.LSU.2.11.2104211737410.3299@eggly.anvils> <20210422011631.GL3596236@casper.infradead.org> <alpine.LSU.2.11.2104212253000.4412@eggly.anvils> <alpine.LSU.2.11.2104221338410.1170@eggly.anvils>
 <alpine.LSU.2.11.2104221347240.1170@eggly.anvils> <20210422160410.e9014b38b843d7a6ec06a9bb@linux-foundation.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 22 Apr 2021, Andrew Morton wrote:
> On Thu, 22 Apr 2021 13:48:57 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
> 
> > Andrew, I'd have just sent a -fix.patch to remove the unnecessary u64s,
> > but need to reword the commit message: so please replace yesterday's
> > mm-filemap-fix-mapping_seek_hole_data-on-thp-32-bit.patch
> > by this one - thanks.
> 
> Actually, I routinely update the base patch's changelog when queueing a -fix.

And thank you for that, but if there's time, I think we would still
prefer the final commit message to include corrections where Matthew
enlightened me (that "sign-extension" claim came from my confusion):

-u64 casts added to stop unfortunate sign-extension when shifting (and
-let's use shifts throughout, rather than mixed with * and /).
-
-Use round_up() when advancing pos, to stop assuming that pos was already
-THP-aligned when advancing it by THP-size.  (But I believe this use of
-round_up() assumes that any THP must be THP-aligned: true while tmpfs
-enforces that alignment, and is the only fs with FS_THP_SUPPORT; but might
-need to be generalized in the future?  If I try to generalize it right
-now, I'm sure to get it wrong!)
+u64 cast to stop losing bits when converting unsigned long to loff_t
+(and let's use shifts throughout, rather than mixed with * and /).
+
+Use round_up() when advancing pos, to stop assuming that pos was
+already THP-aligned when advancing it by THP-size.  (This use of
+round_up() assumes that any THP has THP-aligned index: true at present
+and true going forward, but could be recoded to avoid the assumption.)

Thanks,
Hugh
