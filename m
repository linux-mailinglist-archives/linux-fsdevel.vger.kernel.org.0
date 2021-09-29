Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68AE41C0EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 10:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244881AbhI2Ira (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 04:47:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56217 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244873AbhI2Ir3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 04:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632905148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gvu4L83YOBGLGvWqLGUuGEaO/DEUZyEQ1rFR5bn6b8M=;
        b=JX8sXbowIGFwf7cZnZnH3wolVvbBg/04UwcHDM4LArKbK7y5RdnLF7GKBfNlCIqxj7WeYb
        EJQIzjv+Oko8xuDDKM8M1tO52KUIC4K0DaVpqAhlyP0JmqIwixnUFtYcSt5jJSOtPXDc77
        LK4n2WibCqgob34LQwQqKU6A/2Ads4g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-zA8dWT6NPYurC4C7mRuReA-1; Wed, 29 Sep 2021 04:45:47 -0400
X-MC-Unique: zA8dWT6NPYurC4C7mRuReA-1
Received: by mail-wm1-f69.google.com with SMTP id m2-20020a05600c3b0200b0030cd1310631so577000wms.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Sep 2021 01:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Gvu4L83YOBGLGvWqLGUuGEaO/DEUZyEQ1rFR5bn6b8M=;
        b=X6ELMf/CziDEM9eyNmI2tBVobtqy4SSTn8zn3Z0pJEAv0y5BZqpEMxPyxqhzgdFd3M
         ZbRofnRhH4tsykR6GnJ1ni4s5ryCdGN9ikVIG6lukrxsqzrBzUz+rvtdo7+tkfRpLGY5
         1F2m/WRxSXnQou4Ac1KPMh1lYQ5I8Kxk2qMDxFNW4LqLWiHEerd2+0azOkZ/EvUhEIe4
         XWBZ/Kpwjde53t8Fh4AuTRdTH0HShM62YKBfqXz5Bd7zlFu1eTutY12tUHNQH+Er8UNv
         WnO5ni7DRhzPNDjEvFpqO39B81HLW+8oS8iit0iXVSAuEyOndDeBr76w1IFxq3Jn5AIu
         slJQ==
X-Gm-Message-State: AOAM530vC8t1EGQYyf4Hq34k7gxL1HPCVQ6L8O/GN4PKbCBxwnJUnunJ
        LL98rs4OhSpUIEsajlS/IYd4wE9T5RwPu29kV8ab9kDUjLbt9cfJE5qLrRK8pt1To+W4r2w1vVH
        Rrbvn0Ui0pSp4BtG6RV5FyRq2Ow==
X-Received: by 2002:a1c:7c0f:: with SMTP id x15mr8734501wmc.149.1632905146273;
        Wed, 29 Sep 2021 01:45:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaikWIkzzrJGqHValULa/ZmnNfg4rl1LyjKqzMWVt+gz9mbskxaXhni5v3m042+vSd753h3g==
X-Received: by 2002:a1c:7c0f:: with SMTP id x15mr8734485wmc.149.1632905146123;
        Wed, 29 Sep 2021 01:45:46 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c3b.dip0.t-ipconnect.de. [79.242.60.59])
        by smtp.gmail.com with ESMTPSA id t126sm893773wma.4.2021.09.29.01.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 01:45:45 -0700 (PDT)
Subject: Re: [PATCH v1 2/8] x86/xen: simplify xen_oldmem_pfn_is_ram()
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org,
        virtualization@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210928182258.12451-1-david@redhat.com>
 <20210928182258.12451-3-david@redhat.com>
 <4ab2f8c2-c3d5-30b3-a670-a8b38e218b6e@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <bfe72f46-9a0d-1a87-64bd-4b03999edd1e@redhat.com>
Date:   Wed, 29 Sep 2021 10:45:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4ab2f8c2-c3d5-30b3-a670-a8b38e218b6e@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> 
> How about
> 
>      return a.mem_type != HVMMEM_mmio_dm;
> 

Ha, how could I have missed that :)

> 
> Result should be promoted to int and this has added benefit of not requiring changes in patch 4.
> 

Can we go one step further and do


@@ -20,24 +20,11 @@ static int xen_oldmem_pfn_is_ram(unsigned long pfn)
         struct xen_hvm_get_mem_type a = {
                 .domid = DOMID_SELF,
                 .pfn = pfn,
+               .mem_type = HVMMEM_ram_rw,
         };
-       int ram;
  
-       if (HYPERVISOR_hvm_op(HVMOP_get_mem_type, &a))
-               return -ENXIO;
-
-       switch (a.mem_type) {
-       case HVMMEM_mmio_dm:
-               ram = 0;
-               break;
-       case HVMMEM_ram_rw:
-       case HVMMEM_ram_ro:
-       default:
-               ram = 1;
-               break;
-       }
-
-       return ram;
+       HYPERVISOR_hvm_op(HVMOP_get_mem_type, &a);
+       return a.mem_type != HVMMEM_mmio_dm;
  }
  #endif


Assuming that if HYPERVISOR_hvm_op() fails that
.mem_type is not set to HVMMEM_mmio_dm.

-- 
Thanks,

David / dhildenb

