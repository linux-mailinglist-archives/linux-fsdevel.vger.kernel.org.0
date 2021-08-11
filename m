Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138893E93E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 16:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbhHKOpo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 10:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45491 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232438AbhHKOpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628693118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eBcHxr3b5mworuPq4PqU+l4xARfNUKjm75tM9rIDjPo=;
        b=H0toEhJFaVPa1FYGYNV9TgTvkuvhDFsbVheyCFk9a970pxctFfFFIXedcpAO9VxzUCj91d
        06dNrLcqZ5P9whIUUno6hASxBomUs/8XxPd3cLLd7EgUzY8PcQuIfnREhT52PAqxktUOUF
        FNLcHKvnEuTWg2DK0mHhpA5A7ocvRfI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-t5QHWJKEMZij881GOh7KRQ-1; Wed, 11 Aug 2021 10:45:17 -0400
X-MC-Unique: t5QHWJKEMZij881GOh7KRQ-1
Received: by mail-wr1-f71.google.com with SMTP id q11-20020a5d61cb0000b02901550c3fccb5so811254wrv.14
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Aug 2021 07:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=eBcHxr3b5mworuPq4PqU+l4xARfNUKjm75tM9rIDjPo=;
        b=O5x9hrbSj9AlUMpX8K5MCnbBusDgrMd0nbf//kOrJ7e/JynJLW1Ut/QSxvwDALjrye
         mQWdueyV/GuvHn7gHJBqsIuU3mDmWxp+ROI6OjlVlajFBEnpc2VeQm2NsU2iS0UZm8em
         h8nqOiFb0c1nd2oT2ZH6FrzPMq/E9VzRqeQGxrNsMBW8BaB2tpQHuHgh9LCzamb8k9zA
         dTYIqy52MDoVb5k4zBNCmOlqa3f8DQCvLSCesy/FJltM0kpe4me3YA9vuUILQiNefkVh
         Er9ZnGMrHPfPUV03vZpuSiNbDVY03Y3Rr0rPNfHF4dVvciEE7cW5oESCBjmCU6YGAmCf
         Ke2g==
X-Gm-Message-State: AOAM530B0D5/7vrFBNaP14jGCf+jmr/DKczeYfn+enfYcICCugC0NzSl
        3ymOPyJhkpKTy3Oi5yqUJ0E0BaJpFBjerTUM0WbqxH6dOmFABfjRN2G0vXW4NFw2XMHqdADpKEU
        ogwEZkU+cVzVsGgzIiW3jukU2Sg==
X-Received: by 2002:a1c:f019:: with SMTP id a25mr10501108wmb.96.1628693116071;
        Wed, 11 Aug 2021 07:45:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyH29GuiTfEW6pGrDbGgwByHckYOSWZlO1OckR66NtZ86Hv7seISYduYOnbWzd/HniZiX+U4w==
X-Received: by 2002:a1c:f019:: with SMTP id a25mr10501089wmb.96.1628693115840;
        Wed, 11 Aug 2021 07:45:15 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64a0.dip0.t-ipconnect.de. [91.12.100.160])
        by smtp.gmail.com with ESMTPSA id g6sm9982769wrm.73.2021.08.11.07.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 07:45:14 -0700 (PDT)
