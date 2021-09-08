Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1ED3403D2E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 17:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352202AbhIHQAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 12:00:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352177AbhIHQAy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 12:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631116786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nNGQxhgl92hWe/3FtCW1Csy9gPO2VqfXKxGZzqH+8fM=;
        b=SwP5RoLM1shtTU4HSgZQsYkY2N0VGaXBZeJzY4wZMczDQBg5NRN+bOu4BzULQ1ISL4wPyZ
        q2n1lwuR7OxnGUvKqygHAhVLrYnIsFf8y9/JYhkLFqb1shETAH2mCKAd+Duq56VJzmXmNX
        kkCguYstJyPoNjxix+g4Z0b+I5yKONk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-zLdX8V9KO0-hqcY_P7F0MA-1; Wed, 08 Sep 2021 11:59:45 -0400
X-MC-Unique: zLdX8V9KO0-hqcY_P7F0MA-1
Received: by mail-wm1-f72.google.com with SMTP id x10-20020a7bc20a000000b002f8cf761457so800961wmi.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Sep 2021 08:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nNGQxhgl92hWe/3FtCW1Csy9gPO2VqfXKxGZzqH+8fM=;
        b=mcoAa0H6LqafNzS0jfrwgECkBlazXCxATP6sAy7IGYTSB5uSbWJi9inaHAp981b57z
         +Q2pFsM9o7EETjguRh/lDQXaZACTbV58noVxCr+qB9S/LRiEvWwd1EyB5lz+lqGagLxI
         qvLLNl3JFPWpqQU5yypnfGJ+BqaAJebayuG2+fLy6fjPmgqEozw6Fklqr24OmiPAk2OE
         +lM/w6vOObUedndnnsb+ncuX7K3tv7eOYxZjWg2ibi7Jxivezz5ZwJO1NvD/FoZC95it
         JG1XPf5XaTCXdlltUGJltwWY6F/R2WePQh+wLo6zjzR8QDTZoXLTA4v/kLK3RX9co5mB
         qqIQ==
X-Gm-Message-State: AOAM533lyWggebP5maOQwF1CW8fh0WMx3LePADCFwzTSPhXrmXzN9sX6
        rhPPt29mi2jav+PMd/XFG1JR8HHYUCHh2jQk8ly1FEAYoI1YKWgXdXb8pbI+tq+iwmfwyEY/RSa
        RvVJ4OwNOw/91erkR+YmoblhjuA==
X-Received: by 2002:a5d:5241:: with SMTP id k1mr5057151wrc.14.1631116784251;
        Wed, 08 Sep 2021 08:59:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbV4MVn6sYe3duHRKvKFgkXf7OfAeyy0HcyFVucgkBnamnZJUt5EmSeR3LM818BjuO31ao5Q==
X-Received: by 2002:a5d:5241:: with SMTP id k1mr5057132wrc.14.1631116784080;
        Wed, 08 Sep 2021 08:59:44 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6125.dip0.t-ipconnect.de. [91.12.97.37])
        by smtp.gmail.com with ESMTPSA id g1sm2745480wrc.65.2021.09.08.08.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 08:59:43 -0700 (PDT)
Subject: Re: [PATCH v1] hugetlbfs: s390 is always 64bit
To:     linux-kernel@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20210908154506.20764-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <3f9d1394-600b-5851-670d-71f1ab13a88a@redhat.com>
Date:   Wed, 8 Sep 2021 17:59:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210908154506.20764-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08.09.21 17:45, David Hildenbrand wrote:
> No need to check for 64BIT. While at it, let's just select
> ARCH_SUPPORTS_HUGETLBFS from arch/s390x/Kconfig.
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: linux-s390@vger.kernel.org
> Cc: linux-mm@vger.kernel.org

^ wishful thinking, lol

Cc: linux-mm@kvack.org


-- 
Thanks,

David / dhildenb

