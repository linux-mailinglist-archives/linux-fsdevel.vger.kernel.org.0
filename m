Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC1FA7AAB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 07:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfIDFTi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 01:19:38 -0400
Received: from verein.lst.de ([213.95.11.211]:35930 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfIDFTi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 01:19:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7B64868AEF; Wed,  4 Sep 2019 07:19:33 +0200 (CEST)
Date:   Wed, 4 Sep 2019 07:19:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christopher Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm, sl[aou]b: guarantee natural alignment for
 kmalloc(power-of-two)
Message-ID: <20190904051933.GA10218@lst.de>
References: <20190826111627.7505-1-vbabka@suse.cz> <20190826111627.7505-3-vbabka@suse.cz> <0100016cd98bb2c1-a2af7539-706f-47ba-a68e-5f6a91f2f495-000000@email.amazonses.com> <20190828194607.GB6590@bombadil.infradead.org> <20190829073921.GA21880@dhcp22.suse.cz> <0100016ce39e6bb9-ad20e033-f3f4-4e6d-85d6-87e7d07823ae-000000@email.amazonses.com> <20190901005205.GA2431@bombadil.infradead.org> <0100016cf8c3033d-bbcc9ba3-2d59-4654-a7c2-8ba094f8a7de-000000@email.amazonses.com> <20190903205312.GK29434@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903205312.GK29434@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 01:53:12PM -0700, Matthew Wilcox wrote:
> > Its enabled in all full debug session as far as I know. Fedora for
> > example has been running this for ages to find breakage in device drivers
> > etc etc.
> 
> Are you telling me nobody uses the ramdisk driver on fedora?  Because
> that's one of the affected drivers.

For pmem/brd misaligned memory alone doesn't seem to be the problem.
Misaligned memory that cross a page barrier is.  And at least XFS
before my log recovery changes only used kmalloc for smaller than
page size allocation, so this case probably didn't hit.  But other
cases where alignment and not just not crossing a page boundary
occurred and we had problems with those before.  It just too a long
time for people to root cause them.
