Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6AB458F6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 14:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbhKVNey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 08:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhKVNey (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 08:34:54 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4ACC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 05:31:47 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 132so18035114qkj.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 05:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u7JEhlzeqWEWi1WfdsbI31hG4XTiKs7YjTVY93B2ee4=;
        b=CRLeFVlaDHYADj0c4pdgyA6WVjM0CriKWH34VQ3Zgnf0WtTraYkd/cgjTCbMDOczww
         NdXiD8njOfcPQpNHpYRgBzhYd2yhCkVtjUBQDrAQcLu+SgaPJ18JLMcHZiSnAkVeknnd
         0r6V6MGiqUoTitEC42jbkgtqGFrBYYzJPumsEkVo7XS5sE6Xgi92bWwMj7cA04T9KZgG
         KBEMYlzIWnHu0BDIdQb3DAJr0IAt/qNWxoYSuFBMXOWkuMB4UlcMl9O5g8H1aCzjXOTg
         YIexlAtl5QrrWHsZHnXp+oDhqqchuEu2x1mCbFWEHmpRnxygBJW2KKryq/0Wb2YGQp6B
         zPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u7JEhlzeqWEWi1WfdsbI31hG4XTiKs7YjTVY93B2ee4=;
        b=LG081JmXR2MkrbDrMwc7CGKT2KY7ZR8yL110DixxVSFxe6ArsBeTbDaMlswS4LcVHz
         ny9rI8pXLfJCWnw18XIh444gbleJG2QcjzQ9PXu/qXNuVx2G2V9N6WihhGXJgp0/28Uj
         vxddojEr7+RbdJVciK7a9Vfg3mNO3h9ReWaXHKFxRX1nfJhmba0s2A6o4PUQ71J/XFtW
         CbiPbRxMcUvipq1fuX1KwQzQ7WEZx3f7QBmrZCpal8UKqpPH9n8VAqxNIWMGCEymYGAK
         NuPcjYLjgmrEsKxmSFfjMyUrCq+Ky2a6KYjga2wlCpuXl+Z7oKClSTfsLH0nPCGTEj58
         xmkw==
X-Gm-Message-State: AOAM531inkquW1li1xSH2LgY0MJdYqFzgJ6cwRAanGfzUFck/HvRx7Vx
        xieB5X3BPNK1vWICmHazYWw+HKy+lvXxRg==
X-Google-Smtp-Source: ABdhPJyVecFgN4ENVdXtmS+AeA6UBpyD+QSrsm4bekxw4Uozjfi2oAytM0ALDEqjOc3nqbmPpEzZDw==
X-Received: by 2002:a05:620a:c84:: with SMTP id q4mr47040794qki.176.1637587906879;
        Mon, 22 Nov 2021 05:31:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id n19sm4455570qta.78.2021.11.22.05.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 05:31:46 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mp9Q9-00DrvP-FD; Mon, 22 Nov 2021 09:31:45 -0400
Date:   Mon, 22 Nov 2021 09:31:45 -0400
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
Message-ID: <20211122133145.GQ876299@ziepe.ca>
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-2-chao.p.peng@linux.intel.com>
 <20211119151943.GH876299@ziepe.ca>
 <df11d753-6242-8f7c-cb04-c095f68b41fa@redhat.com>
 <20211119160023.GI876299@ziepe.ca>
 <4efdccac-245f-eb1f-5b7f-c1044ff0103d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4efdccac-245f-eb1f-5b7f-c1044ff0103d@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 22, 2021 at 10:26:12AM +0100, David Hildenbrand wrote:

> I do wonder if we want to support sharing such memfds between processes
> in all cases ... we most certainly don't want to be able to share
> encrypted memory between VMs (I heard that the kernel has to forbid
> that). It would make sense in the use case you describe, though.

If there is a F_SEAL_XX that blocks every kind of new access, who
cares if userspace passes the FD around or not?

Jason
