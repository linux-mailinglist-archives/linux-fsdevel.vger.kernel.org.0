Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5347A4FC38F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 19:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243215AbiDKRkP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 13:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiDKRkP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 13:40:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAA521834;
        Mon, 11 Apr 2022 10:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bMrJHV/z+bX/cuAH7pcyQOkcKK7bzLU7VyTOOCpZyb4=; b=erkRbNGLY+gX7G3uPm3SG0mTx3
        Jdx7PliLE1m6zK4NNVitRkQJ6unZgko9E1n00r2oC94gRsCHlLsiGCswwo30LyKn8N3eyiV0eHzGK
        KVQo5nx4BpZwhqUwnIow2CDwbB9TMMWDq5CJBWafSeNZYkXctNhJmdLRMiPKfS0wr8sH/Y3MkvOCu
        I6C7teJwx6u095ud9PIjrshxJo1aZWTwEIXb+0lfYBvYJZsVtn4juZ7I/t1Dy8HbVWfv5MuWCO5fF
        Uu/6C3J3litqwbHDD4o+p6RHN5Igw3cMd9w3oAoQfGeia3NmBkehIjhXciZ3tFpmt7WX/oWeThaxq
        N/Ln3s2A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndxyI-00CX12-Kx; Mon, 11 Apr 2022 17:37:02 +0000
Date:   Mon, 11 Apr 2022 18:37:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        arnd@arndb.de, 21cnbao@gmail.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
Subject: Re: [PATCH v1 00/14] Add support for shared PTEs across processes
Message-ID: <YlRnPstOywJzxUib@casper.infradead.org>
References: <cover.1649370874.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1649370874.git.khalid.aziz@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 11, 2022 at 10:05:44AM -0600, Khalid Aziz wrote:
> Page tables in kernel consume some of the memory and as long as number
> of mappings being maintained is small enough, this space consumed by
> page tables is not objectionable. When very few memory pages are
> shared between processes, the number of page table entries (PTEs) to
> maintain is mostly constrained by the number of pages of memory on the
> system. As the number of shared pages and the number of times pages
> are shared goes up, amount of memory consumed by page tables starts to
> become significant.

All of this is true.  However, I've found a lot of people don't see this
as compelling.  I've had more success explaining this from a different
direction:

--- 8< ---

Linux supports processes which share all of their address space (threads)
and processes that share none of their address space (tasks).  We propose
a useful intermediate model where two or more cooperating processes
can choose to share portions of their address space with each other.
The shared portion is referred to by a file descriptor which processes
can choose to attach to their own address space.

Modifications to the shared region affect all processes sharing
that region, just as changes by one thread affect all threads in a
multithreaded program.  This implies a certain level of trust between
the different processes (ie malicious processes should not be allowed
access to the mshared region).

--- 8< ---

Another argument that MM developers find compelling is that we can reduce
some of the complexity in hugetlbfs where it has the ability to share
page tables between processes.

One objection that was raised is that the mechanism for starting the
shared region is a bit clunky.  Did you investigate the proposed approach
of creating an empty address space, attaching to it and using an fd-based
mmap to modify its contents?

> int mshare_unlink(char *name)
> 
> A shared address range created by mshare() can be destroyed using
> mshare_unlink() which removes the  shared named object. Once all
> processes have unmapped the shared object, the shared address range
> references are de-allocated and destroyed.
> 
> mshare_unlink() returns 0 on success or -1 on error.

Can you explain why this is a syscall instead of being a library
function which does

	int dirfd = open("/sys/fs/mshare");
	err = unlinkat(dirfd, name, 0);
	close(dirfd);
	return err;

Does msharefs support creating directories, so that we can use file
permissions to limit who can see the sharable files?  Or is it strictly
a single-level-deep hierarchy?

