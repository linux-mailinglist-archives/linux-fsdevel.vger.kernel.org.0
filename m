Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BEE44E0CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 04:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhKLDeI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 22:34:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29906 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229770AbhKLDeI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 22:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636687877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2v9fF/0oseQ/pQZH0U5TtuGlQ3sQjbX2pDiieAp4QMo=;
        b=RdCR6sXnVZ/2pNSYTbueJmCZmNRT+yrqOJK+Ng4tER3kxq7YPQYl3k+DM+PUZC+fXTOIQi
        SHUhRqq4c7br1irucZgTJbZTp4cNhb1sugsEMwwXuNWMsD2ztGNHi9g25UQM2K4BqWKspp
        wYRo/EQSBX3ccfTvgFGw7cNcpUxe/YY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-SPH25Kq2PjGfHXY8CK0iTw-1; Thu, 11 Nov 2021 22:31:14 -0500
X-MC-Unique: SPH25Kq2PjGfHXY8CK0iTw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 743B015720;
        Fri, 12 Nov 2021 03:31:13 +0000 (UTC)
Received: from localhost (ovpn-12-197.pek2.redhat.com [10.72.12.197])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82D5B79455;
        Fri, 12 Nov 2021 03:30:31 +0000 (UTC)
Date:   Fri, 12 Nov 2021 11:30:28 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] proc/vmcore: don't fake reading zeroes on surprise
 vmcore_cb unregistration
Message-ID: <20211112033028.GP27625@MiWiFi-R3L-srv>
References: <20211111192243.22002-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111192243.22002-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/11/21 at 08:22pm, David Hildenbrand wrote:
> In commit cc5f2704c934 ("proc/vmcore: convert oldmem_pfn_is_ram callback
> to more generic vmcore callbacks"), we added detection of surprise
> vmcore_cb unregistration after the vmcore was already opened. Once
> detected, we warn the user and simulate reading zeroes from that point on
> when accessing the vmcore.
> 
> The basic reason was that unexpected unregistration, for example, by
> manually unbinding a driver from a device after opening the
> vmcore, is not supported and could result in reading oldmem the
> vmcore_cb would have actually prohibited while registered. However,
> something like that can similarly be trigger by a user that's really
> looking for trouble simply by unbinding the relevant driver before opening
> the vmcore -- or by disallowing loading the driver in the first place.
> So it's actually of limited help.

Yes, this is the change what I would like to see in the original patch
"proc/vmcore: convert oldmem_pfn_is_ram callback to more generic vmcore callbacks".
I am happy with this patch appended to commit cc5f2704c934.

> 
> Currently, unregistration can only be triggered via virtio-mem when
> manually unbinding the driver from the device inside the VM; there is no
> way to trigger it from the hypervisor, as hypervisors don't allow for
> unplugging virtio-mem devices -- ripping out system RAM from a VM without
> coordination with the guest is usually not a good idea.
> 
> The important part is that unbinding the driver and unregistering the
> vmcore_cb while concurrently reading the vmcore won't crash the system,
> and that is handled by the rwsem.
> 
> To make the mechanism more future proof, let's remove the "read zero"
> part, but leave the warning in place. For example, we could have a future
> driver (like virtio-balloon) that will contact the hypervisor to figure out
> if we already populated a page for a given PFN. Hotunplugging such a device
> and consequently unregistering the vmcore_cb could be triggered from the
> hypervisor without harming the system even while kdump is running. In that

I am a little confused, could you tell more about "contact the hypervisor to
figure out if we already populated a page for a given PFN."? I think
vmcore dumping relies on the eflcorehdr which is created beforehand, and
relies on vmcore_cb registered in advance too, virtio-balloon could take
another way to interact with kdump to make sure the dumpable ram?

Nevertheless, this patch looks good to me, thanks.

Acked-by: Baoquan He <bhe@redhat.com>

> case, we don't want to silently end up with a vmcore that contains wrong
> data, because the user inside the VM might be unaware of the hypervisor
> action and might easily miss the warning in the log.
> 
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Philipp Rudo <prudo@redhat.com>
> Cc: kexec@lists.infradead.org
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  fs/proc/vmcore.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 30a3b66f475a..948691cf4a1a 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -65,8 +65,6 @@ static size_t vmcoredd_orig_sz;
>  static DECLARE_RWSEM(vmcore_cb_rwsem);
>  /* List of registered vmcore callbacks. */
>  static LIST_HEAD(vmcore_cb_list);
> -/* Whether we had a surprise unregistration of a callback. */
> -static bool vmcore_cb_unstable;
>  /* Whether the vmcore has been opened once. */
>  static bool vmcore_opened;
>  
> @@ -94,10 +92,8 @@ void unregister_vmcore_cb(struct vmcore_cb *cb)
>  	 * very unusual (e.g., forced driver removal), but we cannot stop
>  	 * unregistering.
>  	 */
> -	if (vmcore_opened) {
> +	if (vmcore_opened)
>  		pr_warn_once("Unexpected vmcore callback unregistration\n");
> -		vmcore_cb_unstable = true;
> -	}
>  	up_write(&vmcore_cb_rwsem);
>  }
>  EXPORT_SYMBOL_GPL(unregister_vmcore_cb);
> @@ -108,8 +104,6 @@ static bool pfn_is_ram(unsigned long pfn)
>  	bool ret = true;
>  
>  	lockdep_assert_held_read(&vmcore_cb_rwsem);
> -	if (unlikely(vmcore_cb_unstable))
> -		return false;
>  
>  	list_for_each_entry(cb, &vmcore_cb_list, next) {
>  		if (unlikely(!cb->pfn_is_ram))
> @@ -577,7 +571,7 @@ static int vmcore_remap_oldmem_pfn(struct vm_area_struct *vma,
>  	 * looping over all pages without a reason.
>  	 */
>  	down_read(&vmcore_cb_rwsem);
> -	if (!list_empty(&vmcore_cb_list) || vmcore_cb_unstable)
> +	if (!list_empty(&vmcore_cb_list))
>  		ret = remap_oldmem_pfn_checked(vma, from, pfn, size, prot);
>  	else
>  		ret = remap_oldmem_pfn_range(vma, from, pfn, size, prot);
> 
> base-commit: debe436e77c72fcee804fb867f275e6d31aa999c
> -- 
> 2.31.1
> 

