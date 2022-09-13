Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FB65B761B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 18:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiIMQIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 12:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiIMQIX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:08:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CC9BF4F
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 08:04:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so11639349pjl.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 08:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=OJAIEjey9dL/oOlyHKJUty+rvUtRfrNcjV74l588HbE=;
        b=nipjUGyopyRbnweevoI2Oq+FbDhrGlaD7wKP+k5xapkMVsoGweAQ6K2hQ8AZ+n3N71
         J85U0qDe2D5AD8d1gpjf++nTpiIkyTFzNlFk+YTPVFtJCYSH/SE9jP8KJtPu7wQ0hfi5
         wYDpgxyUrRwd1sYa/NGSuu4VudYk3GqiPthKN+bOi/ckST3RiIggvPeGp3bhm5p8ypVT
         3f+MwrbGT4h/7a0VEnXrxvfZQW0KEOYcQaivu+1/UqQdLAEGFiH+0RbJHMUiEdIZPPCt
         MhVMuPS1IGUUE+HBMjXHJM9fAUIO8mG1oaSP0/UpGjTZuC/UI7ZeIyP4hCCX4seU5+Tv
         A0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=OJAIEjey9dL/oOlyHKJUty+rvUtRfrNcjV74l588HbE=;
        b=tL4UGoEwtioWDeRIVuM/T4WufZrMhUb7Pbk80SftKe4QXcPXkxnd7d2koFeWYbUaWk
         ny4Sc99+5HCJY2Z1T9WT4y7uUBjo6JySqXaknXKkT5RWdt+lDRD26ABp1ExgITTqqUpr
         DOvZ+UrT/JCd7Fji9DZ+QSGqblmN1pcZ5TpzjtrUhKVDezwtBZDHESBqKhBBWkMFc5VK
         PZ2eY1kqKpK0XYLTmcRMFPHkAPNeyNbHp5st33jkn5Jp7SAmNktNN8YN4mfOz01MIzkO
         l99RqtQpLCNWrq1+TARxl4mn+NYAQxahU1WxtJa6Mw6ZL0kHeVEDU7YPqkFxcKF+Y48u
         c63Q==
X-Gm-Message-State: ACgBeo0BVus53b+phTlQ8/lwS4Whq7tZlnLX4s3rrnr17om27ZlbhwTi
        sIJfu1L48FTN6bbcr+itUhp3wUHN/OSVww==
X-Google-Smtp-Source: AA6agR4hCeLSjZthMuJfgYlKUGutRaZadKKJTFOH4uT+lOP/oa9jwO7wbAgJCVwL7oqP3EbrVwcGew==
X-Received: by 2002:a17:902:c7cc:b0:176:9fdd:ddb7 with SMTP id r12-20020a170902c7cc00b001769fddddb7mr32324812pla.150.1663080810301;
        Tue, 13 Sep 2022 07:53:30 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id k5-20020aa79985000000b00535d3caa66fsm7855085pfh.197.2022.09.13.07.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:53:29 -0700 (PDT)
Date:   Tue, 13 Sep 2022 14:53:25 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <YyCZZSyCrwXLLCD9@google.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com>
 <20220818132421.6xmjqduempmxnnu2@box>
 <c6ccbb96-5849-2e2f-3b49-4ea711af525d@google.com>
 <20220820002700.6yflrxklmpsavdzi@box.shutemov.name>
 <c194262b-b634-4baf-abf0-dc727e8f1d7@google.com>
 <20220831142439.65q2gi4g2d2z4ofh@box.shutemov.name>
 <20220908011037.ez2cdorthqxkerwk@box.shutemov.name>
 <YyBQ+wzPtGwwRB/U@google.com>
 <20220913132821.3ch5cv3rgdxqgz3i@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913132821.3ch5cv3rgdxqgz3i@box.shutemov.name>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 13, 2022, Kirill A. Shutemov wrote:
> On Tue, Sep 13, 2022 at 09:44:27AM +0000, Sean Christopherson wrote:
> > On Thu, Sep 08, 2022, Kirill A. Shutemov wrote:
> > > On Wed, Aug 31, 2022 at 05:24:39PM +0300, Kirill A . Shutemov wrote:
> > > > On Sat, Aug 20, 2022 at 10:15:32PM -0700, Hugh Dickins wrote:
> > > > > > I will try next week to rework it as shim to top of shmem. Does it work
> > > > > > for you?
> > > > > 
> > > > > Yes, please do, thanks.  It's a compromise between us: the initial TDX
> > > > > case has no justification to use shmem at all, but doing it that way
> > > > > will help you with some of the infrastructure, and will probably be
> > > > > easiest for KVM to extend to other more relaxed fd cases later.
> > > > 
> > > > Okay, below is my take on the shim approach.
> > > > 
> > > > I don't hate how it turned out. It is easier to understand without
> > > > callback exchange thing.
> > > > 
> > > > The only caveat is I had to introduce external lock to protect against
> > > > race between lookup and truncate.
> > 
> > As before, I think this lock is unnecessary.  Or at least it's unnessary to hold
> > the lock across get/put.  The ->invalidate() call will ensure that the pfn is
> > never actually used if get() races with truncation.
> 
> The updated version you replying to does not use the lock to protect
> against truncation anymore. The lock protect notifier list.

Gah, grabbed the patch when applying.

> > Switching topics, what actually prevents mmapp() on the shim?  I tried to follow,
> > but I don't know these areas well enough.
> 
> It has no f_op->mmap, so mmap() will fail with -ENODEV. See do_mmap().
> (I did not read the switch statement correctly at first. Note there are
> two 'fallthrough' there.)

Ah, validate_mmap_request().  Thought not implementing ->mmap() was the key, but
couldn't find the actual check.

Thanks much!
