Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5DA75B84A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 21:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjGTTuf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 15:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjGTTuf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:50:35 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B0A1733;
        Thu, 20 Jul 2023 12:50:33 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4R6NZt1JgmzB1;
        Thu, 20 Jul 2023 21:50:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1689882631; bh=a9pL0kNuMRIgcmjOND4LJd48iF3+VEg/CEzl3bltNR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hRKxNIdHwobRsOgpUwGtj+PdQV6SIpFKL7mg/O157lrA1OdMbATu7NMdtJdaMFxHH
         wYb2lzjgjAc1zwBOkuf1Y0YCoCa/3zkjF+oLjeIyGbnIekVSjv2pTGB3Lbs4TtUmD3
         CDrONvId5YYm2VrtVW/O9+xteB94GdrKp1I5VNl9qFJERmhGiMmmkQrYEKIScjkFBO
         33PVI8P5Y4bfRGiOr5nvIcC8qulynBJ4tKxHKswiPiNutMC3cmuOiM8/NTOdRebSR7
         61Q6DeowDNmdlT15unjNT2E1xXOyW4lVB0A5PDXjykFs2NSoxKU5chGOowKNABgOOM
         DOhpTS7bkz/jw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Thu, 20 Jul 2023 21:50:28 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Alex Sierra <alex.sierra@amd.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        David Hildenbrand <david@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <emmir@google.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        kernel@collabora.com
Subject: Re: fs/proc/task_mmu: Implement IOCTL for efficient page table
 scanning
Message-ID: <ZLmQBMympuVU2zLn@qmqm.qmqm.pl>
References: <20230713101415.108875-6-usama.anjum@collabora.com>
 <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 20, 2023 at 09:28:52PM +0200, Micha³ Miros³aw wrote:
> This is a massaged version of patch by Muhammad Usama Anjum [1]
> to illustrate my review comments and hopefully push the implementation
> efforts closer to conclusion. The changes are:
[...]
> +static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
> +				       unsigned long addr, unsigned long end)
> +{
> +	struct page_region *cur_buf = &p->cur_buf;
> +
> +	if (cur_buf->start != addr) {
> +		cur_buf->end = addr;
> +	} else {
> +		cur_buf->start = cur_buf->end = 0;
> +	}
> +
> +	p->end_addr = 0;

Just noticed that this is missing:

	p->found_pages -= (end - addr) / PAGE_SIZE;

> +}
[...]

Best Regards
Micha³ Miros³aw
