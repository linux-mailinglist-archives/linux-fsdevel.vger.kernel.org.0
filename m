Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4127A9E7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 22:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjIUUCh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 16:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjIUUCO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:02:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46A1A72B9;
        Thu, 21 Sep 2023 10:22:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23993176B;
        Thu, 21 Sep 2023 09:29:10 -0700 (PDT)
Received: from [10.1.34.154] (XHFQ2J9959.cambridge.arm.com [10.1.34.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FD333F59C;
        Thu, 21 Sep 2023 09:28:29 -0700 (PDT)
Message-ID: <637361bb-dd56-4085-a427-86fd76480de5@arm.com>
Date:   Thu, 21 Sep 2023 17:28:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] selftests/mm: add uffd unit test for UFFDIO_POISON
Content-Language: en-GB
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Yu Zhao <yuzhao@google.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230707215540.2324998-1-axelrasmussen@google.com>
 <20230707215540.2324998-9-axelrasmussen@google.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230707215540.2324998-9-axelrasmussen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/07/2023 22:55, Axel Rasmussen wrote:
> The test is pretty basic, and exercises UFFDIO_POISON straightforwardly.
> We register a region with userfaultfd, in missing fault mode. For each
> fault, we either UFFDIO_COPY a zeroed page (odd pages) or UFFDIO_POISON
> (even pages). We do this mix to test "something like a real use case",
> where guest memory would be some mix of poisoned and non-poisoned pages.
> 
> We read each page in the region, and assert that the odd pages are
> zeroed as expected, and the even pages yield a SIGBUS as expected.
> 
> Why UFFDIO_COPY instead of UFFDIO_ZEROPAGE? Because hugetlb doesn't
> support UFFDIO_ZEROPAGE, and we don't want to have special case code.
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Hi,

FYI, when running this test on arm64 it provokes a kernel panic. I've posted a
fix along with a detailed explanation at [1].

[1]
https://lore.kernel.org/linux-arm-kernel/20230921162007.1630149-1-ryan.roberts@arm.com/

Thanks,
Ryan

