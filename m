Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 043ADEC507
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 15:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfKAOto (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 10:49:44 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:43215 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfKAOto (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 10:49:44 -0400
Received: by mail-il1-f193.google.com with SMTP id j2so6766272ilc.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Nov 2019 07:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OvG/qWeSbh1TxLgtmArlVNDYsoALFmkQsSm7UaGBE/U=;
        b=I8fTjuu/6Ne32KB3TzlkLHNc34FVVQHy/sTVoKvVYeIrGIs/zEWpPkdT4X2FTYZjfJ
         UM4GFAou96icNjK1AVI5vEOtitRVjbXgZfqaanuntVF/vhTirkZT/9E+CWJUq7E2TQj0
         StXEuMWcR5zlKYK8R7EGKhYIJ+Gb4ciY1IEMBuLWPRJg6NDyeWhuiAg3JUaKBbPDkQbL
         sElozNdk4t7DFMJr/2GTc4DXhCqAVsopLQpS5jb3DWebvxakkqFHF/FpNq1kpaMflaeM
         i/d5Nr3Kf7lOCXzSXk2CZXk0I+pfGJSDm0die6SS7xUqTydNbrFVI18tKwuFsQOAi/MB
         kf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OvG/qWeSbh1TxLgtmArlVNDYsoALFmkQsSm7UaGBE/U=;
        b=Hhtx0wnzGDRQNYsOdnqyhCpDYq9JTUEMNm8xEkt4adof4CTN1PbJhh9FKAllWfNBYw
         l7hMXDDvQ3FjPm+RuKHZyNSZ9OVukIEMdluEpj92gnYmH5EFj04f+fXYh++b7jXnWO3t
         ZIB8lowZDxUuSNK99+IHXlgHy5VEKo9fwDh0APGTjY8QdEMPH4hkO64wMMhZgp6Xowad
         52W2aRjd3TQh6uTGyS0HnlPDqyJDnXCEAm3YvvwNdjfW7yjlKBfZqNa+aQ2YNrDJYVMy
         v6vNE+Z2Py5jDcmOFYhxxDo/JhZKeAWi/uawB7fCwqiu8/QgAyAtzyugWyeQkEnS8Hnp
         J+Fw==
X-Gm-Message-State: APjAAAW1+O7yEN6KeeqyJ+dnDgkvQLIMbNtJpg0NvaXM2m7XhV+OWREF
        DnKmmjFGo0AETbs5b8DXnUEJJA==
X-Google-Smtp-Source: APXvYqxr+bs1ScRWYKeCxmeXCSlj6Q4Lr6KXKYyS2zYjKblHkVBUMc7IPKJ+YzvkERiHaP9xr0/5Lg==
X-Received: by 2002:a92:5d8f:: with SMTP id e15mr13331860ilg.173.1572619783709;
        Fri, 01 Nov 2019 07:49:43 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f73sm1107827ild.59.2019.11.01.07.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 07:49:42 -0700 (PDT)
Subject: Re: [PATCH 10/19] fs/io_uring: set FOLL_PIN via pin_user_pages()
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Chinner <david@fromorbit.com>,
        David Airlie <airlied@linux.ie>,
        "David S . Miller" <davem@davemloft.net>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, bpf@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rdma@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
References: <20191030224930.3990755-1-jhubbard@nvidia.com>
 <20191030224930.3990755-11-jhubbard@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <979ba2a3-ee04-fb12-204d-1b68c7b6e141@kernel.dk>
Date:   Fri, 1 Nov 2019 08:49:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030224930.3990755-11-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/19 4:49 PM, John Hubbard wrote:
> Convert fs/io_uring to use the new pin_user_pages() call, which sets
> FOLL_PIN. Setting FOLL_PIN is now required for code that requires
> tracking of pinned pages, and therefore for any code that calls
> put_user_page().

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

