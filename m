Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE6532141C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 11:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhBVKZG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 05:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhBVKY6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 05:24:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09BB564E2F;
        Mon, 22 Feb 2021 10:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613989457;
        bh=hPfUfFtTmjkrQbsktsKt6yfqMzt3/NRJ4jjF/NEBc8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b3V9NfUxwhwIYN04tZ4xVJ3p5sqw8LDNui76vseSDtV/Re6690BnkfF+nR9DcxpOG
         pUgE90vqEFMU/X/MPAhMaZnhkphLp2hZD3Ly/S74TC7UD+nyJ2MxvQgUFzQn0n4cWr
         O38zmX3c++0vqSgjip+sme4YMMtTL5UAgX7/Dvrcr8EOMRxrQU75JWaHMRk39qP/AW
         lgAw/KQkfggAeoHx3YM+5n3m6vnlhaY/3Jp3VStjpjmNap+nGK6+o3g9qwoOyHxtFy
         vWZY83MCClCfU5xmCjWJ66fOJT92kzAT9sZgszmOAF/eGW/eyThqm6caGmwW8QA7LL
         32a3PdFZcp9HQ==
Date:   Mon, 22 Feb 2021 12:23:59 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH v17 08/10] PM: hibernate: disable when there are active
 secretmem users
Message-ID: <20210222102359.GE1447004@kernel.org>
References: <20210208084920.2884-1-rppt@kernel.org>
 <20210208084920.2884-9-rppt@kernel.org>
 <20210222073452.GA30403@codon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222073452.GA30403@codon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 22, 2021 at 07:34:52AM +0000, Matthew Garrett wrote:
> On Mon, Feb 08, 2021 at 10:49:18AM +0200, Mike Rapoport wrote:
> 
> > It is unsafe to allow saving of secretmem areas to the hibernation
> > snapshot as they would be visible after the resume and this essentially
> > will defeat the purpose of secret memory mappings.
> 
> Sorry for being a bit late to this - from the point of view of running
> processes (and even the kernel once resume is complete), hibernation is
> effectively equivalent to suspend to RAM. Why do they need to be handled
> differently here?

Hibernation leaves a copy of the data on the disk which we want to prevent.

-- 
Sincerely yours,
Mike.
