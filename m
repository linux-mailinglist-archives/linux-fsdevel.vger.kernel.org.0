Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AA76E17DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 01:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjDMXHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 19:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjDMXHb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:07:31 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B9BE6F
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 16:07:29 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f1ffb8ccfso139543867b3.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 16:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681427248; x=1684019248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m0eoChJ3C+wX0j/cXmxt8QdAgHqIaCqFV7218jkkfFU=;
        b=cUBnq6doIYuLvUGVyiYaA7jpkgVtHOtimIKcwt2fzUEGbTagC+SbFxwzie3YwQBvoi
         2tvxYDlX35dBRsyJ0dqJ0imqCLe7ogS8WTyC7A5vLzXCTzi2nfvrTc7VxeigvLRuypoj
         d9zWu9lsiLRAeEcyRqF2vB0H2fEa6JEL4FKRXo81NT0wlQUQMuRZJC6/qqZxiWVlFuvs
         rCpdS64PxIo7V8SajS2etdSOROdKTmlVD4sBgXB1W2FZSMb7wXUNI2yqiz+J9cWyF9eb
         0i6PytQOESujv8I6M/6hszVyOyKaqVF3BjpcBY+b2iw09H2OLHz5o/ci5kucUCGLlxuh
         5zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681427248; x=1684019248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m0eoChJ3C+wX0j/cXmxt8QdAgHqIaCqFV7218jkkfFU=;
        b=Fb/GIBGVEtE6VQ3k2AUGjkk5NPHZXiD09FpFNswk0gMhlHLaP73AjiOuYDLysfZC+w
         B95YZIAM7mAkh5t1ebtcdZ3X/go0FEVj9GRRNs9x6KPkT3wkdUW71czvupuexu8+T94Z
         vJS23IoGdV1JTaaLHwU43PbJJin6go/0ogl4eTPa6QpSjBUzYwPR8ISgCAwvRh/IEqnX
         GFEk/NfFKa07M1D14565K6OsSrfS4mME4jNR69vANOVxi5FeNAfeVffm4gVDKdHVczsc
         7D643O9Hh/IlFQgW2VT3JrKIIM8z/eJd7zyYN46kl2epfhKefWzpv+exx696df+AogGm
         JH9w==
X-Gm-Message-State: AAQBX9ca6mucQferGJ2iKxDEzxej/C0ajGtvUqI553KBYTQx13K4acav
        JNxo2ZBhtAmDUq5cWQFcNpzgXiJSxAs=
X-Google-Smtp-Source: AKy350amwDqyJa+LlzM7biYAI+3i1mkieCfxZS836tmzptZ4SOWRoy5g8JqAYQ9+zKy/xdEKWNYlO5mXB8A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d0d6:0:b0:b8f:559f:bd49 with SMTP id
 h205-20020a25d0d6000000b00b8f559fbd49mr2479865ybg.6.1681427247867; Thu, 13
 Apr 2023 16:07:27 -0700 (PDT)
Date:   Thu, 13 Apr 2023 23:07:26 +0000
In-Reply-To: <diqzedono0m5.fsf@ackerleytng-cloudtop.c.googlers.com>
Mime-Version: 1.0
References: <20230412-kurzweilig-unsummen-3c1136f7f437@brauner> <diqzedono0m5.fsf@ackerleytng-cloudtop.c.googlers.com>
Message-ID: <ZDiLLih4XHUCCwFY@google.com>
Subject: Re: [RFC PATCH v3 1/2] mm: restrictedmem: Allow userspace to specify
 mount for memfd_restricted
From:   Sean Christopherson <seanjc@google.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     Christian Brauner <brauner@kernel.org>, kvm@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, aarcange@redhat.com, ak@linux.intel.com,
        akpm@linux-foundation.org, arnd@arndb.de, bfields@fieldses.org,
        bp@alien8.de, chao.p.peng@linux.intel.com, corbet@lwn.net,
        dave.hansen@intel.com, david@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, hpa@zytor.com, hughd@google.com,
        jlayton@kernel.org, jmattson@google.com, joro@8bytes.org,
        jun.nakajima@intel.com, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, luto@kernel.org, mail@maciej.szmigiero.name,
        mhocko@suse.com, michael.roth@amd.com, mingo@redhat.com,
        naoya.horiguchi@nec.com, pbonzini@redhat.com, qperret@google.com,
        rppt@kernel.org, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 13, 2023, Ackerley Tng wrote:
> Christian Brauner <brauner@kernel.org> writes:
> > I'm curious, is there an LSFMM session for this?
> 
> As far as I know, there is no LSFMM session for this.

Correct, no LSFMM session.  In hindsight, that's obviously something we should
have pursued :-(
