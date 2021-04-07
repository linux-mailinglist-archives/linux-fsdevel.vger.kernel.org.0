Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2C63577F8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 00:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhDGWvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 18:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhDGWvV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 18:51:21 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04DFC061761
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Apr 2021 15:51:11 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id c3so337232qkc.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Apr 2021 15:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=akFwvW1OPNUTvr2e/zyj+KD9T58HeKDdv1pZyCx4m3s=;
        b=DuFPi2GpNFK4QFLfLRuf3hEguynbfHsAkqPmG8FbTdFT76p/tQXsHu07amyvhobFvS
         vdHvFMcHUQtsmDgP53Bd3z4x/ghUyUMHBYMBCVmNuyc9P/mfugQ/MWu633B3iu5zrNRN
         +yb1Y/tjbE6cRQ777L85d/W9xXkQ7CVwD2vYbml96Qvi0j2hBMZjazbPYNFE+RIk5vxh
         aZECALgLkrvWjt7yA/LFghP261JTdP/bY1sS6vWhUlAAWLgITKSXmrnE6T15+QdiA7c0
         VQX73UCJjunCOkEgVZrLWtV5bffDnY+V+P6/Ir84+to3gBRpvt+atQPcpGSScNLdFera
         Y2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=akFwvW1OPNUTvr2e/zyj+KD9T58HeKDdv1pZyCx4m3s=;
        b=KL2vqZFrF/I5swIa9uK/eLKtgOaWnOqd7oo/EAbYhTnmxyOjZhmIKAdfMgzqlXZ4f8
         3Izn7D5DpkrkMqZF8cGWlQE8so3DA1iHPx6VY2m6VNBXqAJwIAUImDvvkoVcWI6qDNMP
         cPWYzl2ii+j8MP0n5ak6Ybl3lkVLECKQj4m1D3UlRllHm8ElKkB+HPXU9RfIHQeDb23V
         caX4auyHSiSSA59iOB+rVP6hgv+ksUg6XAawgur5oL/36+Eeauq6KwlqUALajv5tCv8m
         xqVmMt0QM9p8EeDoFrGOJdeptJU/yfrWO+MF7Z1us1waOCRajmgETla1hG4ZxveRUDhL
         LZ1w==
X-Gm-Message-State: AOAM530iIqlTfgCez8bj5xIICUSE76RdKDIuCPDkaelsEcnorjEcwyze
        01g5bFWIf799Okyn/y4XRDG6sg==
X-Google-Smtp-Source: ABdhPJxwo5ZTCb8pJWYlrRQi+hQ9q5Ts9Qg8T9xfYtLCCgFcYREh0mV5OiX7ERdLHMrCb14BuF1v5Q==
X-Received: by 2002:a37:dcb:: with SMTP id 194mr5795509qkn.4.1617835870547;
        Wed, 07 Apr 2021 15:51:10 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s19sm19059776qks.130.2021.04.07.15.51.08
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 07 Apr 2021 15:51:10 -0700 (PDT)
Date:   Wed, 7 Apr 2021 15:50:54 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Axel Rasmussen <axelrasmussen@google.com>
cc:     Hugh Dickins <hughd@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org, Brian Geffon <bgeffon@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4] userfaultfd/shmem: fix MCOPY_ATOMIC_CONTINUE
 behavior
In-Reply-To: <CAJHvVcgGbdeoniOzwQsc370idV5gJ5cfq8Kzu3hneBAaB+CL6g@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2104071542190.15034@eggly.anvils>
References: <20210401183701.1774159-1-axelrasmussen@google.com> <alpine.LSU.2.11.2104062307110.14082@eggly.anvils> <CAJHvVcgGbdeoniOzwQsc370idV5gJ5cfq8Kzu3hneBAaB+CL6g@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 7 Apr 2021, Axel Rasmussen wrote:
> Agreed about taking one direction or the other further.
> 
> I get the sense that Peter prefers the mcopy_atomic_install_ptes()
> version, and would thus prefer to just expose that and let
> shmem_mcopy_atomic_pte() use it.
> 
> But, I get the sense that you (Hugh) slightly prefer the other way -
> just letting shmem_mcopy_atomic_pte() deal with both the VM_SHARED and
> !VM_SHARED cases.

No, either direction seems plausible to me: start from whichever
end you prefer.

> 
> I was planning to write "I prefer option X because (reasons), and
> objections?" but I'm realizing that it isn't really clear to me which
> route would end up being cleaner. I think I have to just pick one,
> write it out, and see where I end up. If it ends up gross, I don't
> mind backtracking and taking the other route. :) To that end, I'll
> proceed by having shmem_mcopy_atomic_pte() call the new
> mcopy_atomic_install_ptes() helper, and see how it looks (unless there
> are objections).

I am pleased to read that: it's exactly how I would approach it -
so it must be right :-)

Hugh
