Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61797223844
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 11:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgGQJZU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 05:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQJZT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:25:19 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25830C061755;
        Fri, 17 Jul 2020 02:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oh4+QZoZC7XJ5liIvD/prbetozs/+rcdlSei8EeQx8I=; b=kazs8KzUqKOCO/2D6mprbyvEnU
        +fzslg8lr95LXVXM9aFdR5oVu7YU+jtZjZuUuNhtdMoijq35pApqNb0Kjpu2+qVjYJPMxBkMxwxwt
        zJhrNYgoG+hopYMkGXql6VsXOH/lcfSxf6ew9w8rrvlgWZWbac4aHyF3rLfDTz9Z9EaOC5qqudxmp
        MPUw2W8cUivp9Wp2v/EKMhTIHSccGcg5LfOOnbnhGaWNlBaW4Nt73aFJHO/KOx+DjkatJQ183jtX+
        +ShtbR2b2ELtr1q+XxcZs8EPUhEs/rKmpIBEOk0TS2IxU4449Zsd/jtbWwQvb1sB85UrR0QJJ9Ss7
        A65td5HQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwMc8-00048L-Pk; Fri, 17 Jul 2020 09:25:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6906F300130;
        Fri, 17 Jul 2020 11:25:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5316B29CF6F53; Fri, 17 Jul 2020 11:25:07 +0200 (CEST)
Date:   Fri, 17 Jul 2020 11:25:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     ira.weiny@intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V2 16/17] [dax|pmem]: Enable stray write protection
Message-ID: <20200717092507.GE10769@hirez.programming.kicks-ass.net>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-17-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717072056.73134-17-ira.weiny@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 12:20:55AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Protecting against stray writes is particularly important for PMEM
> because, unlike writes to anonymous memory, writes to PMEM persists
> across a reboot.  Thus data corruption could result in permanent loss of
> data.  Therefore, there is no option presented to the user.
> 
> Enable stray write protection by setting the flag in pgmap which
> requests it.  Note if Zone Device Access Protection not be supported
> this flag will have no affect.

The actual implementation is stray-access-protection, as noted ealier.
This inconsisteny is throughout.
