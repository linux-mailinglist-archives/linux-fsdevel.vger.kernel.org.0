Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1F87644A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 05:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjG0D5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 23:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjG0D5R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:57:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012A82706;
        Wed, 26 Jul 2023 20:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8617261D19;
        Thu, 27 Jul 2023 03:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333DBC433C8;
        Thu, 27 Jul 2023 03:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690430233;
        bh=2LZQxDDrrueBXO8BVcvN88sdAiFgW61YpvmWoV4rusk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EZdgMDJNvWHpTU/TbbeuJIRdZELQC4io44o7BRZjr/qEbqXP+mOb3SpnPc3GnzZUJ
         6/89F+qI71eFF4iUju0DDwCRfWxlmyu525kPI64StVeMn3g22mxzWiFX5SyeyJUOvC
         7vpMprEDvWDPdxrLmbFWPjI1sopKugt5VjA6tOeYBWY7dbKLYXy1ooOebTmGv3ACSj
         fFwMNdhI5gT7lq20ftyAy9B2B7F0Kx3men5CLDs/URmKMEbxn6qNQpfOdz4+yFLRKM
         U8TEEb4JSsQRcj9xreGkiiwQXGZr6UG1WIoN/6+4R39C1Goqdd0J+NCOS+t8EZnNCl
         LnOw3z+jPm6bA==
Date:   Wed, 26 Jul 2023 20:57:10 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
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
Message-ID: <20230727035710.GA15127@sol.localdomain>
References: <cover.1689092120.git.legion@kernel.org>
 <cover.1689074739.git.legion@kernel.org>
 <104971.1690300714@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <104971.1690300714@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 25, 2023 at 04:58:34PM +0100, David Howells wrote:
> Rather than adding a fchmodat2() syscall, should we add a "set_file_attrs()"
> syscall that takes a mask and allows you to set a bunch of stuff all in one
> go?  Basically, an interface to notify_change() in the kernel that would allow
> several stats to be set atomically.  This might be of particular interest to
> network filesystems.
> 
> David
> 

fchmodat2() is a simple addition that fits well with the existing syscalls.
It fixes an oversight in fchmodat().

IMO we should just add fchmodat2(), and not get sidetracked by trying to add
some super-generalized syscall instead.  That can always be done later.

- Eric
