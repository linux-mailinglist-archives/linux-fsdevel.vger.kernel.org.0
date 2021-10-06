Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE7F42413E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 17:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhJFPZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 11:25:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43954 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230436AbhJFPZs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633533834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WoiqEiz5IdrKb1UpAKPf4dBFpgwGZSSW64De8jBpBcM=;
        b=ioUEFJITAh/SvgI9G9/O78/DU1X8B/6fq1pmIM7XeurQoyOtN9ZF30dvOkE5BjoJnP/0/D
        uWRiRIm0dVr+Ji6SaLab2cFO7gQjBuN+1e/YVSfiojrQmiQCTLMtCk0uqpX091waaqridf
        ga0bpgnf2oYsQPZXpmB/7BymIVe8kqI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-LiMYrDhGO3arngvPlqARyQ-1; Wed, 06 Oct 2021 11:23:51 -0400
X-MC-Unique: LiMYrDhGO3arngvPlqARyQ-1
Received: by mail-wr1-f71.google.com with SMTP id x14-20020a5d60ce000000b00160b27b5fd1so2345419wrt.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Oct 2021 08:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WoiqEiz5IdrKb1UpAKPf4dBFpgwGZSSW64De8jBpBcM=;
        b=tI9lDKtqwH28Y8bA/sukx1PRmLsMhSvQoBShTYaSv2FJXMLgElrkSCVJyt5S2v23Nx
         wKNLbA/nacwVI9KB5kipjBKkzCJCVb+s6rBXgNT8mpKcADG1rLHkh572nfRUIYnljDi4
         AZbSQVrIUZo6mdakl8btMV0Nq7kQGRZgw2BaLcqjPgTZ/UGq8g4lxooQjfdaNbt80Z/F
         Ek/lNNtv4BojQJynBtMWpNvjZfx7g7xiB/PoX01N0fTDtCvS7YTvFQ9VOd4MnqKronfc
         vE2pai/A5SxFo52hHp7XAXlcrSvYL26LU20+OjnFvuCefqyFey5xIMNlzRJhljp4jz4J
         r8Ow==
X-Gm-Message-State: AOAM530SnNmQHEJUmliHX9unAIcSEYdd7ZP/VjTQ79FGQpx5r6oa8YwC
        bIoPOPGXrFEy8Puf5DV3pQQaXw5XF4/35/UilZCvUUwTsl4++yUKWeImu8kXFCDm/5nDt8jbSJT
        lgjX0gP9AaCSU6XtI5rPr7BleH23IWUnw64kapxFTlkijrmLzYA5fsp+inHPNTwcwEmnjV13kNg
        ==
X-Received: by 2002:a5d:54c5:: with SMTP id x5mr29540098wrv.47.1633533830697;
        Wed, 06 Oct 2021 08:23:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbD/raW5NJPn4bA1hSznDz4smRpmWI83BG64gzgl3ZFvCr/hW9+CSyjOBYfNGjdlF8Wa5xKg==
X-Received: by 2002:a5d:54c5:: with SMTP id x5mr29540073wrv.47.1633533830443;
        Wed, 06 Oct 2021 08:23:50 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6529.dip0.t-ipconnect.de. [91.12.101.41])
        by smtp.gmail.com with ESMTPSA id t4sm5190392wrx.39.2021.10.06.08.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 08:23:50 -0700 (PDT)
Subject: Re: [RFC] pgflags_t
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org
References: <YV25hsgfJ2qAYiRJ@casper.infradead.org>
 <YV2/NZjsmSK6/vlB@zeniv-ca.linux.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <106400c5-d3f2-e858-186a-82f9b517917b@redhat.com>
Date:   Wed, 6 Oct 2021 17:23:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YV2/NZjsmSK6/vlB@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06.10.21 17:22, Al Viro wrote:
> On Wed, Oct 06, 2021 at 03:58:14PM +0100, Matthew Wilcox wrote:
>> David expressed some unease about the lack of typesafety in patches
>> 1 & 2 of the page->slab conversion [1], and I'll admit to not being
>> particularly a fan of passing around an unsigned long.  That crystallised
>> in a discussion with Kent [2] about how to lock a page when you don't know
>> its type (solution: every memory descriptor type starts with a
>> pgflags_t)
> 
> Why bother making it a struct?  What's wrong with __bitwise and letting
> sparse catch conversions?
> 

As I raised in my reply, we store all kinds of different things in 
page->flags ... not sure if that could be worked around somehow.

-- 
Thanks,

David / dhildenb

