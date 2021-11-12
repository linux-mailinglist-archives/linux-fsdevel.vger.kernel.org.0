Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D1C44E381
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 09:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbhKLIx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 03:53:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55492 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233978AbhKLIx5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 03:53:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636707066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3f/23L/6apTFHiWVWbIOXq1GImY0uN3EstFOe+3yv8E=;
        b=PLao9/fHB9shWr7+ALF7goDBmk8H7mpTOlmkOpo11GQfO+r5Enn3KWotXPUrBb4xtWo76f
        XvHZgjpsSgXa0UZ9iXOeU/O/Dnmi+zxuWURyi5Ets3YI5io1O6JZljHZetPEwP7+2PJPE8
        h6bum4j0hhw468N2Y/Jhyrd8sjjvaHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-QX2frTGxOjacUUQsXRhkDg-1; Fri, 12 Nov 2021 03:51:03 -0500
X-MC-Unique: QX2frTGxOjacUUQsXRhkDg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B2871006AA0;
        Fri, 12 Nov 2021 08:51:02 +0000 (UTC)
Received: from localhost (ovpn-12-197.pek2.redhat.com [10.72.12.197])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B835E1002391;
        Fri, 12 Nov 2021 08:50:44 +0000 (UTC)
Date:   Fri, 12 Nov 2021 16:50:42 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] proc/vmcore: don't fake reading zeroes on surprise
 vmcore_cb unregistration
Message-ID: <20211112085042.GB19016@MiWiFi-R3L-srv>
References: <20211111192243.22002-1-david@redhat.com>
 <20211112033028.GP27625@MiWiFi-R3L-srv>
 <d8cd422d-54aa-8695-6563-a98b8a61c280@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8cd422d-54aa-8695-6563-a98b8a61c280@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/12/21 at 09:28am, David Hildenbrand wrote:
> On 12.11.21 04:30, Baoquan He wrote:
> > On 11/11/21 at 08:22pm, David Hildenbrand wrote:
> >> In commit cc5f2704c934 ("proc/vmcore: convert oldmem_pfn_is_ram callback
> >> to more generic vmcore callbacks"), we added detection of surprise
> >> vmcore_cb unregistration after the vmcore was already opened. Once
> >> detected, we warn the user and simulate reading zeroes from that point on
> >> when accessing the vmcore.
> >>
> >> The basic reason was that unexpected unregistration, for example, by
> >> manually unbinding a driver from a device after opening the
> >> vmcore, is not supported and could result in reading oldmem the
> >> vmcore_cb would have actually prohibited while registered. However,
> >> something like that can similarly be trigger by a user that's really
> >> looking for trouble simply by unbinding the relevant driver before opening
> >> the vmcore -- or by disallowing loading the driver in the first place.
> >> So it's actually of limited help.
> > 
> > Yes, this is the change what I would like to see in the original patch
> > "proc/vmcore: convert oldmem_pfn_is_ram callback to more generic vmcore callbacks".
> > I am happy with this patch appended to commit cc5f2704c934.
> 
> Good, thanks!
> 
> > 
> >>
> >> Currently, unregistration can only be triggered via virtio-mem when
> >> manually unbinding the driver from the device inside the VM; there is no
> >> way to trigger it from the hypervisor, as hypervisors don't allow for
> >> unplugging virtio-mem devices -- ripping out system RAM from a VM without
> >> coordination with the guest is usually not a good idea.
> >>
> >> The important part is that unbinding the driver and unregistering the
> >> vmcore_cb while concurrently reading the vmcore won't crash the system,
> >> and that is handled by the rwsem.
> >>
> >> To make the mechanism more future proof, let's remove the "read zero"
> >> part, but leave the warning in place. For example, we could have a future
> >> driver (like virtio-balloon) that will contact the hypervisor to figure out
> >> if we already populated a page for a given PFN. Hotunplugging such a device
> >> and consequently unregistering the vmcore_cb could be triggered from the
> >> hypervisor without harming the system even while kdump is running. In that
> > 
> > I am a little confused, could you tell more about "contact the hypervisor to
> > figure out if we already populated a page for a given PFN."? I think
> > vmcore dumping relies on the eflcorehdr which is created beforehand, and
> > relies on vmcore_cb registered in advance too, virtio-balloon could take
> > another way to interact with kdump to make sure the dumpable ram?
> 
> This is essentially what the XEN callback does: check if a PFN is
> actually populated in the hypervisor; if not, avoid reading it so we
> won't be faulting+populating a fresh/zero page in the hypervisor just to
> be able to dump it in the guest. But in the XEN world we usually simply
> rely on straight hypercalls, not glued to actual devices that can get
> hot(un)plugged.
> 
> Once you have some device that performs such checks instead that could
> get hotunplugged and unregister the vmcore_cb (and virtio-balloon is
> just one example), you would be able to trigger this.
> 
> As we're dealing with a moving target (hypervisor will populate pages as
> necessary once the old kernel accesses them), there isn't really a way
> to adjust this in the old kernel -- where we build the eflcorehdr. We
> could try to adjust the elfcorehdr in the new kernel, but that certainly
> opens up another can of worms.

Sounds a little magic, but should be do-able if want to. Thanks a lot
for these details.

> 
> But again, this is just an example to back the "future proof" claim
> because Dave was explicitly concerned about this situation.
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 

