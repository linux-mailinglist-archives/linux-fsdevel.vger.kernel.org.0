Return-Path: <linux-fsdevel+bounces-61453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9DBB586B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 23:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4307B4E2513
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 21:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02232C0F62;
	Mon, 15 Sep 2025 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqL9b1NW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B41F2BFC9B
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757971577; cv=none; b=WGAYgkEdogztZ3GBu6JiSv1EvcxymQzepybGgfXIpjffJ/vvUu8s9/J29liIXO/FJemK9kRw3xBpX5fpD/uVSmE4XaekZ6UAh5gmgRnJNcH0+WVEnpxS4Wn8mwP04e4RGftj6lSh2hoSFy1ZXxNI8oESVxd740dpOSnQ6qkkei8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757971577; c=relaxed/simple;
	bh=1sOTIRHTFzvVsuFrLFr5SOKUlmErsLY3WO0d1tNp5Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAI0lN3LqgKzKsS9qBmbNefcdlrRHp4ibUs4LYpZy8GIbGDcN+efG7ayD70v3M6gVLXfhYpBp+7SHYjtbJF5TGIBdUL7jbykzuYHnTvceNbLYmLnA80bGS+zoqAluTqiVtd9YgeauXY45VjtjgTMPjrTj1cWOjdUwwSx1C0EMH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqL9b1NW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757971573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KM4RQD/H6XgF3hQHay54Rz4wcT8Td67zLaIIGzgIOjc=;
	b=VqL9b1NWQ0WussgNB3M6/5DEeTKPkt2riW+ZEDXT1eWDrs8Co9WiZO5mgZmuD+OobVNULa
	zTdWRX7VTFzfTJT5uAcvGiVNxfUJ5Tb2ga7RbP13+oMIz8hEmjidkNjVhZlQGMowQPIOxg
	yry0S9DoDx5MBN/ypLIuIE2yswCuKoE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-tyI627ttM1ae_nR3wn4-Ww-1; Mon, 15 Sep 2025 17:26:11 -0400
X-MC-Unique: tyI627ttM1ae_nR3wn4-Ww-1
X-Mimecast-MFC-AGG-ID: tyI627ttM1ae_nR3wn4-Ww_1757971571
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-77ccfa8079cso36306916d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 14:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757971571; x=1758576371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KM4RQD/H6XgF3hQHay54Rz4wcT8Td67zLaIIGzgIOjc=;
        b=SaN/4Om/BS3SvtQOGVWP2e3DMX3rej8vRMqBy64Tu/yx4gLxiEsDpck+ZXqfPumM9t
         jfyFrfIp5ZwcYUUrkQwOM+nbbcwBLkShBOqOdQHC5vNZCNVSr1QaC+WlCq/ejitxgOtL
         gW2FNiZ6VOClA1FeFgScB4oryw5L/KdKr+G6XqY78y6OyL43KwzMAlXqISxW5dUklEUJ
         cByLxTSvA+/6KWzVYsSshPzM/mBlZ6mQU6LN6RfoTVp865as8+474Rhz788nLZ0N41VJ
         kFY5hr1eD3MCbJp63l3AkF66H2NnXZhiJnp9mTxkkcc8kNcEJrcC5UvKgWDFmenkp8d4
         OB+A==
X-Forwarded-Encrypted: i=1; AJvYcCWfqgolOeP+6+uaG7Ug2DEThWX6IrjdNvqOqoHZPCgBt0+qhEJAjPkL92ptY5oIJ+VTU2f0DQ/XS2bdj/Bh@vger.kernel.org
X-Gm-Message-State: AOJu0YwmN9oboiBqIXFDcnM0E1+w3SpyrV64PeS8x9xpNMxj8PBAkBdr
	Tdnx92WIoJwpaUVaGMb0vV03CDRZmCKtc0J19+dhqzt5/9u6fwXQMKCk9RRhnI6sw0x3EmM7rXt
	fCb1KESSfrGb7MdCnzyxNYpQbXFz34N1vONJAxioX3NDCrEBk/XylNz7TiXrU2irJNJM=
X-Gm-Gg: ASbGncvSqBghrCVzBiTDUmUI0lyX+TjKIW1Hc7h8Lhrdlg0vIcjCP7Doa+3xFr8J+TH
	TRM9VAqXjVdiZzWsmHeJJ42M8/40DrEW6ZfWk0VO3VisvBrCQrMQfybVmpawC2rrLAa7gu4Fzkj
	euobc+hYUClOXk2VJ4bDD6cZz+O4kH37CUFz6A4usbhG6F59/nTj2Kr4Np96oNDTUz3nj+S9Js2
	fWOvs0k/TUFcOrSiZw9StFV/BN05qnnV9oOJoj5YVRfh8tiuBPmmRICTELWz78r/tZHhYGs2MXO
	U/+hAplrU19N1fQR0/LaJfeje269WImA
