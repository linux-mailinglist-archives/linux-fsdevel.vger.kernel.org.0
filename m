Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5ABA7470
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 22:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfICUNs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 16:13:48 -0400
Received: from a9-36.smtp-out.amazonses.com ([54.240.9.36]:59984 "EHLO
        a9-36.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbfICUNr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1567541625;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=3CTlLgcwUNm+oBDTSqVhwT6v0ROJvSsfzOlbmJ233Hs=;
        b=Cn915KxoRAOo3PmJZOOm/ld4evNzr6pLGhw1L27Pj4A6Fs/aZr4YyJgWGbjjuYtj
        jeVgNkAMHrsCuy8IfzOPqbjM31SPPbl46ewrDDjxMgWc5IdaUb6qSn4OWC/M8d9fnKh
        6hQcvnAzb8uFmTKLv3L+pNjqUii1U+7KYP92y6TI=
Date:   Tue, 3 Sep 2019 20:13:45 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Matthew Wilcox <willy@infradead.org>
cc:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
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
In-Reply-To: <20190901005205.GA2431@bombadil.infradead.org>
Message-ID: <0100016cf8c3033d-bbcc9ba3-2d59-4654-a7c2-8ba094f8a7de-000000@email.amazonses.com>
References: <20190826111627.7505-1-vbabka@suse.cz> <20190826111627.7505-3-vbabka@suse.cz> <0100016cd98bb2c1-a2af7539-706f-47ba-a68e-5f6a91f2f495-000000@email.amazonses.com> <20190828194607.GB6590@bombadil.infradead.org> <20190829073921.GA21880@dhcp22.suse.cz>
 <0100016ce39e6bb9-ad20e033-f3f4-4e6d-85d6-87e7d07823ae-000000@email.amazonses.com> <20190901005205.GA2431@bombadil.infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.09.03-54.240.9.36
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 31 Aug 2019, Matthew Wilcox wrote:

> > The current behavior without special alignment for these caches has been
> > in the wild for over a decade. And this is now coming up?
>
> In the wild ... and rarely enabled.  When it is enabled, it may or may
> not be noticed as data corruption, or tripping other debugging asserts.
> Users then turn off the rare debugging option.

Its enabled in all full debug session as far as I know. Fedora for
example has been running this for ages to find breakage in device drivers
etc etc.

> > If there is an exceptional alignment requirement then that needs to be
> > communicated to the allocator. A special flag or create a special
> > kmem_cache or something.
>
> The only way I'd agree to that is if we deliberately misalign every
> allocation that doesn't have this special flag set.  Because right now,
> breakage happens everywhere when these debug options are enabled, and
> the very people who need to be helped are being hurt by the debugging.

That is customarily occurring for testing by adding "slub_debug" to the
kernel commandline (or adding debug kernel options) and since my
information is that this is done frequently (and has been for over a
decade now) I am having a hard time believing the stories of great
breakage here. These drivers were not tested with debugging on before?
Never ran with a debug kernel?
