Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84754705912
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 22:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjEPUqd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 16:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEPUqb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 16:46:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87E5196;
        Tue, 16 May 2023 13:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684269991; x=1715805991;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ty6WENYnRqV4osNeJaXPDMsSfcnlueg4+2VirsKRiyc=;
  b=axif19YAEn890t2nA04e1FB3gE3PkVEwiQPsmDcTB0D9o+vYrSiuaD8E
   tB521vbEsWr40eB6RBS9uot8aqQStFnycgXldtgbdpSLL3/MHOi6nHy1Y
   UHkcqP6tWqRV9xnwPf17ErOAgZBkzcrpxZ0lLpYFRLJJAowL48GnkskgA
   tywjeRN/FgIViYR5tmYgaASRbUO8NO+IaUHfkNRYqBJFo5WXDQskthdHL
   +0NatLp0RLtyZ9+7zG2L7PHRCmOd488sO1IViIrfnz2eJ7+Csyr6PUxWM
   YIX1BU6+E+n1i6xKoZLOsYD+yLGZRYNi3Q/Lockbe89z5+y+8unoeWJUr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="336136887"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="336136887"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 13:46:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="734434783"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="734434783"
Received: from mtpanu-mobl1.amr.corp.intel.com (HELO [10.212.203.6]) ([10.212.203.6])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 13:46:23 -0700
Message-ID: <5c7e7ebc-7898-0b4e-3c59-e9b8d2b2f197@intel.com>
Date:   Tue, 16 May 2023 13:46:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] procfs: consolidate arch_report_meminfo declaration
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, viro@zeniv.linux.org.uk,
        brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
References: <20230516195834.551901-1-arnd@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230516195834.551901-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/16/23 12:57, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The arch_report_meminfo() function is provided by four architectures,
> with a __weak fallback in procfs itself. On architectures that don't
> have a custom version, the __weak version causes a warning because
> of the missing prototype.
> 
> Remove the architecture specific prototypes and instead add one
> in linux/proc_fs.h.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/parisc/include/asm/pgtable.h    | 3 ---
>  arch/powerpc/include/asm/pgtable.h   | 3 ---
>  arch/s390/include/asm/pgtable.h      | 3 ---
>  arch/s390/mm/pageattr.c              | 1 +
>  arch/x86/include/asm/pgtable.h       | 1 +
>  arch/x86/include/asm/pgtable_types.h | 3 ---

Looks sane.  Thanks Arnd!

Acked-by: Dave Hansen <dave.hansen@linux.intel.com> # for arch/x86
