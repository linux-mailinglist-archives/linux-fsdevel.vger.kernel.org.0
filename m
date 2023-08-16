Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0103977E025
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 13:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244529AbjHPLSB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 07:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244517AbjHPLRt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:17:49 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75D92128;
        Wed, 16 Aug 2023 04:17:47 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RQlwm16hDzBZ;
        Wed, 16 Aug 2023 13:17:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1692184666; bh=HPTBh1TZUwpwJ0n8YtW6jDQsKC75wBbqafxnMaIb2KI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bz3QqekByN94TsO/Ae1JtkBo7JvQmNeBGJdzyp82ZcYrXVAD3o1/wK2vqqtgsrOpS
         MpHBUyxJ131EOsBk73z4kk1WWnpi0laZyz2I1c1rKViRIIpupwObLsYN5ZmMc9Zm/n
         7zDKyHhOUHQUcFIWnX2YNZRtRRifZGYN3D2QPmXJFY9peFUFG36hiDc8DGYnXn5U7G
         WlRPRqrFTOkg6rQd+pkcoDRhfWawRe7duUTX45D78IxssuT4AnN88fiLnvUsezGlHu
         JZL8yfwboMeMhWGdXhgej4uz8l8Z4BZtmiM/NrAH7vjKdKPWmdJe13ykpj/jHRA0NF
         It04xWcjCCRrA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Wed, 16 Aug 2023 13:17:42 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
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
Subject: Re: [PATCH v31 2/6] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <ZNywVhVe1H8S60FR@qmqm.qmqm.pl>
References: <20230816103814.1522393-1-usama.anjum@collabora.com>
 <20230816103814.1522393-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230816103814.1522393-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 16, 2023 at 03:38:10PM +0500, Muhammad Usama Anjum wrote:
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
[...]
> +		/* The walk_end isn't set when ret is zero  */
> +		if (!p.arg.walk_end)
> +			p.arg.walk_end = p.arg.end;

This is now redundant with the `if` after the loop. [1]

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
> +	if (!p.arg.walk_end)
> +		p.arg.walk_end = p.arg.end;

[1] The one above.

Best Regards
Micha³ Miros³aw
