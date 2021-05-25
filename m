Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7224738FC8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 10:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhEYIWO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 04:22:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:34300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhEYIWN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 04:22:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1621930843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=33WehLefsaCs8mzrnxUBokX91qQhEQO8tRtqWO8+uRo=;
        b=t/lQVQ3lCBCGFEeJZbepLGbJ7ZtWPvnIv58iYyPJmu9nlp0PQwgaWqpsE4WhmFubLs4I3k
        w1acVXlUcqMJisu+YxE55jtPcsc9ACG+rotjvUss84r8XzoE6zupOLa8QbzV7V/Ec3ne+k
        /WOhD6VLnZUKRFQYyWRLIJNYsZUAANw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1621930843;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=33WehLefsaCs8mzrnxUBokX91qQhEQO8tRtqWO8+uRo=;
        b=aq8jZKe/CGd0TlTEQ6IRtlA6LXEukQZ/9rkTezLfByteZUnmh7UuVzfA87csX5o/tc48Iy
        FbM4nWnzmGk6v4Cg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3203BAE92;
        Tue, 25 May 2021 08:20:42 +0000 (UTC)
Date:   Tue, 25 May 2021 10:20:36 +0200
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
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 5/6] virtio-mem: use page_offline_(start|end) when
 setting PageOffline()
Message-ID: <20210525082036.GC3300@linux>
References: <20210514172247.176750-1-david@redhat.com>
 <20210514172247.176750-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514172247.176750-6-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 14, 2021 at 07:22:46PM +0200, David Hildenbrand wrote:
> Let's properly use page_offline_(start|end) to synchronize setting
> PageOffline(), so we won't have valid page access to unplugged memory
> regions from /proc/kcore.
> 
> Existing balloon implementations usually allow reading inflated memory;
> doing so might result in unnecessary overhead in the hypervisor, which
> is currently the case with virtio-mem.
> 
> For future virtio-mem use cases, it will be different when using shmem,
> huge pages, !anonymous private mappings, ... as backing storage for a VM.
> virtio-mem unplugged memory must no longer be accessed and access might
> result in undefined behavior. There will be a virtio spec extension to
> document this change, including a new feature flag indicating the
> changed behavior. We really don't want to race against PFN walkers
> reading random page content.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE L3
