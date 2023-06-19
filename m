Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67BB735DF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 21:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjFSTps (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 15:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjFSTpr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:45:47 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91E4106
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 12:45:45 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6685421cdb3so1398540b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jun 2023 12:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687203945; x=1689795945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2mZiRdSqt+8wYLSRq7eLPC9b4RpYVG9iNh28AaCGdYw=;
        b=VbyQLRYNz3Mu4xhjfuwM6hsK60V4+prvJC2X+UK9XAc/Elig3W+lZfOdm3lsaFffXc
         aLwRhEXpqpl49PVYjZsMWtH3rA+TStqTAEBqKAhOrHyss+uM65w2xGYEfuipVtRsXjG5
         f8D6Fx7Bv1krhLICrN7S8Z1r0/mK+azg85Gk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687203945; x=1689795945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mZiRdSqt+8wYLSRq7eLPC9b4RpYVG9iNh28AaCGdYw=;
        b=FiUdzRS31GwpEXeuG0ldS78WMblKQWskAeI8I8MNIDrr5j8atGmFyKSuLeubQyyfAq
         N7xWlfLxez5Gv0DiQeI0mTrfDxQT5XKioKa92Qx/XBfKowkWKdVSkegt5ti8L+gGMzg1
         QFWyOlo6FqnZ/0ADjF12SBi145CeoILbG3q/JcOHgus2hIFNZ4Gx1k2Oz1o5+XfpL80O
         cgPW14km0WLR220sPyT2C5UKKiXSctjx++CboLByLy9O5ZBD0Q6y4Q5Z9jWvxQqfLYYN
         P9nM0P0kAYDqnwf0Z1ZY9YsB200+wmwFDnKrPhmNaaygYAPU51coI6Mq3k3J/eaaLU6u
         iKaA==
X-Gm-Message-State: AC+VfDwA9dMQx6rTMxPQPv2MJMdDSg4BlNYqz/R9bqWEjm/ib+PwT8/N
        Th9BQaXolNcUbk0vIBhMpSU5vg==
X-Google-Smtp-Source: ACHHUZ7onSh5feYj5qpymA9lTfUnolVSYLdS9M5+I0v+eTgmIbWulfKky2Q6Tl0VqKEkRqo1tB/S/w==
X-Received: by 2002:a05:6a20:9389:b0:121:637e:f0e5 with SMTP id x9-20020a056a20938900b00121637ef0e5mr6130614pzh.5.1687203945205;
        Mon, 19 Jun 2023 12:45:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h18-20020a63f912000000b00519c3475f21sm76437pgi.46.2023.06.19.12.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 12:45:44 -0700 (PDT)
Date:   Mon, 19 Jun 2023 12:45:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <202306191228.6A98FD25@keescook>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <3508afc0-6f03-a971-e716-999a7373951f@wdc.com>
 <202305111525.67001E5C4@keescook>
 <ZF6Ibvi8U9B+mV1d@moria.home.lan>
 <202305161401.F1E3ACFAC@keescook>
 <ZGPzocRpSlg+4vgN@moria.home.lan>
 <1d249326-e3dd-9c9d-7b53-2fffeb39bfb4@kernel.org>
 <ZI3Sh6p8b4FcP0Y2@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZI3Sh6p8b4FcP0Y2@moria.home.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 17, 2023 at 11:34:31AM -0400, Kent Overstreet wrote:
> On Fri, Jun 16, 2023 at 09:13:22PM -0700, Andy Lutomirski wrote:
> > On 5/16/23 14:20, Kent Overstreet wrote:
> > > On Tue, May 16, 2023 at 02:02:11PM -0700, Kees Cook wrote:
> > > > For something that small, why not use the text_poke API?
> > > 
> > > This looks like it's meant for patching existing kernel text, which
> > > isn't what I want - I'm generating new functions on the fly, one per
> > > btree node.
> > 
> > Dynamically generating code is a giant can of worms.
> > 
> > Kees touched on a basic security thing: a linear address mapped W+X is a big
> > no-no.  And that's just scratching the surface -- ideally we would have a
> > strong protocol for generating code: the code is generated in some
> > extra-secure context, then it's made immutable and double-checked, then
> > it becomes live.
> 
> "Double checking" arbitrary code is is fantasy. You can't "prove the
> security" of arbitrary code post compilation.

I think there's a misunderstanding here about the threat model I'm
interested in protecting against for JITs. While making sure the VM of a
JIT is safe in itself, that's separate from what I'm concerned about.

The threat model is about flaws _elsewhere_ in the kernel that can
leverage the JIT machinery to convert a "write anything anywhere anytime"
exploit primitive into an "execute anything" primitive. Arguments can
be made to say "a write anything flaw means the total collapse of the
security model so there's no point defending against it", but both that
type of flaw and the slippery slope argument don't stand up well to
real-world situations.

The kinds of flaws we've seen are frequently limited in scope (write
1 byte, write only NULs, write only in a specific range, etc), but
when chained together, the weakest link is what ultimately compromises
the kernel. As such, "W^X" is a basic building block of the kernel's
self-defense methods, because it is such a potent target for a
write->execute attack upgrades.

Since a JIT constructs something that will become executable, it needs
to defend itself against stray writes from other threads. Since Linux
doesn't (really) use per-CPU page tables, the workspace for a JIT can be
targeted by something that isn't the JIT. To deal with this, JITs need
to use 3 phases: a writing pass (into W memory), then switch it to RO
and perform a verification pass (construct it again, but compare results
to the RO version), and finally switch it executable. Or, it can use
writes to memory that only the local CPU can perform (i.e. text_poke(),
which uses a different set of page tables with different permissions).

Without basic W^X, it becomes extremely difficult to build further
defenses (e.g. protecting page tables themselves, etc) since WX will
remain the easiest target.

-Kees

-- 
Kees Cook
