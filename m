Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF65223835
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 11:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgGQJWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 05:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgGQJWy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:22:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7602CC061755;
        Fri, 17 Jul 2020 02:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0cWzT9ttoeeT27mu1yXKQJtQPYAF2pim+h1ybnpSsI0=; b=tZ375G7K0Kic3bBHbECJdHyToB
        uofgKiBUdoGtRF0xWh2CTpH+grA6Ohxha9q/zMVCYJsZ31MyH13ZzHquYmLTMtFkwr1GW1OOiFznY
        9UoxGQU4GQIbjTQoPKhd0i+8kmco42C/+8qDBDHOuzLHdfOc/SUOfe/Q0SOs955+k/NuDM7mOfCvp
        2EoKAMwVL2rR+PKu16gnz/myd9zqlnSxGPYaSmlZTStTPyMlEysCRoP2w/acV4OYOOuM/HRszIVFj
        nGIjib9d+s9AkFAR84zQJKNmb+ZLvM196KiL3tpkkG3NYDtuiGcfPF3KXl8/PfVDurMcJrjstthhR
        FwwipBWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwMZn-0007Sc-TL; Fri, 17 Jul 2020 09:22:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 759913003D8;
        Fri, 17 Jul 2020 11:22:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6588829CF6F4C; Fri, 17 Jul 2020 11:22:43 +0200 (CEST)
Date:   Fri, 17 Jul 2020 11:22:43 +0200
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
Subject: Re: [PATCH RFC V2 14/17] dax: Stray write protection for
 dax_direct_access()
Message-ID: <20200717092243.GD10769@hirez.programming.kicks-ass.net>
References: <20200717072056.73134-1-ira.weiny@intel.com>
 <20200717072056.73134-15-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717072056.73134-15-ira.weiny@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 12:20:53AM -0700, ira.weiny@intel.com wrote:

> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -30,12 +30,14 @@ static DEFINE_SPINLOCK(dax_host_lock);
>  
>  int dax_read_lock(void)
>  {
> +	dev_access_enable();
>  	return srcu_read_lock(&dax_srcu);
>  }
>  EXPORT_SYMBOL_GPL(dax_read_lock);
>  
>  void dax_read_unlock(int id)
>  {
> +	dev_access_disable();
>  	srcu_read_unlock(&dax_srcu, id);
>  }
>  EXPORT_SYMBOL_GPL(dax_read_unlock);

This is inconsistently ordered.
