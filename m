Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840D44EBE43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 12:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245109AbiC3KE6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 06:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238742AbiC3KE5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:04:57 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67C1EBABA2;
        Wed, 30 Mar 2022 03:03:09 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123090685"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Mar 2022 18:03:08 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 70C084D16FF2;
        Wed, 30 Mar 2022 18:03:02 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 30 Mar 2022 18:03:02 +0800
Received: from [10.167.201.8] (10.167.201.8) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 30 Mar 2022 18:03:01 +0800
Message-ID: <15a635d6-2069-2af5-15f8-1c0513487a2f@fujitsu.com>
Date:   Wed, 30 Mar 2022 18:03:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v11 1/8] dax: Introduce holder for dax_device
To:     Christoph Hellwig <hch@infradead.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, david <david@fromorbit.com>,
        Jane Chu <jane.chu@oracle.com>
References: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
 <20220227120747.711169-2-ruansy.fnst@fujitsu.com>
 <CAPcyv4jAqV7dZdmGcKrG=f8sYmUXaL7YCQtME6GANywncwd+zg@mail.gmail.com>
 <4fd95f0b-106f-6933-7bc6-9f0890012b53@fujitsu.com>
 <YkPtptNljNcJc1g/@infradead.org>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <YkPtptNljNcJc1g/@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 70C084D16FF2.A0C25
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/3/30 13:41, Christoph Hellwig 写道:
> On Wed, Mar 16, 2022 at 09:46:07PM +0800, Shiyang Ruan wrote:
>>> Forgive me if this has been discussed before, but since dax_operations
>>> are in terms of pgoff and nr pages and memory_failure() is in terms of
>>> pfns what was the rationale for making the function signature byte
>>> based?
>>
>> Maybe I didn't describe it clearly...  The @offset and @len here are
>> byte-based.  And so is ->memory_failure().
> 
> Yes, but is there a good reason for that when the rest of the DAX code
> tends to work in page chunks?

Because I am not sure if the offset between each layer is page aligned. 
  For example, when pmem dirver handles ->memory_failure(), it should 
subtract its ->data_offset when it calls dax_holder_notify_failure().

The implementation of ->memory_failure() by pmem driver:
+static int pmem_pagemap_memory_failure(struct dev_pagemap *pgmap,
+		phys_addr_t addr, u64 len, int mf_flags)
+{
+	struct pmem_device *pmem =
+			container_of(pgmap, struct pmem_device, pgmap);
+	u64 offset = addr - pmem->phys_addr - pmem->data_offset;
+
+	return dax_holder_notify_failure(pmem->dax_dev, offset, len, mf_flags);
+}

So, I choose u64 as the type of @len.  And for consistency, the @addr is 
using byte-based type as well.

 > memory_failure()
 > |* fsdax case
 > |------------
 > |pgmap->ops->memory_failure()      => pmem_pgmap_memory_failure()
 > | dax_holder_notify_failure()      =>

the offset from 'pmem driver' to 'dax holder'

 > |  dax_device->holder_ops->notify_failure() =>
 > |                                     - xfs_dax_notify_failure()
 > |  |* xfs_dax_notify_failure()
 > |  |--------------------------
 > |  |   xfs_rmap_query_range()
 > |  |    xfs_dax_failure_fn()
 > |  |    * corrupted on metadata
 > |  |       try to recover data, call xfs_force_shutdown()
 > |  |    * corrupted on file data
 > |  |       try to recover data, call mf_dax_kill_procs()
 > |* normal case
 > |-------------
 > |mf_generic_kill_procs()


--
Thanks,
Ruan.


