Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1672FF3A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 19:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbhAUSyQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 13:54:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48769 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727056AbhAUSyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 13:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611255156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9dViudQ3lb05x7W07+1rvaBJLRkqsQmlwfw0YFNbKhk=;
        b=LkV+bRsArE3C7PSlJj494ghg4yiuNHWEFgXELlrCL4jHDU0XP3/nHoUCBOWjoV5IJcckkU
        39CmMJ+kSYlXGpoMscg0z33QlIW56bxz2IbBz4D0+GwuET4wC4G5lyU/iUAKIj376u+3Dz
        rR7sA3ysHtqRnV87B5JtBkqd5sftjYg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-m2bajtJ-NAyiw4eY6lXeYQ-1; Thu, 21 Jan 2021 13:52:33 -0500
X-MC-Unique: m2bajtJ-NAyiw4eY6lXeYQ-1
Received: by mail-qk1-f198.google.com with SMTP id g5so2271909qke.22
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 10:52:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9dViudQ3lb05x7W07+1rvaBJLRkqsQmlwfw0YFNbKhk=;
        b=LC8Oxesiq5qiABeh0e+H+THssnnaXvapXqRZwGbTnC4alUI+ELs9Osy2J889r9NXE0
         VGdj6H1TZiRSyLIj+YSj93S2++8LI3G2cfIPFFuedsYq2ZCCsPJBNiqQH0v8ctYdpvUH
         /KhGGbzKHX+sOW7Zbx7pz4aJFaTIAnUrLqVEhf019yVXacWV/RUdaPKQlQ7dXOegwNo4
         cvJdG2/TsM4/tC3Gdv+vBYpCgEjJFBAVBTE9w/FW5hlgcVm/SiJNUbKqwgF3BEd5r7aH
         aH4cT+F/apjC4ZlCp95bNbSA7i22i9N/D6/U+qlCMzPpTCkz4UTQTdDbjR9gzq+m1AMD
         mk7g==
X-Gm-Message-State: AOAM532p7ELyDwF1mvF9Qswe4KoytBE+mlxUx47kuJhDcoVxIGkvFBQL
        37gJEew/K3ghtZdZy1/TMogpTwgunrPOs7trn+/itW6IQzIU6ZosTZ6allVWOcrhISoLXpsrgD8
        5g5fd8iEyUZRljjTB/SVgRdMESw==
X-Received: by 2002:a0c:a5a5:: with SMTP id z34mr964527qvz.59.1611255153386;
        Thu, 21 Jan 2021 10:52:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx+t6w7Xqx74qVrhjLt4C+TV/igg6sGjjWeLwYgwcTDBDVePcoDrMGpdJssFcXjs87Jbc1oiQ==
X-Received: by 2002:a0c:a5a5:: with SMTP id z34mr964502qvz.59.1611255153199;
        Thu, 21 Jan 2021 10:52:33 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id i129sm4225591qkd.114.2021.01.21.10.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 10:52:32 -0800 (PST)
Date:   Thu, 21 Jan 2021 13:52:30 -0500
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
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH 2/9] hugetlb/userfaultfd: Forbid huge pmd sharing when
 uffd enabled
Message-ID: <20210121185230.GE260413@xz-x1>
References: <20210115190451.3135416-1-axelrasmussen@google.com>
 <20210115190451.3135416-3-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115190451.3135416-3-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 15, 2021 at 11:04:44AM -0800, Axel Rasmussen wrote:

[...]

> @@ -947,4 +948,15 @@ static inline __init void hugetlb_cma_check(void)
>  }
>  #endif
>  
> +static inline bool want_pmd_share(struct vm_area_struct *vma)
> +{
> +#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
> +	if (uffd_disable_huge_pmd_share(vma))
> +		return false;
> +	return true;
> +#else
> +	return false;
> +#endif
> +}

I got syzbot complains about this chunk when compile some other archs outside
x86, probably because CONFIG_ARCH_WANT_HUGE_PMD_SHARE can be defined without
CONFIG_USERFAULTFD.  I don't know why it didn't complain here, so just a fyi
that I've pushed some new version to the online repo so that they should have
been fixed.  For example, for this patch:

https://github.com/xzpeter/linux/commit/0fd01db2c9ac3ab8600f3f7df23cf28fddcfee1b

static inline bool want_pmd_share(struct vm_area_struct *vma)
{
#ifdef CONFIG_USERFAULTFD
	if (uffd_disable_huge_pmd_share(vma))
		return false;
#endif

#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
	return true;
#else
	return false;
#endif
}

Thanks,

-- 
Peter Xu

