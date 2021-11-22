Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280C8458FDE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 15:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbhKVOE5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 09:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbhKVOE5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 09:04:57 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E50C06173E
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 06:01:50 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id p4so18165626qkm.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 06:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AkVa9dgYFMW65oNWi3lEAnC5wvNaUzrKbDuhcPjVyAM=;
        b=YbZPXtBUsIP409q2mT8lSr4BqkVNQQ7uwSh3flKk8k1tLdFvFH+qBcjZfbEQuRnSJt
         ym7KIc8Rr2qe7cnTl58XYSE6lugUqTMCIbLTauRHYkZqs9rs3GKm1bMlBUWI+TRMcDGX
         I0UZlTo4cd8ySiP1lEYqugVzwPTPEfPtKNmmPzejl2rh3HDr1pH7Jp2W80NczxtpUT2f
         7DZmFWyXm06nxDnZOIMEP5lLL2tkQARwppJwaeUpCzINEB5Wi61hhIuu1iPds6HyRHDs
         CkaIWL9eMwFvW3dqc9J2iSLvyxaUEjT+FHbVEY0VTDVLySkuR3731mB61RPDNMhCVl2Y
         9yWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AkVa9dgYFMW65oNWi3lEAnC5wvNaUzrKbDuhcPjVyAM=;
        b=RSdiKGQJj/gfFng9E9jbW1pGpmR0zBnMnV6bpZa36LMfI+N9SLzL58somsLnI2HvZ3
         HH9fNj0bG/O/qpZ2qJhJnTBtePkUpQwVSYayBp89YPSgv1F606+MNfCr402RoWWjh7Pl
         X8rbhpPulN+MH2cT2xsc5fXRUzGUIqdSaGkv8bZJcQuSiXqWtFOmJp+a8xBfQY4PwTTX
         nQpA6Je8Mo0DhWh5+TXtIcZJkVj+WnzScqREYBVHjBsc5ymmXzlAZn96baLKxJAM0me0
         UI//4xsOd8c3D1ugf7D8YBKLkUXlmfQKI0mrZ5Amp7w7amjyCFKaa9Uo/GKgTd3m439t
         3GIA==
X-Gm-Message-State: AOAM531VLxPXxZwU7DEp8evbx/hnvc9ZlyBliPM532HWORLpW2WswG8n
        Uxg+yl8tN4DblV39QpQfzTlRfQ==
X-Google-Smtp-Source: ABdhPJx4FBEsFukDClDSwGw8qd9OgvbrBef1ytO7EqEtX4yVEQkSoyHCZqYrRFEAi40duExffLYOuw==
X-Received: by 2002:a05:620a:190b:: with SMTP id bj11mr47809423qkb.514.1637589709646;
        Mon, 22 Nov 2021 06:01:49 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id s13sm4716120qki.23.2021.11.22.06.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 06:01:49 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mp9tE-00DsN8-Ie; Mon, 22 Nov 2021 10:01:48 -0400
Date:   Mon, 22 Nov 2021 10:01:48 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     David Hildenbrand <david@redhat.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com
Subject: Re: [RFC v2 PATCH 01/13] mm/shmem: Introduce F_SEAL_GUEST
Message-ID: <20211122140148.GR876299@ziepe.ca>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-2-chao.p.peng@linux.intel.com>
 <20211119151943.GH876299@ziepe.ca>
 <df11d753-6242-8f7c-cb04-c095f68b41fa@redhat.com>
 <20211119160023.GI876299@ziepe.ca>
 <4efdccac-245f-eb1f-5b7f-c1044ff0103d@redhat.com>
 <20211122133145.GQ876299@ziepe.ca>
 <56c0dffc-5fc4-c337-3e85-a5c9ce619140@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56c0dffc-5fc4-c337-3e85-a5c9ce619140@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 22, 2021 at 02:35:49PM +0100, David Hildenbrand wrote:
> On 22.11.21 14:31, Jason Gunthorpe wrote:
> > On Mon, Nov 22, 2021 at 10:26:12AM +0100, David Hildenbrand wrote:
> > 
> >> I do wonder if we want to support sharing such memfds between processes
> >> in all cases ... we most certainly don't want to be able to share
> >> encrypted memory between VMs (I heard that the kernel has to forbid
> >> that). It would make sense in the use case you describe, though.
> > 
> > If there is a F_SEAL_XX that blocks every kind of new access, who
> > cares if userspace passes the FD around or not?
> I was imagining that you actually would want to do some kind of "change
> ownership". But yeah, the intended semantics and all use cases we have
> in mind are not fully clear to me yet. If it's really "no new access"
> (side note: is "access" the right word?) then sure, we can pass the fd
> around.

What is "ownership" in a world with kvm and iommu are reading pages
out of the same fd?

"no new access" makes sense to me, we have access through
read/write/mmap/splice/etc and access to pages through the private in
kernel interface (kvm, iommu)

Jason
