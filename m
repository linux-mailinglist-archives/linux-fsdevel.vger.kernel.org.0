Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1824D015A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 15:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243253AbiCGOfB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 09:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243245AbiCGOe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:34:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64A5E5F4DB
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Mar 2022 06:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646663644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EFYNbblCnNcuaPx8LOQ1Hn2woAp9Zpf6py8Ud+OJaTY=;
        b=JHkA6iHsw6poTI57aQopSoC4FjWrUtIrxyKlpOU3vBRG2DSVZYvMdC75dBgEHV46h6FDVE
        8C4zsRyQlB1N/AX2pVS2FEsPDkrGiciZYIME3zy7/QREXjjzNWFm2n5uPZe9H7Q8ZC4VCD
        Aib3JK1eNIUIti8k2BTbGvt54rtaMJg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-QC-LexlHOUqItUG7_mhgBQ-1; Mon, 07 Mar 2022 09:34:03 -0500
X-MC-Unique: QC-LexlHOUqItUG7_mhgBQ-1
Received: by mail-wm1-f71.google.com with SMTP id o21-20020a05600c511500b003818c4b98b5so5296888wms.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Mar 2022 06:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=EFYNbblCnNcuaPx8LOQ1Hn2woAp9Zpf6py8Ud+OJaTY=;
        b=T2BC8U5zwXoc8zZyVkYSc+1tqF7LNyn6SgKYZ8/8rYHHQQ184GgeXUWbNbekjG3jDg
         eZ/4kuaFEN3J6xoiazpeHaQ1PbZkfWSd2ZEUjHS5DL0/gu38i/rwU6Hg2Z6NJGk0viXc
         sNSUjImAiUkmVJw6t3VllMR833v9tJiikgkQUYqRYc5O6zdSdc3cmupmRDpXdRcI5UPA
         sMsJO240vaTlnQL4rLWba8xSonRpP0K0y0aujr5Fv9jDnRQp0b1QnzTLWwWBbRp1PIc2
         n7U4f9g1X/D7peuLFjAXuWsf60TyGXgnZZixXgntLYhVddkoAw7jT4uMEdZTNEX5u/Kl
         yRbg==
X-Gm-Message-State: AOAM532RPv9KgSqettpXQge1lsk+5upcE6TOT3LhMTEw7xF1h45Uddt7
        qKuxF6JFyuHVmKNLDFCM3edUjRdsSOhbrbU274ONSzVVZhqQMXclMFcaXzRGRxY8JcX4QDmvUzi
        jDYXDm1GfMuB0zb32EpVr54gbNA==
X-Received: by 2002:a7b:ca49:0:b0:389:bcde:f7ab with SMTP id m9-20020a7bca49000000b00389bcdef7abmr1185213wml.7.1646663642076;
        Mon, 07 Mar 2022 06:34:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPQNqWxZSPrdYEmAfxwtZ3y4N0Kf0xHJe42MVbdVGbGB8hJ9qV6tBxdbfd3Fa3fXlIgu+yCQ==
X-Received: by 2002:a7b:ca49:0:b0:389:bcde:f7ab with SMTP id m9-20020a7bca49000000b00389bcdef7abmr1185173wml.7.1646663641772;
        Mon, 07 Mar 2022 06:34:01 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:1e00:8d67:f75a:a8ae:dc02? (p200300cbc7051e008d67f75aa8aedc02.dip0.t-ipconnect.de. [2003:cb:c705:1e00:8d67:f75a:a8ae:dc02])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d548c000000b001f1f99e7792sm2398939wrv.111.2022.03.07.06.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 06:33:54 -0800 (PST)
Message-ID: <dab25b2d-88f1-7ad5-c28a-15a97b38af03@redhat.com>
Date:   Mon, 7 Mar 2022 15:33:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthew Auld <matthew.auld@intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= 
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
References: <20220306053211.135762-1-jarkko@kernel.org>
 <d6b09f23-f470-c119-8d3e-7d72a3448b64@redhat.com> <YiYVHTkS8IsMMw6T@iki.fi>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 0/3] MAP_POPULATE for device memory
