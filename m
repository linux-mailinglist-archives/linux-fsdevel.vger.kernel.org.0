Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3644342E62
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 17:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCTQcx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 12:32:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229761AbhCTQcv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 12:32:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9923961934;
        Sat, 20 Mar 2021 16:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1616257971;
        bh=WdUxKSETKcrjBZWfh67ufbdZG8tgIef5zeapBbsXIO4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BvJy91r/xPJQ8TUhms4zJXAeQ4JjQyRMHpSH+J/t+PshlcnFIyfVVma+n4FauXHNK
         JJmU1xS8qmmRUXGq8D+66H/D1R3jsEy31C8bUhiu/FPYERlHAiszKng4AExesa6RV8
         Q/rQPfRcAx6QWZzZT7sEWsp4GBQ+kGqJywmKe0B8=
Date:   Sat, 20 Mar 2021 09:32:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        joaodias@google.com, surenb@google.com, cgoldswo@codeaurora.org,
        willy@infradead.org, mhocko@suse.com, david@redhat.com,
        vbabka@suse.cz, linux-fsdevel@vger.kernel.org,
        oliver.sang@intel.com
Subject: Re: [PATCH v4 3/3] mm: fs: Invalidate BH LRU during page migration
Message-Id: <20210320093249.2df740cd139449312211c452@linux-foundation.org>
In-Reply-To: <20210319175127.886124-3-minchan@kernel.org>
References: <20210319175127.886124-1-minchan@kernel.org>
        <20210319175127.886124-3-minchan@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 19 Mar 2021 10:51:27 -0700 Minchan Kim <minchan@kernel.org> wrote:

> Pages containing buffer_heads that are in one of the per-CPU
> buffer_head LRU caches will be pinned and thus cannot be migrated.
> This can prevent CMA allocations from succeeding, which are often used
> on platforms with co-processors (such as a DSP) that can only use
> physically contiguous memory. It can also prevent memory
> hot-unplugging from succeeding, which involves migrating at least
> MIN_MEMORY_BLOCK_SIZE bytes of memory, which ranges from 8 MiB to 1
> GiB based on the architecture in use.
> 
> Correspondingly, invalidate the BH LRU caches before a migration
> starts and stop any buffer_head from being cached in the LRU caches,
> until migration has finished.
> 
> Tested-by: Oliver Sang <oliver.sang@intel.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

The signoff chain ordering might mean that Chris was the primary author, but
there is no From:him.  Please clarify?