X-Received: by 2002:a05:6214:3c85:b0:769:cd09:9d77 with SMTP id 6a1803df08f44-769cd099fafmr170285406d6.4.1757971571203;
        Mon, 15 Sep 2025 14:26:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkORZIzaSeYsztcwaPnCJ3V7jNeNP5xXWbRprE054mUcehDj+b7ToSI1uNg2GLUniMgON4ow==
X-Received: by 2002:a05:6214:3c85:b0:769:cd09:9d77 with SMTP id 6a1803df08f44-769cd099fafmr170284896d6.4.1757971570738;
        Mon, 15 Sep 2025 14:26:10 -0700 (PDT)
Received: from x1.local ([174.89.135.121])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-76e576ee0fcsm60107386d6.69.2025.09.15.14.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 14:26:10 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:25:57 -0400
From: Peter Xu <peterx@redhat.com>
To: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"david@redhat.com" <david@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"willy@infradead.org" <willy@infradead.org>,
	"vbabka@suse.cz" <vbabka@suse.cz>,
	"rppt@kernel.org" <rppt@kernel.org>,
	"surenb@google.com" <surenb@google.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "jack@suse.cz" <jack@suse.cz>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"tabba@google.com" <tabba@google.com>,
	"vannapurve@google.com" <vannapurve@google.com>,
	"Roy, Patrick" <roypat@amazon.co.uk>,
	"Thomson, Jack" <jackabt@amazon.co.uk>,
	"Manwaring, Derek" <derekmn@amazon.com>,
	"Cali, Marco" <xmarcalx@amazon.co.uk>
Subject: Re: [RFC PATCH v6 0/2] mm: Refactor KVM guest_memfd to introduce
 guestmem library
Message-ID: <aMiEZfkx5sRMU7it@x1.local>
References: <20250915161815.40729-1-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250915161815.40729-1-kalyazin@amazon.com>

Hello, Nikita,

On Mon, Sep 15, 2025 at 04:18:16PM +0000, Kalyazin, Nikita wrote:
> This is a revival of the guestmem library patch series originated from
> Elliot [1].  The reason I am bringing it up now is it would help
> implement UserfaultFD support minor mode in guest_memfd.
> 
> Background
> 
> We are building a Firecracker version that uses guest_memfd to back
> guest memory [2].  The main objective is to use guest_memfd to remove
> guest memory from host kernel's direct map to reduce the surface for
> Spectre-style transient execution issues [3].  Currently, Firecracker
> supports restoring VMs from snapshots using UserfaultFD [4], which is
> similar to the postcopy phase of live migration.  During restoration,
> while we rely on a separate mechanism to handle stage-2 faults in
> guest_memfd [5], UserfaultFD support in guest_memfd is still required to
> handle faults caused either by the VMM itself or by MMIO access handling
> on x86.
> 
> The major problem in implementing UserfaultFD for guest_memfd is that
> the MM code (UserfaultFD) needs to call KVM-specific interfaces.
> Particularly for the minor mode, these are 1) determining the type of
> the VMA (eg is_vma_guest_memfd()) and 2) obtaining a folio (ie
> kvm_gmem_get_folio()).  Those may not be always available as KVM can be
> compiled as a module.  Peter attempted to approach it via exposing an
> ops structure where modules (such as KVM) could provide their own
> callbacks, but it was not deemed to be sufficiently safe as it opens up
> an unrestricted interface for all modules and may leave MM in an
> inconsistent state [6].

I apologize when I was replying to your offlist email that I'll pick it up,
but I didn't.. I moved on with other things after the long off which was
more urgent, then I never got the chance to go back..  I will do it this
week.

I don't think it's a real safety issue.  Frankly, I still think that latest
patchset, as-is, is the best we should come up with userfaultfd.  If people
worry about uffdio_copy(), it's fine, we can drop it.  It's not a huge deal
at least for now.

Btw, thanks for help pinging that thread, and sorry I didn't yet get back
to it.  I'll read the discussions (I didn't yet, after back to work for
weeks), but I will.

> 
> An alternative way to make these interfaces available to the UserfaultFD
> code is extracting generic-MM guest_memfd parts into a library
> (guestmem) under MM where they can be safely consumed by the UserfaultFD
> code.  As far as I know, the original guestmem library series was
> motivated by adding guest_memfd support in Gunyah hypervisor [7].
> 
> This RFC
> 
> I took Elliot's v5 (the latest) and rebased it on top of the guest_memfd
> preview branch [8] because I also wanted to see how it would work with
> direct map removal [3] and write syscall [9], which are building blocks
> for the guest_memfd-based Firecracker version.  On top of it I added a
> patch that implements UserfaultFD support for guest_memfd using
> interfaces provided by the guestmem library to illustrate the complete
> idea.

