Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F3844E3A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 10:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhKLJLV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 04:11:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43820 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234675AbhKLJLU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 04:11:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636708109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ujeVOJaP3l3Agh5Fd01V+TO1YiXBRY47fAbGw6BqApM=;
        b=RDpsBNieUXm4ruPV2bO73mUC3pOodvMe3ljQpZS36Hq92aNmr2w+3eBuwWmNqLmSL3b7c3
        QbvqQPR3rQMvQ3Qk2G7+tEcCVxUuIodrjX1vVTH+M1FoL35aTNpb1gwAT8NZaX/Yx8mKqN
        WBTsJzNPgxCwyx+7MeAWhJ0w3CkupWo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-E2Qi09WcOXq5f37m_uHvMQ-1; Fri, 12 Nov 2021 04:08:28 -0500
X-MC-Unique: E2Qi09WcOXq5f37m_uHvMQ-1
Received: by mail-lj1-f197.google.com with SMTP id z18-20020a2e8e92000000b00218e583aff1so2740162ljk.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Nov 2021 01:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ujeVOJaP3l3Agh5Fd01V+TO1YiXBRY47fAbGw6BqApM=;
        b=8NMXH3HIWxS8kUxPlRCqy/DC6GjOBfrJnCvHOPmABU9GM6KWnbBKhdh8gB5doX50y4
         nQ1VTItuFIb9+86Srlasfwl6tObOGSQ3xEHJhOUizGsFO0ZzFgvzmT8MQr253uBV5Bd8
         74k8Ib8IXCcaeQbcH4nSqoRI2wOIRUnkWYS1hCcvBRco7dxvzpMwR1r9Nnlu00BRFRq7
         /4JvoHuEhyrkyraFy6ORdc+RMZwc0vD7mqEAgduA7NP+qVTAF6WDNAqba/V+/EcfZghM
         /cuLQCYAfBdeetdaoVGnXnGbhqxmw9tcOpIjL9GtGLkomZgXg+800iQ0f8zQqlBVbWcj
         3r2Q==
X-Gm-Message-State: AOAM532mWAkT6YmF+MiahrxW/6M2QRLWBoVMK2RVEJBSICcSmIjs1Z7G
        5trWhet/p/yQRpByUsP/1/slIBbtH3vHSNMkSk7sb4ZRW8GRvvSXCeo3h/kiYp1IyG2iCdwDGdS
        xMelUo3NebSkKKxKyXF0ztsPGumR53U6tHuBEbsSr9Q==
X-Received: by 2002:ac2:4341:: with SMTP id o1mr12750434lfl.297.1636708106673;
        Fri, 12 Nov 2021 01:08:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCc2uOBlvYGYG6DZyxhxuF39PB33M8nb2w4etD6lIMHAvP93dNADJAYeJYTDPnFUoiH+M+IkY/35BQGVeyOL4=
X-Received: by 2002:ac2:4341:: with SMTP id o1mr12750368lfl.297.1636708106001;
 Fri, 12 Nov 2021 01:08:26 -0800 (PST)
MIME-Version: 1.0
References: <20211111191800.21281-1-david@redhat.com> <20211112070113.GA19016@MiWiFi-R3L-srv>
 <21bdcecd-127c-f70e-0c7d-cb1b97caecb0@redhat.com> <20211112090116.GC19016@MiWiFi-R3L-srv>
In-Reply-To: <20211112090116.GC19016@MiWiFi-R3L-srv>
From:   David Hildenbrand <david@redhat.com>
Date:   Fri, 12 Nov 2021 10:08:14 +0100
Message-ID: <CADFyXm7uS3GN1AnF-iLpUZMFK=MwF3=NGwSZFqXPA+kK182-cQ@mail.gmail.com>
Subject: Re: [PATCH v1] proc/vmcore: fix clearing user buffer by properly
 using clear_user()
To:     Baoquan He <bhe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > "that allows supervisor mode programs to optionally set user-space
> > memory mappings so that access to those mappings from supervisor mode
> > will cause a trap. This makes it harder for malicious programs to
> > "trick" the kernel into using instructions or data from a user-space
> > program"
>
> OK, probably. I thought it's triggered in access_ok(), and tried to
> figure out why. But seems we should do something to check this in
> access_ok(), otherwise the logic of clear_user/_clear_user is not so
> reasonable. Anyway, I have learned it, thanks a lot for digging it out.
>
> By the way, I can't open above wiki article, found below commit from
> hpa. Maybe we can add some into log to tell this, not strong opinin,
> leave it to you.

Yes, now that we know the root cause I'll add some more details to the
patch description and resend -- thanks Baoquan!

