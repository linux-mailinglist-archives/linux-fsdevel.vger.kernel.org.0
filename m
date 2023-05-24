Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6ED70EF70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 09:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbjEXHb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 03:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbjEXHb1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 03:31:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5401790;
        Wed, 24 May 2023 00:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JWeiXDNejpnwIzLgTU/23od5O2F3Mmup/rXfS/mSgtU=; b=RbsSpdIBOq3BZKkwPoSgqQayF2
        5P6+wfsjWDMtGKARnHgBscWBdI8H4uGcbVNEo5jf55w6njt21XXGOl1hcJObLAH3zJyCra5OVogsl
        O41eYrcAYVeOwCzfqRIYnzPZHnh8uc0UYebhT5ua3goSwQL5KDfCwZ+4X+acQHOCb356auBFyjgE0
        o3GsrgFTDP6HjbXxYfQgQCv4HzTpKMcv6HJvEPDjpWEv8hLSTmVuXqF4nQMi86BejMVFA1r0xnOcF
        x1bEoniUEKfRuEBN/s7ldzV1qSMGHIdD2gvX/mr74+AebCG4APyA8vzfL+WNt8UJH7hQmkD8RZnoJ
        tE0ldKYA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1ixB-00CcAF-0o;
        Wed, 24 May 2023 07:30:37 +0000
Date:   Wed, 24 May 2023 00:30:37 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     keescook@chromium.org, yzaikin@google.com, ebiederm@xmission.com,
        arnd@arndb.de, bp@alien8.de, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, brgerst@gmail.com,
        christophe.jaillet@wanadoo.fr, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, j.granados@samsung.com, akpm@linux-foundation.org,
        willy@infradead.org, linux-parisc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] signal: move show_unhandled_signals sysctl to its
 own file
Message-ID: <ZG29HWE9NWn56hTg@bombadil.infradead.org>
References: <20230522210814.1919325-1-mcgrof@kernel.org>
 <20230522210814.1919325-3-mcgrof@kernel.org>
 <d0fe7a6f-8cd9-0b81-758a-f3b444e74bab@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0fe7a6f-8cd9-0b81-758a-f3b444e74bab@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 07:16:55AM -0700, Dave Hansen wrote:
> On 5/22/23 14:08, Luis Chamberlain wrote:
> > --- a/arch/x86/kernel/umip.c
> > +++ b/arch/x86/kernel/umip.c
> > @@ -12,6 +12,7 @@
> >  #include <asm/insn.h>
> >  #include <asm/insn-eval.h>
> >  #include <linux/ratelimit.h>
> > +#include <linux/signal.h>
> 
> Oh, so this is actually fixing a bug: umip.c uses
> 'show_unhandled_signals' but it doesn't explicitly include
> linux/signal.h where 'show_unhandled_signals' is declared.

Fixes a non-critical bug perhaps, but I doubt it would be fixing
a functional bug as otherwise folks would have reported a build bug, no?

What or how it ends up including that file today to avoid build
failures is beyond me.

> It doesn't actually have anything to do with moving the
> show_unhandled_signals sysctl, right?

Well in my case it is making sure the sysctl variable used is declared
as well.

> If that's the case, it would be nice to have this in its own patch.

If its not really fixing any build bugs or functional bugs I don't see
the need. But if you really want it, I can do it.

Let me know!

  Luis
