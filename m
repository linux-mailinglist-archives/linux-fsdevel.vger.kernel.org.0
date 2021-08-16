Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D75E3EDCAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 19:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhHPRzA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 13:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229590AbhHPRzA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 13:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629136468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2v98zOI2BiyS+Z7E5GTSTF3ORDqhfzMWN2Ky3NfunAk=;
        b=hMMBa1c+mrzWBLMcme/7uju3/tpoJUf3Nk+s61ByGQkR7MggVQ0RB9BT2wsbdzJoo8hgXa
        emf3WE1STqRxULvcJ+sm5Bq0IPqd8GvLFmYfADC+oG1fhU76pcY+bO7H0lfv6BeEd/erNk
        MkWKrKBZr5MRmCiEjzHVCirc2GdRNg4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-f4eD38kOMxiA-OchSR6mZw-1; Mon, 16 Aug 2021 13:54:27 -0400
X-MC-Unique: f4eD38kOMxiA-OchSR6mZw-1
Received: by mail-wm1-f70.google.com with SMTP id w25-20020a1cf6190000b0290252505ddd56so4323917wmc.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Aug 2021 10:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2v98zOI2BiyS+Z7E5GTSTF3ORDqhfzMWN2Ky3NfunAk=;
        b=NJyMegKosVFLv5bNfE7B9E2vqoojojoJBffnQThyJ+KEgC1yuUBJAvwDOC8xUbb1N4
         9Ax/6E1dVugQsjA73FYRmwgRj7juHhA3DBX28aP2W54e/dhDVESEg3avum+tJx/mP9w0
         fQf6vYlRwGcbsX/j5FQivNFOvj/jKAddGTZfQ7mB4LUhNI1IauPRErM5vZ9DyEREiXyi
         p6EkCJavkxRWbXM93zo9IbkFU3LlBlwFPlq47l/26sL74mGchchvMEPIAC/xpzsefd1B
         vQMj/RlhY9LsbU7u41OT2lEtLklB7niVYoDUR4yi0/JE/ccn/Mrtx6iF+CaZDA+fzv65
         hmAQ==
X-Gm-Message-State: AOAM530bQXteT73Z+3ZmMJ6NQaxXi9USdlHSLk81OXBsfcwZQnv4tvof
        e1Q7E1PW+7EMdnB6qMLUev/b4RhDcuEhgqezT55o8klAL7lVkbw1S6UYscMmBUD9259jrFZAuuw
        M8KCf32hiCOffua//XyVupSY8pN9V9rpYUE9A5wJDclqZ3FlWb7NIm+0BhfNAvrbxbl+pUi2KSg
        ==
X-Received: by 2002:a1c:f206:: with SMTP id s6mr279801wmc.15.1629136465834;
        Mon, 16 Aug 2021 10:54:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAZnCmIeVVhzPxv52QvlEF7twuHTqS2Vw3CmpN+7OAFGbJOmsh5IWtA/rvCBhwF8R5G49Lag==
X-Received: by 2002:a1c:f206:: with SMTP id s6mr279784wmc.15.1629136465644;
        Mon, 16 Aug 2021 10:54:25 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c67f1.dip0.t-ipconnect.de. [91.12.103.241])
        by smtp.gmail.com with ESMTPSA id h4sm12872990wrm.42.2021.08.16.10.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 10:54:25 -0700 (PDT)
Subject: Re: [BUG] general protection fault when reading /proc/kcore
From:   David Hildenbrand <david@redhat.com>
To:     Jiri Olsa <jolsa@redhat.com>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <YRqhqz35tm3hA9CG@krava>
 <1a05d147-e249-7682-2c86-bbd157bc9c7d@redhat.com>
Organization: Red Hat
Message-ID: <d05f4d38-fdb8-29a6-202e-19d65cd0b1f1@redhat.com>
Date:   Mon, 16 Aug 2021 19:54:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1a05d147-e249-7682-2c86-bbd157bc9c7d@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 16.08.21 19:49, David Hildenbrand wrote:
> On 16.08.21 19:34, Jiri Olsa wrote:
>> hi,
>> I'm getting fault below when running:
>>
>> 	# cat /proc/kallsyms | grep ksys_read
>> 	ffffffff8136d580 T ksys_read
>> 	# objdump -d --start-address=0xffffffff8136d580 --stop-address=0xffffffff8136d590 /proc/kcore
>>
>> 	/proc/kcore:     file format elf64-x86-64
>>
>> 	Segmentation fault
>>
>> any idea? config is attached
> 
> Just tried with a different config on 5.14.0-rc6+
> 
> [root@localhost ~]# cat /proc/kallsyms | grep ksys_read
> ffffffff8927a800 T ksys_readahead
> ffffffff89333660 T ksys_read
> 
> [root@localhost ~]# objdump -d --start-address=0xffffffff89333660
> --stop-address=0xffffffff89333670
> 
> a.out:     file format elf64-x86-64


Sorry, missed the /proc/kcore part:

[root@localhost ~]# cat /proc/kallsyms | grep ksys_read
ffffffffba27a800 T ksys_readahead
ffffffffba333660 T ksys_read
[root@localhost ~]# objdump -d --start-address=0xffffffffba333660 
--stop-address=0xffffffffba333670 /proc/kcore

/proc/kcore:     file format elf64-x86-64


Disassembly of section load1:

ffffffffba333660 <load1+0x333660>:
ffffffffba333660:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
ffffffffba333665:       41 55                   push   %r13
ffffffffba333667:       49 89 d5                mov    %rdx,%r13
ffffffffba33366a:       41 54                   push   %r12
ffffffffba33366c:       49 89 f4                mov    %rsi,%r12
ffffffffba33366f:       55                      push   %rbp


-- 
Thanks,

David / dhildenb

