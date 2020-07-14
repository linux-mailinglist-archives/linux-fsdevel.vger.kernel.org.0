Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79F021FD8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgGNTkt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729702AbgGNTks (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:40:48 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F50BC061755;
        Tue, 14 Jul 2020 12:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A7QakhpbDS7UpMv5+nU5KcUWNAdeAaqYrQ/G09rIDaM=; b=hfQoOcG+Pzg8dmu3eJSSuTU6l1
        IOJF9Ygv/Ir6H4jax9Vk0necvIXLuIFoc8RghaSIpMO2o90p3Kq+v8gmgX+JBiM2dUtjNrfgeLaIE
        NygcPnxNWGIDt8TfeoiZjI3culu/1+/kakxLwczxNW6ZtWxyqh0zsIiYqlLORazVknTBLLZhmFarB
        oxjQNqBBHr+/xhoC//cla5A+xlCy3cwKDZPEBcjywqGKy+NS8coxnvKAin3/6zvC+y5ORIiiFWrL7
        8niS3yPRXFTMnawEHXnE3kmKOZa2Rjy2EMpWfjQklgfuiYZLSLOyu0KH3mh9FihtfRDQMzFs7CKzb
        bKC+acMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQn3-0003Xv-HT; Tue, 14 Jul 2020 19:40:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D32E9817E0; Tue, 14 Jul 2020 21:40:31 +0200 (CEST)
Date:   Tue, 14 Jul 2020 21:40:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
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
Subject: Re: [RFC PATCH 11/15] memremap: Add zone device access protection
Message-ID: <20200714194031.GI5523@worktop.programming.kicks-ass.net>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
 <20200714070220.3500839-12-ira.weiny@intel.com>
 <20200714084057.GP10769@hirez.programming.kicks-ass.net>
 <20200714191047.GE3008823@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714191047.GE3008823@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:10:47PM -0700, Ira Weiny wrote:
> On Tue, Jul 14, 2020 at 10:40:57AM +0200, Peter Zijlstra wrote:

> > That's an anti-pattern vs static_keys, I'm thinking you actually want
> > static_key_slow_{inc,dec}() instead of {enable,disable}().
> 
> Thanks.  I'll go read the doc for those as I'm not familiar with them.

Look for static_branch_{inc,dec} in include/linux/jump_label.h, it
basically does the refcount thing you need and does the actual
transition on the 0->1 and 1->0 transitions.
