Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC007B2341
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 19:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjI1RGs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 13:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjI1RGe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:06:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBE2DD
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 10:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695920746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o5/wGCofixZwvi3PH41gwKcB6yNjtyo8RsF8JyFJAyM=;
        b=PkyzW4eNv7lpI0ULHb79voDVAX1m4YYXtEgohyUXIm2je8/rr5QJk1oEAm1dhv4d8BeEUH
        /6V3LlFsBXEfpJI6FpuHGbmmuzYx//DvsdnSwT9h1VuFyTc6g/3Jo0248QglTa65q2gTWj
        98RLDAS+FrXGIVl5nmkm/aRX4ajnORA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-eSU8i62HPkGgyLdqYJ4QnA-1; Thu, 28 Sep 2023 13:05:44 -0400
X-MC-Unique: eSU8i62HPkGgyLdqYJ4QnA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-315af0252c2so10584236f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 10:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695920743; x=1696525543;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5/wGCofixZwvi3PH41gwKcB6yNjtyo8RsF8JyFJAyM=;
        b=Y4WeyJXeThL2EvuxbTtnZ0PuePziA/1V236YdCZNkPXRP0X8U1a+mInvKJuBA0uh0V
         EorVIV2Aj8jeIXqSQ5UuNe7X7arTw4G/AotiXlF2iSY8cRn+JeOfbXtQg1btwRz48jXr
         be9oFlZFddInW/w0+0y1mYW7ILFOad12pHx7ihCLzyP7M8JJ0pZlMYpTxNsmEoI+VBSm
         XsVBzOLQjpN/yqLBehqGYl4dDeCR8VYmYB/AbVTwXAchWhpCe+CpvjryCil4pIccWuN3
         LmmQtOc53S9L0B39HVEMRNSBQCogUvDWbSCp0s6AmGaOC/UibED0ElJ8fXHkkEKT1s42
         ZtQg==
X-Gm-Message-State: AOJu0YyGfekU1y+V9WhE5eSGKgcRk9evb2xq3zYBdQWm5Ctb+MLX/yw5
        gfdCFHKTQWNtnv7CkxjL5aEDanupeORtyAnIEngAvjFPQbL9OJObw8OlZimK5W+CSCH337oW5Tt
        OFJXucDKvg2kP6FgEyCTiTYJikg==
X-Received: by 2002:adf:ce8b:0:b0:321:66a5:4da4 with SMTP id r11-20020adfce8b000000b0032166a54da4mr1829446wrn.2.1695920742805;
        Thu, 28 Sep 2023 10:05:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERTxVsRw8PBt/UNjmDxfFO2N+rZGMaLmfr39sZgf/NmLF39wf/w/uu7CxYnbR6wcmEiiC1UA==
X-Received: by 2002:adf:ce8b:0:b0:321:66a5:4da4 with SMTP id r11-20020adfce8b000000b0032166a54da4mr1829421wrn.2.1695920742351;
        Thu, 28 Sep 2023 10:05:42 -0700 (PDT)
Received: from [192.168.3.108] (p5b0c6ff2.dip0.t-ipconnect.de. [91.12.111.242])
        by smtp.gmail.com with ESMTPSA id y5-20020adfd085000000b003217c096c1esm907619wrh.73.2023.09.28.10.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 10:05:41 -0700 (PDT)
Message-ID: <98b21e78-a90d-8b54-3659-e9b890be094f@redhat.com>
Date:   Thu, 28 Sep 2023 19:05:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     Peter Xu <peterx@redhat.com>
Cc:     Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
References: <20230923013148.1390521-1-surenb@google.com>
 <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com>
 <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com> <ZRWo1daWBnwNz0/O@x1n>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZRWo1daWBnwNz0/O@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28.09.23 18:24, Peter Xu wrote:
> On Wed, Sep 27, 2023 at 03:29:35PM +0200, David Hildenbrand wrote:
>>>> +       if (!pte_same(*src_pte, orig_src_pte) ||
>>>> +           !pte_same(*dst_pte, orig_dst_pte) ||
>>>> +           folio_test_large(src_folio) ||
>>>> +           folio_estimated_sharers(src_folio) != 1) {
>>
>> ^ here you should check PageAnonExclusive. Please get rid of any implicit
>> explicit/implcit mapcount checks.
> 
> David, is PageAnon 100% accurate now in the current tree?
> 
> IOW, can it be possible that the page has total_mapcount==1 but missing
> AnonExclusive bit in any possible way?

As described as reply to v1, without fork() and KSM, the PAE bit should 
stick around. If that's not the case, we should investigate why.

If we ever support the post-fork case (which the comment above 
remap_pages() excludes) we'll need good motivation why we'd want to make 
this overly-complicated feature even more complicated.

-- 
Cheers,

David / dhildenb

