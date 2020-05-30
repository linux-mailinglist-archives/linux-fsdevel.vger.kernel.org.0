Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A081E9360
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 21:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgE3T1U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 May 2020 15:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgE3T1U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 May 2020 15:27:20 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47E0C03E969;
        Sat, 30 May 2020 12:27:19 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jf78U-000YpY-D7; Sat, 30 May 2020 19:27:14 +0000
Date:   Sat, 30 May 2020 20:27:14 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Subject: Re: [PATCH 8/9] x86: kvm_hv_set_msr(): use __put_user() instead of
 32bit __clear_user()
Message-ID: <20200530192714.GT23230@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
 <20200529232723.44942-1-viro@ZenIV.linux.org.uk>
 <20200529232723.44942-8-viro@ZenIV.linux.org.uk>
 <CAHk-=wgq2dzOdN4_=eY-XwxmcgyBM_esnPtXCvz1zStZKjiHKA@mail.gmail.com>
 <20200530143147.GN23230@ZenIV.linux.org.uk>
 <81563af6-6ea2-3e21-fe53-9955910e303a@redhat.com>
 <CAHk-=wiW=cKaMyBKgZMOOJQbpAyeRrz--o2H_7CdDpbn+az9vQ@mail.gmail.com>
 <20200530183853.GQ23230@ZenIV.linux.org.uk>
 <CAHk-=wjmCBXj0==no0f9Og6NZuAVWPEFXUgRL+fRmJ8PovbdPQ@mail.gmail.com>
 <20200530191940.GS23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530191940.GS23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 30, 2020 at 08:19:40PM +0100, Al Viro wrote:
> On Sat, May 30, 2020 at 11:52:44AM -0700, Linus Torvalds wrote:
> 
> > And I don't understand why you mention set_fs() vs access_ok(). None
> > of this code has anything that messes with set_fs(). The access_ok()
> > is garbage and shouldn't exist, and those user accesses should all use
> > the checking versions and the double underscores are wrong.
> > 
> > I have no idea why you think the double underscores could _possibly_
> > be worth defending.
> 
> I do not.  What I'm saying is that this just might be a beast different
> from *both* __... and the normal ones.  I'm not saying that this
> __put_user() (or __clear_user(), etc.) is the right primitive here.
> If anything, it's closer to the situation for (x86) copy_stack_trace().

... and no, I'm not saying that copy_stack_trace() should stay with
__get_user() either.  It feels like we are lacking primitives needed
to express that cleanly and copy_stack_trace() currently cobbles something
up out of what we have.  Which works for arch-specific code, but yes,
that kind of thing is brittle for arch-independent places like virt/kvm;
I wonder if e.g. s390 is really OK there.