I hope patch 2 exactly illustrated on why the uffd modulization effort is
still worthwhile (to not keep attaching "if"s all over the places).  Would
you agree?

If you agree, we'll need to review the library work as a separate effort
from userfaultfd.

> 
> I made the following modifications along the way:
>  - Followed by a comment from Sean, converted invalidate_begin()
>    callback back to void as it cannot fail in KVM, and the related
>    Gunyah requirement is unknown to me
>  - Extended the guestmem_ops structure with the supports_mmap() callback
>    to provide conditional mmap support in guestmem
>  - Extended the guestmem library interface with guestmem_allocate(),
>    guestmem_test_no_direct_map(), guestmem_mark_prepared(),
>    guestmem_mmap(), and guestmem_vma_is_guestmem()
>  - Made (kvm_gmem)/(guestmem)_test_no_direct_map() use
>    mapping_no_direct_map() instead of KVM-specific flag
>    GUEST_MEMFD_FLAG_NO_DIRECT_MAP to make it KVM-independent
> 
> Feedback that I would like to receive:
>  - Is this the right solution to the "UserfaultFD in guest_memfd"
>    problem?

Yes it's always a fair question to ask.  I shared my two cents above.  We
can definitely also hear about how others think.

I hope I'll keep my words this time on reposting.

Thanks,

>  - What requirements from other hypervisors than KVM do we need to
>    consider at this point?
>  - Does the line between generic-MM and KVM-specific guest_memfd parts
>    look sensible?
> 
> Previous iterations of UserfaultFD support in guest_memfd patches:
> v3:
>  - https://lore.kernel.org/kvm/20250404154352.23078-1-kalyazin@amazon.com
>  - minor changes to address review comments (James)
> v2:
>  - https://lore.kernel.org/kvm/20250402160721.97596-1-kalyazin@amazon.com
>  - implement a full minor trap instead of hybrid missing/minor trap
>    (James/Peter)
>  - make UFFDIO_CONTINUE implementation generic calling vm_ops->fault()
> v1:
>  - https://lore.kernel.org/kvm/20250303133011.44095-1-kalyazin@amazon.com
> 
> Nikita
> 
> [1]: https://lore.kernel.org/kvm/20241122-guestmem-library-v5-2-450e92951a15@quicinc.com
> [2]: https://github.com/firecracker-microvm/firecracker/tree/feature/secret-hiding
> [3]: https://lore.kernel.org/kvm/20250912091708.17502-1-roypat@amazon.co.uk
> [4]: https://github.com/firecracker-microvm/firecracker/blob/main/docs/snapshotting/handling-page-faults-on-snapshot-resume.md
> [5]: https://lore.kernel.org/kvm/20250618042424.330664-1-jthoughton@google.com
> [6]: https://lore.kernel.org/linux-mm/20250627154655.2085903-1-peterx@redhat.com
> [7]: https://lore.kernel.org/lkml/20240222-gunyah-v17-0-1e9da6763d38@quicinc.com
> [8]: https://git.kernel.org/pub/scm/linux/kernel/git/david/linux.git/log/?h=guestmemfd-preview
> [9]: https://lore.kernel.org/kvm/20250902111951.58315-1-kalyazin@amazon.com
> 
> Nikita Kalyazin (2):
>   mm: guestmem: introduce guestmem library
>   userfaulfd: add minor mode for guestmem
> 
>  Documentation/admin-guide/mm/userfaultfd.rst |   4 +-
>  MAINTAINERS                                  |   2 +
>  fs/userfaultfd.c                             |   3 +-
>  include/linux/guestmem.h                     |  46 +++
>  include/linux/userfaultfd_k.h                |   8 +-
>  include/uapi/linux/userfaultfd.h             |   8 +-
>  mm/Kconfig                                   |   3 +
>  mm/Makefile                                  |   1 +
>  mm/guestmem.c                                | 380 +++++++++++++++++++
>  mm/userfaultfd.c                             |  14 +-
>  virt/kvm/Kconfig                             |   1 +
>  virt/kvm/guest_memfd.c                       | 303 ++-------------
>  12 files changed, 493 insertions(+), 280 deletions(-)
>  create mode 100644 include/linux/guestmem.h
>  create mode 100644 mm/guestmem.c
> 
> 
> base-commit: 911634bac3107b237dcd8fdcb6ac91a22741cbe7
> -- 
> 2.50.1
> 
> 
> 

-- 
Peter Xu


