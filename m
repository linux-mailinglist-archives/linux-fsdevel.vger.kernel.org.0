Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61357A0D8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 20:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241907AbjINSwa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 14:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241913AbjINSwI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:52:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FCF92697
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 11:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694717250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=91ItEaA48PaYp5ILUtPQ0EOz3NpWw/JFlwU7DDokP0U=;
        b=H8v7pz02M0YZQq83o6gHy+7Qxt9FBnoE/sk4FDzjyVAuH8UqbKVj44u5TCz8FUOd4cN40s
        /RzHppus6yrBrkPMUChcAe5vP9xBFPuzDvlZR2KdZxuvMMYBOXKAWhGoZLYKQDupUQOwF+
        MUltAVVxCiFMTM6NjZR9GiRI2voDs+s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-4hsk2xSXMqSmbkOnsw8rsA-1; Thu, 14 Sep 2023 14:47:29 -0400
X-MC-Unique: 4hsk2xSXMqSmbkOnsw8rsA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31facb07f53so572315f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 11:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694717248; x=1695322048;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91ItEaA48PaYp5ILUtPQ0EOz3NpWw/JFlwU7DDokP0U=;
        b=JYAM3kb9oNWjehVxKHBRw78IGe7ZKkYaBC4iAk44gGrcoAxh/XXN/YAS+e6eJgcnZa
         2/nZpC9KEPZ30gcdhgnoA5fBrszmeA9L/WCdgxr01r4N7BxtcOuFXb3ShE3nbKXpoAiA
         3yBUY/cNZmNtQISOMPFgoPK5/UGTlf91uGQoSYQXOa/O0UUZ8IPYM8w7tynN5QhwnKDp
         9oLQ9bqNU4evV9IBxj/Wz1seNgOIa6xzsG567U4VzuwFKW4H+n1aypVBWfcYDQA1LxQN
         af7GO05+Ou2CdjwclScZc7lNTvGihpqPw7op/q9kSc7FN/uNVRbsXno2tBIC8md0UHhB
         CWVA==
X-Gm-Message-State: AOJu0Yzbr6UBCHA4yJq6au+iTZvoe7dL6gJZJAmV4OV/k7glOkZgSNXC
        DQm2xHpxAg47blA42FQKFSL6bf/IJkXuVP/Y/h/uhZjgEgRhTTEimCaut+V/wSWhW5zAz80te/9
        lA8CcbNoFZMYg9OBBwvyAW4Pa3Q==
X-Received: by 2002:adf:ef09:0:b0:319:6997:9432 with SMTP id e9-20020adfef09000000b0031969979432mr2074735wro.1.1694717248106;
        Thu, 14 Sep 2023 11:47:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy12DLRCd8OQHn+OojnAwrycBjGv1lx9Cp32vLLh8AHV2EYYDMTmO3oDXfBhNoF1kAoqLVgw==
X-Received: by 2002:adf:ef09:0:b0:319:6997:9432 with SMTP id e9-20020adfef09000000b0031969979432mr2074717wro.1.1694717247674;
        Thu, 14 Sep 2023 11:47:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71c:600:4630:4a91:d07:7095? (p200300cbc71c060046304a910d077095.dip0.t-ipconnect.de. [2003:cb:c71c:600:4630:4a91:d07:7095])
        by smtp.gmail.com with ESMTPSA id e11-20020a056000120b00b003196b1bb528sm2456394wrx.64.2023.09.14.11.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 11:47:27 -0700 (PDT)
Message-ID: <b7f44bff-644b-8aa6-4d0e-8f1dfd6d03d2@redhat.com>
Date:   Thu, 14 Sep 2023 20:47:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] userfaultfd: UFFDIO_REMAP uABI
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
References: <20230914152620.2743033-1-surenb@google.com>
 <20230914152620.2743033-3-surenb@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230914152620.2743033-3-surenb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14.09.23 17:26, Suren Baghdasaryan wrote:
> From: Andrea Arcangeli <aarcange@redhat.com>
> 
> This implements the uABI of UFFDIO_REMAP.
> 
> Notably one mode bitflag is also forwarded (and in turn known) by the
> lowlevel remap_pages method.

Sorry to say, but these functions are unacceptably long. Please find 
ways to structure the code in a better way.

-- 
Cheers,

David / dhildenb

