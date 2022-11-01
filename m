Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6296147F9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 11:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiKAKxg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 06:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKAKxd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:53:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6762C18E27;
        Tue,  1 Nov 2022 03:53:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FB1D1FB;
        Tue,  1 Nov 2022 03:53:37 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.3.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2E223F5A1;
        Tue,  1 Nov 2022 03:53:29 -0700 (PDT)
Date:   Tue, 1 Nov 2022 10:53:20 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] fs: add memory barrier in __fget_light()
Message-ID: <Y2D6lbcp8Mxwu6A5@FVFF77S0Q05N>
References: <20221031171307.2784981-1-jannh@google.com>
 <CAHk-=whgwb5oysYi_sTgzQjDPdg+DGH=VmfQk0o1EBrWOk+JRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whgwb5oysYi_sTgzQjDPdg+DGH=VmfQk0o1EBrWOk+JRw@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 31, 2022 at 10:37:01AM -0700, Linus Torvalds wrote:
> On Mon, Oct 31, 2022 at 10:13 AM Jann Horn <jannh@google.com> wrote:
> >
> > If this is too expensive on platforms like arm64, I guess the more
> > performant alternative would be to add another flags field that tracks
> > whether the fs_struct was ever shared and check that instead of the
> > reference count in __fget_light().
> 
> No, the problem is that you should never use the "smp_*mb()" horrors
> for any new code.
> 
> All the "smp_*mb()" things really are broken. Please consider them
> legacy garbage. It was how people though about SMP memory ordering in
> the bad old days.
> 
> So get with the 21st century, and instead replace the "atomic_read()"
> with a "smp_load_acquire()".

Minor nit: atomic{,64,_long}_{read_acquire,set_release}() exist to be used
directly on atomics and should d.t.r.t. on all architectures (e.g. where 64-bit
atomics on 32-bit platforms have extra requirements).

So this instance can be:

  ...
  if (atomic_read_acquire(&files->count) == 1) {
  ...

Mark.
