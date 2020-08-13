Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2009F2435E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 10:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgHMIVg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 04:21:36 -0400
Received: from foss.arm.com ([217.140.110.172]:51522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgHMIVf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:21:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 291C61063;
        Thu, 13 Aug 2020 01:21:35 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E13B73F70D;
        Thu, 13 Aug 2020 01:21:32 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] mmap locking API: add mmap_lock_is_contended()
To:     Chinwen Chang <chinwen.chang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Song Liu <songliubraving@fb.com>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Huang Ying <ying.huang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        wsd_upstream@mediatek.com
References: <1597284810-17454-1-git-send-email-chinwen.chang@mediatek.com>
 <1597284810-17454-2-git-send-email-chinwen.chang@mediatek.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <a28c900c-f3a2-e39f-b5d9-9e6a34d1b168@arm.com>
Date:   Thu, 13 Aug 2020 09:21:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597284810-17454-2-git-send-email-chinwen.chang@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/08/2020 03:13, Chinwen Chang wrote:
> Add new API to query if someone wants to acquire mmap_lock
> for write attempts.
> 
> Using this instead of rwsem_is_contended makes it more tolerant
> of future changes to the lock type.
> 
> Signed-off-by: Chinwen Chang <chinwen.chang@mediatek.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   include/linux/mmap_lock.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 0707671..18e7eae 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -87,4 +87,9 @@ static inline void mmap_assert_write_locked(struct mm_struct *mm)
>   	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
>   }
>   
> +static inline int mmap_lock_is_contended(struct mm_struct *mm)
> +{
> +	return rwsem_is_contended(&mm->mmap_lock);
> +}
> +
>   #endif /* _LINUX_MMAP_LOCK_H */
> 

