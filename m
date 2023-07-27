Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B768F765127
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 12:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbjG0K3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 06:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbjG0K2U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:28:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0428126B8;
        Thu, 27 Jul 2023 03:27:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95F0261E1D;
        Thu, 27 Jul 2023 10:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FC3C433C8;
        Thu, 27 Jul 2023 10:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690453676;
        bh=deaD8pujkpTtajMkrzG6FDy9HzkESG69/qNzMXZtjw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I7SQDE13fzKBcFUp5ePMk9YUxZ5LwkMwJzEhJh5gygi5y3Ao4HYQUhpzqZ+RcAGng
         bn4vp/EfbLNeCzrahJPNrwO1OBRujz9xBo7+Gwbo3boim4OhzbOb3qoiVHBiAMEaWJ
         PUG9ntl7QrNnL9tqEWTP/FDqYRjBLv6Pe+hC4010c/XsSyQFDc2T5KRE4F0CEfvhIP
         4kdpLRFtj8U5bMLrtJSUPNEcwdIVIx3V75HfNd2zboybu6ykt1PDPjB308ZqP7GtZB
         ns0n3LOD64u1iaWvsMh+b+uKRfMRf5JlVFDa1qQYJ082NdSiyLNQ81rIjYiYhPr8X+
         TOPX0LSqgemIg==
Date:   Thu, 27 Jul 2023 12:27:42 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Alexey Gladkov <legion@kernel.org>,
        James.Bottomley@hansenpartnership.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, axboe@kernel.dk,
        benh@kernel.crashing.org, borntraeger@de.ibm.com, bp@alien8.de,
        catalin.marinas@arm.com, christian@brauner.io, dalias@libc.org,
        davem@davemloft.net, deepa.kernel@gmail.com, deller@gmx.de,
        fenghua.yu@intel.com, fweimer@redhat.com, geert@linux-m68k.org,
        glebfm@altlinux.org, gor@linux.ibm.com, hare@suse.com,
        hpa@zytor.com, ink@jurassic.park.msu.ru, jhogan@kernel.org,
        kim.phillips@arm.com, ldv@altlinux.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux@armlinux.org.uk, linuxppc-dev@lists.ozlabs.org,
        luto@kernel.org, mattst88@gmail.com, mingo@redhat.com,
        monstr@monstr.eu, mpe@ellerman.id.au, namhyung@kernel.org,
        paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org,
        sparclinux@vger.kernel.org, stefan@agner.ch, tglx@linutronix.de,
        tony.luck@intel.com, tycho@tycho.ws, will@kernel.org,
        x86@kernel.org, ysato@users.sourceforge.jp,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: Add fchmodat2() - or add a more general syscall?
Message-ID: <20230727-kassieren-aneinander-052b18a84546@brauner>
References: <cover.1689092120.git.legion@kernel.org>
 <cover.1689074739.git.legion@kernel.org>
 <104971.1690300714@warthog.procyon.org.uk>
 <20230727035710.GA15127@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230727035710.GA15127@sol.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 08:57:10PM -0700, Eric Biggers wrote:
> On Tue, Jul 25, 2023 at 04:58:34PM +0100, David Howells wrote:
> > Rather than adding a fchmodat2() syscall, should we add a "set_file_attrs()"
> > syscall that takes a mask and allows you to set a bunch of stuff all in one
> > go?  Basically, an interface to notify_change() in the kernel that would allow
> > several stats to be set atomically.  This might be of particular interest to
> > network filesystems.
> > 
> > David
> > 
> 
> fchmodat2() is a simple addition that fits well with the existing syscalls.
> It fixes an oversight in fchmodat().
> 
> IMO we should just add fchmodat2(), and not get sidetracked by trying to add
> some super-generalized syscall instead.  That can always be done later.

Agreed.
