Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C3E31D6D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 10:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhBQJLe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 04:11:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21853 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231713AbhBQJLc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 04:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613553005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RFusShBhS4qAoH9QAhjf7bQvV8GQfYBBL88bdpAsQow=;
        b=QPdvjnnP1R+9gDV+zmUc4lsAfj3h4fAdrT00RlaRS239TPavBbmoHfvl0eSd8kSaWWkVqS
        kFnkyIURfm7E+iCTCynmhm2oniGo+xt8Sw+7SaTZgsoZKxcAVNm4zj312tN5mifd5jyFhS
        SVKa7RioOiS9Ht0JqBy59sjImoK4WHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-8jQz2_2HM-mUSQwRkBX7UA-1; Wed, 17 Feb 2021 04:10:03 -0500
X-MC-Unique: 8jQz2_2HM-mUSQwRkBX7UA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C3E81020C20;
        Wed, 17 Feb 2021 09:10:01 +0000 (UTC)
Received: from [10.36.114.178] (ovpn-114-178.ams2.redhat.com [10.36.114.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF16660C62;
        Wed, 17 Feb 2021 09:09:58 +0000 (UTC)
Subject: Re: [RFC PATCH] mm, oom: introduce vm.sacrifice_hugepage_on_oom
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     felipe.franciosi@nutanix.com
References: <20210216030713.79101-1-eiichi.tsukata@nutanix.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <dc18e98e-2467-bb36-7f78-d7003d9aa5f9@redhat.com>
Date:   Wed, 17 Feb 2021 10:09:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210216030713.79101-1-eiichi.tsukata@nutanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 16.02.21 04:07, Eiichi Tsukata wrote:
> Hugepages can be preallocated to avoid unpredictable allocation latency.
> If we run into 4k page shortage, the kernel can trigger OOM even though
> there were free hugepages. When OOM is triggered by user address page
> fault handler, we can use oom notifier to free hugepages in user space
> but if it's triggered by memory allocation for kernel, there is no way
> to synchronously handle it in user space.
> 
> This patch introduces a new sysctl vm.sacrifice_hugepage_on_oom. If
> enabled, it first tries to free a hugepage if available before invoking
> the oom-killer. The default value is disabled not to change the current
> behavior.

In addition to the other comments, some more thoughts:

What if you're low on kernel memory but you end up freeing huge pages 
residing in ZONE_MOVABLE? IOW, this is not zone aware.

-- 
Thanks,

David / dhildenb

