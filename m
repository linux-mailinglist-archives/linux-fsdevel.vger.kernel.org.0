Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3341667B283
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 13:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbjAYMTU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 07:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbjAYMTI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:19:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8303F72BD;
        Wed, 25 Jan 2023 04:19:07 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.165.226])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 613ED6602E43;
        Wed, 25 Jan 2023 12:18:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674649145;
        bh=8pBnnWTRCzJetctu8Nbw6JJEIemO40Oj4vUcQtXcfGg=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=F7KhLA2McNOeHM6FUER+Uc9UkGtMLFCI26a93xGU8BG4e6doRmku8xHSzd5DA4Ljx
         arLliEsGKg6V/CdUqjU8gxw49K+M8pa+vvQpCZ7KRerOTYvZHCLBwQ38BYlNH13Yus
         7lzwaWY4LgfVpe8M0dpRTiWk+IyPQvLHduULFtbtPYCmM24EZVvmxrGLnvbJOZ/2am
         Z1P788FsylIi0qw+ncIPPhORHQg+uHsiu2XWPpAE1s3REKdL4A3Nb88vqQahtVGUfp
         KRUun+8gUwAf98n7c3I8EAC3NLMyx4NprwEW+wsGmnImeNqKhsdBSqRoV1t8TQVGCG
         vXHWXGurCPdlw==
Message-ID: <1310badc-5fcd-dc98-9b5c-85044c6c7083@collabora.com>
Date:   Wed, 25 Jan 2023 17:18:52 +0500
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
Subject: Re: [PATCH v7 1/4] userfaultfd: Add UFFD WP Async support
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
References: <20230109064519.3555250-1-usama.anjum@collabora.com>
 <20230109064519.3555250-2-usama.anjum@collabora.com> <Y8gkY8OlnOwvlkj4@x1n>
 <0bed5911-48b9-0cc2-dfcf-d3bc3b0e8388@collabora.com> <Y8lxW5YtD6MX61WD@x1n>
 <Y8qq0dKIJBshua+X@x1n> <328f54c1-171f-22a1-10c9-8b7a25bd8027@collabora.com>
 <Y9AUsCxgitOI2lUA@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y9AUsCxgitOI2lUA@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/24/23 10:26 PM, Peter Xu wrote:
> On Mon, Jan 23, 2023 at 03:11:20PM +0500, Muhammad Usama Anjum wrote:
>>> One thing worth mention is, I think for async wp it doesn't need to be
>>> restricted by UFFD_USER_MODE_ONLY, because comparing to the sync messages
>>> it has no risk of being utilized for malicious purposes.
>> I think with updated handling path updated in do_wp_page() and
>> wp_huge_pmd() in version, UFFD_USER_MODE_ONLY will not affect us.
> 
> This is more or less a comment for the design, the new code should work (by
> bypassing handle_userfaultfd(), where this bit was checked).
> 
> We'll need an man page update if this feature will be merged [1], and if so
> it'll need to be updated for the UFFD_USER_MODE_ONLY section regarding to
> async uffd-wp support too.  I think that can also be worked out after the
> series being accepted first, so just a heads up.
> 
> [1] https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
Thank you for explaining it. Definitely, we'll update the man pages after
the change has been merged. I've added it to my notes.>

-- 
BR,
Muhammad Usama Anjum
