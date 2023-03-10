Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE736B512C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 20:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjCJTx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 14:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjCJTx5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:53:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C3F10FB9E;
        Fri, 10 Mar 2023 11:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=Ss+hdlsE3tPgccu1HnUCYdR+3LmCLybQ7871SrfrPpU=; b=0ntTevDI5MKI7rCGq03+F0Xh2f
        rwpX68L12144Jx2FT77vR0dUqtR3ZG4e7aYqEjJLB45iYWxjQO++W/ChDmofmzTe9ghqkVH6Fxx8T
        RcLeMaphm4W71tV+eq7czrT1SiWJ32fqc5QTXVBXgc1yFf2X0hgsjTe0vyI4mID+owLue9ZGvrGAu
        0MFLLuWtqMDeqZwORN6wnu2mtQQW+XwKB2j9bgQ/raiRq8p64RvLocZ2mw/p3np71VhecrQvslNGp
        g0fuIUoNsXlUN/ParteV9vUJWhFHSDrZfv0i+gPZzMo9HuVPSe8bQuQA/owJMwNLuEGjt89ujEwgx
        1LBFYAVQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paioC-00FwaX-QL; Fri, 10 Mar 2023 19:53:44 +0000
Date:   Fri, 10 Mar 2023 11:53:44 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: [PATCH] mm: hugetlb: move hugeltb sysctls to its own file
Message-ID: <ZAuKyAnfkOnK7NWK@bombadil.infradead.org>
References: <20230309122011.61969-1-wangkefeng.wang@huawei.com>
 <a9375f3c-bd8b-8d32-2fd2-32047005f9b5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9375f3c-bd8b-8d32-2fd2-32047005f9b5@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 10, 2023 at 10:23:34PM +0800, Kefeng Wang wrote:
> 
> 
> On 2023/3/9 20:20, Kefeng Wang wrote:
> > This moves all hugetlb sysctls to its own file, also kill an
> > useless hugetlb_treat_movable_handler() defination.
> > 
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > ---
> >   include/linux/hugetlb.h |  8 -------
> >   kernel/sysctl.c         | 32 --------------------------
> >   mm/hugetlb.c            | 51 ++++++++++++++++++++++++++++++++++++++---
> >   3 files changed, 48 insertions(+), 43 deletions(-)
> > 
> 
> > +#ifdef CONFIG_SYSCTL
> > +static void hugetlb_sysctl_init(void);
> 
> Hi Luis，this should add __init as it is called by hugetlb_init,
> could you help to change it, or I could send a new patch.
> 
> 
> > +#else
> > +static inline void hugetlb_sysctl_init(void) { }
> > +#endif
> > +
> >   static int __init hugetlb_init(void)
> >   {
> >   	int i;
> > @@ -4257,6 +4263,7 @@ static int __init hugetlb_init(void)
> >   	hugetlb_sysfs_init();
> >   	hugetlb_cgroup_file_init();
> > +	hugetlb_sysctl_init();
> ...
> > +
> > +static void hugetlb_sysctl_init(void)
> 
> ditto, sorry for the mistake.

Just send a fix.

  Luis
