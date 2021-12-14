Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF29474408
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 14:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbhLNN7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 08:59:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232428AbhLNN7I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:59:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639490347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m/5pRcl9h3yj8MAkqvRPCHvPcL0c1vkmrKvq7UUnKBk=;
        b=R3Pf0BtheeKCR+6DQSyWJYaEe4fbm54u+afSsZqD8yWyWP0PptSLbc90j0aBv1rbRkpBqr
        fV+lHDJzyENjvDJoW5BjuykfC4VW1hTtJSHQl7dI9bnRCxTQzh2kPA0eTkNaZPAN+Id1Oa
        0pDAhTOYKzR3UlEmF7pQyMadKJzDpUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-0kDh8FCsOqi2t6NYQJXz-g-1; Tue, 14 Dec 2021 08:59:04 -0500
X-MC-Unique: 0kDh8FCsOqi2t6NYQJXz-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA20F1966320;
        Tue, 14 Dec 2021 13:59:01 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25B375BE02;
        Tue, 14 Dec 2021 13:59:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A5F242233DF; Tue, 14 Dec 2021 08:59:00 -0500 (EST)
Date:   Tue, 14 Dec 2021 08:59:00 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 5/5] dax: always use _copy_mc_to_iter in dax_copy_to_iter
Message-ID: <YbijJOjhLAwvyNag@redhat.com>
References: <20211209063828.18944-1-hch@lst.de>
 <20211209063828.18944-6-hch@lst.de>
 <YbNejVRF5NQB0r83@redhat.com>
 <CAPcyv4i_HdnMcq6MmDMt-a5p=ojh_vsoAiES0vUYEh7HvC1O-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4i_HdnMcq6MmDMt-a5p=ojh_vsoAiES0vUYEh7HvC1O-A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 12, 2021 at 06:48:05AM -0800, Dan Williams wrote:
> On Fri, Dec 10, 2021 at 6:05 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Thu, Dec 09, 2021 at 07:38:28AM +0100, Christoph Hellwig wrote:
> > > While using the MC-safe copy routines is rather pointless on a virtual device
> > > like virtiofs,
> >
> > I was wondering about that. Is it completely pointless.
> >
> > Typically we are just mapping host page cache into qemu address space.
> > That shows as virtiofs device pfn in guest and that pfn is mapped into
> > guest application address space in mmap() call.
> >
> > Given on host its DRAM, so I would not expect machine check on load side
> > so there was no need to use machine check safe variant.
> 
> That's a broken assumption, DRAM experiences multi-bit ECC errors.
> Machine checks, data aborts, etc existed before PMEM.

So we should use MC safe variant when loading from DRAM as well?
(If needed platoform support is there).

Vivek