In-Reply-To: <YiYVHTkS8IsMMw6T@iki.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07.03.22 15:22, Jarkko Sakkinen wrote:
> On Mon, Mar 07, 2022 at 11:12:44AM +0100, David Hildenbrand wrote:
>> On 06.03.22 06:32, Jarkko Sakkinen wrote:
>>> For device memory (aka VM_IO | VM_PFNMAP) MAP_POPULATE does nothing. Allow
>>> to use that for initializing the device memory by providing a new callback
>>> f_ops->populate() for the purpose.
>>>
>>> SGX patches are provided to show the callback in context.
>>>
>>> An obvious alternative is a ioctl but it is less elegant and requires
>>> two syscalls (mmap + ioctl) per memory range, instead of just one
>>> (mmap).
>>
>> What about extending MADV_POPULATE_READ | MADV_POPULATE_WRITE to support
>> VM_IO | VM_PFNMAP (as well?) ?
> 
> What would be a proper point to bind that behaviour? For mmap/mprotect it'd
> be probably populate_vma_page_range() because that would span both mmap()
> and mprotect() (Dave's suggestion in this thread).

MADV_POPULATE_* ends up in faultin_vma_page_range(), right next to
populate_vma_page_range(). So it might require a similar way to hook
into the driver I guess.

> 
> For MAP_POPULATE I did not have hard proof to show that it would be used
> by other drivers but for madvice() you can find at least a few ioctl
> based implementations:
> 
> $ git grep -e madv --and \( -e ioc \)  drivers/
> drivers/gpu/drm/i915/gem/i915_gem_ioctls.h:int i915_gem_madvise_ioctl(struct drm_device *dev, void *data,
> drivers/gpu/drm/i915/i915_driver.c:     DRM_IOCTL_DEF_DRV(I915_GEM_MADVISE, i915_gem_madvise_ioctl, DRM_RENDER_ALLOW),
> drivers/gpu/drm/i915/i915_gem.c:i915_gem_madvise_ioctl(struct drm_device *dev, void *data,
> drivers/gpu/drm/msm/msm_drv.c:static int msm_ioctl_gem_madvise(struct drm_device *dev, void *data,
> drivers/gpu/drm/msm/msm_drv.c:  DRM_IOCTL_DEF_DRV(MSM_GEM_MADVISE,  msm_ioctl_gem_madvise,  DRM_RENDER_ALLOW),
> drivers/gpu/drm/panfrost/panfrost_drv.c:static int panfrost_ioctl_madvise(struct drm_device *dev, void *data,
> drivers/gpu/drm/vc4/vc4_drv.c:  DRM_IOCTL_DEF_DRV(VC4_GEM_MADVISE, vc4_gem_madvise_ioctl, DRM_RENDER_ALLOW),
> drivers/gpu/drm/vc4/vc4_drv.h:int vc4_gem_madvise_ioctl(struct drm_device *dev, void *data,
> drivers/gpu/drm/vc4/vc4_gem.c:int vc4_gem_madvise_ioctl(struct drm_device *dev, void *data,
> 
> IMHO this also provides supportive claim for MAP_POPULATE, and yeah, I
> agree that to be consistent implementation, both madvice() and MAP_POPULATE
> should work.

MADV_POPULATE_WRITE + MADV_DONTNEED/FALLOC_FL_PUNCH_HOLE is one way to
dynamically manage memory consumption inside a sparse memory mapping
(preallocate/populate via MADV_POPULATE_WRITE, discard via
MADV_DONTNEED/FALLOC_FL_PUNCH_HOLE).  Extending that whole mechanism to
deal with VM_IO | VM_PFNMAP mappings as well could be interesting.

At least I herd about some ideas where we might want to dynamically
expose memory to a VM (via virtio-mem) inside a sparse memory mapping,
and the memory in that sparse memory mapping is provided from a
dedicated memory pool managed by a device driver -- not just using
ordinary anonymous/file/hugetlb memory as we do right now.

Now, this is certainly stuff for the future, I just wanted to mention it.

-- 
Thanks,

David / dhildenb

