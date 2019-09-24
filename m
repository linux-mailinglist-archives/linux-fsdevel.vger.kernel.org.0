Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB5CDBD426
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 23:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409964AbfIXVTf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 17:19:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:58134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406468AbfIXVTf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 17:19:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83BA2AC84;
        Tue, 24 Sep 2019 21:19:32 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] mm, sl[aou]b: guarantee natural alignment for
 kmalloc(power-of-two)
To:     "Darrick J. Wong" <darrick.wong@oracle.com>, dsterba@suse.cz,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-btrfs@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20190826111627.7505-1-vbabka@suse.cz>
 <20190826111627.7505-3-vbabka@suse.cz>
 <df8d1cf4-ff8f-1ee1-12fb-cfec39131b32@suse.cz>
 <20190923171710.GN2751@twin.jikos.cz> <20190923175146.GT2229799@magnolia>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <172b2ed8-f260-6041-5e10-502d1c91f88c@suse.cz>
Date:   Tue, 24 Sep 2019 23:19:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923175146.GT2229799@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/23/19 7:51 PM, Darrick J. Wong wrote:
> On Mon, Sep 23, 2019 at 07:17:10PM +0200, David Sterba wrote:
>> On Mon, Sep 23, 2019 at 06:36:32PM +0200, Vlastimil Babka wrote:
>>> So if anyone thinks this is a good idea, please express it (preferably
>>> in a formal way such as Acked-by), otherwise it seems the patch will be
>>> dropped (due to a private NACK, apparently).
> 
> Oh, I didn't realize  ^^^^^^^^^^^^ that *some* of us are allowed the
> privilege of gutting a patch via private NAK without any of that open
> development discussion incovenience. <grumble>
> 
> As far as XFS is concerned I merged Dave's series that checks the
> alignment of io memory allocations and falls back to vmalloc if the
> alignment won't work, because I got tired of scrolling past the endless
> discussion and bug reports and inaction spanning months.

I think it's a big fail of kmalloc API that you have to do that, and
especially with vmalloc, which has the overhead of setting up page
tables, and it's a waste for allocation requests smaller than page size.
I wish we could have nice things.
