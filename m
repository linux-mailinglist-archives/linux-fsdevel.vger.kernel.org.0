Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 181A718212E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 19:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbgCKSss (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 14:48:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49660 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730755AbgCKSss (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583952527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bMn5VsQsp930KA1I/ZJbWcOCwMA4aqEYv8NsDetmcJU=;
        b=bfzL4Xf1RhiENfzFro8njkWk2a4bJBen8NJbt54tor9E/lg3Nu8BPNDFA+ZIB6X9vW4rGV
        frY+zcz+tlE1DMwH38YGqfio7NRngL2qwOYnEZOz0lF747ThOAy8pgFZnmhvdkrV0Hq+8H
        SeHtL2+XHEu0yMLc/N2DSsCEspoTrZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-ZZQiu4saN3OKau72Vg4fvg-1; Wed, 11 Mar 2020 14:48:40 -0400
X-MC-Unique: ZZQiu4saN3OKau72Vg4fvg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34C161005510;
        Wed, 11 Mar 2020 18:48:39 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 424118F364;
        Wed, 11 Mar 2020 18:48:31 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C3BEB22021D; Wed, 11 Mar 2020 14:48:30 -0400 (EDT)
Date:   Wed, 11 Mar 2020 14:48:30 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>, mst@redhat.com
Subject: Re: [PATCH 00/20] virtiofs: Add DAX support
Message-ID: <20200311184830.GC83257@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <CAOQ4uxi_Xrf+iyP6KVugFgLOfzUvscMr0de0KxQo+jHNBCA9oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi_Xrf+iyP6KVugFgLOfzUvscMr0de0KxQo+jHNBCA9oA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 11, 2020 at 07:22:51AM +0200, Amir Goldstein wrote:
> On Wed, Mar 4, 2020 at 7:01 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > Hi,
> >
> > This patch series adds DAX support to virtiofs filesystem. This allows
> > bypassing guest page cache and allows mapping host page cache directly
> > in guest address space.
> >
> > When a page of file is needed, guest sends a request to map that page
> > (in host page cache) in qemu address space. Inside guest this is
> > a physical memory range controlled by virtiofs device. And guest
> > directly maps this physical address range using DAX and hence gets
> > access to file data on host.
> >
> > This can speed up things considerably in many situations. Also this
> > can result in substantial memory savings as file data does not have
> > to be copied in guest and it is directly accessed from host page
> > cache.
> >
> > Most of the changes are limited to fuse/virtiofs. There are couple
> > of changes needed in generic dax infrastructure and couple of changes
> > in virtio to be able to access shared memory region.
> >
> > These patches apply on top of 5.6-rc4 and are also available here.
> >
> > https://github.com/rhvgoyal/linux/commits/vivek-04-march-2020
> >
> > Any review or feedback is welcome.
> >
> [...]
> >  drivers/dax/super.c                |    3 +-
> >  drivers/virtio/virtio_mmio.c       |   32 +
> >  drivers/virtio/virtio_pci_modern.c |  107 +++
> >  fs/dax.c                           |   66 +-
> >  fs/fuse/dir.c                      |    2 +
> >  fs/fuse/file.c                     | 1162 +++++++++++++++++++++++++++-
> 
> That's a big addition to already big file.c.
> Maybe split dax specific code to dax.c?
> Can be a post series cleanup too.

How about fs/fuse/iomap.c instead. This will have all the iomap related logic
as well as all the dax range allocation/free logic which is required
by iomap logic. That moves about 900 lines of code from file.c to iomap.c

Vivek

