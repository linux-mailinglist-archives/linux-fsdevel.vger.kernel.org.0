Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06FA738696
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 16:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjFUOQa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 10:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjFUOQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:16:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646A6199C;
        Wed, 21 Jun 2023 07:16:19 -0700 (PDT)
Received: from [192.168.10.54] (unknown [182.179.162.32])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2D60A6606F95;
        Wed, 21 Jun 2023 15:16:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687356977;
        bh=ZfrnBJpRDergXzvQfqh1+l1r+/MY/drS+UbPB4AW/uk=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=i57nuMmb+8vcTd9/9oF/rAl+e8nxceBaB7h55tYAuxyov6Kermz+DV/q/aSfpXnfw
         fa8Wh1/O/jcyxUTiVaIDZsTJagLKkHdu3rAIkPCyLGIS7c/AUAAQ5cWjs6+wJ4YjFZ
         28FYWQGCWE1W4Rg6Hv+ambt+3tBj+XtWDqtgLG3uUE6iz74JTwH00h6JkBcmciWkxY
         1Rn4/ywv2h8ZMp4jhiilafjzHifzX+1iH3jW6WJm1DrfWIhhrqCyShcEIO3MfVWZ5Q
         9Zxrt/Eheo7J3RVDJ9qCHBx6ebvjMNUq99xe6OyN5lGj2rWehMZ7VgF27366Y1QTbg
         lfsg9sPmQ4uYw==
Message-ID: <de16602a-7ed9-9c03-30d9-5edccc48d2f0@collabora.com>
Date:   Wed, 21 Jun 2023 19:16:07 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
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
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v20 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <20230621072404.2918101-1-usama.anjum@collabora.com>
 <20230621072404.2918101-3-usama.anjum@collabora.com>
 <CABb0KFGhSLAHAsa3nk-pyMe2j9MU4u3xkQR21HOoS65ZB2dKsw@mail.gmail.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFGhSLAHAsa3nk-pyMe2j9MU4u3xkQR21HOoS65ZB2dKsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/21/23 6:42 PM, Michał Mirosław wrote:
> On Wed, 21 Jun 2023 at 09:24, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
> [...]
>> +static int pagemap_scan_test_walk(unsigned long start, unsigned long end,
>> +                                 struct mm_walk *walk)
>> +{
>> +       struct pagemap_scan_private *p = walk->private;
>> +       struct vm_area_struct *vma = walk->vma;
>> +
>> +       if ((p->flags & PM_SCAN_REQUIRE_UFFD) && (!userfaultfd_wp_async(vma) ||
>> +           !userfaultfd_wp_use_markers(vma)))
>> +               return -EPERM;
>> +
>> +       if (vma->vm_flags & VM_PFNMAP)
>> +               return 1;
>> +
>> +       return 0;
>> +}
> 
> This could actually short-circuit all vma flags (e.g. IS_FILE): if
> (required_mask & IS_FILE && vma is not file-backed) return 0;
Sorry, unable to understand you. Should we do something here?

> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
