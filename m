Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DED781644
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Aug 2023 03:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243230AbjHSBE1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 21:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243181AbjHSBEX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 21:04:23 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA98110F1;
        Fri, 18 Aug 2023 18:04:21 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RSL9Z0rDnz9Y;
        Sat, 19 Aug 2023 03:04:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1692407060; bh=sFq9Q+VaStp1O+YV7cwSTZ53EOPS3jtEcfot7OFqKYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gz9HN/5ke2KWkSBGXpxjmiGIQ6pVqMNlBIiUp9oEzLyclbNE27pcaLnZmjGt8fyDG
         yuRmR4LoesM+ikFVO1lthn22e79wgUIVudmi7uvOWixPYQO+hkS+1AG67vfktG8r/E
         09xvswvHSS03kZpP08hV29fFX8PYJrsMsOCpyaBMEQpDg2TI9qh/kT4JtD8XlSy+ul
         amQ6PdgWHi2pYEYYEqD8fbAyEwWFqLM2UUGENRBDQkCiZ6rcVJOtQKOqwtrcAi275N
         YocSGFnW+CJgcpaXU4w0TdjesZQFKuyBPLkcE1GsIm8ZGl9wi8r5TcPShBF2vXeUpr
         t+8Ght2q9MPlg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Sat, 19 Aug 2023 03:04:16 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v32 2/6] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <ZOAVEFniF/dm+mre@qmqm.qmqm.pl>
References: <20230816113049.1697849-1-usama.anjum@collabora.com>
 <20230816113049.1697849-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230816113049.1697849-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 16, 2023 at 04:30:45PM +0500, Muhammad Usama Anjum wrote:
> The PAGEMAP_SCAN IOCTL on the pagemap file can be used to get or optionally
> clear the info about page table entries.
[...]
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
[...]
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static unsigned long pagemap_thp_category(pmd_t pmd)
> +{
> +	unsigned long categories = PAGE_IS_HUGE;
> +
> +	/*
> +	 * THPs don't support file-backed memory. So PAGE_IS_FILE
> +	 * is not checked here.
> +	 */

It seems that we can have THP for files: ref. recent LKML thread [1].

[1] https://lkml.org/lkml/2023/8/16/1212

> +	if (pmd_present(pmd)) {
> +		categories |= PAGE_IS_PRESENT;
> +		if (!pmd_uffd_wp(pmd))
> +			categories |= PAGE_IS_WRITTEN;
> +		if (is_zero_pfn(pmd_pfn(pmd)))
> +			categories |= PAGE_IS_PFNZERO;
> +	} else if (is_swap_pmd(pmd)) {
> +		categories |= PAGE_IS_SWAPPED;
> +		if (!pmd_swp_uffd_wp(pmd))
> +			categories |= PAGE_IS_WRITTEN;
> +	}
> +
> +	return categories;
> +}

Best Regards
Micha³ Miros³aw
