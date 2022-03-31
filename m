Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89084EE426
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 00:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242516AbiCaWiJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 18:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242593AbiCaWh4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:37:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830721C8A8E;
        Thu, 31 Mar 2022 15:36:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29E60B82207;
        Thu, 31 Mar 2022 22:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15766C340ED;
        Thu, 31 Mar 2022 22:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1648766165;
        bh=iBYgZff6GuQ3ATSOp8xBpl/j0xeUF6jSNcZ6KDmqKns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fIcl/wh5iws0jPhPCBMRJJMDBTMQ6kamI6va5kHNSpYGEveErRZYY88FsKlQwQQSy
         /XVVsarP8EhcgIW/EI30Qt355LTOJetDTJKU0SItWIpx151hUzBVYdp7oTBrFd3yXV
         hXezsuSCl08mKiCRiGJjrF45vT/ATvVYQ+wHr+6w=
Date:   Thu, 31 Mar 2022 15:36:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <apopple@nvidia.com>, <shy828301@gmail.com>,
        <rcampbell@nvidia.com>, <hughd@google.com>,
        <xiyuyang19@fudan.edu.cn>, <kirill.shutemov@linux.intel.com>,
        <zwisler@kernel.org>, <hch@infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <duanxiongchun@bytedance.com>, <smuchun@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v5 0/6] Fix some bugs related to ramp and dax
Message-Id: <20220331153604.da723f3546fa8adabd7a74ae@linux-foundation.org>
In-Reply-To: <YkXPA69iLBDHFtjn@qian>
References: <20220318074529.5261-1-songmuchun@bytedance.com>
        <YkXPA69iLBDHFtjn@qian>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 31 Mar 2022 11:55:47 -0400 Qian Cai <quic_qiancai@quicinc.com> wrote:

> On Fri, Mar 18, 2022 at 03:45:23PM +0800, Muchun Song wrote:
> > This series is based on next-20220225.
> > 
> > Patch 1-2 fix a cache flush bug, because subsequent patches depend on
> > those on those changes, there are placed in this series.  Patch 3-4
> > are preparation for fixing a dax bug in patch 5.  Patch 6 is code cleanup
> > since the previous patch remove the usage of follow_invalidate_pte().
> 
> Reverting this series fixed boot crashes.
> 

Thanks.  I'll drop

mm-rmap-fix-cache-flush-on-thp-pages.patch
dax-fix-cache-flush-on-pmd-mapped-pages.patch
mm-rmap-introduce-pfn_mkclean_range-to-cleans-ptes.patch
mm-rmap-introduce-pfn_mkclean_range-to-cleans-ptes-fix.patch
mm-pvmw-add-support-for-walking-devmap-pages.patch
dax-fix-missing-writeprotect-the-pte-entry.patch
dax-fix-missing-writeprotect-the-pte-entry-v6.patch
mm-simplify-follow_invalidate_pte.patch

