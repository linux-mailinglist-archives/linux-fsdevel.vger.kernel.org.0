Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B2B4D036A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 16:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbiCGPvM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 10:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiCGPvL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:51:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C4992D22;
        Mon,  7 Mar 2022 07:50:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B695CB815F8;
        Mon,  7 Mar 2022 15:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C24CC340EB;
        Mon,  7 Mar 2022 15:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646668214;
        bh=kOQrIB//kV8fsU32x9w7qLTU4u76ufnPafjP+aW2LGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xn3UfVQig7siysNhTckqEt/3YwfSb/hQX777ZeUBNR25CWtPmBg3AozCiz0C9Vx6e
         vI0+ZBFRrmaTJtZfVDBV/wXr9kndWweVAzDmNxzcrOpxEk6sb14183+qU7UsuGoPyD
         BJdWxk6dfqo2i8LIPODB/uTqA5n5E/QX1Oc7iq5pAYpzAleGc7lc3aIGfn/PwB89lT
         Ot8o/PrK/bdSm0BXhzDWSnMhi1VaTaPkbIEK8WSygHQZnXIc+PUDkiS/iC31zhENiH
         FHocAoA6uueu5ukIdmZ08K5KjK1lXb4Pte/4tQ3FvPFI29pSDVfw1hXJlmCJ0ZynWA
         ECBe+IItixYgw==
Date:   Mon, 7 Mar 2022 17:49:33 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthew Auld <matthew.auld@intel.com>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        zhangyiru <zhangyiru3@huawei.com>,
        Alexey Gladkov <legion@kernel.org>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        linux-mips@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, codalist@coda.cs.cmu.edu,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] MAP_POPULATE for device memory
Message-ID: <YiYpjdD8BYcoGQ4s@iki.fi>
References: <20220306053211.135762-1-jarkko@kernel.org>
 <d6b09f23-f470-c119-8d3e-7d72a3448b64@redhat.com>
 <YiYVHTkS8IsMMw6T@iki.fi>
 <dab25b2d-88f1-7ad5-c28a-15a97b38af03@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dab25b2d-88f1-7ad5-c28a-15a97b38af03@redhat.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 07, 2022 at 03:33:52PM +0100, David Hildenbrand wrote:
> On 07.03.22 15:22, Jarkko Sakkinen wrote:
> > On Mon, Mar 07, 2022 at 11:12:44AM +0100, David Hildenbrand wrote:
> >> On 06.03.22 06:32, Jarkko Sakkinen wrote:
> >>> For device memory (aka VM_IO | VM_PFNMAP) MAP_POPULATE does nothing. Allow
> >>> to use that for initializing the device memory by providing a new callback
> >>> f_ops->populate() for the purpose.
> >>>
> >>> SGX patches are provided to show the callback in context.
> >>>
> >>> An obvious alternative is a ioctl but it is less elegant and requires
> >>> two syscalls (mmap + ioctl) per memory range, instead of just one
> >>> (mmap).
> >>
> >> What about extending MADV_POPULATE_READ | MADV_POPULATE_WRITE to support
> >> VM_IO | VM_PFNMAP (as well?) ?
> > 
> > What would be a proper point to bind that behaviour? For mmap/mprotect it'd
> > be probably populate_vma_page_range() because that would span both mmap()
> > and mprotect() (Dave's suggestion in this thread).
> 
> MADV_POPULATE_* ends up in faultin_vma_page_range(), right next to
> populate_vma_page_range(). So it might require a similar way to hook
> into the driver I guess.
> 
> > 
> > For MAP_POPULATE I did not have hard proof to show that it would be used
> > by other drivers but for madvice() you can find at least a few ioctl
> > based implementations:
> > 
> > $ git grep -e madv --and \( -e ioc \)  drivers/
> > drivers/gpu/drm/i915/gem/i915_gem_ioctls.h:int i915_gem_madvise_ioctl(struct drm_device *dev, void *data,
> > drivers/gpu/drm/i915/i915_driver.c:     DRM_IOCTL_DEF_DRV(I915_GEM_MADVISE, i915_gem_madvise_ioctl, DRM_RENDER_ALLOW),
> > drivers/gpu/drm/i915/i915_gem.c:i915_gem_madvise_ioctl(struct drm_device *dev, void *data,
> > drivers/gpu/drm/msm/msm_drv.c:static int msm_ioctl_gem_madvise(struct drm_device *dev, void *data,
> > drivers/gpu/drm/msm/msm_drv.c:  DRM_IOCTL_DEF_DRV(MSM_GEM_MADVISE,  msm_ioctl_gem_madvise,  DRM_RENDER_ALLOW),
> > drivers/gpu/drm/panfrost/panfrost_drv.c:static int panfrost_ioctl_madvise(struct drm_device *dev, void *data,
> > drivers/gpu/drm/vc4/vc4_drv.c:  DRM_IOCTL_DEF_DRV(VC4_GEM_MADVISE, vc4_gem_madvise_ioctl, DRM_RENDER_ALLOW),
> > drivers/gpu/drm/vc4/vc4_drv.h:int vc4_gem_madvise_ioctl(struct drm_device *dev, void *data,
> > drivers/gpu/drm/vc4/vc4_gem.c:int vc4_gem_madvise_ioctl(struct drm_device *dev, void *data,
> > 
> > IMHO this also provides supportive claim for MAP_POPULATE, and yeah, I
> > agree that to be consistent implementation, both madvice() and MAP_POPULATE
> > should work.
> 
> MADV_POPULATE_WRITE + MADV_DONTNEED/FALLOC_FL_PUNCH_HOLE is one way to
> dynamically manage memory consumption inside a sparse memory mapping
> (preallocate/populate via MADV_POPULATE_WRITE, discard via
> MADV_DONTNEED/FALLOC_FL_PUNCH_HOLE).  Extending that whole mechanism to
> deal with VM_IO | VM_PFNMAP mappings as well could be interesting.
> 
> At least I herd about some ideas where we might want to dynamically
> expose memory to a VM (via virtio-mem) inside a sparse memory mapping,
> and the memory in that sparse memory mapping is provided from a
> dedicated memory pool managed by a device driver -- not just using
> ordinary anonymous/file/hugetlb memory as we do right now.
> 
> Now, this is certainly stuff for the future, I just wanted to mention it.

For SGX purposes I'm now studying the possibly to use ra_state to get
idea where do "prefetching" (EAUG's) in batches, as it is something
that would not require any intrusive changes to mm but thank you for
sharing this. Looking into implementing this properly is the 2nd option,
if that does not work out.

> -- 
> Thanks,
> 
> David / dhildenb

BR, Jarkko
