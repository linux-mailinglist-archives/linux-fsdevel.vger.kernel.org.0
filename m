Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099092FF404
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 20:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbhAUTOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 14:14:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726840AbhAUTOR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611256367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OPl8jorAsGAxXf0P/mQDZPfRGxFOXLofHdgCnNwVIcc=;
        b=dgeqA9M5i2ibO6RCyA/McyKZ4pzjjZ3b8G0v1y8EEpoq5vOGv2lQOrqr2wf2pZ3IfK9WUg
        gkEwrBnRE38IRTMBX17FBAR3Iz0rFP1VbwxwfaUTCkiIs/2XOvoblnhS5jCIpBxleyc86c
        91D61cxUk1ORIriZFotjAYV2FQfT2X8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-_80A7-c5OzCoXNdEYF8Ikg-1; Thu, 21 Jan 2021 14:12:45 -0500
X-MC-Unique: _80A7-c5OzCoXNdEYF8Ikg-1
Received: by mail-qk1-f200.google.com with SMTP id g26so2339858qkk.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 11:12:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OPl8jorAsGAxXf0P/mQDZPfRGxFOXLofHdgCnNwVIcc=;
        b=CWzGjCoFWBjJ5gVxXOYB1G8UYIVpAgGNmxdRL0YhLhLtYzDXpRbSBhZb5MEEYZp7Wf
         hmpbHTRJOlsXzBwz7gmVDyhcoEROgYUWVzXAvo8PIKl+kc31FY7k3JzSG1zV6pspu3EH
         zbRMapbqb8LTq1TJ202Y7pvMCmA3lndg5xOBNz3yRccfEgz7zLRKx/gaxrJXj7evIyCf
         3dpHdlPrEU+WM6cRv6DAob19oFwSy1FoSdL3qYeZUcZZhr7MggmqqRT1ZdU0/7LpWxvS
         xDWm2YKhEMa9xwb7arGFMfIIad8HSHh1lsYOpPDMPKO2lZozE7xB128d2xx8/S3oJEon
         0VLQ==
X-Gm-Message-State: AOAM532xJh6Uei40ysm/+BjB65IhGF+G9tCAnQ0o+yIlFFCuQVpmYlcA
        /8CAm5lkfH6XPCUC2lcylO98FVXyktH/t7qM0hUM7beFZONihRBx9yGnyRWSSsjfmm15yiVa4Cr
        ObaefFlgygEAnvbFhn96j9Qm7lg==
X-Received: by 2002:a05:620a:1370:: with SMTP id d16mr1350897qkl.26.1611256365114;
        Thu, 21 Jan 2021 11:12:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjih88mfXgX9Vd3gMH5PELft+ec29CkvSN6ax9zZG54+dCmmfWryq5S5QgIKBD44NV5o5pUw==
X-Received: by 2002:a05:620a:1370:: with SMTP id d16mr1350868qkl.26.1611256364928;
        Thu, 21 Jan 2021 11:12:44 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id b78sm4408055qkg.29.2021.01.21.11.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 11:12:44 -0800 (PST)
Date:   Thu, 21 Jan 2021 14:12:41 -0500
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
Subject: Re: [PATCH 0/9] userfaultfd: add minor fault handling
Message-ID: <20210121191241.GG260413@xz-x1>
References: <20210115190451.3135416-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115190451.3135416-1-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 15, 2021 at 11:04:42AM -0800, Axel Rasmussen wrote:
> UFFDIO_COPY and UFFDIO_ZEROPAGE cannot be used to resolve minor faults. Without
> modifications, the existing codepath assumes a new page needs to be allocated.
> This is okay, since userspace must have a second non-UFFD-registered mapping
> anyway, thus there isn't much reason to want to use these in any case (just
> memcpy or memset or similar).
> 
> - If UFFDIO_COPY is used on a minor fault, -EEXIST is returned.

When minor fault the dst VM will report to src with the address.  The src could
checkup whether dst contains the latest data on that (pmd) page and either:

  - it's latest, then tells dst, dst does UFFDIO_CONTINUE

  - it's not latest, then tells dst (probably along with the page data?  if
    hugetlbfs doesn't support double map, we'd need to batch all the dirty
    small pages in one shot), dst does whatever to replace the page

Then, I'm thinking what would be the way to replace an old page.. is that one
FALLOC_FL_PUNCH_HOLE plus one UFFDIO_COPY at last?

Thanks,

-- 
Peter Xu

