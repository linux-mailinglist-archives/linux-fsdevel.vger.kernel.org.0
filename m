Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D5762F9CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 16:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241423AbiKRP7V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 10:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241240AbiKRP7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:59:19 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405BB8CF1B
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 07:59:17 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so5454180pjk.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 07:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BIzAKlqfAaMg368D6jPlp8HmIeVCVtTOFRZVfOrIoRA=;
        b=s6eyQMrxXlVr7mjyTTlqJhnlh/Xi9X6Am4TwNlENwsPyRh8KvXIqhnsP3MMWC9+MoB
         oQd97BmjUOsQPxgMsh5zyjcOYLIVp3cqB3U8qN7/Ud5hvTdIANRIWIS/vJblpoBTxukB
         h0Lxk6Jg3vNqw4OVzI0CkcjluXS6vsT31cdyDImlVx7++g13+ozmNNZ5BkzVdivrg7g+
         00m3rpeYDbyzY05rk/dB8GnC4ClchfIxtJ5aTCzCQyATv7KhMjKNSIDvnh3cGt1Q5v+L
         lNMyGoelDxkjB2wAw8ywO8jmucxwhUGJpJ8n7dWOAqcgUj06ocsZtkUfpHvBn0wBdFz1
         TsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIzAKlqfAaMg368D6jPlp8HmIeVCVtTOFRZVfOrIoRA=;
        b=yMSFKoggrOFhbzzp5AfncDm4xSDJ0JRVLAYUZNbFmNU2AEKK9zM9Me2YSaZDJGmFS8
         eJBbvs6zoKST3UWCwLVKeyMQoe4iGwA7CUW9cs8DOz65qRYcP7t/PqPJnDlWHJcJKI1E
         kY1jNUJYdrFcjtQCh8yTdMyjaA+XcJJCoyrJ5JII/1TvwgelGvCxVpGcsjRub8TTuxMw
         Z4p9/N26PTTJNyoaK95Sze/pjDxrshfCbg4MYezygyhJTE8AitoDWJuJzhi7CTdt3G31
         PHt6MObJgJA3ARDsYAUjeEjs/FGwVY1+nit3Bx7Z7eE8c7T2cqCrJ5iCfw6aLkzMd7Eg
         uYZw==
X-Gm-Message-State: ANoB5plIRiN/malK4bdaPr8T5PTEizdDg3GhaiOOR2lHGTxGATazH/oC
        CgEOqKW2n4wREm9B/mueR0u3lbdvdfidRw==
X-Google-Smtp-Source: AA0mqf68z73TZ4LH+iMU8Y7+vIcozkzW9+xI2VfYzqSxI4RUtQBXAdSaqw03S7HKwO0upOzd1Ydjhw==
X-Received: by 2002:a17:90a:9f03:b0:211:59c6:6133 with SMTP id n3-20020a17090a9f0300b0021159c66133mr8428311pjp.238.1668787156611;
        Fri, 18 Nov 2022 07:59:16 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902a51000b001869f2120a5sm3840359plq.34.2022.11.18.07.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 07:59:16 -0800 (PST)
Date:   Fri, 18 Nov 2022 15:59:12 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
Subject: Re: [PATCH v9 3/8] KVM: Add KVM_EXIT_MEMORY_FAULT exit
Message-ID: <Y3er0M5Rpf1X97W/@google.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-4-chao.p.peng@linux.intel.com>
 <87cz9o9mr8.fsf@linaro.org>
 <20221116031441.GA364614@chaop.bj.intel.com>
 <87mt8q90rw.fsf@linaro.org>
 <20221117134520.GD422408@chaop.bj.intel.com>
 <87a64p8vof.fsf@linaro.org>
 <20221118013201.GA456562@chaop.bj.intel.com>
 <87o7t475o7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o7t475o7.fsf@linaro.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 18, 2022, Alex Bennée wrote:
> 
> Chao Peng <chao.p.peng@linux.intel.com> writes:
> 
> > On Thu, Nov 17, 2022 at 03:08:17PM +0000, Alex Bennée wrote:
> >> >> I think this should be explicit rather than implied by the absence of
> >> >> another flag. Sean suggested you might want flags for RWX failures so
> >> >> maybe something like:
> >> >> 
> >> >> 	KVM_MEMORY_EXIT_SHARED_FLAG_READ	(1 << 0)
> >> >> 	KVM_MEMORY_EXIT_SHARED_FLAG_WRITE	(1 << 1)
> >> >> 	KVM_MEMORY_EXIT_SHARED_FLAG_EXECUTE	(1 << 2)
> >> >>         KVM_MEMORY_EXIT_FLAG_PRIVATE            (1 << 3)
> >> >
> >> > Yes, but I would not add 'SHARED' to RWX, they are not share memory
> >> > specific, private memory can also set them once introduced.
> >> 
> >> OK so how about:
> >> 
> >>  	KVM_MEMORY_EXIT_FLAG_READ	(1 << 0)
> >>  	KVM_MEMORY_EXIT_FLAG_WRITE	(1 << 1)
> >>  	KVM_MEMORY_EXIT_FLAG_EXECUTE	(1 << 2)
> >>         KVM_MEMORY_EXIT_FLAG_SHARED     (1 << 3)
> >>         KVM_MEMORY_EXIT_FLAG_PRIVATE    (1 << 4)
> >
> > We don't actually need a new bit, the opposite side of private is
> > shared, i.e. flags with KVM_MEMORY_EXIT_FLAG_PRIVATE cleared expresses
> > 'shared'.
> 
> If that is always true and we never expect a 3rd type of memory that is
> fine. But given we are leaving room for expansion having an explicit bit
> allows for that as well as making cases of forgetting to set the flags
> more obvious.

Hrm, I'm on the fence.

A dedicated flag isn't strictly needed, e.g. even if we end up with 3+ types in
this category, the baseline could always be "private".

I do like being explicit, and adding a PRIVATE flag costs KVM practically nothing
to implement and maintain, but evetually we'll up with flags that are paired with
an implicit state, e.g. see the many #PF error codes in x86.  In other words,
inevitably KVM will need to define the default/base state of the access, at which
point the base state for SHARED vs. PRIVATE is "undefined".  

The RWX bits are in the same boat, e.g. the READ flag isn't strictly necessary.
I was thinking more of the KVM_SET_MEMORY_ATTRIBUTES ioctl(), which does need
the full RWX gamut, when I typed out that response.

So I would say if we add an explicit READ flag, then we might as well add an explicit
PRIVATE flag too.  But if we omit PRIVATE, then we should omit READ too.
