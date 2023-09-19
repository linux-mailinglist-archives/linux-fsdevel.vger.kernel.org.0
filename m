Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E807A67A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 17:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjISPKd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 11:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjISPKb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:10:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6227C6;
        Tue, 19 Sep 2023 08:10:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AFF51FB;
        Tue, 19 Sep 2023 08:11:01 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.31.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CACC3F59C;
        Tue, 19 Sep 2023 08:10:22 -0700 (PDT)
Date:   Tue, 19 Sep 2023 16:10:14 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Changhui Zhong <czhong@redhat.com>,
        yangerkun <yangerkun@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>, peterz@infradead.org,
        Kees Cook <keescook@chromium.org>,
        chengzhihao <chengzhihao1@huawei.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [czhong@redhat.com: [bug report] WARNING: CPU: 121 PID: 93233 at
 fs/dcache.c:365 __dentry_kill+0x214/0x278]
Message-ID: <ZQmwcagwXBQCTpUY@FVFF77S0Q05N.cambridge.arm.com>
References: <ZOWFtqA2om0w5Vmz@fedora>
 <20230823-kuppe-lassen-bc81a20dd831@brauner>
 <CAFj5m9KiBDzNHCsTjwUevZh3E3RRda2ypj9+QcRrqEsJnf9rXQ@mail.gmail.com>
 <CAHj4cs_MqqWYy+pKrNrLqTb=eoSOXcZdjPXy44x-aA1WvdVv0w@mail.gmail.com>
 <89d049ed-6bbf-bba7-80d4-06c060e65e5b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89d049ed-6bbf-bba7-80d4-06c060e65e5b@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 16, 2023 at 02:55:47PM +0800, Baokun Li wrote:
> On 2023/9/13 16:59, Yi Zhang wrote:
> > The issue still can be reproduced on the latest linux tree[2].
> > To reproduce I need to run about 1000 times blktests block/001, and
> > bisect shows it was introduced with commit[1], as it was not 100%
> > reproduced, not sure if it's the culprit?
> > 
> > 
> > [1] 9257959a6e5b locking/atomic: scripts: restructure fallback ifdeffery
> Hello, everyone！
> 
> We have confirmed that the merge-in of this patch caused hlist_bl_lock
> (aka, bit_spin_lock) to fail, which in turn triggered the issue above.

Thanks for this!

I believe I know what the issue is.

I took a look at the generated assembly for hlist_bl_lock() and
hlist_bl_unlock(), and for the latter I see a plain store rather than a
store-release as was intended.

I believe that in 9257959a6e5b, I messed up the fallback logic for
atomic*_set_release():

| static __always_inline void 
| raw_atomic64_set_release(atomic64_t *v, s64 i)
| {
| #if defined(arch_atomic64_set_release)
|         arch_atomic64_set_release(v, i);
| #elif defined(arch_atomic64_set)
|         arch_atomic64_set(v, i);
| #else
|         if (__native_word(atomic64_t)) {
|                 smp_store_release(&(v)->counter, i);
|         } else {
|                 __atomic_release_fence();
|                 raw_atomic64_set(v, i);
|         }    
| #endif
| }

On arm64 we want to use smp_store_release(), and don't provide
arch_atomic64_set_release(). Unfortunately we *do* provide arch_atomic64_set(),
and the ifdeffery above will choose that in preference.

Prior to that commit, the ifdeffery would do what we want:

| #ifndef arch_atomic64_set_release
| static __always_inline void
| arch_atomic64_set_release(atomic64_t *v, s64 i)
| {
|         if (__native_word(atomic64_t)) {
|                 smp_store_release(&(v)->counter, i);
|         } else {
|                 __atomic_release_fence();
|                 arch_atomic64_set(v, i);
|         }
| }
| #define arch_atomic64_set_release arch_atomic64_set_release
| #endif

That explains the lock going wrong -- we lose the RELEASE semantic on
hlist_bl_unlock(), and so loads and stores within the critical section aren't
guaranteed to be visible to the next hlist_bl_lock(). On x86 this happens to
work becauase of TSO.

I'm working on fixing that now; I'll try to have a patch shortly.

Thanks,
Mark.
