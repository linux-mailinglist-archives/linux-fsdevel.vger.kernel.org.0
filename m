Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA83429B22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 03:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhJLBqZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 21:46:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27396 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229677AbhJLBqY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 21:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634003062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N7XuxV1xdve3zt5mwi5zf9rSsN0pawUAPW+pIisdSIo=;
        b=ax131Si4wF6HBCBurh5MKfTQ53AiYwmsU+iAF0zhelt0JGdnFHnA6BtZ2M+ZrzhAXdi1Ca
        leTF/rVTyfPmV0yiPYI3hJQ3xbtn5lVBfo7q4aplZkd5rzx5kOqtrwGVGUgsu/0VmrFXDc
        odDzbtOA7xtSXXVFgY/Ku3ots82LYk0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-jnj7QpoNP3GVlP2doqk2vw-1; Mon, 11 Oct 2021 21:44:21 -0400
X-MC-Unique: jnj7QpoNP3GVlP2doqk2vw-1
Received: by mail-pg1-f197.google.com with SMTP id u5-20020a63d3450000b029023a5f6e6f9bso7792471pgi.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Oct 2021 18:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N7XuxV1xdve3zt5mwi5zf9rSsN0pawUAPW+pIisdSIo=;
        b=MK2wXi/f0/gM5j8+dXC0OMhM2zqpgQu0xJlnHw3E88z/YVvz9N72CSZU7gqdK42Q4t
         pGcnfczPrLV2p5f8H4OaX1qSzXmxZ1k5/AvSghnQTlt6eR9+F1S4xZk21VufmYl51ILo
         J1JfX7fWc+37tYfKWrkwxWRCRE1j7Wec2v/ZtVYgQDMziMlGPCB+za9/LTVOXU8uKrFf
         sUPZkc80VIxaHp+IqwebbKYcmyfxyTv7t35NnKyr9xXHAIUleCGZG0XmvVCs5DmDxw5C
         qKgjgzV+pMq2RGsRlgOv5iEdyOpa/bwLCjSM+BiGBrSLwj7l3hx4ggeBxvsdxguwG+a1
         GGkQ==
X-Gm-Message-State: AOAM531zU3xMMvjZJzw20UgpfD6Snw5v37f/AhdkQiNoX8RvEuSCWYlC
        D4KTwy//ImC7Xke90FXZCc4ytqNHWflb6iA5tFJae2a7vUkqxt8n6yqjx7wnvQzfVhK0Xq3zP3H
        mHua0ZgKUoHo/YMO9kMwfwkOCVg==
X-Received: by 2002:a17:90b:3852:: with SMTP id nl18mr2829327pjb.9.1634003060507;
        Mon, 11 Oct 2021 18:44:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlbuOxtzFHegnIMLUhs4POPvF85B+TNSTe0D0W5qKedOJQ0nmMQPvf79G11R3u3blaCXq0jw==
X-Received: by 2002:a17:90b:3852:: with SMTP id nl18mr2829308pjb.9.1634003060166;
        Mon, 11 Oct 2021 18:44:20 -0700 (PDT)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a22sm9062988pfg.61.2021.10.11.18.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 18:44:19 -0700 (PDT)
Date:   Tue, 12 Oct 2021 09:44:12 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
Message-ID: <YWTobPkBc3TDtMGd@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-3-shy828301@gmail.com>
 <YV4Dz3y4NXhtqd6V@t490s>
 <CAHbLzkp8oO9qvDN66_ALOqNrUDrzHH7RZc3G5GQ1pxz8qXJjqw@mail.gmail.com>
 <CAHbLzkqm_Os8TLXgbkL-oxQVsQqRbtmjdMdx0KxNke8mUF1mWA@mail.gmail.com>
 <YWTc/n4r6CJdvPpt@t490s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWTc/n4r6CJdvPpt@t490s>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 11, 2021 at 08:55:26PM -0400, Peter Xu wrote:
> Another thing is I noticed soft_offline_in_use_page() will still ignore file
> backed split.  I'm not sure whether it means we'd better also handle that case
> as well, so shmem thp can be split there too?

Please ignore this paragraph - I somehow read "!PageHuge(page)" as
"PageAnon(page)"...  So I think patch 5 handles soft offline too.

-- 
Peter Xu

