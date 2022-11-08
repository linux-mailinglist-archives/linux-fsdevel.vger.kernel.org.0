Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB2C621B48
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 18:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbiKHR5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Nov 2022 12:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbiKHR5p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:57:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68EA15FF8
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Nov 2022 09:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667930214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KC+QOAZ2Rjsc33WuLf5AORtVReDw8ySdynapXv7DDmc=;
        b=H1SCRDPCYCHC4ExlZ8Pr/LD84yRbzskayOwGOYOX+FReSG/A855fh+CSa3IAzvyP/rDXSD
        G3CBbpRGTCszI2+Nr4ftVJsm4LjLwO/B8vbhysgrkfvs5HgzzrKMAyLpTfDBdazLLhNw0P
        6OMfI4iagpcWhlQI3B+5QVuQ/Pbpac0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-73-5BJvJs5BPxSsAYTjgv-5iA-1; Tue, 08 Nov 2022 12:56:52 -0500
X-MC-Unique: 5BJvJs5BPxSsAYTjgv-5iA-1
Received: by mail-wm1-f69.google.com with SMTP id h204-20020a1c21d5000000b003cf4e055442so7233398wmh.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Nov 2022 09:56:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KC+QOAZ2Rjsc33WuLf5AORtVReDw8ySdynapXv7DDmc=;
        b=Bv7tEkDK6mQqunX6bkETwodTJjYcDiH1/wnf/NBsEPpUT667iNipKBFBZB4yV4vKsg
         BxwPJXJX0jGPyL2ZDqM1nRCTB3oJLLWFJDQecjWWEw+UUomZPmWSZsW3cbUufduMUPOD
         kukEr5dUxilxxrreHi0V1SimxDeJoJryZwc8XmFPq3OUyPexIRbw8j9qZxDSqMPPbGgi
         Vxyq8nAVkwNj+zxvHXn7d4sVkBu/G+vHu3g9TEVc9BPfuq2ymGBjt6cVLOALcVxq4CoE
         BYcWrqW4Y/6yHJWoe3vxzvDDv6BNlVukkQKEwMOZonQaeT2Ad3EYx34SZ/CkZlGrAyRN
         hZDQ==
X-Gm-Message-State: ACrzQf0DEnnTHvZgROtr6UJhEFXlaWZKYXWWA1l4DGAAIRPOOzhnTKgw
        1QQNu+hlgzScMkCuO+GUUzZa9mwI/fOlAKAcwdfVZR2b0Cfq9naHSsVmXk1PcciL64mCviIONr4
        ysovfOaN8GnID0s9wzbNBXKLtWg==
X-Received: by 2002:a05:600c:3494:b0:3cf:8ed7:7124 with SMTP id a20-20020a05600c349400b003cf8ed77124mr615954wmq.140.1667930211425;
        Tue, 08 Nov 2022 09:56:51 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6VUBcqMmBhSgArgPVMY9CQPRgOY/M6ncMhTHXwRtOanYZY7VA2pKJUh5kwU2FYxjJXG0Z1kA==
X-Received: by 2002:a05:600c:3494:b0:3cf:8ed7:7124 with SMTP id a20-20020a05600c349400b003cf8ed77124mr615936wmq.140.1667930211007;
        Tue, 08 Nov 2022 09:56:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:db00:6510:da8d:df40:abbb? (p200300cbc708db006510da8ddf40abbb.dip0.t-ipconnect.de. [2003:cb:c708:db00:6510:da8d:df40:abbb])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b003b4ff30e566sm34771742wmq.3.2022.11.08.09.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 09:56:50 -0800 (PST)
Message-ID: <e94ac231-7137-010c-2f2b-6a309c941759@redhat.com>
Date:   Tue, 8 Nov 2022 18:56:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     Pasha Tatashin <pasha.tatashin@soleen.com>, corbet@lwn.net,
        akpm@linux-foundation.org, hughd@google.com, hannes@cmpxchg.org,
        vincent.whitchurch@axis.com, seanjc@google.com, rppt@kernel.org,
        shy828301@gmail.com, paul.gortmaker@windriver.com,
        peterx@redhat.com, vbabka@suse.cz, Liam.Howlett@Oracle.com,
        ccross@google.com, willy@infradead.org, arnd@arndb.de,
        cgel.zte@gmail.com, yuzhao@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        bagasdotme@gmail.com, kirill@shutemov.name
References: <20221107184715.3950621-1-pasha.tatashin@soleen.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] mm: anonymous shared memory naming
In-Reply-To: <20221107184715.3950621-1-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07.11.22 19:47, Pasha Tatashin wrote:
> Since: commit 9a10064f5625 ("mm: add a field to store names for private
> anonymous memory"), name for private anonymous memory, but not shared
> anonymous, can be set. However, naming shared anonymous memory just as

                                                                  ^ is

> useful for tracking purposes.
> 
> Extend the functionality to be able to set names for shared anon.
> 
> Sample output:
>    /* Create shared anonymous segmenet */

s/segmenet/segment/

>    anon_shmem = mmap(NULL, SIZE, PROT_READ | PROT_WRITE,
>                      MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>    /* Name the segment: "MY-NAME" */
>    rv = prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME,
>               anon_shmem, SIZE, "MY-NAME");
> 
> cat /proc/<pid>/maps (and smaps):
> 7fc8e2b4c000-7fc8f2b4c000 rw-s 00000000 00:01 1024 [anon_shmem:MY-NAME]

What would it have looked like before? Just no additional information?

> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---


[...]

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8bbcccbc5565..06b6fb3277ab 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -699,8 +699,10 @@ static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
>    * paths in userfault.
>    */
>   bool vma_is_shmem(struct vm_area_struct *vma);
> +bool vma_is_anon_shmem(struct vm_area_struct *vma);
>   #else
>   static inline bool vma_is_shmem(struct vm_area_struct *vma) { return false; }
> +static inline bool vma_is_anon_shmem(struct vm_area_struct *vma) { return false; }
>   #endif
>   
>   int vma_is_stack_for_current(struct vm_area_struct *vma);
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 500e536796ca..08d8b973fb60 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -461,21 +461,11 @@ struct vm_area_struct {
>   	 * For areas with an address space and backing store,
>   	 * linkage into the address_space->i_mmap interval tree.
>   	 *
> -	 * For private anonymous mappings, a pointer to a null terminated string
> -	 * containing the name given to the vma, or NULL if unnamed.
>   	 */
> -
> -	union {
> -		struct {
> -			struct rb_node rb;
> -			unsigned long rb_subtree_last;
> -		} shared;
> -		/*
> -		 * Serialized by mmap_sem. Never use directly because it is
> -		 * valid only when vm_file is NULL. Use anon_vma_name instead.
> -		 */
> -		struct anon_vma_name *anon_name;
> -	};
> +	struct {
> +		struct rb_node rb;
> +		unsigned long rb_subtree_last;
> +	} shared;
>   

So that effectively grows the size of vm_area_struct. Hm. I'd really 
prefer to keep this specific to actual anonymous memory, not extending 
it to anonymous files.

Do we have any *actual* users where we don't have an alternative? I 
doubt that this is really required.

The simplest approach seems to be to use memfd instead of MAP_SHARED | 
MAP_ANONYMOUS. __NR_memfd_create can be passed a name and you get what 
you propose here effectively already. Or does anything speak against it?

-- 
Thanks,

David / dhildenb

