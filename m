Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D467798AD9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 18:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243612AbjIHQtD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 12:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239086AbjIHQtC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:49:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A57199F
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 09:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694191691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HSHaK98jP52OExjU5ccVlB5Izk6T25mAruQGfLMmkDo=;
        b=R9uwMSk6wBCdWVHg/PHsFS5Nb7+jiizNclohulGlODx3ckEtFkE7jPdltvgeUj/l1TYLUi
        4QKmnrt6qDESOy0tXYx+IMRZnp9Kyu/pnqmhWN8QY9oWDlNdsNCLyw+MIllJhwJdCMn2L8
        /tn2h+700zadKwvlvCKT1td8QOJA4Bk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-VbCnT9ccPIaiKACSac9R_A-1; Fri, 08 Sep 2023 12:48:10 -0400
X-MC-Unique: VbCnT9ccPIaiKACSac9R_A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f5df65f9f4so17027435e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Sep 2023 09:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694191688; x=1694796488;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSHaK98jP52OExjU5ccVlB5Izk6T25mAruQGfLMmkDo=;
        b=v05Nzj0MQiUkhdIk5gHnAUG0oEl2aY3/zv4dae0oDkQ/YyobiyqbYIFhOPSlfNpu2x
         SRI0arH7puPNH+O/Qc2rrqcbfK7GikJ8Xez4OnSmX2YQeJigswAzkoP0UMg60r//hwm9
         R6qQHn731/SaswpjkV410kriEGgSowRRYfgXcfK/LZ/rYbflaRYnmTp2jj7wbC/9mNGt
         zJt+QIc76kGVKaMTkIfbKXIJPMkye39texImPP/xJm0hvSlSUqrU2fNuBwAsGTi8LDKr
         CzNi0wvnFo3VKw5culX4GqzBSSQ2mH27bnZ7jUBbrkz51OWLBu5mq52OXYtPW7Ax2Jtv
         ANuQ==
X-Gm-Message-State: AOJu0YzZuzTkrYah4Axd+BuEruKAyxpfkArwf3D9PjleUjEpZ9uLsmYw
        57jltNltgU3anzep4w6xKBzaIhnpIcPR51CM72pQb+eKapZkcDeH5ggVBJk3BkuWhlz3F+nZ4pJ
        fV9ch+sKK1sH6RveMbV89EF+8lw==
X-Received: by 2002:a05:600c:3b1e:b0:402:f536:41c5 with SMTP id m30-20020a05600c3b1e00b00402f53641c5mr2466102wms.3.1694191688094;
        Fri, 08 Sep 2023 09:48:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6vY3W7GArv4nn32cMyQOaB0I2anFfX3q4OwjsxS4Vyij+Hd9beJRo+Vd7kIAet301I2JQHA==
X-Received: by 2002:a05:600c:3b1e:b0:402:f536:41c5 with SMTP id m30-20020a05600c3b1e00b00402f53641c5mr2466087wms.3.1694191687701;
        Fri, 08 Sep 2023 09:48:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c720:d00:61ea:eace:637c:3f0f? (p200300cbc7200d0061eaeace637c3f0f.dip0.t-ipconnect.de. [2003:cb:c720:d00:61ea:eace:637c:3f0f])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fed630f560sm2398991wmj.36.2023.09.08.09.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 09:48:07 -0700 (PDT)
Message-ID: <8698ba1f-fc5d-a82e-842b-100dc8957f2f@redhat.com>
Date:   Fri, 8 Sep 2023 18:48:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Lei Huang <lei.huang@linux.intel.com>, miklos@szeredi.hu,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Boris Pismenny <borisp@nvidia.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-mm@kvack.org, v9fs@lists.linux.dev, netdev@vger.kernel.org
References: <20230905141604.GA27370@lst.de>
 <0240468f-3cc5-157b-9b10-f0cd7979daf0@redhat.com>
 <20230908081544.GB8240@lst.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: getting rid of the last memory modifitions through gup(FOLL_GET)
