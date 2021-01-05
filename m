Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6FF2EA45C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 05:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbhAEESh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 23:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbhAEESh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 23:18:37 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538B1C061574;
        Mon,  4 Jan 2021 20:17:57 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwdms-006y0f-FZ; Tue, 05 Jan 2021 04:17:38 +0000
Date:   Tue, 5 Jan 2021 04:17:38 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vineet Gupta <vgupts@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH v2] fs/dax: include <asm/page.h> to fix build error on ARC
Message-ID: <20210105041738.GS3579531@ZenIV.linux.org.uk>
References: <20210101042914.5313-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210101042914.5313-1-rdunlap@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 31, 2020 at 08:29:14PM -0800, Randy Dunlap wrote:
> fs/dax.c uses copy_user_page() but ARC does not provide that interface,
> resulting in a build error.
> 
> Provide copy_user_page() in <asm/page.h> (beside copy_page()) and
> add <asm/page.h> to fs/dax.c to fix the build error.
> 
> ../fs/dax.c: In function 'copy_cow_page_dax':
> ../fs/dax.c:702:2: error: implicit declaration of function 'copy_user_page'; did you mean 'copy_to_user_page'? [-Werror=implicit-function-declaration]

Could somebody explain what the force-cast is doing in there?
I mean, the call is
        copy_user_page(vto, (void __force *)kaddr, vaddr, to);
kaddr is a local variable there, declared as void *; AFAICS, that
had been pure cargo-cult since
commit 7a9eb20666317794d0279843fbd091af93907780
Author: Dan Williams <dan.j.williams@intel.com>
Date:   Fri Jun 3 18:06:47 2016 -0700

    pmem: kill __pmem address space

I mean, it's been more than 4 years, time to bury that body...
