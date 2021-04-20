Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC22D36581C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 13:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhDTLxO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 07:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231196AbhDTLxN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:53:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B4A6613BC;
        Tue, 20 Apr 2021 11:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618919561;
        bh=lLkO2/PkO+bhgVGsPzjcfwOkNWdX1bKmFUUP9AKrk3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OipHbKnYeUn8mSFmquef9HjnEZLVmvx3TNs9yqZmXi/SpT1FKUrAdlQDDYigznhJj
         82nhesndHJF+I20ktltRDKvCXARhYYPIpIYpY31f3h6pweHK0ir4a6oURBE7vMYN9A
         R9J6cM0KhDGrMM5puM23cu3KM3UhVYwW8eOCEa0OV61xJlnxzLDdouFYS/2nyqZvsv
         Enx8/783XySF4OuGqyNx3qDEmd8LsGlHdYXwxdmqGXW+6Prnxbwg43XSHLGAM6lgE3
         SagaZuH8fdcfl9LsMSAa+MNp3kPAp3dhJdKDDwseXH9rzot0FSjdkfukjRQpSKdHnY
         Tap2Mp7Xn3XFA==
Date:   Tue, 20 Apr 2021 14:52:26 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Peter.Enderborg@sony.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com, guro@fb.com, shakeelb@google.com,
        mhocko@suse.com, neilb@suse.de, samitolvanen@google.com,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, willy@infradead.org
Subject: Re: [PATCH v5] dma-buf: Add DmaBufTotal counter in meminfo
Message-ID: <YH7AeqqNyNnY0Zi3@kernel.org>
References: <20210417163835.25064-1-peter.enderborg@sony.com>
 <YH6Xv00ddYfMA3Lg@phenom.ffwll.local>
 <176e7e71-59b7-b288-9483-10e0f42a7a3f@sony.com>
 <YH6h16hviixphaHV@kernel.org>
 <b57a33a3-a5ed-c122-e5b9-c7e7c4dae35f@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b57a33a3-a5ed-c122-e5b9-c7e7c4dae35f@sony.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 20, 2021 at 10:45:21AM +0000, Peter.Enderborg@sony.com wrote:
> On 4/20/21 11:41 AM, Mike Rapoport wrote:
> > Hello Peter,
> >
> > On Tue, Apr 20, 2021 at 09:26:00AM +0000, Peter.Enderborg@sony.com wrote:
> >> On 4/20/21 10:58 AM, Daniel Vetter wrote:
> >>> On Sat, Apr 17, 2021 at 06:38:35PM +0200, Peter Enderborg wrote:
> >>>> This adds a total used dma-buf memory. Details
> >>>> can be found in debugfs, however it is not for everyone
> >>>> and not always available. dma-buf are indirect allocated by
> >>>> userspace. So with this value we can monitor and detect
> >>>> userspace applications that have problems.
> >>>>
> >>>> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> >>> So there have been tons of discussions around how to track dma-buf and
> >>> why, and I really need to understand the use-cass here first I think. proc
> >>> uapi is as much forever as anything else, and depending what you're doing
> >>> this doesn't make any sense at all:
> >>>
> >>> - on most linux systems dma-buf are only instantiated for shared buffer.
> >>>   So there this gives you a fairly meaningless number and not anything
> >>>   reflecting gpu memory usage at all.
> >>>
> >>> - on Android all buffers are allocated through dma-buf afaik. But there
> >>>   we've recently had some discussions about how exactly we should track
> >>>   all this, and the conclusion was that most of this should be solved by
> >>>   cgroups long term. So if this is for Android, then I don't think adding
> >>>   random quick stop-gaps to upstream is a good idea (because it's a pretty
> >>>   long list of patches that have come up on this).
> >>>
> >>> So what is this for?
> >> For the overview. dma-buf today only have debugfs for info. Debugfs
> >> is not allowed by google to use in andoid. So this aggregate the information
> >> so we can get information on what going on on the system. 
> >  
> > Can you send an example debugfs output to see what data are we talking
> > about?
> 
> Sure. This is on a idle system. Im not sure why you need it.The problem is partly that debugfs is
> not accessable on a commercial device.

I wanted to see what kind of information is there, but I didn't think it's
that long :)
 
> Dma-buf Objects:
> size        flags       mode        count       exp_name        buf name    ino    
> 00032768    00000002    00080007    00000002    ion-system-1006-allocator-servi    dmabuf17728    07400825    dmabuf17728
>     Attached Devices:
> Total 0 devices attached
> 
> 11083776    00000002    00080007    00000003    ion-system-1006-allocator-servi    dmabuf17727    07400824    dmabuf17727
>     Attached Devices:
>     ae00000.qcom,mdss_mdp:qcom,smmu_sde_unsec_cb
> Total 1 devices attached
> 
> 00032768    00000002    00080007    00000002    ion-system-1006-allocator-servi    dmabuf17726    07400823    dmabuf17726
>     Attached Devices:
> Total 0 devices attached
> 
> 11083776    00000002    00080007    00000002    ion-system-1006-allocator-servi    dmabuf17725    07400822    dmabuf17725
>     Attached Devices:
>     ae00000.qcom,mdss_mdp:qcom,smmu_sde_unsec_cb
> Total 1 devices attached

...

> Total 654 objects, 744144896 bytes
 
Isn't the size from the first column also available in fdinfo?

Is there anything that prevents monitoring those?

-- 
Sincerely yours,
Mike.
