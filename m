Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24F7D6B384
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 03:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfGQBsZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 21:48:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51824 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfGQBsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 21:48:25 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hnZ34-00075C-8b; Wed, 17 Jul 2019 01:48:02 +0000
Date:   Wed, 17 Jul 2019 02:48:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org,
        monstr@monstr.eu, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, peterz@infradead.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, dhowells@redhat.com, firoz.khan@linaro.org,
        stefan@agner.ch, schwidefsky@de.ibm.com, axboe@kernel.dk,
        christian@brauner.io, hare@suse.com, deepa.kernel@gmail.com,
        tycho@tycho.ws, kim.phillips@arm.com, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 2/4] Add fchmodat4(), a new syscall
Message-ID: <20190717014802.GS17978@ZenIV.linux.org.uk>
References: <20190717012719.5524-1-palmer@sifive.com>
 <20190717012719.5524-3-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717012719.5524-3-palmer@sifive.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 16, 2019 at 06:27:17PM -0700, Palmer Dabbelt wrote:

> -int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
> +int do_fchmodat4(int dfd, const char __user *filename, umode_t mode, int flags)
>  {
>  	struct path path;
>  	int error;
> -	unsigned int lookup_flags = LOOKUP_FOLLOW;
> +	unsigned int lookup_flags;
> +
> +	if (unlikely(flags & ~AT_SYMLINK_NOFOLLOW))
> +		return -EINVAL;
> +
> +	lookup_flags = flags & AT_SYMLINK_NOFOLLOW ? 0 : LOOKUP_FOLLOW;
> +

	Why not do that in sys_fchmodat4() itself, passing lookup_flags to
do_fchmodat() and updating old callers to pass it 0 as extra argument?
