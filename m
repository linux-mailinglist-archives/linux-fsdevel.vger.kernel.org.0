Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D7B54635F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 12:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348019AbiFJKRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 06:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344761AbiFJKRo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7205E09E
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 03:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654856258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ekvjf5YPr7Sjtvmnh5pMqvNXgm63w4q321GSzdMpiws=;
        b=eLYgCVuG0zvOXKTmMaOwP6SNVlBXhzUjqF5QSpK4+tx/jRoHKlpj0rUkGC1UAleaOvghD6
        AE/0HOJPP5GnBRt4/1/x0JpVZGbqBvQ6Kmysabbq6qdTsG6mfmaKpwhXHIhukQ24SaFFXb
        l3d4Nrtesr/Vi4T7IjNKu95kj2hgdpE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-dBsvKVPWOCyFUli4MlBC6A-1; Fri, 10 Jun 2022 06:17:37 -0400
X-MC-Unique: dBsvKVPWOCyFUli4MlBC6A-1
Received: by mail-wm1-f69.google.com with SMTP id k15-20020a7bc40f000000b0039c4b7f7d09so1098321wmi.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jun 2022 03:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Ekvjf5YPr7Sjtvmnh5pMqvNXgm63w4q321GSzdMpiws=;
        b=4mgPsKuV496ADDgrenzSfm+/EYNFFkX76CGpt3SaUncKbnLX3kTqN3DoRlOJKBbFNq
         ChDMphFX++kFUJxuUnYfTFAHFEhCt9KILmnGwSqHWTnnUuHEWTnPWxkXAGtOcd8Ia5x+
         zzxruwVAhvAfDVLIUIDUAkP8FQTR4tuJh8hosXo56VmIf/S5lTmrIoX+f3pZLKjrYFGw
         jzvSBbn35A24Ia2+e5kW9AmlOr/DQja5c4z2T/itpV/rbEivNdBvgKehSjhJo0Qz71eS
         gFcTavkFUNVPqk06yCh78DpkOgd9on9reeWW+X64r8LZFq0wtmXiOjRF/BQ4WLzi/ZZs
         WabA==
X-Gm-Message-State: AOAM530uYdMqcxSQ/YW3BR3Oxc9LlX3qcaYwO+5xKwV2PCG6WT5u1BBg
        OTk2hUuHu24QQ0W6uYpAehFBRGBInv6h1TVhGxq+woRVaonBDF5WjGd+Im9v5rYu6GVXTYmYXTB
        zcalNP5d/TAXkXLn/zdFDBeRJaA==
X-Received: by 2002:a05:6000:91:b0:217:8efc:f572 with SMTP id m17-20020a056000009100b002178efcf572mr29122719wrx.186.1654856255657;
        Fri, 10 Jun 2022 03:17:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMoCknlizO69Nl0wuEIzBALIZP/2+KDolU3ne+3dmHgzec6LJk/2XhtTIsrJ35XnXVn7hgfw==
X-Received: by 2002:a05:6000:91:b0:217:8efc:f572 with SMTP id m17-20020a056000009100b002178efcf572mr29122693wrx.186.1654856255339;
        Fri, 10 Jun 2022 03:17:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:1f00:4727:6420:1d4d:ca23? (p200300cbc7051f00472764201d4dca23.dip0.t-ipconnect.de. [2003:cb:c705:1f00:4727:6420:1d4d:ca23])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c4f5100b0039c4f53c4fdsm3105741wmq.45.2022.06.10.03.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 03:17:34 -0700 (PDT)
Message-ID: <e287a12d-29d9-da69-9315-52414341cbd1@redhat.com>
Date:   Fri, 10 Jun 2022 12:17:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 03/19] fs: Add aops->migrate_folio
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com, linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>
References: <20220608150249.3033815-1-willy@infradead.org>
 <20220608150249.3033815-4-willy@infradead.org>
 <b2a81248-03fc-afb3-1041-d8206e95e08a@redhat.com>
 <YqIFHPJZNMrmtXlh@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YqIFHPJZNMrmtXlh@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09.06.22 16:35, Matthew Wilcox wrote:
