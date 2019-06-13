Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53B4B44C22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 21:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfFMT36 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 15:29:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfFMT36 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 15:29:58 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55DF62147A;
        Thu, 13 Jun 2019 19:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560454197;
        bh=3nq7RwSer/Bwj8wjlB+pF0Ss6fAkxhqxBxJF0LKmZok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PsKvLzul3M76GkVQT+iREuWkduH+sv/EbpqVqvWMxorQopPHVDOT2k5gkJNIiKZLo
         Wt8JuIjy7KWL7G7WfDWj49p2z5kDCYd6eCd4e/tJkh8JYO8BuqeKnzN4SCFIjyzuSX
         8pGOSssDk1JR7zA93vfBURmASTgo8/sfqPOhARXQ=
Date:   Thu, 13 Jun 2019 12:29:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Sandeep Patil <sspatil@android.com>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] fs/proc: add VmTaskSize field to /proc/$$/status
Message-Id: <20190613122956.2fe1e200419c6497159044a0@linux-foundation.org>
In-Reply-To: <1560437690-13919-1-git-send-email-jsavitz@redhat.com>
References: <1560437690-13919-1-git-send-email-jsavitz@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 13 Jun 2019 10:54:50 -0400 Joel Savitz <jsavitz@redhat.com> wrote:

> The kernel provides no architecture-independent mechanism to get the
> size of the virtual address space of a task (userspace process) without
> brute-force calculation. This patch allows a user to easily retrieve
> this value via a new VmTaskSize entry in /proc/$$/status.

Why is access to ->task_size required?  Please fully describe the
use case.

> --- a/Documentation/filesystems/proc.txt
> +++ b/Documentation/filesystems/proc.txt
> @@ -187,6 +187,7 @@ read the file /proc/PID/status:
>    VmLib:      1412 kB
>    VmPTE:        20 kb
>    VmSwap:        0 kB
> +  VmTaskSize:	137438953468 kB
>    HugetlbPages:          0 kB
>    CoreDumping:    0
>    THP_enabled:	  1
> @@ -263,6 +264,7 @@ Table 1-2: Contents of the status files (as of 4.19)
>   VmPTE                       size of page table entries
>   VmSwap                      amount of swap used by anonymous private data
>                               (shmem swap usage is not included)
> + VmTaskSize                  size of task (userspace process) vm space

This is rather vague.  Is it the total amount of physical memory?  The
sum of all vma sizes, populated or otherwise?  Something else? 


