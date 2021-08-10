Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA7B3E8416
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 22:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhHJUHU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 16:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24051 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231398AbhHJUHU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628626017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mb5VBTkb8S88umgyEx90HwHXvZnu9/1GybLMu7zbg4A=;
        b=L0vNBCB2iPiDhkOU1X4nCExathck4D1hamCC6CKQEZOenV/WXV5GMSPcMxQhHLOtDO9Bpx
        1IexgTsx+BMQaD+aBA+7NSJkdjz2MQteckf+/kVdkZrI9FMubAH4gIYY8s1OSgh8T+LcZB
        jtoJ6VGNNVAmxw6zskWGNaTb5M44gAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-kHx-yYzKO2meQHTDf3jW6w-1; Tue, 10 Aug 2021 16:06:55 -0400
X-MC-Unique: kHx-yYzKO2meQHTDf3jW6w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D0B53639F;
        Tue, 10 Aug 2021 20:06:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.22.32.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEFE5100EBB0;
        Tue, 10 Aug 2021 20:06:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210715033704.692967-36-willy@infradead.org>
References: <20210715033704.692967-36-willy@infradead.org> <20210715033704.692967-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 035/138] mm/memcg: Use the node id in mem_cgroup_update_tree()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1809567.1628626012.1@warthog.procyon.org.uk>
Date:   Tue, 10 Aug 2021 21:06:52 +0100
Message-ID: <1809568.1628626012@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> By using the node id in mem_cgroup_update_tree(), we can delete
> soft_limit_tree_from_page() and mem_cgroup_page_nodeinfo().  Saves 42
> bytes of kernel text on my config.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: David Howells <dhowells@redhat.com>

Though I wonder if:

> -		mz = mem_cgroup_page_nodeinfo(memcg, page);
> +		mz = memcg->nodeinfo[nid];

should still have some sort of wrapper function.

