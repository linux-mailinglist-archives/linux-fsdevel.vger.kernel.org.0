Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997E3376781
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 May 2021 17:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237760AbhEGPFc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 May 2021 11:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbhEGPF2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 May 2021 11:05:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A78C061574;
        Fri,  7 May 2021 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fRqBvN0tx2pJaoUlzcO69LtYKZ2yqF996XdsgiyBnas=; b=vaCd2p/D451W+krKP3Hm+Mbqfr
        M8QcUhbPPqPhLegCFXy/cxzLW7FvZbb6uNxUkrkGKI7XjV3rn1ZAHfUBFG0w/Gcd1Y0HXH+I+0tsZ
        X5OIkmdSb3DENIfibsKFsOFwf+J99y1XPqyblM2DtI5EMz6S+PaSg2Gnd8QEkW1EprcE5IyDWWb6H
        XccLGtI0WGlOs3TxB5jzm8biFUFGO1u++Fy5mXwuv4p8ZE02GLqDy0C+/fvdeiHDl1AhGyFKWfXC8
        WRULaO5OwTroeiZB1MTX6BJLmVDaSGw7qazPs7fahImlS4WfUKCD7jeGmPMUmeQ9MZT53HIVPhRiY
        pkdu3BuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lf1z6-003Gsj-Mp; Fri, 07 May 2021 15:01:57 +0000
Date:   Fri, 7 May 2021 16:01:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
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
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v3 2/2] secretmem: optimize page_is_secretmem()
Message-ID: <YJVWWFrvTzC2M0ba@casper.infradead.org>
References: <20210420150049.14031-1-rppt@kernel.org>
 <20210420150049.14031-3-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420150049.14031-3-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 20, 2021 at 06:00:49PM +0300, Mike Rapoport wrote:
> +	mapping = (struct address_space *)
> +		((unsigned long)page->mapping & ~PAGE_MAPPING_FLAGS);
> +
> +	if (mapping != page->mapping)
> +		return false;
> +
> +	return page->mapping->a_ops == &secretmem_aops;

... why do you go back to page->mapping here?

	return mapping->a_ops == &secretmem_aops
