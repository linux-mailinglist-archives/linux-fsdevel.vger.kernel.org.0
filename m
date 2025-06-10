Return-Path: <linux-fsdevel+bounces-51202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0487FAD45EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 00:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29B7189E4FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 22:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9930028C03D;
	Tue, 10 Jun 2025 22:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JdQyFl9U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9D828C5D3
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 22:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749594313; cv=none; b=p/iw1kUtQWjivAnLNwWqEe/s+edtyI5XvKSMr3EC2QL1acnGa1xmf36EJxffWfex4dKx80T/c65bZ3CvLQNaXaC2dO88Z6GADSFlJyvb+P0NwEwdMdoHQ0+Q8feSbXBLBUuRhDr5BNyLy9SQn5sJd1byB+BSGWiVaSBXsWjjHUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749594313; c=relaxed/simple;
	bh=bjEQw4isrba+nP1ZYwzcYPZbVaYkMsqnYrte+EEhbmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4r4B0zKGwksIK+nU6ZqapFy8nMTxy+Y6iQKmpzZTDKfLTETYV/yBMSC4f65H78j0XkYHo8P0tApPtltraryTQwy064nWhLVAtDafsdQIIatecdGLxUboiRnm4J6g1yXF1bVDry+5M1jd1Z+88MjroVsoVeLBWTUxriYvDISD08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JdQyFl9U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749594310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jeldsOfLIW+0Hr4bYxPOhI4qHvZBHHNPgSq/+bzEbT4=;
	b=JdQyFl9Ux+DJ033fklDodGgF1h6bqBwZaoL4qy9SA9g60QhUw4mUWxyJT26x9U/gBSjjel
	MY8JykcSiIDk4uDdBb8yZRwTpWHANf0dsa5z5gE+HysjcWCQba64fohZP3EGyzXq7UPAHW
	LLChEVFcEI027rEBjVYgRi/Q8T/iGZo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-oIpM6vhwMbSAZjN0RsfCyw-1; Tue, 10 Jun 2025 18:25:07 -0400
X-MC-Unique: oIpM6vhwMbSAZjN0RsfCyw-1
X-Mimecast-MFC-AGG-ID: oIpM6vhwMbSAZjN0RsfCyw_1749594307
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-47ae87b5182so119519291cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 15:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749594307; x=1750199107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeldsOfLIW+0Hr4bYxPOhI4qHvZBHHNPgSq/+bzEbT4=;
        b=kmN8cuhAAV0HgZx5zyUj89TVryY07mq3VQ1LoYQJg5lF+7wrSTthTTR8YPATd6/o0g
         agrQxBO4wAFJ41BIV+De0d5N4y7Gd+8ePjdQt+erQh8nN/rMtIjIZiX72cKbsEzPAyC7
         tu+xW1XP8h2QLtJmosL0ekQpx4pVpr/5MhfrY1xzJoIVzbGEQ8SCRxrbdRgK4/0OKiC5
         2kSNbReLcpUWBngAnNQfhlSz6vDzqm+cK3/RJdNmCfyhQr9g14bsFrdq3NiiM4QPnI2A
         zyY90oHrZFaW118nYajZsg8CebmliP1CSYXm2F1E8e2SxijBPy/sMcUuRYAQnR4XRgaf
         ncxw==
X-Forwarded-Encrypted: i=1; AJvYcCWWDZaFnV2fbZZNR5grFlESPW0vcwpWfj5NhDPdxQoL0891uUQ08+XkvhjXoba7v0HdlWmCi6gM4B0NMSFk@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfp1CagqIE7K8yaRsihZCNd59QF2H68Fmw4pn0xJ8Lk1jcr58l
	M3Ydc8XGwIxedkz6IyNpj3bfnIHNSeNXRKgwtaGRSFTZvTLh6zFmy1oO5WmWlGm680D5yGlChYs
	OQQm53qbsbkUi6SJJEXLq8ohNvATSL33t4EufCWNngzwmYxvpqrpacxQEGs21wGiPsOY=
