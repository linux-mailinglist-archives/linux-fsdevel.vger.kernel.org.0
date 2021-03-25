Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1758A348617
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 01:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbhCYAwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 20:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235263AbhCYAwj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 20:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616633559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a/I8HMRSY8uGPzIO7tttoD3dS3yWYP/iDM4q6Ir57s4=;
        b=LAkSIrUlWk3kaq9Ijt7Spe/2d/OVsJK/Q8NxoNpe8T2MoYL+E3W9pNnYXm/bQaZRKdzIb3
        NvDe6a12JELpCiEO4DUfhoqGt2fcxDIdcWAjmmfCmVJ1tUAFuiIz/UlEWg2ECjeu8rAdCX
        XBYKkY8phRKTS6J1WSkJniSwBKoscNA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-keORL-CmOnuYxM1pYaRlfw-1; Wed, 24 Mar 2021 20:52:37 -0400
X-MC-Unique: keORL-CmOnuYxM1pYaRlfw-1
Received: by mail-qk1-f198.google.com with SMTP id v136so2856051qkb.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 17:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a/I8HMRSY8uGPzIO7tttoD3dS3yWYP/iDM4q6Ir57s4=;
        b=WGCbuhT0h+hTjC4zAMBhjUVFp2BxsBWGjw138vCYgj7Ad/IL8FM0izC8sUAEccP2H3
         LrTcYUKX32QWl0QnKVlrBjxPob4geabYVmOduwlZe8ew2t/YQpjpiYqwN6cKwmddI38h
         T6M+2gjjjmr/h4VmUfRukHrowtJDnHWUWPp/sS+KQ9mH8KIh9b+ojhSWVVUvsUKn7PsW
         qg3LBGg3qyvQorsgOO9pOAFc6VDdKHsT6ePIXk+219ftKD+szcWM+fzNLwyPhnbc08GD
         0gobM0WOe02DK4Tpf7EL7z63hvP3Jc1BHT0cBmVy9hv8mN4iTYddIEunp66rpK8ScKkw
         QksA==
X-Gm-Message-State: AOAM530C2d927Eu8lA20/LZgZsV8aHUGZZtL2C7YL9Eq7AJgUHCh/Ppx
        Crf8V/X4hYv0H04bt7R1DFVw8b2lSsg/DSLmGjVFWfEvwpIwjRGTYSE8RfItCfQ7Dylv7CGFCJv
        Zn//3RQ/7ZHWKtvwpWJ10GcOaRg==
X-Received: by 2002:ac8:6a04:: with SMTP id t4mr5714165qtr.258.1616633557073;
        Wed, 24 Mar 2021 17:52:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwf9lYUsnxZG/nhvJyxohZp2hC5gok7X1yMvcKfPeM5sVJS83vfqZvs4qyqdec2U35Zf3Et5A==
X-Received: by 2002:ac8:6a04:: with SMTP id t4mr5714138qtr.258.1616633556783;
        Wed, 24 Mar 2021 17:52:36 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id k4sm3078112qke.13.2021.03.24.17.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 17:52:36 -0700 (PDT)
Date:   Wed, 24 Mar 2021 20:52:34 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Wang Qing <wangqing@vivo.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH] userfaultfd/shmem: fix minor fault page leak
Message-ID: <20210325005234.GG219069@xz-x1>
References: <20210322204836.1650221-1-axelrasmussen@google.com>
 <20210324162027.cc723b545ff62b1ad6f5223e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210324162027.cc723b545ff62b1ad6f5223e@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Andrew,

On Wed, Mar 24, 2021 at 04:20:27PM -0700, Andrew Morton wrote:
> On Mon, 22 Mar 2021 13:48:35 -0700 Axel Rasmussen <axelrasmussen@google.com> wrote:
> 
> > This fix is analogous to Peter Xu's fix for hugetlb [0]. If we don't
> > put_page() after getting the page out of the page cache, we leak the
> > reference.
> > 
> > The fix can be verified by checking /proc/meminfo and running the
> > userfaultfd selftest in shmem mode. Without the fix, we see MemFree /
> > MemAvailable steadily decreasing with each run of the test. With the
> > fix, memory is correctly freed after the test program exits.
> > 
> > Fixes: 00da60b9d0a0 ("userfaultfd: support minor fault handling for shmem")
> 
> Confused.  The affected code:
> 
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1831,6 +1831,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
> >  
> >  	if (page && vma && userfaultfd_minor(vma)) {
> >  		unlock_page(page);
> > +		put_page(page);
> >  		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
> >  		return 0;
> >  	}
> 
> Is added by Peter's "page && vma && userfaultfd_minor".  I assume that
> "Fixes:" is incorrect?
> 

It seems to me the commit is correct as pointed to in "Fixes", but I do have a
different commit ID here:

    commit 63c826b1372c4930f89b8a55092699fa7f0d6f4e
    Author: Axel Rasmussen <axelrasmussen@google.com>
    Date:   Thu Mar 18 10:20:43 2021 -0400

    userfaultfd: support minor fault handling for shmem

Axel, did you fetched the commit ID from your local tree, perhaps?  Since I
should have fetched from hnaz/linux-mm and I can see Andrew's sign-off too.

Thanks,

-- 
Peter Xu

