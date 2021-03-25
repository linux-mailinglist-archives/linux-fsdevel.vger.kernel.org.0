Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361CA34929F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 14:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhCYNDU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 09:03:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49047 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230248AbhCYNCt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616677368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FwWZJPBaAmN+VY9ozn1oVCEcu1CBKTJa99Q0BFn4OQI=;
        b=cGOygGXRS+CClPZ+WJnCEx98dFdpRMQmbSydrbGYRWZzzulIroljQSp5zqVMZ58/BUnzVw
        1oWYuFoaNQtkQ0jy/Cwb563sitLjEScI7p89ihFihD5Avo8z33PLj3AVcy6WuW5YTPhiJO
        k/zBwZo7LwT9zapsriTxXVjMI5ndVio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-t0Ss08QpONaeHfc-Em4w5Q-1; Thu, 25 Mar 2021 09:02:43 -0400
X-MC-Unique: t0Ss08QpONaeHfc-Em4w5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84AEE801817;
        Thu, 25 Mar 2021 13:02:40 +0000 (UTC)
Received: from [10.36.115.72] (ovpn-115-72.ams2.redhat.com [10.36.115.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7EE25D9CA;
        Thu, 25 Mar 2021 13:02:35 +0000 (UTC)
To:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org
Cc:     Ira Weiny <ira.weiny@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH 0/3] mm, pmem: Force unmap pmem on surprise remove
Message-ID: <22545105-d3f1-23b1-948c-8481af839f21@redhat.com>
Date:   Thu, 25 Mar 2021 14:02:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18.03.21 05:08, Dan Williams wrote:
> Summary:
> 
> A dax_dev can be unbound from its driver at any time. Unbind can not
> fail. The driver-core will always trigger ->remove() and the result from
> ->remove() is ignored. After ->remove() the driver-core proceeds to tear
> down context. The filesystem-dax implementation can leave pfns mapped
> after ->remove() if it is triggered while the filesystem is mounted.
> Security and data-integrity is forfeit if the dax_dev is repurposed for
> another security domain (new filesystem or change device modes), or if
> the dax_dev is physically replaced. CXL is a hotplug bus that makes
> dax_dev physical replace a real world prospect.
> 
> All dax_dev pfns must be unmapped at remove. Detect the "remove while
> mounted" case and trigger memory_failure() over the entire dax_dev
> range.
> 
> Details:
> 
> The get_user_pages_fast() path expects all synchronization to be handled
> by the pattern of checking for pte presence, taking a page reference,
> and then validating that the pte was stable over that event. The
> gup-fast path for devmap / DAX pages additionally attempts to take/hold
> a live reference against the hosting pgmap over the page pin. The
> rational for the pgmap reference is to synchronize against a dax-device
> unbind / ->remove() event, but that is unnecessary if pte invalidation
> is guaranteed in the ->remove() path.
> 
> Global dax-device pte invalidation *does* happen when the device is in
> raw "device-dax" mode where there is a single shared inode to unmap at
> remove, but the filesystem-dax path has a large number of actively
> mapped inodes unknown to the driver at ->remove() time. So, that unmap
> does not happen today for filesystem-dax. However, as Jason points out,
> that unmap / invalidation *needs* to happen not only to cleanup
> get_user_pages_fast() semantics, but in a future (see CXL) where dax_dev
> ->remove() is correlated with actual physical removal / replacement the
> implications of allowing a physical pfn to be exchanged without tearing
> down old mappings are severe (security and data-integrity).
> 
> What is not in this patch set is coordination with the dax_kmem driver
> to trigger memory_failure() when the dax_dev is onlined as "System
> RAM". The remove_memory() API was built with the assumption that
> platform firmware negotiates all removal requests and the OS has a
> chance to say "no". This is why dax_kmem today simply leaks
> request_region() to burn that physical address space for any other
> usage until the next reboot on a manual unbind event if the memory can't
> be offlined. However a future to make sure that remove_memory() succeeds
> after memory_failure() of the same range seems a better semantic than
> permanently burning physical address space.

I'd have similar requirements for virtio-mem on forced driver unloading 
(although less of an issue, because in contrast to cxl, it doesn't 
really happen in sane environments). However, I'm afraid there are 
absolutely no guarantees that you can actually offline+rip out memory 
exposed to the buddy, at least in the general case.

I guess it might be possible to some degree if memory was onlined to 
ZONE_MOVABLE (there are still no guarantees, though), however, bets are 
completely off with ZONE_NORMAL. Just imagine the memmap of one dax 
device being allocated from another dax device. You cannot possibly 
invalidate via memory_failure() and rip out the memory without crashing 
the whole system afterwards.

-- 
Thanks,

David / dhildenb

