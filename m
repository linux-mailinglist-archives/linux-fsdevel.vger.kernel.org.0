Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6E23B6D5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 06:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhF2EPi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 00:15:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38721 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229562AbhF2EPi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 00:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624939991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7N6S5aXlTsxjRnLUAwuT1GGB2dsJH/gvDpQ3UzIqM0M=;
        b=KOrKQyi1cxI1FSXNCfA6jqtubkndfc8lFhqTYW4JKduekkdH5Q5R37fQY4nbYoLyI6NSEc
        CP9dbzak04/8q/q9rw23wHz9ZW4CAOwMBe7O+awuI6eiV0+uZmckUVQ6VnQRPp05nL96fH
        +5lY3cmtmB/ZTASnJAtg/D8If+THlNE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-00YVh5GgMbSflub3_e-wkg-1; Tue, 29 Jun 2021 00:13:09 -0400
X-MC-Unique: 00YVh5GgMbSflub3_e-wkg-1
Received: by mail-pj1-f70.google.com with SMTP id go14-20020a17090b03ceb02901709d30a8a1so1389940pjb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 21:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7N6S5aXlTsxjRnLUAwuT1GGB2dsJH/gvDpQ3UzIqM0M=;
        b=qo53pAdkgzXvkG06rbNhb6gr+Vmhsg2LvrLlj5CHxAfPdzCtqs+EvEdf5Z/n0tR9YY
         jC+LPimF9up5UBUeQyQIci8H0COY5EbM4B4sWt5RXOqV66dKdyzc9RrJBoe7AcNFwDhq
         3JaVn+uyzcwLUtBAHWLuREK6QA+pigIJcxnh2hF/4iMF8GjhZE8b0Pr2jJMY+IXAHY05
         6DHD3AXwhDs7MGwzlZT5m2aD4DCrWF2bA9elUZu50CfQi7eLbzhFD1Z6t4ktEdUCCgJ5
         0O7fIQRb7pyvFF75aFu2OmvymA68FN4+P6r0NnJkX7nFus8PF2pLKzZ9xaFKGfBrbRxu
         MemQ==
X-Gm-Message-State: AOAM532J8ORAtRQVEpQATNMsaGYSHQZ8m2o/v1XrxczFbUO9TSpPX3Ht
        XH50Nqcr2d+8Tkh7XarFtcniGRHE5eAEH6xzUI/Fkg9a3g2b/nzwhEmT85ysybSnGsWwPs14082
        igIRJoUAVv8hVAWWE6ExsHTYuKLEiLQb1oyxrxP7jbiWRLMJ+azryqI/aQWQWfIN45JHkCYV2nU
        +f0w==
X-Received: by 2002:a65:478d:: with SMTP id e13mr26587088pgs.37.1624939988040;
        Mon, 28 Jun 2021 21:13:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTnV+jCJcWth5Gh1PanbNwyDV44mMvsm0eLCzSFKGOg12/3H6rwksZzo35n3QJumwiuRcZHQ==
X-Received: by 2002:a65:478d:: with SMTP id e13mr26587053pgs.37.1624939987713;
        Mon, 28 Jun 2021 21:13:07 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k13sm1525904pgh.82.2021.06.28.21.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 21:13:07 -0700 (PDT)
Subject: Re: [PATCH v8 00/10] Introduce VDUSE - vDPA Device in Userspace
To:     Yongji Xie <elohimes@gmail.com>,
        Liu Xiaodong <xiaodong.liu@intel.com>
Cc:     Xie Yongji <xieyongji@bytedance.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, sgarzare@redhat.com,
        parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        iommu@lists.linux-foundation.org, songmuchun@bytedance.com,
        linux-fsdevel@vger.kernel.org
References: <20210615141331.407-1-xieyongji@bytedance.com>
 <20210628103309.GA205554@storage2.sh.intel.com>
 <CAONzpcbjr2zKOAQrWa46Tv=oR1fYkcKLcqqm_tSgO7RkU20yBA@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <d5321870-ef29-48e2-fdf6-32d99a5fa3b9@redhat.com>
Date:   Tue, 29 Jun 2021 12:12:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAONzpcbjr2zKOAQrWa46Tv=oR1fYkcKLcqqm_tSgO7RkU20yBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2021/6/28 下午6:32, Yongji Xie 写道:
>> The large barrier is bounce-buffer mapping: SPDK requires hugepages
>> for NVMe over PCIe and RDMA, so take some preallcoated hugepages to
>> map as bounce buffer is necessary. Or it's hard to avoid an extra
>> memcpy from bounce-buffer to hugepage.
>> If you can add an option to map hugepages as bounce-buffer,
>> then SPDK could also be a potential user of vduse.
>>
> I think we can support registering user space memory for bounce-buffer
> use like XDP does. But this needs to pin the pages, so I didn't
> consider it in this initial version.
>

Note that userspace should be unaware of the existence of the bounce buffer.

So we need to think carefully of mmap() vs umem registering.

Thanks

