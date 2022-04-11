Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FDF4FC4C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 21:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349458AbiDKTLC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 15:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349412AbiDKTLB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:11:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5248736152;
        Mon, 11 Apr 2022 12:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e1fwTBXjpGLJFVbGSqSy8bq2chVaIHZsuFHQZUO8y+E=; b=mmM2y6S6rZIMBTjXkY4V46NlM0
        H5kyclJL/93EdWx7Zwa9CDDPoqGca8SYxp0BdNUZ4v8CCNUA9UAvFXNgS6FE22UO+nXuxfcCyzxa6
        UJeLsjlNW2tgw6U745WHagYGxBFWwKenSW7WYS1DaID+825/M+lQ5Tg/XpTwDYyJRDujcDqcUGbRP
        P3R3ZotqUwp3eoZPX1KgB8vRrCkHohmK3+VMa8ZmG44pp7W9l+I6Rfu6W0YI1DVW7b7HZL2dJ1vf1
        wyCT2pu99/McoU6vEd7DL7rA14VRz4niYl+IQat9J7XlEDRAYdLD8S3ID5AuSHaZDPKozB6PG2Nba
        AMH9lpEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndzOK-00Cart-EG; Mon, 11 Apr 2022 19:08:00 +0000
Date:   Mon, 11 Apr 2022 20:08:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
Subject: Re: [PATCH v1 00/14] Add support for shared PTEs across processes
Message-ID: <YlR8kDs3I1jx6Oxs@casper.infradead.org>
References: <cover.1649370874.git.khalid.aziz@oracle.com>
 <YlRnPstOywJzxUib@casper.infradead.org>
 <dbd8a627-ce8d-8265-289d-30e0399a66e2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbd8a627-ce8d-8265-289d-30e0399a66e2@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 11, 2022 at 11:51:46AM -0700, Dave Hansen wrote:
> On 4/11/22 10:37, Matthew Wilcox wrote:
> > Another argument that MM developers find compelling is that we can reduce
> > some of the complexity in hugetlbfs where it has the ability to share
> > page tables between processes.
> 
> When could this complexity reduction actually happen in practice?  Can
> this mshare thingy be somehow dropped in underneath the existing
> hugetlbfs implementation?  Or would userspace need to change?

Userspace needs to opt in to mshare, so there's going to be a transition
period where we still need hugetlbfs to still support it, but I have
the impression that the users that need page table sharing are pretty
specialised and we'll be able to find them all before disabling it.

I don't think we can make it transparent to userspace, but I'll noodle
on that a bit.
