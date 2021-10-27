Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCC843CCA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 16:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhJ0Or5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 10:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38860 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229618AbhJ0Or5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635345931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PdtiwDdFJI7BaqiiT86SNgpbpQqbtDADrurbkArGQhA=;
        b=QVUSwpt7+Az47LL6kFN1Pg0mK0k6j1GbwyVkvABo+GPHCBhSarYk3VNRDpv4IVWgEqG90V
        FpsDCnVTj/40atM+oCBvycptddcGPfMKqJILLG0E0dZ0qE9bimIzYljGe8a1eCNoMeRDb9
        XF/HYvo8rO+O2mNfL9WWaLoneTzB/Rg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-VcF2jaxgNdyTLWxOpt9QDw-1; Wed, 27 Oct 2021 10:45:27 -0400
X-MC-Unique: VcF2jaxgNdyTLWxOpt9QDw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A65BA1019983;
        Wed, 27 Oct 2021 14:45:25 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.34.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1A275DF35;
        Wed, 27 Oct 2021 14:45:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D847C2204A5; Wed, 27 Oct 2021 10:45:00 -0400 (EDT)
Date:   Wed, 27 Oct 2021 10:45:00 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v5 0/5] fuse,virtiofs: support per-file DAX
Message-ID: <YXll7Ar9zOeA8FHE@redhat.com>
References: <20210923092526.72341-1-jefflexu@linux.alibaba.com>
 <YUzOADZvjv7IczrJ@redhat.com>
 <d2a54a62-d6dc-0e41-694d-7a5f574f0f32@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2a54a62-d6dc-0e41-694d-7a5f574f0f32@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 27, 2021 at 11:42:52AM +0800, JeffleXu wrote:
> 
> Sorry for the late reply, as your previous reply was moved to junk box
> by the algorithm...
> 
> On 9/24/21 2:57 AM, Vivek Goyal wrote:
> > On Thu, Sep 23, 2021 at 05:25:21PM +0800, Jeffle Xu wrote:
> >> This patchset adds support of per-file DAX for virtiofs, which is
> >> inspired by Ira Weiny's work on ext4[1] and xfs[2].
> >>
> >> Any comment is welcome.
> >>
> >> [1] commit 9cb20f94afcd ("fs/ext4: Make DAX mount option a tri-state")
> >> [2] commit 02beb2686ff9 ("fs/xfs: Make DAX mount option a tri-state")
> >>
> >>
> >> [Purpose]
> >> DAX may be limited in some specific situation. When the number of usable
> >> DAX windows is under watermark, the recalim routine will be triggered to
> >> reclaim some DAX windows. It may have a negative impact on the
> >> performance, since some processes may need to wait for DAX windows to be
> >> recalimed and reused then. To mitigate the performance degradation, the
> >> overall DAX window need to be expanded larger.
> >>
> >> However, simply expanding the DAX window may not be a good deal in some
> >> scenario. To maintain one DAX window chunk (i.e., 2MB in size), 32KB
> >> (512 * 64 bytes) memory footprint will be consumed for page descriptors
> >> inside guest, which is greater than the memory footprint if it uses
> >> guest page cache when DAX disabled. Thus it'd better disable DAX for
> >> those files smaller than 32KB, to reduce the demand for DAX window and
> >> thus avoid the unworthy memory overhead.
> >>
> >> Per-file DAX feature is introduced to address this issue, by offering a
> >> finer grained control for dax to users, trying to achieve a balance
> >> between performance and memory overhead.
> >>
> >>
> >> [Note]
> >> When the per-file DAX hint changes while the file is still *opened*, it
> >> is quite complicated and maybe fragile to dynamically change the DAX
> >> state, since dynamic switching needs to switch a_ops atomiclly. Ira
> >> Weiny had ever implemented a so called i_aops_sem lock [3] but
> >> eventually gave up since the complexity of the implementation [4][5][6][7].
> >>
> >> Hence mark the inode and corresponding dentries as DONE_CACHE once the
> >> per-file DAX hint changes, so that the inode instance will be evicted
> >> and freed as soon as possible once the file is closed and the last
> >> reference to the inode is put. And then when the file gets reopened next
> >> time, the new instantiated inode will reflect the new DAX state.
> > 
> > If we don't cache inode (if no fd is open), will it not have negative
> > performance impact. When we cache inodes, we also have all the dax
> > mappings cached as well. So if a process opens the same file again,
> > it gets all the mappings already in place and it does not have
> > to call FUSE_SETUPMAPPING again.
> > 
> 
> What does 'all the dax mappings cached' mean when 'we cache inodes'?
> 
> If the per-file DAX hint indeed changes for a large sized file, with
> quite many page caches or DAX mapping already in the address space, then
> marking it DONT_CACHE means evicting the inode as soon as possible,
> which means flushing the page caches or removing all DAX mappings. When
> the inode is reopened next time, page cache is re-instantiated or
> FUSE_SETUPMAPPING is called again. Then the negative performance impact
> indeed exist in this case.
> 
> But this performance impact only exist when the per-file DAX hint
> changes halfway, that is, the hint suddenly changes after the virtiofs
> has already mounted in the guest.

Ok, got it. I think I saw that in the code. I had assumed that an inode
will always be marked don't cache. That's not the case. It will be
marked don't cache only if inode property changes (from dax to non-dax or
vice-a-versa). That seems fine.

Vivek

