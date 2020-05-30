Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889DC1E9232
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 16:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgE3Ow4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 May 2020 10:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgE3Ow4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 May 2020 10:52:56 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40954C03E969;
        Sat, 30 May 2020 07:52:53 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jf2qv-000U2Z-8N; Sat, 30 May 2020 14:52:49 +0000
Date:   Sat, 30 May 2020 15:52:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Subject: Re: [PATCH 8/9] x86: kvm_hv_set_msr(): use __put_user() instead of
 32bit __clear_user()
Message-ID: <20200530145249.GO23230@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
 <20200529232723.44942-1-viro@ZenIV.linux.org.uk>
 <20200529232723.44942-8-viro@ZenIV.linux.org.uk>
 <CAHk-=wgq2dzOdN4_=eY-XwxmcgyBM_esnPtXCvz1zStZKjiHKA@mail.gmail.com>
 <20200530143147.GN23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530143147.GN23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 30, 2020 at 03:31:47PM +0100, Al Viro wrote:

> It's a bit trickier than that, but I want to deal with that at the same
> time as the rest of kvm/vhost stuff.  So for this series I just went
> for minimal change.  There's quite a pile of vhost and kvm stuff,
> but it's not ready yet - wait for the next cycle.

BTW, regarding uaccess plans for the next cycle:
	* regset mess (at least the ->get() side)
	* killing more compat_alloc_user_space() call sites (_maybe_
all of it, if we are lucky enough; v4l2 is a bitch in that respect,
but I've some ideas on how to deal with that - need to discuss with
mchehab)
	* sorting the remaining (harder) parts of i915 out
	* kvm/vhost
	* fault_in_pages_...() series
That should get rid of almost all __... ones outside of arch/*; might
actually kill copy_in_user() off as well.
	* finally lifting stac/clac out of raw_copy_{to,from}_user().
