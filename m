Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B405547E76D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 19:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349696AbhLWSGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 13:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244610AbhLWSGX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:06:23 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806FAC061401
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 10:06:23 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id l10so5584035pgm.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 10:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xAmKzIc+8wB6wpfnMshmg3i7fbLcnqAVF/wlNkzMihA=;
        b=tTF25W0YJCF52VxnCB1yX2ghBWLxGZJIFN7meLmiZtwzhBFTNeS4pdlakQJzZthEVV
         sLib2vBfvyhkW444CXX6MyhXs2FVrJSmeOjey8QRFwqmDwoI0MkwMyxaf45xTCz7swuh
         yaGi9nwJG/3GAVuVtArFcBEU9kicedJGmiVBsW7ZsGufu8H34zMzEZuJ5+H6/lkFUVog
         f40Y4Ji6HA1nAKyvbZErsgxVE2A//Nlu4SFhBhFcNJnt2EyxEDNQFqBtXLQT1MUqQX5+
         tlBhIpZNunp3NCHf4C/ZbsZkCUoAI3H1wY+Nke7l6nQDCrTpDid2y9cBURkBmzOpyS9T
         g8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xAmKzIc+8wB6wpfnMshmg3i7fbLcnqAVF/wlNkzMihA=;
        b=7ok7nQV/gzX3XM9xr0dM7Eoj+Z7TwVl1wdmeYxyYWtm3vRPxvQaaDV85wLzD65na7L
         3uOc7g0pVQJiEUVy5vVJmPuXXjDXrTGfbmYFLugytYEjmTXcPykLOr8sNSobYPT41BPr
         wIJvkR1pkmnUnBQ74U5Du9ylRgKrpMMKH7al4MhZF0T2whz7g+AP4Q0h8VggBAr3wC/M
         d7ez0+QNBdl/RbhK3YQKd2EsFtyqAqVoNdzq53D5uob7zfndam1a2oPcq62hD8aCFGr4
         VS2q1w5safAU5THY3eiIBR/GzvYuCAXfobQPX2kXrwg2fdqXf0si4pRFidyytS1fg/xK
         ga3g==
X-Gm-Message-State: AOAM530dr8eYI3ecI8+H1d+/4Xo4NriIYHnl9GDXbCB3Zi1DhOxhASJF
        TasF1qVvxbhgg4OY4ojwAOKDUQ==
X-Google-Smtp-Source: ABdhPJx8ZGtfl7eWpJl5BHdJwST1PNXKEmCce64dp3wTaCWQJvvaSUBLS2W1N1XEWNIx8vbJ5FtHxQ==
X-Received: by 2002:a63:787:: with SMTP id 129mr3065930pgh.289.1640282782830;
        Thu, 23 Dec 2021 10:06:22 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 22sm6830378pfv.173.2021.12.23.10.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 10:06:22 -0800 (PST)
Date:   Thu, 23 Dec 2021 18:06:19 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: Re: [PATCH v3 kvm/queue 11/16] KVM: Add kvm_map_gfn_range
Message-ID: <YcS6m9CieYaIGA3F@google.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-12-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223123011.41044-12-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 23, 2021, Chao Peng wrote:
> This new function establishes the mapping in KVM page tables for a
> given gfn range. It can be used in the memory fallocate callback for
> memfd based memory to establish the mapping for KVM secondary MMU when
> the pages are allocated in the memory backend.

NAK, under no circumstance should KVM install SPTEs in response to allocating
memory in a file.   The correct thing to do is to invalidate the gfn range
associated with the newly mapped range, i.e. wipe out any shared SPTEs associated
with the memslot.
