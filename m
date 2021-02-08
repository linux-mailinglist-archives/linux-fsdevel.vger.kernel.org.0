Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC67E3141D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 22:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbhBHVaa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 16:30:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236288AbhBHV3s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 16:29:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A648464E6F;
        Mon,  8 Feb 2021 21:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612819747;
        bh=BHP7iz8fCkGAAZDbGkYOw5wU43VUzE8VWkEzgL/I5DY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qL100s6mgIPyUjqubn6qZY/kMCsj1KEQZdirnkXADWmg0iVj7hfwIQ3IyHN4+oznZ
         sKVq1m3+0ySh0eOSN1oIzlM8FbtudrJ3CE2DwvdNGhMPCh3lBCQg2N+kNymfamdpqT
         XCPvnHR85Ke8iqXZ+XZTaKdCsMDq3TH8SWa1ajgh8qTJqRGpTRsgpXnc3gRC7gshD4
         AXtH79cnaN9/ayJxdS78B84cPXS5Rtc2XoOXe9toc6RfKcnPk7iQVK9JPIdZqSYlwY
         nUdImrFVP5JU69KSlGnPav89Q/NWipnWsKDgUR1IQOb4hc851nIVO3OzJ5l3fxoOYv
         1GdeKPuy4OdKA==
Date:   Mon, 8 Feb 2021 23:28:51 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
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
Message-ID: <20210208212851.GY242749@kernel.org>
References: <20210208084920.2884-1-rppt@kernel.org>
 <20210208084920.2884-9-rppt@kernel.org>
 <YCEP/bmqm0DsvCYN@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCEP/bmqm0DsvCYN@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 08, 2021 at 11:18:37AM +0100, Michal Hocko wrote:
> On Mon 08-02-21 10:49:18, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > It is unsafe to allow saving of secretmem areas to the hibernation
> > snapshot as they would be visible after the resume and this essentially
> > will defeat the purpose of secret memory mappings.
> > 
> > Prevent hibernation whenever there are active secret memory users.
> 
> Does this feature need any special handling? As it is effectivelly
> unevictable memory then it should behave the same as other mlock, ramfs
> which should already disable hibernation as those cannot be swapped out,
> no?

As David already said, hibernation does not care about mlocked memory, so
this feature requires a special handling.

-- 
Sincerely yours,
Mike.
