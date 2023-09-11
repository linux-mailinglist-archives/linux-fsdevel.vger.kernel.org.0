Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8D779C017
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjIKUw4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239970AbjIKOcw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:32:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346F7CF0;
        Mon, 11 Sep 2023 07:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694442768; x=1725978768;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GBvaxapfraK64H6oc4OtRUMWrhE97kyIgzhCWgEuG4k=;
  b=RgS6YBbsEeF6GNpDm2PyTwljgQNqnzwsZiU2SoQX07jlfB7zATrMUh+e
   AaIhd2tqwZ8ZRUdVJ4bD6uq0d6uhsAZNm2LDDCFUn38AjsoKSCIrI0E8N
   LQNaciK9omXUm+ZNHgX4IXOKmjRdO41kA3OMEEVNWd0iQMLEePK4tyPov
   0APX1YwEI+y47U1JBKLmLxM9/7ZIk2YhWE2qfESbUdcgQHy2wTG7bPf1t
   jsJdYdy4p9odRM/r7joCAM68761hJ9jlW8banBiwD/e8yHBktZgDlfr1W
   BBXdmx6glZdg1dWD6ButI6gCcHCSajlETsvCzgblzIXH/15u0++DWD8dR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378012085"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="378012085"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 07:32:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="720000764"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="720000764"
Received: from cdaubert-mobl13.amr.corp.intel.com (HELO [10.212.203.41]) ([10.212.203.41])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 07:32:46 -0700
Message-ID: <40a363b1-80be-89ce-6527-ac2a4c04917f@intel.com>
Date:   Mon, 11 Sep 2023 07:32:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/3] /dev/mem: Do not map unaccepted memory
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org
References: <20230906073902.4229-1-adrian.hunter@intel.com>
 <20230906073902.4229-4-adrian.hunter@intel.com>
 <9ffb7a3b-cf20-617a-e4f1-8a6a8a2c5972@intel.com>
 <20230907142510.vcj57cvnewqt4m37@box.shutemov.name>
 <7a50d04f-63ee-a901-6f39-7d341e423a77@intel.com>
 <c60df0e4-4214-bbd0-7fc6-8f04e5888f53@redhat.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <c60df0e4-4214-bbd0-7fc6-8f04e5888f53@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/11/23 01:09, David Hildenbrand wrote:
> So, making unaccepted memory similarly depend on "!DEVMEM ||
> STRICT_DEVMEM" does not sound too far off ...

Yeah, considering all of the invasive work folks want to do to "harden"
the kernel for TDX, doing that ^ is just about the best
bang-for-your-buck "hardening" that you can get.
