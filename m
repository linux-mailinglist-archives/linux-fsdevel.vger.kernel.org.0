Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79412FF48C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 20:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbhAUTcU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 14:32:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbhAUTFE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611255783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q9aC69Rrd685E5LorLOvTrA44ELra9S4V5jph1Dfqxg=;
        b=LyyT+Pg2KaHVr0sD0BC74NsLOy8cevivdasiyT4k1lq/bo2bgEMfYnajYxxVnlMXTA3FgQ
        zzBs7//SOGdVpvVPmnq3wBL4R13uvxgknxuJ4LNSFRM/MqVisx7y0LRfYQPWU0sqf7D87t
        K5PmOPqz3kTKpK+XlQlYiftggb/t4nc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-eoU_fNgrOWmLGAjofuNDkw-1; Thu, 21 Jan 2021 13:59:31 -0500
X-MC-Unique: eoU_fNgrOWmLGAjofuNDkw-1
Received: by mail-qv1-f70.google.com with SMTP id t16so2113726qvk.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 10:59:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q9aC69Rrd685E5LorLOvTrA44ELra9S4V5jph1Dfqxg=;
        b=BTCeAJ5N6eZ1XZNsFqMjMuPB0W9ydhUvybv7WZr1yMYjyG/IgrG5eHwrcXZGIKK0CT
         kSd4guH3cwNSWlut5Zr3eUINbEPfgmc69LiXFfPJglok8bxTpy8JxW1gDahhkZztRlRm
         PykSkac4vjI4OVF/6wkEsYOxdnXIqdGbtoJ6j2HQHRAALz3pmLDrf/S+BSbVgEBYk5Aj
         XrCT9S/TpFL/DZrs70k+Ee/0a1noBLyU6bEnlj9U707XCJvhk3rr+OkVl8Ikp5qNwib/
         u2xZVqN669ER+tsiaA8Z+Oc3jvfu0zneEn1ZQoAumRzoDSMPHr7d4h7EoHUZ3vreJXpa
         pz4w==
X-Gm-Message-State: AOAM532gj+jw0vGn/r6f106FYdRzaFGbV6rgsrRoz0xQ8F6UsoumLrUT
        WQ36QfFU4up/PMhMOeojdiEj1izZtql0ENZKy78zqPQEwXMmQgirxdwhJ1EbN63iU1GNmNKi14w
        ZwhKx53Rb/ecAwRsGM/uR0FctEg==
X-Received: by 2002:a37:4905:: with SMTP id w5mr1238051qka.332.1611255571021;
        Thu, 21 Jan 2021 10:59:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpPfqGEB5hWMaS7ODRJG0nJlz/OA1oFXO3oLmpasvHghnddIsNoZXPMGIOq60g/FNnFLxxvQ==
X-Received: by 2002:a37:4905:: with SMTP id w5mr1238009qka.332.1611255570798;
        Thu, 21 Jan 2021 10:59:30 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id u5sm4409823qka.86.2021.01.21.10.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 10:59:30 -0800 (PST)
Date:   Thu, 21 Jan 2021 13:59:28 -0500
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
Subject: Re: [PATCH 6/9] userfaultfd: disable huge PMD sharing for MINOR
 registered VMAs
Message-ID: <20210121185928.GF260413@xz-x1>
References: <20210115190451.3135416-1-axelrasmussen@google.com>
 <20210115190451.3135416-7-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115190451.3135416-7-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 15, 2021 at 11:04:48AM -0800, Axel Rasmussen wrote:
> As the comment says: for the MINOR fault use case, although the page
> might be present and populated in the other (non-UFFD-registered) half
> of the shared mapping, it may be out of date, and we explicitly want
> userspace to get a minor fault so it can check and potentially update
> the page's contents.
> 
> Huge PMD sharing would prevent these faults from occurring for
> suitably aligned areas, so disable it upon UFFD registration.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

