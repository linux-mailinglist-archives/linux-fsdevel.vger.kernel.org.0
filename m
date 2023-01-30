Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A23680837
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 10:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbjA3JK0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 04:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbjA3JKY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:10:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763929F;
        Mon, 30 Jan 2023 01:10:23 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.165.226])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 35DF06602E2A;
        Mon, 30 Jan 2023 09:10:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675069821;
        bh=/l1ZA909PK+xOECy6RWevd3pYBOOmWKWLYoZHDERZd8=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=VXjvZz+hCCgMh9CNLBkp08d1EtF4OT//jWEFDvgnJuR54ryFfcB82MGaOOymQGIhq
         k+VqrLhTOWhFgL9CRaE1GjOI4aXCfgyfQV00hwCQZgMu4qPbr5/CWcksAA8KRYgW0D
         sD3jhX82/6V5IWZInIh23Ux3H5NY3DX8zJKYkfvMx8W4BbOdGg0VecV4A9xy3yGABr
         K+QEJnPQMT4HN70Ue9QBllXQHdTyBSnzCdzBqh2KmM0/PxCh2Xr7lba5rvwKW2LMTk
         p8g3hpdTWa4ZGQSVJIa4Ckj3RVgKIo2uuL/Bl9euykx3U94MW0kUUSXAsXUfrtsgKd
         ntxb0+Jp+Kzgg==
Message-ID: <c3cc49b6-1ad3-f5aa-50bb-a12f3bbb377a@collabora.com>
Date:   Mon, 30 Jan 2023 14:10:11 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
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
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v8 2/4] userfaultfd: split mwriteprotect_range()
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
References: <20230124084323.1363825-1-usama.anjum@collabora.com>
 <20230124084323.1363825-3-usama.anjum@collabora.com> <Y9QEdbkZxOJ10oEJ@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y9QEdbkZxOJ10oEJ@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/27/23 10:05 PM, Peter Xu wrote:
> On Tue, Jan 24, 2023 at 01:43:21PM +0500, Muhammad Usama Anjum wrote:
>> Split mwriteprotect_range() to create a unlocked version. This
>> will be used in the next patch to write protect a memory area.
>> Add a helper function, wp_range_async() as well.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 
> IIUC this patch is not needed.  You have a stable vma, so I think you can
> directly use uffd_wp_range(), while most of the mwriteprotect_range() is
> not needed.
> 
> There's one trivial detail of ignoring userfaultfd_ctx->mmap_changing when
> it's set to true, but I don't think it applies here either because it was
> used to resolve a problem in uffd non-cooperative mode on the predictable
> behavior of events, here I don't think it matters a lot either.
> 
Thanks, I'll drop this patch and do direct wiring to uffd_wp_range().

-- 
BR,
Muhammad Usama Anjum
