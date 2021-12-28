Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9217F480DA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Dec 2021 23:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbhL1WOr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Dec 2021 17:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbhL1WOq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Dec 2021 17:14:46 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4AFC06173E
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Dec 2021 14:14:46 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id j13so14519195plx.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Dec 2021 14:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4kbldenRRljiKR1Jt8lmO+A9SOM5gsjtEfI6iQUXR9o=;
        b=MNwTLMoEjto6Tw6TfXVbYxRNk4Y/L11GzPwaCuLWqyWzjZ2pcEiwjFaSREd3CUy2fC
         MiMYyR8Cfk1wKwmCHbKOnQ+t6IQzl9Sw5a16HNSmWYqEpHHgEPKkuCKouItq6Q1Z1hFc
         MWTqs9iGTa5rvoxswEX5nU0xHrhOfCFbpvB3rYanRhKMz+DP1PdTiuKuvi2a2YEOySZN
         6CFhKlk2BnfSTBv/hCv7vLBIZepm6QGteoEDmTMfxwUFRX2DO4G2RWbTWc3RavQ+f0NQ
         pfTJMLA/uOnVIYf0YqAPnhCgUAusvK7b8nikHrV9n4IDIo1Keq98ObiEwq6iLXgYmejs
         jbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4kbldenRRljiKR1Jt8lmO+A9SOM5gsjtEfI6iQUXR9o=;
        b=Cq21jnbSc9uIwkYyauBjVZXpxWshgXbHiueF7/YUlw793V7c8zlEtz7sJgYjPFyrl6
         lEBFhq9+0xX83DMMNKQyT9GgOMvCqbJQ0vSMoHjAn5BxnLKSzxcbpKOryfo2tGHdn07z
         8fcJvG7SUNTTq36jcMcbZuOp+SYMgHOQQcGBEREj+HBP6ere9BGllAxm+X3AmtvUojUN
         2GOR8TwhhrTL5mJosvSlXNpIBTg8RXtkftroUKRtbYLLjRcLxYl+knFh8IN1mbloeySb
         jEOieaEzbD0RAMAEArN+GktmvIC3FTeV2xbuY/kPb7LC89AzVzhfKqBnlzhVOGKTvClc
         RK2Q==
X-Gm-Message-State: AOAM532lmrygzhLBOWzRoL+eLrMOM4Uzx1f2TFC0RbOLErqTJLWZ00MV
        v+jnI/hY4wp3XhyIFmf2I3qAXQ==
X-Google-Smtp-Source: ABdhPJzfJNaMPXkNIFnIwBuKP0GW8ia1wKbbn8Tjarn7+ME8Xqk/IQFh/+e6Aq1yAU5kMGgNptVopg==
X-Received: by 2002:a17:90a:bc46:: with SMTP id t6mr29119866pjv.78.1640729685623;
        Tue, 28 Dec 2021 14:14:45 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id a4sm23854157pjw.30.2021.12.28.14.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 14:14:45 -0800 (PST)
Date:   Tue, 28 Dec 2021 22:14:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
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
Subject: Re: [PATCH v3 kvm/queue 06/16] KVM: Implement fd-based memory using
 MEMFD_OPS interfaces
Message-ID: <YcuMUemyBXFYyxCC@google.com>
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-7-chao.p.peng@linux.intel.com>
 <YcTBLpVlETdI8JHi@google.com>
 <e3fe04eb-1a01-bea4-f1ea-cb9ee98ee216@redhat.com>
 <20211224042554.GD44042@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224042554.GD44042@chaop.bj.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 24, 2021, Chao Peng wrote:
> On Fri, Dec 24, 2021 at 12:09:47AM +0100, Paolo Bonzini wrote:
> > On 12/23/21 19:34, Sean Christopherson wrote:
> > > >   	select HAVE_KVM_PM_NOTIFIER if PM
> > > > +	select MEMFD_OPS
> > > MEMFD_OPS is a weird Kconfig name given that it's not just memfd() that can
> > > implement the ops.
> > > 
> > 
> > Or, it's kvm that implements them to talk to memfd?
> 
> The only thing is VFIO may also use the same set of callbacks, as
> discussed in the v2. But I think that's fine.

I'm objecting to assuming that KVM is talking to memfd.  KVM shouldn't know or
care what is sitting behind the fd, KVM only cares whether or not the backing store
provides the necessary APIs.

I also think that the API as whole should be abstracted from memfd.  It's mostly
cosmectic, e.g. tweak the struct and Kconfig name.  I don't really care if it's
initially dependent on MEMFD_CREATE, I just don't want to end up with an API and
KVM implementation that implies there's something fundamentally special about memfd.
