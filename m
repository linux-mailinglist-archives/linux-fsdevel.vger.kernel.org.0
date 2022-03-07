Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FF54D02DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 16:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243783AbiCGPaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 10:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbiCGPaX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:30:23 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E9C49930;
        Mon,  7 Mar 2022 07:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646666969; x=1678202969;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=+Ryh1cggbQNBN3ci8CirZd3kAvv6BbXwKIEkPSgvYgY=;
  b=JMxTF1fSCVM8W57maYuXQGwAw1E8Godzt4FHpwgklmGDsgDWWtvFpSwG
   adYr9f76bUJXWs8XNCtfWqohPB4glgULKg+h4ln0WkdSitUlUO/cygBOQ
   EBkDGhy6QpvZZR/y0Zs2IL3mqd0XIEqf8ZpIGx7S+LSE9+uTVHrb9OCnI
   ZezShSjTIukEEWy/cKk/wPsjP2jYlYcAaLdkw7sm7qxdbTcYJOYeCjkg6
   Qfd3r701DeheGHzAkTZgnhxRdBt2qX3pDkLlyvkzzkv2Ir+WMiU6BxWiF
   fhsi7p0SPe6edFVkx85MUM3kR+O70q1VZt6WNX+7xtZlaggcLi7MyAfXi
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="241850201"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="241850201"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 07:29:28 -0800
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="643281164"
Received: from mshipman-mobl5.amr.corp.intel.com (HELO [10.251.12.40]) ([10.251.12.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 07:29:28 -0800
Message-ID: <3c974f25-ece6-102b-01c3-bd7e6274f613@intel.com>
Date:   Mon, 7 Mar 2022 07:29:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        linux-sgx@vger.kernel.org, jaharkes@cs.cmu.edu,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        codalist@telemann.coda.cs.cmu.edu, linux-unionfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20220306032655.97863-1-jarkko@kernel.org>
 <20220306152456.2649b1c56da2a4ce4f487be4@linux-foundation.org>
 <c3083144-bfc1-3260-164c-e59b2d110df8@intel.com> <YiXsJRE8CWOvFNWH@iki.fi>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH RFC v2] mm: Add f_ops->populate()
In-Reply-To: <YiXsJRE8CWOvFNWH@iki.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/7/22 03:27, Jarkko Sakkinen wrote:
> But e.g. in __mm_populate() anything with (VM_IO | VM_PFNMAP) gets
> filtered out and never reach that function.
> 
> I don't know unorthodox that'd be but could we perhaps have a VM
> flag for SGX?

SGX only works on a subset of the chips from one vendor on one
architecture.  That doesn't seem worth burning a VM flag.
