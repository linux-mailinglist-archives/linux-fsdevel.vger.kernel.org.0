Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2244A322D5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 16:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbhBWPWa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 10:22:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23216 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231919AbhBWPWY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614093654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jwgWYg1VA5fUePkB2TEpm/nm7aaUWzYkZRWH3OYKmTM=;
        b=GRSfctgJOK0rqk/HMLbXWsfCz9EnQcHMkvtdFYkkIR/mycWmbb2tM0vN68IzF5dkP7b9LP
        /WUWgXOO9c+dWU4tvubDL03OKjTFy6N4d01SW0ilnEc3PBsOHgjQUyXufr5BezA7QCfwbd
        e9C1RRYbIjkaPALrFKq8nAz/KW06vhI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-_uZbkqUQPHWKA3HhLe1PuQ-1; Tue, 23 Feb 2021 10:20:18 -0500
X-MC-Unique: _uZbkqUQPHWKA3HhLe1PuQ-1
Received: by mail-qt1-f198.google.com with SMTP id a41so3351199qtk.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 07:20:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jwgWYg1VA5fUePkB2TEpm/nm7aaUWzYkZRWH3OYKmTM=;
        b=eIr/308KM3pO/sWq8uMfIPK9eFcEEAbmdMYSajw3QVdrTtc4I3jM09VWNh+Bjm75IR
         /pp/rj9tIyDlx/wnTUqDF2tFszHNO5+d5Wt8lLEFIIfZdKjPI+MpO2my9QAnnbTfZi2L
         xDDMNcsz7RFPtuJcgmQw0j5XSSw1m8hE1iyiIYmieQc5HIyiNOXUq6/Pu004Bv6Y+I+L
         V1AX8ok31sUTO/EVddD66hDP6fOnJidQa77Y5WtdDQz6wsB4NsxVC/TMSW5sU2A1MXlp
         h5MXRgIJXou5FO/GRfQAYryno2tUxNbksXsnb8wYZZM0ryyrqbkneWcNgo/vTxuL3iVM
         XT9g==
X-Gm-Message-State: AOAM5333PSCZLRuRbylB1pxcn1/4UaH7kBqU4BUNxuRKO/mPzTolAHhH
        ItcYUTh3IZEsaO0MB+x4H8WTvZRBdLeEsriLeiHy6MAaW4jxoyZzN2sdkWxmJihRlDt9N5e8Qpu
        lNcfYCC4lUr6uEoMeerAnn/x/Ng==
X-Received: by 2002:a0c:c248:: with SMTP id w8mr1518150qvh.58.1614093618378;
        Tue, 23 Feb 2021 07:20:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWcuu23NOnPAZhpzswg6vHbLvB7EZ9s8gIVRn3vVyGv4fb9Pn+5A210Mu4KiqWVED3IWq47A==
X-Received: by 2002:a0c:c248:: with SMTP id w8mr1518096qvh.58.1614093618102;
        Tue, 23 Feb 2021 07:20:18 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id w139sm9203829qka.19.2021.02.23.07.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 07:20:17 -0800 (PST)
Date:   Tue, 23 Feb 2021 10:20:15 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v7 1/6] userfaultfd: add minor fault registration mode
Message-ID: <20210223152015.GA154711@xz-x1>
References: <20210219004824.2899045-1-axelrasmussen@google.com>
 <20210219004824.2899045-2-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210219004824.2899045-2-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 18, 2021 at 04:48:19PM -0800, Axel Rasmussen wrote:

[...]

> @@ -1290,14 +1299,20 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
>  	ret = -EINVAL;
>  	if (!uffdio_register.mode)
>  		goto out;
> -	if (uffdio_register.mode & ~(UFFDIO_REGISTER_MODE_MISSING|
> -				     UFFDIO_REGISTER_MODE_WP))
> +	if (uffdio_register.mode & ~UFFD_API_REGISTER_MODES)
>  		goto out;
>  	vm_flags = 0;
>  	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_MISSING)
>  		vm_flags |= VM_UFFD_MISSING;
>  	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_WP)
>  		vm_flags |= VM_UFFD_WP;
> +	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_MINOR) {
> +		/* VM_UFFD_MINOR == VM_NONE if this arch doesn't support it. */

How about check CONFIG_HAVE_ARCH_USERFAULTFD_MINOR below directly instead of
commenting?

> +		ret = -EINVAL;

Should be able to drop this line too since ret is -EINVAL already?

> +		if (!VM_UFFD_MINOR)
> +			goto out;
> +		vm_flags |= VM_UFFD_MINOR;
> +	}

[...]

> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index 67018d367b9f..a743a0f9ebde 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -137,6 +137,12 @@ IF_HAVE_PG_ARCH_2(PG_arch_2,		"arch_2"	)
>  #define IF_HAVE_VM_SOFTDIRTY(flag,name)
>  #endif
>  
> +#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
> +# define IF_HAVE_UFFD_MINOR(flag, name) {flag, name},
> +#else
> +# define IF_HAVE_UFFD_MINOR(flag, name)
> +#endif
> +
>  #define __def_vmaflag_names						\
>  	{VM_READ,			"read"		},		\
>  	{VM_WRITE,			"write"		},		\
> @@ -148,6 +154,7 @@ IF_HAVE_PG_ARCH_2(PG_arch_2,		"arch_2"	)
>  	{VM_MAYSHARE,			"mayshare"	},		\
>  	{VM_GROWSDOWN,			"growsdown"	},		\
>  	{VM_UFFD_MISSING,		"uffd_missing"	},		\
> +IF_HAVE_UFFD_MINOR(VM_UFFD_MINOR,	"uffd_minor"	)		\
>  	{VM_PFNMAP,			"pfnmap"	},		\
>  	{VM_DENYWRITE,			"denywrite"	},		\
>  	{VM_UFFD_WP,			"uffd_wp"	},		\
> @@ -169,7 +176,7 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
>  	{VM_MIXEDMAP,			"mixedmap"	},		\
>  	{VM_HUGEPAGE,			"hugepage"	},		\
>  	{VM_NOHUGEPAGE,			"nohugepage"	},		\
> -	{VM_MERGEABLE,			"mergeable"	}		\
> +	{VM_MERGEABLE,			"mergeable"	}

This change seems irrelevant.

If you agree with above comments, please feel free to add:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

