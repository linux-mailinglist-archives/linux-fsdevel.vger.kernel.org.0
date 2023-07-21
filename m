Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0149175BD3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 06:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjGUE14 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 00:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjGUE1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 00:27:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC9F268E;
        Thu, 20 Jul 2023 21:27:52 -0700 (PDT)
Received: from [192.168.10.12] (unknown [39.45.151.35])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D8E616607027;
        Fri, 21 Jul 2023 05:27:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689913670;
        bh=iKsddZcHQfqrHPuhFqHvQKPW73Sg5qlkV+VjcVMfyNQ=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=S+vXr5QcpujtN7Eomq6xVbBtFRYy/Qn36tOKBjeamqj8kw0oHDbD8Pi64s1HgYKIx
         5Ql7AOb99tROiFpRW/3Z1wBjIS37oRBRL7/upNkeCkWPQ9SgV+yquhVp+SFZn00pTv
         Mp1rNsm9RGGWFfwdzpO6+K9uM7DdIJXMxLc0SmiPqBIHQj54g16rm+My/s9TtqAb/E
         4s6W1dV+LtuOFtQcQvtyNqsVFbwZSufIpXpRU4+bJCRzijEawwNkykwxHRI5c+fsBn
         n80+maVPwJVkr9wnKWo3cJhKrtNMackCmcOtxfl4yX3+o+yFirqolzMY6XpnnFYlmD
         VCeoAc+i3vgCg==
Message-ID: <e430ea5c-fbf2-9e23-626d-2e6ea63eba18@collabora.com>
Date:   Fri, 21 Jul 2023 09:27:34 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
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
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
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
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>
References: <20230713101415.108875-6-usama.anjum@collabora.com>
 <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <a0b5c6776b2ed91f78a7575649f8b100e58bd3a9.1689881078.git.mirq-linux@rere.qmqm.pl>
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

Thank you Michał.

On 7/21/23 12:28 AM, Michał Mirosław wrote:
>   b. rename match "flags" to 'page categories' everywhere - this makes
> 	it easier to differentiate the ioctl()s categorisation of pages
> 	from struct page flags;
>   c. change {required + excluded} to {inverted + required}. This was
> 	rejected before, but I'd like to illustrate the difference.
> 	Old interface can be translated to the new by:
> 		categories_inverted = excluded_mask
> 		categories_mask = required_mask | excluded_mask
> 		categories_anyof_mask = anyof_mask
> 	The new way allows filtering by: A & (B | !C)
> 		categories_inverted = C
> 		categories_mask = A
> 		categories_anyof_mask = B | C
Andrei and Danylo,

Are you okay with these masks? It were you two who had proposed these.


-- 
BR,
Muhammad Usama Anjum
