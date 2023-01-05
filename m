Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3581E65E748
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 10:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjAEJEz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 04:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjAEJEZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:04:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB7350172
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jan 2023 01:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672909404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yJxUMJ4cc0bXFjxOxYH/8plJN+Z8JHXgOnN6m3GItqw=;
        b=F3hA9/sROyMqt0t+FuMigNPQ0EjNy1EE2AQrPXEaseWzIr47Z+RBYVK1ITJDQaNg0xnqKC
        OgJOmiPf/bAiQjHl6CzDzaN9YfGa0CyTlFc2V4i/pDNrkmlDQzn5xT+CEoNoppNnalaZhG
        Yt07pfOuNgg1NjKo7nTiD/kUMw2e2Ds=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-411-BoCaiqGCOsqBc_pwGC10Eg-1; Thu, 05 Jan 2023 04:03:22 -0500
X-MC-Unique: BoCaiqGCOsqBc_pwGC10Eg-1
Received: by mail-wr1-f71.google.com with SMTP id j18-20020adfb312000000b00293def622d1so2048253wrd.17
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jan 2023 01:03:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJxUMJ4cc0bXFjxOxYH/8plJN+Z8JHXgOnN6m3GItqw=;
        b=71giaCOFgajNsX71/6z3asCAfgLfM93+h0/iAmB/b5PVw185T5B7v0jFPTA9vQENYX
         zqf9snRTzrgwx9FRkhSH0rGLN8H3zkbuQ2SBWC393lYTx9zvL1v4oONJlrwk0vM0OkhM
         Zbscg+rBEqXbzT2liTBXLyKzOwCBkveR3Pkf5lWoiP+qrPvk+g22p10vcV+nz/9N+/C/
         OLSo2dm+jKilVDFz3uilro+glKV6LF7a5/K3SIcSSHwD6NwK8uVRdxBbXSy3dYuHLGLX
         02UbPdFmyB6Scsm6ASTPFMII2cXYYTwlWzxYQ9uZTSW4mJh9cfldAyUX2n1/9ALu8xmw
         OgMQ==
X-Gm-Message-State: AFqh2kodO73pnOGmvRYcIVvc8mAZ2T6Y6odQ3Bv6MN0SOG1LIBLxrM6+
        8ESA1dbpnG4jP9SWhue0NJrhaBYLFO8M29+cTyMjuKntTTdmM8TuYZCjSydzUQcfaa6f7tW78x0
        jhHlbYpH2K539LBMHcuvYBPMLkg==
X-Received: by 2002:a7b:ce8e:0:b0:3d7:1b84:e377 with SMTP id q14-20020a7bce8e000000b003d71b84e377mr37831288wmj.27.1672909401815;
        Thu, 05 Jan 2023 01:03:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv0Y5fQcX763RAIzRQ8PNO4w/Q2VzlNrFEMudJbNju7Ud3QGHFnC6dt54wDBWwyaGolHjuW8Q==
X-Received: by 2002:a7b:ce8e:0:b0:3d7:1b84:e377 with SMTP id q14-20020a7bce8e000000b003d71b84e377mr37831254wmj.27.1672909401521;
        Thu, 05 Jan 2023 01:03:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e? (p200300cbc7076e00ff02ec7aded5ec1e.dip0.t-ipconnect.de. [2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e])
        by smtp.gmail.com with ESMTPSA id hg9-20020a05600c538900b003cf71b1f66csm1752231wmb.0.2023.01.05.01.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 01:03:21 -0800 (PST)
Message-ID: <ed9dc172-e519-3fd5-afa4-0089b083ee10@redhat.com>
Date:   Thu, 5 Jan 2023 10:03:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/1] mm: fix vma->anon_name memory leak for anonymous
 shmem VMAs
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     hughd@google.com, hannes@cmpxchg.org, vincent.whitchurch@axis.com,
        seanjc@google.com, rppt@kernel.org, shy828301@gmail.com,
        pasha.tatashin@soleen.com, paul.gortmaker@windriver.com,
        peterx@redhat.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
        ccross@google.com, willy@infradead.org, arnd@arndb.de,
        cgel.zte@gmail.com, yuzhao@google.com, bagasdotme@gmail.com,
        suleiman@google.com, steven@liquorix.net, heftig@archlinux.org,
        cuigaosheng1@huawei.com, kirill@shutemov.name,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        syzbot+91edf9178386a07d06a7@syzkaller.appspotmail.com
References: <20230105000241.1450843-1-surenb@google.com>
 <20230104173855.48e8734a25c08d7d7587d508@linux-foundation.org>
 <CAJuCfpGHMeWSSp+ge3pPppLrQ5BpGiga=fjKmDk65GTjFDV=3w@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAJuCfpGHMeWSSp+ge3pPppLrQ5BpGiga=fjKmDk65GTjFDV=3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05.01.23 03:39, Suren Baghdasaryan wrote:
> On Wed, Jan 4, 2023 at 5:38 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Wed,  4 Jan 2023 16:02:40 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
>>
>>> free_anon_vma_name() is missing a check for anonymous shmem VMA which
>>> leads to a memory leak due to refcount not being dropped.  Fix this by
>>> calling anon_vma_name_put() unconditionally. It will free vma->anon_name
>>> whenever it's non-NULL.
>>>
>>> Fixes: d09e8ca6cb93 ("mm: anonymous shared memory naming")
>>
>> A cc:stable is appropriate here, yes?
> 
> Hmm. The patch we are fixing here was merged in 6.2-rc1. Should I CC
> stable to fix the previous -rc branch?
> 

No need for stable if it's not in a release kernel yet.

-- 
Thanks,

David / dhildenb

