Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C7F38FC51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 10:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhEYIMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 04:12:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:44046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232340AbhEYILC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 04:11:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1621930172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X4K/eFCPs5ZyC3dq4RSvLq5Boc7xvE8slnEIPMBZGpw=;
        b=c1s1plU6q0xrLR+wXrLfQf62Fs8wZWwnwCoO9eX9RbnlSx1ytXiGg2P44Npq03wQ028FsM
        Pgv6/QpacFC/f/qRjUIhAlTYPlbJPDo7MUvqlxT5zDg/PV6Gcp2Al6e1IaSae4vwoLAj9n
        ora26UMWYB1ymnK3BrlQj4iK8b3K/3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1621930172;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X4K/eFCPs5ZyC3dq4RSvLq5Boc7xvE8slnEIPMBZGpw=;
        b=ADAQcDeXbTkMZE5JillIUtK1huQAY3rN8g/TrXwlUJb8X94NEHSD8dKdcBd+3MMfXW6E6n
        Y++137sQrMpl4cBw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CBAC5AEBD;
        Tue, 25 May 2021 08:09:31 +0000 (UTC)
Date:   Tue, 25 May 2021 10:09:27 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Price <steven.price@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Aili Yao <yaoaili@kingsoft.com>, Jiri Bohac <jbohac@suse.cz>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 3/6] fs/proc/kcore: don't read offline sections,
 logically offline pages and hwpoisoned pages
Message-ID: <20210525080922.GA3300@linux>
References: <20210514172247.176750-1-david@redhat.com>
 <20210514172247.176750-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514172247.176750-4-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 14, 2021 at 07:22:44PM +0200, David Hildenbrand wrote:
> Let's avoid reading:
> 
> 1) Offline memory sections: the content of offline memory sections is stale
>    as the memory is effectively unused by the kernel. On s390x with standby
>    memory, offline memory sections (belonging to offline storage
>    increments) are not accessible. With virtio-mem and the hyper-v balloon,
>    we can have unavailable memory chunks that should not be accessed inside
>    offline memory sections. Last but not least, offline memory sections
>    might contain hwpoisoned pages which we can no longer identify
>    because the memmap is stale.
> 
> 2) PG_offline pages: logically offline pages that are documented as
>    "The content of these pages is effectively stale. Such pages should not
>     be touched (read/write/dump/save) except by their owner.".
>    Examples include pages inflated in a balloon or unavailble memory
>    ranges inside hotplugged memory sections with virtio-mem or the hyper-v
>    balloon.
> 
> 3) PG_hwpoison pages: Reading pages marked as hwpoisoned can be fatal.
>    As documented: "Accessing is not safe since it may cause another machine
>    check. Don't touch!"
> 
> Introduce is_page_hwpoison(), adding a comment that it is inherently
> racy but best we can really do.
> 
> Reading /proc/kcore now performs similar checks as when reading
> /proc/vmcore for kdump via makedumpfile: problematic pages are exclude.
> It's also similar to hibernation code, however, we don't skip hwpoisoned
> pages when processing pages in kernel/power/snapshot.c:saveable_page() yet.
> 
> Note 1: we can race against memory offlining code, especially
> memory going offline and getting unplugged: however, we will properly tear
> down the identity mapping and handle faults gracefully when accessing
> this memory from kcore code.
> 
> Note 2: we can race against drivers setting PageOffline() and turning
> memory inaccessible in the hypervisor. We'll handle this in a follow-up
> patch.
> 
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE L3
