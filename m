Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0472C8E57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 20:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgK3Tqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 14:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgK3Tqp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:46:45 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE107C0613D3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 11:46:05 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id l206so15458244oif.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 11:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=lzfoUfWajb4p4eNOmNvuQscrN072WhSa9bylfU2yzX0=;
        b=hTSPjl64XJLko7MKmjQjMrFqQD4dLlsqADqMsqR+j3i/O/jTAASbFKHNMbwdnvdsxG
         UJZzukjaYm4Ayg5ODgCXo7kBIzIPle5y9CI+Kg0QDNPFnkM+gvFH6a3kk3YxqcjE4PK+
         5Ug7f208kwZgD9lrNpKuOhc3h5tIhD2YRYHrxrNcd5iGfogG4HJ3wUxs7dn6SybwpDDI
         QoCDuivGuqPcKB0Rpts8le3YCMv1xr3gwRxTqgomXagAehDHvGJaMA2BgjzI29OMV144
         Wt2U7BFKpldDf9PtgttIyJVQoDmqVwizngX7QNriPx1R7PxMM84LS0ElqDUgaQD5PwV3
         wPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=lzfoUfWajb4p4eNOmNvuQscrN072WhSa9bylfU2yzX0=;
        b=o6XIUow9lnLRqTuIAlsguZvSt1m6fyvKfFkSvcETsoBrxyDKT+xa244X+fPy0ZS9Cw
         Z63SGHkVWIE2reMRkFZdcOiD4EIyyLLZ1nHmyH5wd9h8z4RG7d+esFOi9rToSg2ol5bC
         /Jp+rItcvDLFQqTHenIEsGCZhFWimAksjzFqrC9bBoGCOD6U+BJHQlhmm/ZJgJnPPt9l
         IgGT5zXbQGo9cPKc8W9vPBEYuvfKcmPoId7WZbVPCKzolYUP4gA2FHwghCtfHgz1F9U9
         DnEGdPuGsunJdriPxE5r2zUJr+RrIIt+gGSbZXKZkhtm+EeLZ1+heEhzOScq0sLgLNWb
         pOmQ==
X-Gm-Message-State: AOAM533tdjb3MKaQM7dbPNgImx0PEvHf3xyvLwYa08j9SK2TnDtDeapF
        4eUjZAZkHt6KoYc4LTbrikOFg6qYARNvAQ==
X-Google-Smtp-Source: ABdhPJzFDs2BTB3DjlhZABlkie1tpUYCKaVrsycFta9dfeVORIayucoUUj+UR4lDvvzwar+7y7I3iQ==
X-Received: by 2002:a05:6808:7cd:: with SMTP id f13mr432496oij.38.1606765564711;
        Mon, 30 Nov 2020 11:46:04 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i4sm9994210oos.31.2020.11.30.11.46.03
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 30 Nov 2020 11:46:04 -0800 (PST)
Date:   Mon, 30 Nov 2020 11:45:46 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Linux-FSDevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Christoph Hellwig <hch@lst.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>, dchinner@redhat.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
In-Reply-To: <20201126200703.GW4327@casper.infradead.org>
Message-ID: <alpine.LSU.2.11.2011301109230.17996@eggly.anvils>
References: <alpine.LSU.2.11.2011160128001.1206@eggly.anvils> <20201117153947.GL29991@casper.infradead.org> <alpine.LSU.2.11.2011170820030.1014@eggly.anvils> <20201117191513.GV29991@casper.infradead.org> <20201117234302.GC29991@casper.infradead.org>
 <20201125023234.GH4327@casper.infradead.org> <20201125150859.25adad8ff64db312681184bd@linux-foundation.org> <CANsGZ6a95WK7+2H4Zyg5FwDxhdJQqR8nKND1Cn6r6e3QxWeW4Q@mail.gmail.com> <20201126121546.GN4327@casper.infradead.org> <alpine.LSU.2.11.2011261101230.2851@eggly.anvils>
 <20201126200703.GW4327@casper.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 26 Nov 2020, Matthew Wilcox wrote:
> On Thu, Nov 26, 2020 at 11:24:59AM -0800, Hugh Dickins wrote:
> 
> > But right now it's the right fix that's important: ack to yours below.
> > 
> > I've not yet worked out the other issues I saw: will report when I have.
> > Rebooted this laptop, pretty sure it missed freeing a shmem swap entry,
> > not yet reproduced, will study the change there later, but the non-swap 
> > hang in generic/476 (later seen also in generic/112) more important.

It's been a struggle, but I do now have a version of shmem_undo_range()
that works reliably, no known bugs, with no changes to your last version
outside of shmem_undo_range().

But my testing so far has been with the initial optimization loop (of
trylocks in find_lock_entries()) "#if 0"ed out, to give the final loop
a harder time. Now I'll bring back that initial loop (maybe cleaning up
some start/end variables) and retest - hoping not to regress as I do so.

I'll send it late today: I expect I'll just send the body of
shmem_undo_range() itself, rather than a diff, since it's too confusing
to know what to diff against.  Or, maybe you now have your own improved
version, and will want me to look at yours rather than sending mine.

Andrew, if you're planning another mmotm soon, please remove/comment
mm-truncateshmem-handle-truncates-that-split-thps.patch
and any of its "fixes" as to-be-updated: all versions to date
have been too buggy to keep, and a new version will require its own
review, as you noted. I think that means you also have to remove
mm-filemap-return-only-head-pages-from-find_get_entries.patch
which I think is blameless, but may depend on it logically.

> 
> The good news is that I've sorted out the SCRATCH_DEV issue with
> running xfstests.  The bad news is that (even on an unmodified kernel),
> generic/027 takes 19 hours to run.  On xfs, it's 4 minutes.  Any idea
> why it's so slow on tmpfs?

I sent a tarball of four xfstests patches on Thursday, they're valid:
but generic/075 and generic/112, very useful for this testing, suffer
from an fsx build bug which might or might not affect you: so I'll now
reply to that mail with latest tarball.

Hugh
