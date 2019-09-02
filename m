Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 982F8A5E4C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 01:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfIBXyB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 19:54:01 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36863 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbfIBXyB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 19:54:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46Mn3n2Lzbz9s7T;
        Tue,  3 Sep 2019 09:53:57 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Breno Leitao <leitao@debian.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Stanley <joel@jms.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Diana Craciun <diana.craciun@nxp.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Hildenbrand <david@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 5/6] powerpc/64: Make COMPAT user-selectable disabled on littleendian by default.
In-Reply-To: <20190902130008.GZ31406@gate.crashing.org>
References: <cover.1567198491.git.msuchanek@suse.de> <c7c88e88408588fa6fcf858a5ae503b5e2f4ec0b.1567198492.git.msuchanek@suse.de> <87ftlftpy7.fsf@mpe.ellerman.id.au> <20190902130008.GZ31406@gate.crashing.org>
Date:   Tue, 03 Sep 2019 09:53:56 +1000
Message-ID: <87k1aqs19n.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Mon, Sep 02, 2019 at 12:03:12PM +1000, Michael Ellerman wrote:
>> Michal Suchanek <msuchanek@suse.de> writes:
>> > On bigendian ppc64 it is common to have 32bit legacy binaries but much
>> > less so on littleendian.
>> 
>> I think the toolchain people will tell you that there is no 32-bit
>> little endian ABI defined at all, if anything works it's by accident.
                ^
                v2

> There of course is a lot of powerpcle-* support.  The ABI used for it
> on linux is the SYSV ABI, just like on BE 32-bit.

I was talking about ELFv2, which is 64-bit only. But that was based on
me thinking we had a hard assumption in the kernel that ppc64le kernels
always expect ELFv2 userland. Looking at the code though I was wrong
about that, it looks like we will run little endian ELFv1 binaries,
though I don't think anyone is testing it.

> There also is specific powerpcle-linux support in GCC, and in binutils,
> too.  Also, config.guess/config.sub supports it.  Half a year ago this
> all built fine (no, I don't test it often either).
>
> I don't think glibc supports it though, so I wonder if anyone builds an
> actual system with it?  Maybe busybox or the like?
>
>> So I think we should not make this selectable, unless someone puts their
>> hand up to say they want it and are willing to test it and keep it
>> working.
>
> What about actual 32-bit LE systems?  Does anyone still use those?

Not that I've ever heard of.

cheers
