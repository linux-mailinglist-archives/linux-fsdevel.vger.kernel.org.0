Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AA577DDA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 11:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242670AbjHPJqT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 05:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243526AbjHPJqG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:46:06 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593F426AB;
        Wed, 16 Aug 2023 02:46:00 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RQjtq04rDzBZ;
        Wed, 16 Aug 2023 11:45:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1692179157; bh=Sos1qBs3VlhhehklG3z9L5LLCdtvKR73wVoo/Xasofo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ol06/qIuowDl7DPikhSBJ06gBA3bo6LVSVl3/SSxjEXhTMUOzp2DmEgKigpja0DX5
         ExHnhjvldSYSXIBbUvvPOEQ+/AlcmfTCYFvFj9OFu7ljS4XL+f4W7PkRzkVLhstuqm
         DF7fVFuCZDEeUJRt92zYm4pwI6QfXmF8nv1kx9WDAAVJl17NMacCM5aWXRIh0025rH
         W88IZz96SfBc3464a8ghhNDsZfSSTwHM1c6HMp9RxLNMFVkKLLn9kGzOCIOeoPRxSz
         bTSC8c0ya+Q7EphOave/HMXcGQwbIK0b8+/oWWi8yyyySIQbRBl0idRigCqsoUmgYY
         ZX37j+Ik0gWbQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Wed, 16 Aug 2023 11:45:53 +0200
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
Subject: Re: [PATCH v30 2/6] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <ZNya0c7zRmQ/HPMl@qmqm.qmqm.pl>
References: <20230816065925.850879-1-usama.anjum@collabora.com>
 <20230816065925.850879-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230816065925.850879-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 16, 2023 at 11:59:21AM +0500, Muhammad Usama Anjum wrote:
> The PAGEMAP_SCAN IOCTL on the pagemap file can be used to get or optionally
> clear the info about page table entries.
[...]
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
[...]
> +static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
> +{
[...]
> +	for (walk_start = p.arg.start; walk_start < p.arg.end;
> +			walk_start = p.arg.walk_end) {
> +		long n_out;
> +
> +		if (fatal_signal_pending(current)) {
> +			ret = -EINTR;
> +			break;
> +		}
> +
> +		ret = mmap_read_lock_killable(mm);
> +		if (ret)
> +			break;
> +		ret = walk_page_range(mm, walk_start, p.arg.end,
> +				      &pagemap_scan_ops, &p);
> +		mmap_read_unlock(mm);
> +
> +		n_out = pagemap_scan_flush_buffer(&p);
> +		if (n_out < 0)
> +			ret = n_out;
> +		else
> +			n_ranges_out += n_out;
> +
> +		p.arg.walk_end = p.walk_end_addr ? p.walk_end_addr : p.arg.end;

I think p.walk_end_addr can be removed and replaced by `p.arg.walk_end`
directly in the walk functions. If we don't set walk_end_addr we'll also
return 0 so the check below will match. Might be good to add this as
a comment.

> +		if (ret != -ENOSPC)
> +			break;
> +
> +		if (p.arg.vec_len == 0 || p.found_pages == p.arg.max_pages)
> +			break;
> +	}
> +
> +	/* ENOSPC signifies early stop (buffer full) from the walk. */
> +	if (!ret || ret == -ENOSPC)
> +		ret = n_ranges_out;
> +
> +	p.arg.walk_end = p.arg.walk_end ? p.arg.walk_end : walk_start;

When the walk is finished, with ret == 0, the walk_start will point to
the beginning, not the end of the range. So:

if (!walk_end) walk_end = p.arg.end;

Other than that, the patch looks complete now. Thanks for all your work!

Best Regards
Micha³ Miros³aw
