Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD091416223
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 17:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241976AbhIWPgY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 11:36:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60176 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233143AbhIWPgY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632411291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B6vU7I66Oh4IvVlNoUJK6FShhyszDTfSEBuK0IXxA/U=;
        b=B/b0Ij56L4nxhTS01WGLvOi5pc7UNGaoFFuwXruZ8mG8degF0hQMU0TWWcTNr6dRQmpf+H
        7kdX1oWeSoNGdewKXlGjdlYpgJcNXobKLLSPcjw543YwuvtqQm7ViP/EW8iR5jW4hyzWC8
        CNIVPTVvHcDiTg107j8T+z6KDSiImU4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-N2JRr8otO2-oMoUS57RSoA-1; Thu, 23 Sep 2021 11:34:50 -0400
X-MC-Unique: N2JRr8otO2-oMoUS57RSoA-1
Received: by mail-wr1-f72.google.com with SMTP id i4-20020a5d5224000000b0015b14db14deso5430850wra.23
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 08:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=B6vU7I66Oh4IvVlNoUJK6FShhyszDTfSEBuK0IXxA/U=;
        b=RFy2vvv0WtMrAWy9qKADSeAFRlHVViOxeXeWlqc+gp3lt1zaDc8fxpQIh7pbgeqRtl
         R3Jvd43lSCOWyYRDAS/w6uy0S6iVc5bd3yOxIICjmF/zRStZVVmoJBTVZ9dP+HR285+4
         uUOl9CqzgI20GMixzxADsPlldCTk7ttwvVM9ssZNANa420AfZcrF0ju7dhRCE7b2+3P3
         2wfcGTmqfr1ISQf7/orf6mj3Shc3bhwXSWvkAP/7OSVFAw0uzIE12ywEmRyWLR6xiA3W
         72/ovC28eQtCN1BRp+gPZnKqGPuAyKDDJ4pnAPF/iqBpQfCq6pNPDOxAOF4I6q3ADCge
         UiaQ==
X-Gm-Message-State: AOAM530jNE+KvDYTNgK5tNWFN4b4YsV6oxVq0rzfIVNfpz7rm5qSbDBz
        a/XUkf7IsvRl9xjG8o1WC+ciMjhEEmXNNQHafSwyq50RuUk/94RwBXMzEeoP5xBxSWfyaOykD4f
        QY0y6yL+K7c13cqb0+MpRU/w8Lg==
X-Received: by 2002:a05:600c:4a16:: with SMTP id c22mr16730724wmp.72.1632411289511;
        Thu, 23 Sep 2021 08:34:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBZhyVs/6Bg7XD0uHKGpE7WMvutAt47Dpksuv26PSDqXvvl4mTPp5CHm/1FAbKd+sEANHxSg==
X-Received: by 2002:a05:600c:4a16:: with SMTP id c22mr16730710wmp.72.1632411289286;
        Thu, 23 Sep 2021 08:34:49 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23e5d.dip0.t-ipconnect.de. [79.242.62.93])
        by smtp.gmail.com with ESMTPSA id b187sm9825989wmd.33.2021.09.23.08.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 08:34:48 -0700 (PDT)
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
 <e567ad16-0f2b-940b-a39b-a4d1505bfcb9@redhat.com>
 <YUybu+OCpCM2lZJu@moria.home.lan>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: Struct page proposal
Message-ID: <2116e35d-019d-67e3-e163-a0ef0a821a87@redhat.com>
Date:   Thu, 23 Sep 2021 17:34:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YUybu+OCpCM2lZJu@moria.home.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23.09.21 17:22, Kent Overstreet wrote:
> On Thu, Sep 23, 2021 at 11:03:44AM +0200, David Hildenbrand wrote:
>> Don't get me wrong, but before there are answers to some of the
>> very basic questions raised above (especially everything that lives
>> in page->flags, which are not only page flags, refcount, ...) this
>> isn't very tempting to spend more time on, from a reviewer
>> perspective.
> 
> Did you miss the part of the folios discussion where we were talking
> about how acrimonious it had gotten and why, and talking about (Chris
> Mason in particular) writing design docs up front and how they'd been
> pretty successful in other places?
> 
> We're trying something new here, and trying to give people an
> opportunity to discussion what we're trying to do _before_ dumping
> thousands and thousands of lines of refactoring patches on the list.
> 

This here is different: the very basic questions haven't been solved.
Folios compiled. Folios worked. I stopped following the discussion at 
one point, though.

Again, don't get me wrong, but what I read in this mail was "I don't
know how to solve most of this but this is what we could do.".

Would we want to reduce the struct page size? Sure! Do we have a
concrete plan on how all the corner cases would work? No.

IIRC Windows uses exactly one pointer (8 bytes) to track the state of a 
physical page by linking it into the right list. So what would you say 
if I proposed that without tackling the hard cases?

Corner cases is what make it hard. Memory holes. Memory hot(un)plug. 
Page isolation. Memory poisoning. Various memory allocators. Lock-free 
physical memory walkers. And that's all outside the scope of filesystems.

-- 
Thanks,

David / dhildenb

