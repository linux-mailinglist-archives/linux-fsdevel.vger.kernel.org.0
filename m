Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D1638FC7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 10:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhEYISD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 04:18:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:56944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhEYISB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 04:18:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1621930591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cBTpb8oJt9glxSCHDQUwIyXY+s7ZBCa51c0d2hwY7nc=;
        b=EczqhsS4/Xi3ikRA8F8oPMZV5MYYAX6lPTn7KdzPl6WKUo7l+wWnC/B0mSH22rgXmtA055
        kbLbdsKFvk65GV0LQe4n+vLdoQpePZu/j3Z4wWLqjiznCeXoRbgJ2pokf81wy9ezABhoY8
        FBdCmL9X+POMWP7GrVxBuomgcWzVcoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1621930591;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cBTpb8oJt9glxSCHDQUwIyXY+s7ZBCa51c0d2hwY7nc=;
        b=5LG/R/yAUM5v9t0s1VF4gwLYCBRdG0N9ggk+VBmXNocCPcVfvBwWckPOqjt4TIl5jBI+pv
        nAJF0QhPxrXz9NCQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1C9ACAE1F;
        Tue, 25 May 2021 08:16:31 +0000 (UTC)
Date:   Tue, 25 May 2021 10:16:26 +0200
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
Subject: Re: [PATCH v2 4/6] mm: introduce
 page_offline_(begin|end|freeze|thaw) to synchronize setting PageOffline()
Message-ID: <20210525081626.GB3300@linux>
References: <20210514172247.176750-1-david@redhat.com>
 <20210514172247.176750-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514172247.176750-5-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 14, 2021 at 07:22:45PM +0200, David Hildenbrand wrote:
> A driver might set a page logically offline -- PageOffline() -- and
> turn the page inaccessible in the hypervisor; after that, access to page
> content can be fatal. One example is virtio-mem; while unplugged memory
> -- marked as PageOffline() can currently be read in the hypervisor, this
> will no longer be the case in the future; for example, when having
> a virtio-mem device backed by huge pages in the hypervisor.
> 
> Some special PFN walkers -- i.e., /proc/kcore -- read content of random
> pages after checking PageOffline(); however, these PFN walkers can race
> with drivers that set PageOffline().
> 
> Let's introduce page_offline_(begin|end|freeze|thaw) for
> synchronizing.
> 
> page_offline_freeze()/page_offline_thaw() allows for a subsystem to
> synchronize with such drivers, achieving that a page cannot be set
> PageOffline() while frozen.
> 
> page_offline_begin()/page_offline_end() is used by drivers that care about
> such races when setting a page PageOffline().
> 
> For simplicity, use a rwsem for now; neither drivers nor users are
> performance sensitive.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
