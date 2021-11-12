Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6228F44E28A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 08:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbhKLHqW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 02:46:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233893AbhKLHqQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 02:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636703006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2+bbLPuvp6j+cegdNKlEPJqnoq6OmsKUa3Sntf90VmI=;
        b=JO8ANUhqcIJJyerJWWFt5pfRjpyUv5tYzR/8VZDs6JrWppnqSbSKuzgr7FJIDbgip45Bxm
        Uj6sSAv2DJRyfssTq2ruvS7fMCaCjkf1ZHe5oFcr7ouPmqODfv+6H4ZmU/5boQrJsxAHWl
        5IBOsZnLsF/Uk9ukh4wYSjmOaZo2JfA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-E67HXO59Og6gO4PJpSCi4A-1; Fri, 12 Nov 2021 02:43:24 -0500
X-MC-Unique: E67HXO59Og6gO4PJpSCi4A-1
Received: by mail-pg1-f198.google.com with SMTP id e4-20020a630f04000000b002cc40fe16afso4511237pgl.23
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Nov 2021 23:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2+bbLPuvp6j+cegdNKlEPJqnoq6OmsKUa3Sntf90VmI=;
        b=6cxKJDWI/2mEZEtX+ZL9gSVApLl2tA+kM7p9ND8bdDUbyVRTSFF3OaXkf8AfuradWV
         M10IBrREAPYRfeUo8w54S2zivvQMq2j92EP+J+L6mI/mMmcO8eNOkDClMkeT0CO2WXAL
         kqcJGsCcYJ8w6v6OK6XzsLpBtblRCW0V+HLhDN5ea2RkykAkhOHs03pGVrhNMYgCFOM7
         Abj1J6vHFbkNk+vJTnuaRtlmBNm/tBZIw6W6KK9aHImABnLBGq/g0U0xsJo/JVOWjzMA
         IQToLJLsfWEvW+jLzBHElWb3dBoGFtEYqlqra4cbeMGxP3aZ0qtlkDYLiNyp1jR/VnKZ
         XEPQ==
X-Gm-Message-State: AOAM5302AxUZ2hQLh1ywOpZZ4oZOMxO76UkEJgWRT9GjOZWCmcyOFX1f
        Y1jRa+bpnIMHJvNK7k0DkjYMvvHIbAl8VHnIbNAF8qNUBAbfZISHMdoHkzFxjmRpKSrZjM6/hqZ
        QuOwq63erNRda8TMqA0TZL/KYjQ==
X-Received: by 2002:a62:e907:0:b0:4a0:3a71:9712 with SMTP id j7-20020a62e907000000b004a03a719712mr11992007pfh.73.1636703003573;
        Thu, 11 Nov 2021 23:43:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyW65zsGOp0tOg78dGWcQxPMcJVbcn+Q5ElOLrsIyJjMaVrE4YLHP5pKzdyX2p+4jQg0KZ6Bg==
X-Received: by 2002:a62:e907:0:b0:4a0:3a71:9712 with SMTP id j7-20020a62e907000000b004a03a719712mr11991987pfh.73.1636703003370;
        Thu, 11 Nov 2021 23:43:23 -0800 (PST)
Received: from xz-m1.local ([94.177.118.141])
        by smtp.gmail.com with ESMTPSA id h12sm5667373pfv.117.2021.11.11.23.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 23:43:22 -0800 (PST)
Date:   Fri, 12 Nov 2021 15:43:16 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4] mm: Add PM_HUGE_THP_MAPPING to /proc/pid/pagemap
Message-ID: <YY4bFPkfUhlpUqvo@xz-m1.local>
References: <20211107235754.1395488-1-almasrymina@google.com>
 <YYtuqsnOSxA44AUX@t490s>
 <CAHS8izP9zJYfqmDouA1otnD-CsQtWJSta0KhOQq81qLSTOHB4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHS8izP9zJYfqmDouA1otnD-CsQtWJSta0KhOQq81qLSTOHB4Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 10, 2021 at 09:50:13AM -0800, Mina Almasry wrote:
> On Tue, Nov 9, 2021 at 11:03 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > The ending "_MAPPING" seems redundant to me, how about just call it "PM_THP" or
> > "PM_HUGE" (as THP also means HUGE already)?
> >
> 
> So I want to make it clear that the flag is set only when the page is
> PMD mappend and is a THP (not hugetlbfs or some other PMD device
> mapping). PM_THP would imply the flag is set only if the underlying
> page is THP without regard to whether it's actually PMD mapped or not.

I see, that's fine.

However as I mentioned I still think HUGE and THP dup with each other.
Meanwhile, "MAPPING" does not sound like a boolean status on whether it's thp
mapped..

If you still prefer this approach, how about PM_THP_MAPPED?

-- 
Peter Xu

