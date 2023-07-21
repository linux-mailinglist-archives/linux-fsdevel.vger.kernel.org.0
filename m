Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE6175D0EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 19:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjGURwD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 13:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjGURwB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:52:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CBD3586;
        Fri, 21 Jul 2023 10:51:57 -0700 (PDT)
Received: from [192.168.10.12] (unknown [39.45.151.35])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 35C69660709D;
        Fri, 21 Jul 2023 18:51:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689961916;
        bh=DDoWRz+yUmRlcHh/cA8RW2LvkPV43c8fzdbwlgOqXBw=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=hb/3Tmml0TudHA0SnrngZDAV7m9FDd2UZ1ziQ1dY9CToxHBzlNqg1sf4BUQ2pMXe3
         DZYC7IWdLwAhwS8jS2QqqmmyhgNOem6p6MSZ+rBQH+ucZG4tqBWbP0rntrri4to3Y4
         3MjSAjGzGKNbf3to9oalMh9VH+wJ+2vOdQVN2zaFtMqb1IFUqxj6UyhkcK4Ze8y9JT
         XUjI1sncjMt8/sXvVbsw6uwEDh16us2s5s6T8+OAA3oi6AiSASvNnLsUG/4znoSrKM
         J5xb7TQjkFyrIw+3OnCIA6wZ2poYcI9wXDzOsCLmFqH15rMNYhKixhc8/MA5hDEtq5
         hZ9wnODa0VsRw==
Message-ID: <04e76ff6-3cc0-4ad3-a39b-1f39107e5f3f@collabora.com>
Date:   Fri, 21 Jul 2023 22:51:44 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
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
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
References: <20230713101415.108875-6-usama.anjum@collabora.com>
 <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
 <7eedf953-7cf6-c342-8fa8-b7626d69ab63@collabora.com>
 <ZLpsEGZkeQECO08M@qmqm.qmqm.pl>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZLpsEGZkeQECO08M@qmqm.qmqm.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/21/23 4:29 PM, Michał Mirosław wrote:
> On Fri, Jul 21, 2023 at 03:48:22PM +0500, Muhammad Usama Anjum wrote:
>> On 7/21/23 12:28 AM, Michał Mirosław wrote:
>>> This is a massaged version of patch by Muhammad Usama Anjum [1]
>>> to illustrate my review comments and hopefully push the implementation
>>> efforts closer to conclusion. The changes are:
>> Thank you so much for this effort. I also want to reach conclusion. I'll
>> agree with all the changes which don't affect me. But some requirements
>> aren't being fulfilled with this current design.
> [...]
>> #define PAGE_IS_WPASYNC		(1 << 0)
>> #define PAGE_IS_WRITTEN		(1 << 1)
>> You have another new flag PAGE_IS_WPASYNC. But there is no application of
>> PAGE_IS_WPASYNC. We must not add a flag which don't have any user.
> 
> BTW, I'm not sure I got the PAGE_IS_WPASYNC naming right - this is to
> designate pages that can be write-protected (are UFFD-registered I believe).
PAGE_IS_UFFDWP_REGISTERED or PAGE_IS_WP_REG?

> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
