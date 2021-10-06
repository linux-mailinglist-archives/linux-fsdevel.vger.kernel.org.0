Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB45B4241C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 17:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbhJFPt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 11:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37982 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239025AbhJFPtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633535282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IcPCxjjKJisJ3VBwkVizgnGjb9s34GHznEsiVVY0f5A=;
        b=FyGBFbqIqbbMWvbB6TQYmwYqC/wTAwCh9Rwu4WYtMCAQYETWcXB11joC9SEJDul0su6LiR
        PqmLWX0Sabuo6Fr9ZmhvtvrR6F5qkj21bG4s0Qzm8T8C0PFgM7shItFNfwkbFvXYjWejJd
        aM7Jjj5PW0dvOg3EHBX7vqSFoATi0hE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-9dvODeqtMv-jgnfCODkGvg-1; Wed, 06 Oct 2021 11:48:01 -0400
X-MC-Unique: 9dvODeqtMv-jgnfCODkGvg-1
Received: by mail-wr1-f70.google.com with SMTP id r21-20020adfa155000000b001608162e16dso2396017wrr.15
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Oct 2021 08:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IcPCxjjKJisJ3VBwkVizgnGjb9s34GHznEsiVVY0f5A=;
        b=npiw3feTkXG0EpJeZgPYVdr0DmONYzUb+E0Uoy2z28s0Hk55lwbozimn1Co9blzwp9
         a9LAaPPzvjJf/JD5TOtnpfzosJZA/1PISxl4bsFGAvS4si2Itbo1zcbdKYUJtQC0naCg
         owdxasHDM3nc5Ccr4H5+GsjgHXYBbIKkH41ANhjafhcRrvsjgrrgnUQaYVkKJ/ybnO4L
         bz14gge7QSn68QtPKDDMGogsJxxWUmsTmrQrO7wawfvxx1iLnBJmItuotK5ga5h32UYg
         gHhkXuHxaydYaSrecyrAK72jWOBExMzgzdaXnfKSgTuBhFzqA8YG3PTnusK0Sns1QeKI
         SLTA==
X-Gm-Message-State: AOAM530OZl2JXJyEKCcGY8SdanbdvUuDKP3xc7dWOduHPSveVZIxnajw
        bzJE5UDblgSjosziXjv7tqKXwoR6FPqqbjvRT/F1pl4etF0Q872ODw9sdvFXLQZqCkILSyvOWPu
        BDW0Nu0je7nWXGuyIL82poU98hKrhMzBd1KhOJ2do0WkjFOrjOdeckbv5wT8zj/1uSADr+pTucA
        ==
X-Received: by 2002:a5d:59ae:: with SMTP id p14mr30104774wrr.278.1633535280627;
        Wed, 06 Oct 2021 08:48:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTklnLKd3Spod1ykI+TjCZjz+B2TbYaYxPdsDPTHa12wkhA18TDzVDz1dCmUuYb3NKM4kBtQ==
X-Received: by 2002:a5d:59ae:: with SMTP id p14mr30104744wrr.278.1633535280390;
        Wed, 06 Oct 2021 08:48:00 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6529.dip0.t-ipconnect.de. [91.12.101.41])
        by smtp.gmail.com with ESMTPSA id o12sm2043243wrw.73.2021.10.06.08.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 08:48:00 -0700 (PDT)
Subject: Re: [RFC] pgflags_t
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org
References: <YV25hsgfJ2qAYiRJ@casper.infradead.org>
 <YV2/NZjsmSK6/vlB@zeniv-ca.linux.org.uk>
 <106400c5-d3f2-e858-186a-82f9b517917b@redhat.com>
 <YV3ArQxQ7CFzhBhR@zeniv-ca.linux.org.uk>
 <21ce511e-7cde-8bdb-b6c6-e1278681ebf6@redhat.com>
 <YV3E6Ym1+T6Tyq17@zeniv-ca.linux.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <514dfafb-6a98-65ff-a9a7-421bbc2a0cec@redhat.com>
Date:   Wed, 6 Oct 2021 17:47:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YV3E6Ym1+T6Tyq17@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06.10.21 17:46, Al Viro wrote:
> On Wed, Oct 06, 2021 at 05:32:39PM +0200, David Hildenbrand wrote:
> 
>> It feels to me like using __bitwise for access checks and then still
>> modifying the __bitwise fields randomly via a backdoor. But sure, if it
>> works, I'll be happy if we can use that.
> 
> __bitwise == "can't do anything other than bitwise operations without
> an explicit force-cast".  All there is to it.  Hell, the very first
> use had been for things like __le32 et.al., where the primitives
> very much do non-bitwise accesses.  They are known to be safe (==
> do the same thing regardless of the host endianness).  Internally
> they contain force-casts, precisely so that the caller wouldn't
> need to.

Thanks for clarifying that :)

-- 
Thanks,

David / dhildenb