X-Gm-Gg: ASbGncumCbZgCg9oGEj64UezBUKSKNnxiKSaP563nvT1LUzf96XJGHOEOgcLseCECsT
	4IqCi45CVJOSXpsKe5Lcg0NFivtP7TJ4SUv1WE8n7nePffScaDJF773anxkwPWPfScYrKSNUFkS
	08fd2iX8iLwD2L7oFPbuA+I4wW2EZTDxQuTL0J6TF34xVbmKoR0i8viNUujsUABNgRerHg+YVLa
	x6Fan1nNBlq9WfRDlAlp3KR3inZhk1U89DUh7DO/JLb+F3mBxPvTWEVrBzW2B2bPp6b3liYPjzU
	D1papMQk2EvYQA==
X-Received: by 2002:a05:622a:17cb:b0:477:ea0:1b27 with SMTP id d75a77b69052e-4a713c2b203mr19488581cf.26.1749594306765;
        Tue, 10 Jun 2025 15:25:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh6veUjTr0aDX8Dk7lxqv8igglcGEC5XvjmK9Q5HpFTvrfcPRBsYoFnhvHMTj0/FgKtwRQ1A==
X-Received: by 2002:a05:622a:17cb:b0:477:ea0:1b27 with SMTP id d75a77b69052e-4a713c2b203mr19488271cf.26.1749594306427;
        Tue, 10 Jun 2025 15:25:06 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a619866975sm78374471cf.68.2025.06.10.15.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 15:25:05 -0700 (PDT)
Date: Tue, 10 Jun 2025 18:25:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Nikita Kalyazin <kalyazin@amazon.com>
Cc: akpm@linux-foundation.org, pbonzini@redhat.com, shuah@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, muchun.song@linux.dev,
	hughd@google.com, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	jannh@google.com, ryan.roberts@arm.com, david@redhat.com,
	jthoughton@google.com, graf@amazon.de, jgowans@amazon.com,
	roypat@amazon.co.uk, derekmn@amazon.com, nsaenz@amazon.es,
	xmarcalx@amazon.com
Subject: Re: [PATCH v3 4/6] KVM: guest_memfd: add support for userfaultfd
 minor
Message-ID: <aEiwvi-oqfTiyP3s@x1.local>
References: <20250404154352.23078-1-kalyazin@amazon.com>
 <20250404154352.23078-5-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250404154352.23078-5-kalyazin@amazon.com>

On Fri, Apr 04, 2025 at 03:43:50PM +0000, Nikita Kalyazin wrote:
> Add support for sending a pagefault event if userfaultfd is registered.
> Only page minor event is currently supported.
> 
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> ---
>  virt/kvm/guest_memfd.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index fbf89e643add..096d89e7282d 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -4,6 +4,9 @@
>  #include <linux/kvm_host.h>
>  #include <linux/pagemap.h>
>  #include <linux/anon_inodes.h>
> +#ifdef CONFIG_KVM_PRIVATE_MEM
> +#include <linux/userfaultfd_k.h>
> +#endif /* CONFIG_KVM_PRIVATE_MEM */
>  
>  #include "kvm_mm.h"
>  
> @@ -380,6 +383,13 @@ static vm_fault_t kvm_gmem_fault(struct vm_fault *vmf)
>  		kvm_gmem_mark_prepared(folio);
>  	}
>  
> +	if (userfaultfd_minor(vmf->vma) &&
> +	    !(vmf->flags & FAULT_FLAG_USERFAULT_CONTINUE)) {
> +		folio_unlock(folio);
> +		filemap_invalidate_unlock_shared(inode->i_mapping);
> +		return handle_userfault(vmf, VM_UFFD_MINOR);
> +	}
> +

Hmm, does guest-memfd (when with your current approach) at least needs to
define the new can_userfault() hook?

Meanwhile, we have some hard-coded lines so far, like:

mfill_atomic():
	if (!vma_is_shmem(dst_vma) &&
	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
		goto out_unlock;

I thought it would fail guest-memfd already on a CONTINUE request, and it
doesn't seem to be touched yet in this series.

I'm not yet sure how the test worked out without hitting things like it.
Highly likely I missed something.  Some explanations would be welcomed.. 

Thanks,

>  	vmf->page = folio_file_page(folio, vmf->pgoff);
>  
>  out_folio:
> -- 
> 2.47.1
> 

-- 
Peter Xu


