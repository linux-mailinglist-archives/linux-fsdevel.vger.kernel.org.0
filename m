Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9AD759EF0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 17:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfF1Pca (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 11:32:30 -0400
Received: from a9-30.smtp-out.amazonses.com ([54.240.9.30]:45750 "EHLO
        a9-30.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726686AbfF1Pc3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1561735948;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=AS0whl/EcrrVIjGmsUBB1P/c2zpIOxnuhHXncVKXZDs=;
        b=SPfGmsXFLQEBn6h5ufA7w1jky3/Rc5RZWDgWNaiTM/EHlEN3OYChoYEFopmh0TVK
        CsfQ0V2VNWhAZKX5OVGAkkAuAJkc9V4P1tYZ2E+eFutc3svPaXxXsz0EOpjrjpx2KYK
        te37a4g49qMNkC2/MEGlyyhGG40MgUxZQUWAqOFo=
Date:   Fri, 28 Jun 2019 15:32:28 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Roman Gushchin <guro@fb.com>
cc:     Waiman Long <longman@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 2/2] mm, slab: Extend vm/drop_caches to shrink kmem
 slabs
In-Reply-To: <20190627212419.GA25233@tower.DHCP.thefacebook.com>
Message-ID: <0100016b9eb7685e-0a5ab625-abb4-4e79-ab86-07744b1e4c3a-000000@email.amazonses.com>
References: <20190624174219.25513-1-longman@redhat.com> <20190624174219.25513-3-longman@redhat.com> <20190626201900.GC24698@tower.DHCP.thefacebook.com> <063752b2-4f1a-d198-36e7-3e642d4fcf19@redhat.com> <20190627212419.GA25233@tower.DHCP.thefacebook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.06.28-54.240.9.30
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 27 Jun 2019, Roman Gushchin wrote:

> so that objects belonging to different memory cgroups can share the same page
> and kmem_caches.
>
> It's a fairly big change though.

Could this be done at another level? Put a cgoup pointer into the
corresponding structures and then go back to just a single kmen_cache for
the system as a whole? You can still account them per cgroup and there
will be no cleanup problem anymore. You could scan through a slab cache
to remove the objects of a certain cgroup and then the fragmentation
problem that cgroups create here will be handled by the slab allocators in
the traditional way. The duplication of the kmem_cache was not designed
into the allocators but bolted on later.

