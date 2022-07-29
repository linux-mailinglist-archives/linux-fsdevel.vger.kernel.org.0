Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA3458553B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jul 2022 21:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbiG2TCX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jul 2022 15:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238315AbiG2TCU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:02:20 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8961C86C27
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Jul 2022 12:02:17 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w10so5435885plq.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Jul 2022 12:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=LkO9SgTZ2fPl2HYX0gFonlaXjyZgw7WltwbfzzP2PWU=;
        b=LcCMO/BfHtLr67gbUfFYeZ2DnL0Qe15D/zjxvFdRRh7VmNk7LN5oMsc24VO/GmbV/U
         PuV6l97/eHoUtKDyH52SVtPAZ87OnqBus/o63uyQuFgufZzCyq9XsxfOUYAdERS1Jgqd
         Z8e1N8bqzr0z8QDItDcXKcyyEaabrG/16s5zoaP1WRFBF4Ue7XuTf8xaQCPaAoBgg974
         KUIBiMYBx36eqSObwBq4p2WXddbpg1bPZ34gDbt+XQiuHO4akXNCCqBoLF/FeCnzUG2i
         XE9mksL3i7ZMYBmA4SOK8RBlplgWMUQ4wTuOLsTMqyyIK0ibz34Lq8CE9D2iQAq/i5AS
         iEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=LkO9SgTZ2fPl2HYX0gFonlaXjyZgw7WltwbfzzP2PWU=;
        b=K80+y0kk0VGe2M4JKyU9JQJe584wkXlpe6kWNn0u52JK3kQNUqrEDy2IxAtAMTaoD4
         I7kUGjA/ll1Z2Rik6Fr26WI8UU4ttqSJTCUa6tf2fqphwQVEeggogMzCRASYGhiQhJgY
         IkCJtLNAbFbzHdnnL8ijFA+gS7LXzprfjULrot+JXNm973SN7GV9hBLYdDRCvEVYpfI2
         N7yaNYu1bXkC72/EyFr9c0m/nzeOitQ0voG9VF3yLXSPbztK+GB8LmzwhqgmFeJn+4OV
         Lq9Zl80Cz3v9NPo6SEN1IeELnbFkWgoofk+jvYbJfmP9d20Rxw9aBf+mo0pIGvGgXhFn
         JTAA==
X-Gm-Message-State: ACgBeo1sjVOSQoWoGo8HTVHH5eqOkTrcEcTDlX0wZFLpOOMHupF83W1+
        Ixrx/LfiiejCpxJrHhdtvYCbTQ==
X-Google-Smtp-Source: AA6agR6iqcQsub1nBR7JRnM5qfcyEbknlTLsOfU5kvnAs7e7vtoc0LC7cubgKQlDwv2I4efPq2wL9Q==
X-Received: by 2002:a17:90a:2ec5:b0:1f2:ea66:c832 with SMTP id h5-20020a17090a2ec500b001f2ea66c832mr6318473pjs.31.1659121336897;
        Fri, 29 Jul 2022 12:02:16 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id n16-20020a170902e55000b0016d5cf36ff8sm4042180plf.274.2022.07.29.12.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 12:02:16 -0700 (PDT)
Date:   Fri, 29 Jul 2022 19:02:12 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 08/14] KVM: Rename mmu_notifier_*
Message-ID: <YuQutJAhKWcsrrYl@google.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-9-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706082016.2603916-9-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 06, 2022, Chao Peng wrote:
> The sync mechanism between mmu_notifier and page fault handler employs
> fields mmu_notifier_seq/count and mmu_notifier_range_start/end. For the
> to be added private memory, there is the same mechanism needed but not
> rely on mmu_notifier (It uses new introduced memfile_notifier). This
> patch renames the existing fields and related helper functions to a
> neutral name mmu_updating_* so private memory can reuse.

mmu_updating_* is too broad of a term, e.g. page faults and many other operations
also update the mmu.  Although the name most definitely came from the mmu_notifier,
it's not completely inaccurate for other sources, e.g. KVM's MMU is still being
notified of something, even if the source is not the actual mmu_notifier.

If we really want a different name, I'd vote for nomenclature that captures the
invalidation aspect, which is really what the variables are all trackng, e.g.

  mmu_invalidate_seq
  mmu_invalidate_in_progress
  mmu_invalidate_range_start
  mmu_invalidate_range_end

