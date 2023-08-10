Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C33777E9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 18:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbjHJQuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 12:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjHJQuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:50:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEBC268E
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 09:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691686172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tge3O5xH64mxBw706PQBRXVPAQR3V2nMkvoZ63xOAkM=;
        b=VCL8S9eJ0Eg+0phM0U70dyD2jh86/g6IMOHqZF4jKKA5nTxiXLXdnWZEd4fRYMqs4xpPoj
        b+aq+7auN9TkZmeBftEeWrm371254KLSZEH5nxp7qTHG/Z+ju8z+1YZn0UVxggGJZ+wTxp
        p31wgKXCLz6tB6iWLompNwszJdUUhm0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-RzNEkCQeOzagBTFRPfy8XQ-1; Thu, 10 Aug 2023 12:49:30 -0400
X-MC-Unique: RzNEkCQeOzagBTFRPfy8XQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30932d15a30so755121f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 09:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691686169; x=1692290969;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tge3O5xH64mxBw706PQBRXVPAQR3V2nMkvoZ63xOAkM=;
        b=cSK25MWKK11G6Rl9Y23KGNI17okKNnXcesZf9DmzDrHpkEvpqklLLnTrZPNGjSsyJu
         S/Jm3BLS2bu5ueQLHHHMP5lh7vci2hBTLN2IQUIKB5J4WU9VBkP4/qXlArE2u+xs68oA
         REbLq/SSX18xRfivdE4/YrdaAu51DgNICzdHCjKbCkefma5TuWAJdjcAzs6Wsk3EKKO3
         gEJScEMqnAfC+R/MP9jJ5OhpFR9T5dcKGelWuZBzBy7cue4FFgxDPrlBh1ZBF/CSbMLt
         xoVQKhXNOPvvpQc9AIbe0WdnvzHE6kX+VbVBms4D+FLcyC+89bXxedV+zsCXlsHGevGW
         TWvw==
X-Gm-Message-State: AOJu0YxCgQ7aiOFGCKrbgHPAzL7Oam77zKZqocFadudb0/K1gpC+p0Jy
        gWAq4LbB9JG23CyuU+JBBKl2WoQS+Qo2N8DO69wCjTYgqjcj60UvJhSkeFHP9/6amGRSh50iK01
        3rpaXq4NkfG+cRr1Q6VCcQZHeXA==
X-Received: by 2002:adf:d08f:0:b0:314:15a8:7879 with SMTP id y15-20020adfd08f000000b0031415a87879mr2255454wrh.34.1691686169543;
        Thu, 10 Aug 2023 09:49:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq1BI0Gqfj+OV17MjOWpCbOf7zfRKHjnaHO0MoYGdJDjgjD3C4QZsV1UEojpyIp/BuDW68EA==
X-Received: by 2002:adf:d08f:0:b0:314:15a8:7879 with SMTP id y15-20020adfd08f000000b0031415a87879mr2255431wrh.34.1691686169133;
        Thu, 10 Aug 2023 09:49:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:8a00:8200:f041:4b87:a8be? (p200300cbc71a8a008200f0414b87a8be.dip0.t-ipconnect.de. [2003:cb:c71a:8a00:8200:f041:4b87:a8be])
        by smtp.gmail.com with ESMTPSA id o17-20020adfe811000000b0031762e89f94sm2657508wrm.117.2023.08.10.09.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 09:49:28 -0700 (PDT)
Message-ID: <6a7bff41-259b-89f3-1a46-5b5b73d3fea1@redhat.com>
Date:   Thu, 10 Aug 2023 18:49:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH mm-unstable fix] mm: userfaultfd: check for start + len
 overflow in validate_range: fix
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Yu Zhao <yuzhao@google.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        syzbot+42309678e0bc7b32f8e9@syzkaller.appspotmail.com
References: <20230714182932.2608735-1-axelrasmussen@google.com>
 <8fbb5965-28f7-4e9a-ac04-1406ed8fc2d4@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <8fbb5965-28f7-4e9a-ac04-1406ed8fc2d4@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10.08.23 17:53, Ryan Roberts wrote:
> On 14/07/2023 19:29, Axel Rasmussen wrote:
>> This commit removed an extra check for zero-length ranges, and folded it
>> into the common validate_range() helper used by all UFFD ioctls.
>>
>> It failed to notice though that UFFDIO_COPY *only* called validate_range
>> on the dst range, not the src range. So removing this check actually let
>> us proceed with zero-length source ranges, eventually hitting a BUG
>> further down in the call stack.
>>
>> The correct fix seems clear: call validate_range() on the src range too.
>>
>> Other ioctls are not affected by this, as they only have one range, not
>> two (src + dst).
>>
>> Reported-by: syzbot+42309678e0bc7b32f8e9@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=42309678e0bc7b32f8e9
>> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>> ---
>>   fs/userfaultfd.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
>> index 53a7220c4679..36d233759233 100644
>> --- a/fs/userfaultfd.c
>> +++ b/fs/userfaultfd.c
>> @@ -1759,6 +1759,9 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
>>   			   sizeof(uffdio_copy)-sizeof(__s64)))
>>   		goto out;
>>   
>> +	ret = validate_range(ctx->mm, uffdio_copy.src, uffdio_copy.len);
>> +	if (ret)
>> +		goto out;
>>   	ret = validate_range(ctx->mm, uffdio_copy.dst, uffdio_copy.len);
>>   	if (ret)
>>   		goto out;
> 
> 
> Hi Axel,
> 
> I've just noticed that this patch, now in mm-unstable, regresses the mkdirty mm
> selftest:
> 
> # [INFO] detected THP size: 2048 KiB
> TAP version 13
> 1..6
> # [INFO] PTRACE write access
> ok 1 SIGSEGV generated, page not modified
> # [INFO] PTRACE write access to THP
> ok 2 SIGSEGV generated, page not modified
> # [INFO] Page migration
> ok 3 SIGSEGV generated, page not modified
> # [INFO] Page migration of THP
> ok 4 SIGSEGV generated, page not modified
> # [INFO] PTE-mapping a THP
> ok 5 SIGSEGV generated, page not modified
> # [INFO] UFFDIO_COPY
> not ok 6 UFFDIO_COPY failed
> Bail out! 1 out of 6 tests failed
> # Totals: pass:5 fail:1 xfail:0 xpass:0 skip:0 error:0
> 
> Whereas all 6 tests pass against v6.5-rc4.
> 
> I'm afraid I don't know the test well and haven't looked at what the issue might
> be, but noticed and thought I should point it out.

That test (written by me ;) ) essentially does

src = malloc(pagesize);
dst = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE|MAP_ANON, -1, 0)
...

uffdio_copy.dst = (unsigned long) dst;
uffdio_copy.src = (unsigned long) src;
uffdio_copy.len = pagesize;
uffdio_copy.mode = 0;
if (ioctl(uffd, UFFDIO_COPY, &uffdio_copy)) {
...


So src might not be aligned to a full page.

According to the man page:

"EINVAL Either dst or len was not a multiple of the system page size, or 
the range specified by src and len or dst and len was invalid."

So, AFAIKT, there is no requirement for src to be page-aligned.

Using validate_range() on the src is wrong.

-- 
Cheers,

David / dhildenb