> On Thu, Jun 09, 2022 at 02:50:20PM +0200, David Hildenbrand wrote:
>> On 08.06.22 17:02, Matthew Wilcox (Oracle) wrote:
>>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>>> index c0fe711f14d3..3d28b23676bd 100644
>>> --- a/Documentation/filesystems/locking.rst
>>> +++ b/Documentation/filesystems/locking.rst
>>> @@ -253,7 +253,8 @@ prototypes::
>>>  	void (*free_folio)(struct folio *);
>>>  	int (*direct_IO)(struct kiocb *, struct iov_iter *iter);
>>>  	bool (*isolate_page) (struct page *, isolate_mode_t);
>>> -	int (*migratepage)(struct address_space *, struct page *, struct page *);
>>> +	int (*migrate_folio)(struct address_space *, struct folio *dst,
>>> +			struct folio *src, enum migrate_mode);
>>>  	void (*putback_page) (struct page *);
>>
>> isolate_page/putback_page are leftovers from the previous patch, no?
> 
> Argh, right, I completely forgot I needed to update the documentation in
> that patch.
> 
>>> +++ b/Documentation/vm/page_migration.rst
>>> @@ -181,22 +181,23 @@ which are function pointers of struct address_space_operations.
>>>     Once page is successfully isolated, VM uses page.lru fields so driver
>>>     shouldn't expect to preserve values in those fields.
>>>  
>>> -2. ``int (*migratepage) (struct address_space *mapping,``
>>> -|	``struct page *newpage, struct page *oldpage, enum migrate_mode);``
>>> -
>>> -   After isolation, VM calls migratepage() of driver with the isolated page.
>>> -   The function of migratepage() is to move the contents of the old page to the
>>> -   new page
>>> -   and set up fields of struct page newpage. Keep in mind that you should
>>> -   indicate to the VM the oldpage is no longer movable via __ClearPageMovable()
>>> -   under page_lock if you migrated the oldpage successfully and returned
>>> -   MIGRATEPAGE_SUCCESS. If driver cannot migrate the page at the moment, driver
>>> -   can return -EAGAIN. On -EAGAIN, VM will retry page migration in a short time
>>> -   because VM interprets -EAGAIN as "temporary migration failure". On returning
>>> -   any error except -EAGAIN, VM will give up the page migration without
>>> -   retrying.
>>> -
>>> -   Driver shouldn't touch the page.lru field while in the migratepage() function.
>>> +2. ``int (*migrate_folio) (struct address_space *mapping,``
>>> +|	``struct folio *dst, struct folio *src, enum migrate_mode);``
>>> +
>>> +   After isolation, VM calls the driver's migrate_folio() with the
>>> +   isolated folio.  The purpose of migrate_folio() is to move the contents
>>> +   of the source folio to the destination folio and set up the fields
>>> +   of destination folio.  Keep in mind that you should indicate to the
>>> +   VM the source folio is no longer movable via __ClearPageMovable()
>>> +   under folio if you migrated the source successfully and returned
>>> +   MIGRATEPAGE_SUCCESS.  If driver cannot migrate the folio at the
>>> +   moment, driver can return -EAGAIN. On -EAGAIN, VM will retry folio
>>> +   migration in a short time because VM interprets -EAGAIN as "temporary
>>> +   migration failure".  On returning any error except -EAGAIN, VM will
>>> +   give up the folio migration without retrying.
>>> +
>>> +   Driver shouldn't touch the folio.lru field while in the migrate_folio()
>>> +   function.
>>>  
>>>  3. ``void (*putback_page)(struct page *);``
>>
>> Hmm, here it's a bit more complicated now, because we essentially have
>> two paths: LRU+migrate_folio or !LRU+movable_ops
>> (isolate/migrate/putback page)
> 
> Oh ... actually, this is just documenting the driver side of things.
> I don't really like how it's written.  Here, have some rewritten
> documentation (which is now part of the previous patch):
> 

LGTM, thanks.


-- 
Thanks,

David / dhildenb

