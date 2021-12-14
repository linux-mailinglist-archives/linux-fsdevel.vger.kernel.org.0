Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FBE4744C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 15:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhLNOXF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 09:23:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232521AbhLNOXE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639491784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QkYkB6Kf2sa6GjT4KwY+Pd7w7SplqbJNTIRwfEOjpBQ=;
        b=F9ADpoNOFPiVHuqNy0RnqUYfXmMTRxUPbIN/Y8zWzAJcoOmb28Z6OZmNpMgfoC1r3dHTjz
        nM4/fwl3qCy7qenz5Uxl0Am+51Xopug1GaqioA+m43cpe95DyhSA04DGqgFJi5QV+llyJr
        byr93UxSUGqbIpj/IdDyMG4jzRXMrpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-bjU_FyyzOjuDB6MrfzVczw-1; Tue, 14 Dec 2021 09:23:01 -0500
X-MC-Unique: bjU_FyyzOjuDB6MrfzVczw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD3AD801ADC;
        Tue, 14 Dec 2021 14:22:58 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 389FC60C9F;
        Tue, 14 Dec 2021 14:22:43 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 926EA2233DF; Tue, 14 Dec 2021 09:22:42 -0500 (EST)
Date:   Tue, 14 Dec 2021 09:22:42 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
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
Subject: Re: [PATCH 4/5] dax: remove the copy_from_iter and copy_to_iter
 methods
Message-ID: <YbiosqZoG8e6rDkj@redhat.com>
References: <20211209063828.18944-1-hch@lst.de>
 <20211209063828.18944-5-hch@lst.de>
 <YbNhPXBg7G/ridkV@redhat.com>
 <CAPcyv4g4_yFqDeS+pnAZOxcB=Ua+iArK5mqn0iMG4PX6oL=F_A@mail.gmail.com>
 <20211213082318.GB21462@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213082318.GB21462@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 09:23:18AM +0100, Christoph Hellwig wrote:
> On Sun, Dec 12, 2021 at 06:44:26AM -0800, Dan Williams wrote:
> > On Fri, Dec 10, 2021 at 6:17 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > Going forward, I am wondering should virtiofs use flushcache version as
> > > well. What if host filesystem is using DAX and mapping persistent memory
> > > pfn directly into qemu address space. I have never tested that.
> > >
> > > Right now we are relying on applications to do fsync/msync on virtiofs
> > > for data persistence.
> > 
> > This sounds like it would need coordination with a paravirtualized
> > driver that can indicate whether the host side is pmem or not, like
> > the virtio_pmem driver. However, if the guest sends any fsync/msync
> > you would still need to go explicitly cache flush any dirty page
> > because you can't necessarily trust that the guest did that already.
> 
> Do we?  The application can't really know what backend it is on, so
> it sounds like the current virtiofs implementation doesn't really, does it?

Agreed that application does not know what backend it is on. So virtiofs
just offers regular posix API where applications have to do fsync/msync
for data persistence. No support for mmap(MAP_SYNC). We don't offer persistent
memory programming model on virtiofs. That's not the expectation. DAX 
is used only to bypass guest page cache.

With this assumption, I think we might not have to use flushcache version
at all even if shared filesystem is on persistent memory on host. 

- We mmap() host files into qemu address space. So any dax store in virtiofs
  should make corresponding pages dirty in page cache on host and when
  and fsync()/msync() comes later, it should flush all the data to PMEM.

- In case of file extending writes, virtiofs falls back to regular
  FUSE_WRITE path (and not use DAX), and in that case host pmem driver
  should make sure writes are flushed to pmem immediately.

Are there any other path I am missing. If not, looks like we might not
have to use flushcache version in virtiofs at all as long as we are not
offering guest applications user space flushes and MAP_SYNC support.

We still might have to use machine check safe variant though as loads
might generate synchronous machine check. What's not clear to me is
that if this MC safe variant should be used only in case of PMEM or
should it be used in case of non-PMEM as well.

Vivek