In-Reply-To: <20230908081544.GB8240@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08.09.23 10:15, Christoph Hellwig wrote:
> On Wed, Sep 06, 2023 at 11:42:33AM +0200, David Hildenbrand wrote:
>>> and iov_iter_get_pages_alloc2.  We have three file system direct I/O
>>> users of those left: ceph, fuse and nfs.  Lei Huang has sent patches
>>> to convert fuse to iov_iter_extract_pages which I'd love to see merged,
>>> and we'd need equivalent work for ceph and nfs.
>>>
>>> The non-file system uses are in the vmsplice code, which only reads
>>
>> vmsplice really has to be fixed to specify FOLL_PIN|FOLL_LONGTERM for good;
>> I recall that David Howells had patches for that at one point. (at least to
>> use FOLL_PIN)
> 
> Hmm, unless I'm misreading the code vmsplace is only using
> iov_iter_get_pages2 for reading from the user address space anyway.
> Or am I missing something?

It's not relevant for the case you're describing here ("last memory 
modifitions through gup(FOLL_GET)").

vmsplice_to_pipe() -> iter_to_pipe() -> iov_iter_get_pages2()

So it ends up calling get_user_pages_fast()

... and not using FOLL_PIN|FOLL_LONGTERM

Why FOLL_LONGTERM? Because it's a longterm pin, where unprivileged users 
can grab a reference on a page for all eternity, breaking CMA and memory 
hotunplug (well, and harming compaction).

Why FOLL_PIN? Well FOLL_LONGTERM only applies to FOLL_PIN. But for 
anonymous memory, this will also take care of the last remaining hugetlb 
COW test (trigger COW unsharing) as commented back in:

https://lore.kernel.org/all/02063032-61e7-e1e5-cd51-a50337405159@redhat.com/


> 
>>> After that we might have to do an audit of the raw get_user_pages APIs,
>>> but there probably aren't many that modify file backed memory.
>>
>> ptrace should apply that ends up doing a FOLL_GET|FOLL_WRITE.
> 
> Yes, if that ends up on file backed shared mappings we also need a pin.

See below.

> 
>> Further, KVM ends up using FOLL_GET|FOLL_WRITE to populate the second-level
>> page tables for VMs, and uses MMU notifiers to synchronize the second-level
>> page tables with process page table changes. So once a PTE goes from
>> writable -> r/o in the process page table, the second level page tables for
>> the VM will get updated. Such MMU users are quite different from ordinary
>> GUP users.
> 
> Can KVM page tables use file backed shared mappings?

Yes, usually shmem and hugetlb. But with things like emulated 
NVDIMMs/virtio-pmem for VMs, easily also ordinary files.

But it's really not ordinary write access through GUP. It's write access 
via a secondary page table (secondary MMU), that's synchronized to the 
process page table -- just like if the CPU would be writing to the page 
using the process page tables (primary MMU).

> 
>> Converting ptrace might not be desired/required as well (the reference is
>> dropped immediately after the read/write access).
> 
> But the pin is needed to make sure the file system can account for
> dirtying the pages.  Something we fundamentally can't do with get.

ptrace will find the pagecache page writable in the page table (PTE 
write bit set), if it intends to write to the page (FOLL_WRITE). If it 
is not writable, it will trigger a page fault that informs the file system.

With an FS that wants writenotify, we will not map a page writable (PTE 
write bit not set) unless it is dirty (PTE dirty bit set) IIRC.

So are we concerned about a race between the filesystem removing the PTE 
write bit (to catch next write access before it gets dirtied again) and 
ptrace marking the page dirty?

It's a very, very small race window, staring at __access_remote_vm(). 
But it should apply if that's the concern.

> 
>> The end goal as discussed a couple of times would be the to limit FOLL_GET
>> in general only to a couple of users that can be audited and keep using it
>> for a good reason. Arbitrary drivers that perform DMA should stop using it
>> (and ideally be prevented from using it) and switch to FOLL_PIN.
> 
> Agreed, that's where I'd like to get to.  Preferably with the non-pin
> API not even beeing epxorted to modules.

Yes. However, secondary MMU users (like KVM) would need some way to keep 
making use of that; ideally, using a proper separate interface instead 
of (ab)using plain GUP and confusing people :)

[1] https://lkml.org/lkml/2023/1/24/451

-- 
Cheers,

David / dhildenb

