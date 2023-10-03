Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29207B730D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 23:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjJCVIy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 17:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjJCVIx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:08:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CC0AF
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 14:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696367297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iZqudPdFmsqAX0i25tQhq4N6QuLZbaMC0GnCxXAloB4=;
        b=dHmSqd0YA51X3mozsy0GXR733MUv5UUM3QFn+vaI0eUeMrOjbDo7Eq61tIazZMJnYzOlAf
        RZdGsKfzpft8gt88DgWsS1LHEqOOLQtbnI0sBu6SB3vHMvHn4p4vJ6AyGznZ9DJNBgFxdM
        O8oBKVbLwv8u9sedFqWhI7YJwZL2Vjk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-bgsFKaIsNka3RE4nyYugqw-1; Tue, 03 Oct 2023 17:08:11 -0400
X-MC-Unique: bgsFKaIsNka3RE4nyYugqw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4059475c174so11224945e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Oct 2023 14:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696367290; x=1696972090;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZqudPdFmsqAX0i25tQhq4N6QuLZbaMC0GnCxXAloB4=;
        b=ZDNB1d8GZIeEALryN9kgwiMtNxwd0dB1cqjh3zlhaIGALKtyimw/uLaplTmMy3nVHW
         jxah3uPfvbod46dcocpbS3fA4AzsKK6WwA6DiTmsDKPfc89QQUvraLMc02CUbk0IrQxd
         uGvE7Rz/gR87Jy3QyhPlOChsTZqbEn9VeVbgVuAs0FSXyRtrAyW5Dna2/qlcPz6paoCR
         gSMl3fyVolMVflUcMRJP128ASUFyXVM5/P0Z9kw/9vVoIh/P1Akoli+cCj66IsbitE2R
         2en2X+pIIoidrRO4AJ2xvMg85Xj9ghB29Vyzvn1RQwD0iuYabE0cf0ANmLxLhmhUBoae
         ibwg==
X-Gm-Message-State: AOJu0YwyBLYk9fz3r2LBE0NGX2ME65KToKp+lgXWrUJmO+flIGwiYPc6
        DcvbLzmoXmX2PJZL+2+t1hUqyUfAozW82FHE7G9l1HjhJ7Begpiu8/bYk3j3IysnqVJhJsAcMyG
        WH6XYZKxlbwaNXKxZTS7Ur2t5Xw==
X-Received: by 2002:a7b:c451:0:b0:401:aa8f:7562 with SMTP id l17-20020a7bc451000000b00401aa8f7562mr649083wmi.11.1696367290205;
        Tue, 03 Oct 2023 14:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3Eewd0OYhzLMEft9jgHfzauv7z/0zio9oUhdJ+EuXuDZ6P60kvlN4IwqdpM02c5om1hVGew==
X-Received: by 2002:a7b:c451:0:b0:401:aa8f:7562 with SMTP id l17-20020a7bc451000000b00401aa8f7562mr649063wmi.11.1696367289788;
        Tue, 03 Oct 2023 14:08:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c736:1b00:e1fc:b01b:70f5:1985? (p200300cbc7361b00e1fcb01b70f51985.dip0.t-ipconnect.de. [2003:cb:c736:1b00:e1fc:b01b:70f5:1985])
        by smtp.gmail.com with ESMTPSA id z15-20020a1c4c0f000000b003fee6e170f9sm31441wmf.45.2023.10.03.14.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 14:08:09 -0700 (PDT)
Message-ID: <c837fc02-3dbd-ba88-dacb-cf150272a4c4@redhat.com>
Date:   Tue, 3 Oct 2023 23:08:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        Jann Horn <jannh@google.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
References: <ZRW2CBUDNks9RGQJ@x1n>
 <85e5390c-660c-ef9e-b415-00ee71bc5cbf@redhat.com> <ZRXHK3hbdjfQvCCp@x1n>
 <fc27ce41-bc97-91a7-deb6-67538689021c@redhat.com> <ZRrf8NligMzwqx97@x1n>
 <CA+EESO5VtrfXv-kvDsotPLXcpMgOK5t5c+tbXZ7KWRU2O_0PBQ@mail.gmail.com>
 <CA+EESO4W2jmBSpyHkkqZV0LHnA_OyWQcvwSkfPcWmWCsAF5UWw@mail.gmail.com>
 <9434ef94-15e8-889c-0c31-3e875060a2f7@redhat.com>
 <CA+EESO4GuDXZ6newN-oF43WOxrfsZ9Ejq8RJNF2wOYq571zmDA@mail.gmail.com>
 <CAJuCfpE_h7Bj41sBiADswkUfVCoLXANuQmctdYUEgYjn6fHSCw@mail.gmail.com>
 <ZRx31TKFDGRatoC8@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZRx31TKFDGRatoC8@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.10.23 22:21, Peter Xu wrote:
> On Tue, Oct 03, 2023 at 01:04:44PM -0700, Suren Baghdasaryan wrote:
>> Ok, I think it makes sense to implement the strict remap logic but in
>> a way that we can easily add copy fallback if that's needed in the
>> future. So, I'll change UFFDIO_REMAP to UFFDIO_MOVE and will return
>> some unique error, like EBUSY when the page is not PAE. If we need to
>> add a copy fallback in the future, we will add a
>> UFFDIO_MOVE_MODE_ALLOW_COPY flag and will implement the copy
>> mechanism. Does that sound good?
> 
> For the clear failing approach, sounds all good here.
> 
> For the name, no strong opinion, but is there any strong one over MOVE?

See my reply regarding MOVE (+zero-copy optimization) vs. REMAP. Just my 
thoughts.

REMAP reminds me of mremap, which would never perform any copies, 
because it can just do more expensive page remappings (modifying VMAs etc.).

> MOVE is a fine name, however considering UFFDIO_REMAP's long history.. I
> tend to prefer keeping it called as REMAP - it still sounds sane, and
> anyone who knows REMAP will know this is exactly that.

Sorry I have to ask: has this ever been discussed on the list? I don't 
see any pointers. If not, then probably the number of people that know 
about the history can be counted with my two hands and that shouldn't be 
the basis for making decisions.

But again, remap vs. move is for me a semantical difference; and as I am 
not a native speaker others might disagree and I might be just wrong.

-- 
Cheers,

David / dhildenb

