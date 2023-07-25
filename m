Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D3C7621EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 21:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjGYTAE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 15:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjGYTAD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:00:03 -0400
X-Greylist: delayed 918 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Jul 2023 12:00:00 PDT
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [216.12.86.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129F81BDA
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 12:00:00 -0700 (PDT)
Date:   Tue, 25 Jul 2023 14:44:43 -0400
From:   Rich Felker <dalias@libc.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Alexey Gladkov <legion@kernel.org>,
        James.Bottomley@HansenPartnership.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, axboe@kernel.dk,
        benh@kernel.crashing.org, borntraeger@de.ibm.com, bp@alien8.de,
        catalin.marinas@arm.com, christian@brauner.io, davem@davemloft.net,
        deepa.kernel@gmail.com, deller@gmx.de, fenghua.yu@intel.com,
        geert@linux-m68k.org, glebfm@altlinux.org, gor@linux.ibm.com,
        hare@suse.com, hpa@zytor.com, ink@jurassic.park.msu.ru,
        jhogan@kernel.org, kim.phillips@arm.com, ldv@altlinux.org,
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
Message-ID: <20230725184443.GA20050@brightrain.aerifal.cx>
References: <87fs5c3rbl.fsf@oldenburg3.str.redhat.com>
 <cover.1689092120.git.legion@kernel.org>
 <cover.1689074739.git.legion@kernel.org>
 <104971.1690300714@warthog.procyon.org.uk>
 <107290.1690310391@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <107290.1690310391@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 25, 2023 at 07:39:51PM +0100, David Howells wrote:
> Florian Weimer <fweimer@redhat.com> wrote:
> 
> > > Rather than adding a fchmodat2() syscall, should we add a
> > > "set_file_attrs()" syscall that takes a mask and allows you to set a bunch
> > > of stuff all in one go?  Basically, an interface to notify_change() in the
> > > kernel that would allow several stats to be set atomically.  This might be
> > > of particular interest to network filesystems.
> > 
> > Do you mean atomically as in compare-and-swap (update only if old values
> > match), or just a way to update multiple file attributes with a single
> > system call?
> 
> I was thinking more in terms of the latter.  AFAIK, there aren't any network
> filesystems support a CAS interface on file attributes like that.  To be able
> to do a CAS operation, we'd need to pass in the old values as well as the new.
> 
> Another thing we could look at is doing "create_and_set_attrs()", possibly
> allowing it to take a list of xattrs also.

Can we please not let " hey let's invent a new interface to do
something that will be hard for underlying filesystems to even provide
and that nothing needs because there's no standard API to do it" be
the enemy of "fixing a known problem implementing an existing standard
API that just requires a simple, clearly-scoped syscall to do it"?

Rich