Subject: Re: mmap denywrite mess (Was: [GIT PULL] overlayfs fixes for
 5.14-rc6)
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
References: <YRPaodsBm3ambw8z@miu.piliscsaba.redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <c13de127-a7f0-c2c3-cb21-24fce2c90c11@redhat.com>
Date:   Wed, 11 Aug 2021 16:45:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRPaodsBm3ambw8z@miu.piliscsaba.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11.08.21 16:11, Miklos Szeredi wrote:
> On Mon, Aug 09, 2021 at 02:25:17PM -0700, Linus Torvalds wrote:
> 
>> Ugh. Th edances with denywrite and mapping_unmap_writable are really
>> really annoying.
> 
> Attached version has error and success paths separated.  Was that your
> complaint?
> 
>> I get the feeling that the whole thing with deny_write_access and
>> mapping_map_writable could possibly be done after-the-fact somehow as
>> part of actually inserting the vma in the vma tree, rather than done
>> as the vma is prepared.
> 
> I don't know if that's doable or not.  The final denywrite count is obtained in
> __vma_link_file(), called after __vma_link().  The questions are:
> 
>   - does the order of those helper calls matter?
> 
>   - if it does, could the __vma_link() be safely undone after an unsuccessful
>     __vmal_link_file()?
> 
>> And most users of vma_set_file() probably really don't want that whole
>> thing at all (ie the DRM stuff that just switches out a local thing.
>> They also don't check for the new error cases you've added.
> 
> Christian König wants to follow up with those checks (which should be asserts,
> if the code wasn't buggy in the first place).
> 
>> So I really think this is quite questionable, and those cases should
>> probably have been done entirely inside ovlfs rather than polluting
>> the cases that don't care and don't check.
> 
> I don't get that.  mmap_region() currently drops the deny counts from the
> original file.  That doesn't work for overlayfs since it needs to take new temp
> counts on the override file.
> 
> So mmap_region() is changed to drop the counts on vma->vm_file, but then all
> callers of vma_set_file() will need to do that switch of temp counts, there's no
> way around that.
> 
> Thanks,
> Miklos
> 
> For reference, here's the previous discussion:
> 
> https://lore.kernel.org/linux-mm/YNHXzBgzRrZu1MrD@miu.piliscsaba.redhat.com/
> 
> ---
>   fs/overlayfs/file.c |    4 +++-
>   include/linux/mm.h  |    2 +-
>   mm/mmap.c           |    2 +-
>   mm/util.c           |   31 ++++++++++++++++++++++++++++++-
>   4 files changed, 35 insertions(+), 4 deletions(-)
> 
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -475,7 +475,9 @@ static int ovl_mmap(struct file *file, s
>   	if (WARN_ON(file != vma->vm_file))
>   		return -EIO;
>   
> -	vma_set_file(vma, realfile);
> +	ret = vma_set_file(vma, realfile);
> +	if (ret)
> +		return ret;
>   
>   	old_cred = ovl_override_creds(file_inode(file)->i_sb);
>   	ret = call_mmap(vma->vm_file, vma);
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2780,7 +2780,7 @@ static inline void vma_set_page_prot(str
>   }
>   #endif
>   
> -void vma_set_file(struct vm_area_struct *vma, struct file *file);
> +int /* __must_check */ vma_set_file(struct vm_area_struct *vma, struct file *file);
>   
>   #ifdef CONFIG_NUMA_BALANCING
>   unsigned long change_prot_numa(struct vm_area_struct *vma,
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1806,6 +1806,7 @@ unsigned long mmap_region(struct file *f
>   		 */
>   		vma->vm_file = get_file(file);
>   		error = call_mmap(file, vma);
> +		file = vma->vm_file;
>   		if (error)
>   			goto unmap_and_free_vma;
>   
> @@ -1867,7 +1868,6 @@ unsigned long mmap_region(struct file *f
>   		if (vm_flags & VM_DENYWRITE)
>   			allow_write_access(file);
>   	}
> -	file = vma->vm_file;
>   out:
>   	perf_event_mmap(vma);
>   
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -314,12 +314,41 @@ int vma_is_stack_for_current(struct vm_a
>   /*
>    * Change backing file, only valid to use during initial VMA setup.
>    */
> -void vma_set_file(struct vm_area_struct *vma, struct file *file)
> +int vma_set_file(struct vm_area_struct *vma, struct file *file)
>   {
> +	vm_flags_t vm_flags = vma->vm_flags;
> +	int err;
> +
> +	/* Get temporary denial counts on replacement */
> +	if (vm_flags & VM_DENYWRITE) {
> +		err = deny_write_access(file);
> +		if (err)
> +			return err;
> +	}
> +	if (vm_flags & VM_SHARED) {
> +		err = mapping_map_writable(file->f_mapping);
> +		if (err)
> +			goto undo_denywrite;
> +	}
> +
>   	/* Changing an anonymous vma with this is illegal */
>   	get_file(file);
>   	swap(vma->vm_file, file);
> +
> +	/* Undo temporary denial counts on replaced */
> +	if (vm_flags & VM_SHARED)
> +		mapping_unmap_writable(file->f_mapping);
> +
> +	if (vm_flags & VM_DENYWRITE)
> +		allow_write_access(file);
> +
>   	fput(file);
> +	return 0;
> +
> +undo_denywrite:
> +	if (vm_flags & VM_DENYWRITE)
> +		allow_write_access(file);
> +	return err;
>   }
>   EXPORT_SYMBOL(vma_set_file);
>   
> 

I proposed a while ago to get rid of VM_DENYWRITE completely:

https://lkml.kernel.org/r/20210423131640.20080-1-david@redhat.com

I haven't looked how much it still applies to current upstream, but 
maybe that might help cleaning up that code.

-- 
Thanks,

David / dhildenb

