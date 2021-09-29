Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B0141C0C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 10:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244791AbhI2Ijz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 04:39:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41721 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244595AbhI2Ijr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 04:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632904686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/rI4ipp+6p4YsURf5SVEvaXl3JhZmp49Hm7auACiD3c=;
        b=aGLrO075h6l3SS3vaxgxVQnxc2Iiq769tmBx4DHpw4NwRJHV7cCacdPyCn60njuSE25/5L
        G4sP1Ih58rehmC0nGcr3ZAXQgsBluyZy8dp+YYGOZuyG3Ji0MeP511BweWTebKedGUY+8d
        z80i/pyvyx2H224CBudR2P9R0VUSyYI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-m46fQP9VP2q4aFUk_zyOIQ-1; Wed, 29 Sep 2021 04:38:04 -0400
X-MC-Unique: m46fQP9VP2q4aFUk_zyOIQ-1
Received: by mail-wm1-f71.google.com with SMTP id z137-20020a1c7e8f000000b0030cd1800d86so880395wmc.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Sep 2021 01:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/rI4ipp+6p4YsURf5SVEvaXl3JhZmp49Hm7auACiD3c=;
        b=O5M5V+e4wN7I9uRgiJuV+oCvbla4J+8T3YYz1ZfSQqgC2N2273Iq/rn435sqWjNULR
         Bw+7GCNCpzz5HZophD0hkHw2Qx+f1F9pSsW4GFtf7JCOur+H8CxX8hEQ2iNH0V8REI9T
         pQTf3jPecndsB0vnIUB52YSVdL1nLB4f0iSDdGEZSJHP0D9VY6lhFiTP/cXHjv7F8Ouf
         WG5qVZw29Ez9vTd/6wZMwxbx2IPXBiqpV+zBxCJ44YrmhNoAOaKTCttqx5xIEfeNUqPg
         HIwiirECU8KZ5QiSgWHaKE/Wap0wyRH1UAeSxXbEF68VgoNUFibNhDxNfd6512BkIxzL
         2UZw==
X-Gm-Message-State: AOAM533KFOcwEqCAqf0eI+SgCTfD9oQbAzlPL1GGqytXkZfxT0aRGCPY
        4XE8NO/CTgssOjPLyA5Y8lnwSlQShJPNBykJp9AkRVJa2SA4PONJhYVce6D7jF4K+ysvzlMUbMs
        p25hUH+tYeyMr4L/Iizav8UQKHQ==
X-Received: by 2002:a05:600c:3652:: with SMTP id y18mr8981996wmq.66.1632904683466;
        Wed, 29 Sep 2021 01:38:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1UYD13jo4zi2cV8ML8JLWg6MbDn1wfsjZAud8HZY/udqsA+Bzs8BSxqVjAL69LYYlXkKLHw==
X-Received: by 2002:a05:600c:3652:: with SMTP id y18mr8981980wmq.66.1632904683305;
        Wed, 29 Sep 2021 01:38:03 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c3b.dip0.t-ipconnect.de. [79.242.60.59])
        by smtp.gmail.com with ESMTPSA id f17sm1497220wrm.83.2021.09.29.01.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 01:38:02 -0700 (PDT)
Subject: Re: [PATCH v1 8/8] virtio-mem: kdump mode to sanitize /proc/vmcore
 access
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
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
 <20210928182258.12451-9-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <e01cdc7f-cda8-3268-c971-1255a71fb8ac@redhat.com>
Date:   Wed, 29 Sep 2021 10:38:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210928182258.12451-9-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[...]

> +
> +static bool virtio_mem_vmcore_pfn_is_ram(struct vmcore_cb *cb,
> +					 unsigned long pfn)
> +{
> +	struct virtio_mem *vm = container_of(cb, struct virtio_mem,
> +					     vmcore_cb);
> +	uint64_t addr = PFN_PHYS(pfn);
> +	bool is_ram;
> +	int rc;
> +
> +	if (!virtio_mem_contains_range(vm, addr, addr + PAGE_SIZE))

Some more testing revealed that this has to be

if (!virtio_mem_contains_range(vm, addr, PAGE_SIZE))


-- 
Thanks,

David / dhildenb

