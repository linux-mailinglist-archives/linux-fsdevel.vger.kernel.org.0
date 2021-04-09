Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDD2359445
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 07:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhDIFFA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 01:05:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhDIFFA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:05:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 325B061165;
        Fri,  9 Apr 2021 05:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617944688;
        bh=iBZJg2qunvF7v3TtboIlcuUe7mCGQTTjlXG5RowbNuM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=adLu+IYoQ7vk7/cFv+oy0OjM4dI0Fkt/4xsMjVGSoZD7vRwf/RColxjqeB9UXBB72
         ubv+mWWeZjLsFl6JK0afRRIgsWPHCt9pvMARzw2h4oP/wuMRaOZF+8YhKYaMMmOBA4
         evHoB2QvhdlSOcTjDfAu/EBIDzBiX1XH1PwY3oJM=
Date:   Thu, 8 Apr 2021 22:04:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Daniel Colascione <dancol@google.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH 0/9] userfaultfd: add minor fault handling for shmem
Message-Id: <20210408220440.aab59f2f06beb840c22377b3@linux-foundation.org>
In-Reply-To: <20210408234327.624367-1-axelrasmussen@google.com>
References: <20210408234327.624367-1-axelrasmussen@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu,  8 Apr 2021 16:43:18 -0700 Axel Rasmussen <axelrasmussen@google.com> wrote:

> The idea is that it will apply cleanly to akpm's tree, *replacing* the following
> patches (i.e., drop these first, and then apply this series):
> 
> userfaultfd-support-minor-fault-handling-for-shmem.patch
> userfaultfd-support-minor-fault-handling-for-shmem-fix.patch
> userfaultfd-support-minor-fault-handling-for-shmem-fix-2.patch
> userfaultfd-support-minor-fault-handling-for-shmem-fix-3.patch
> userfaultfd-support-minor-fault-handling-for-shmem-fix-4.patch
> userfaultfd-selftests-use-memfd_create-for-shmem-test-type.patch
> userfaultfd-selftests-create-alias-mappings-in-the-shmem-test.patch
> userfaultfd-selftests-reinitialize-test-context-in-each-test.patch
> userfaultfd-selftests-exercise-minor-fault-handling-shmem-support.patch

Well.  the problem is,

> +	if (area_alias == MAP_FAILED)
> +		err("mmap of memfd alias failed");

`err' doesn't exist until eleventy patches later, in Peter's
"userfaultfd/selftests: unify error handling".  I got tired of (and
lost confidence in) replacing "err(...)" with "fprintf(stderr, ...);
exit(1)" everywhere then fixing up the fallout when Peter's patch came
along.  Shudder.

Sorry, all this material pretty clearly isn't going to make 5.12
(potentially nine days hence), so I shall drop all the userfaultfd
patches.  Let's take a fresh run at all of this after -rc1.


I have tentatively retained the first series:

userfaultfd-add-minor-fault-registration-mode.patch
userfaultfd-add-minor-fault-registration-mode-fix.patch
userfaultfd-disable-huge-pmd-sharing-for-minor-registered-vmas.patch
userfaultfd-hugetlbfs-only-compile-uffd-helpers-if-config-enabled.patch
userfaultfd-add-uffdio_continue-ioctl.patch
userfaultfd-update-documentation-to-describe-minor-fault-handling.patch
userfaultfd-selftests-add-test-exercising-minor-fault-handling.patch

but I don't believe they have had much testing standalone, without the
other userfaultfd patches present.  So I don't think it's smart to
upstream these in this cycle.  Or I could drop them so you and Peter
can have a clean shot at redoing the whole thing.  Please let me know.

