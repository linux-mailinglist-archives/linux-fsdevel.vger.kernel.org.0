Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E09E42FCFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 22:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242991AbhJOUaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 16:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238545AbhJOUaJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 16:30:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEE7D610E5;
        Fri, 15 Oct 2021 20:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1634329683;
        bh=+hYQMU6HoRUMtiXuwckcki+zu/fY1O6s+B9DModVMd8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iqvxEEFB220JWHdFvhux+d3aQApzxz61s1utNdtBG5JrTIsC0+Jllr9B0pOLvv/te
         oHXjcGZgse48FuZj6GqItrT55GXOLnemOos9Ta9dyx43TsKO6cc0aG+U7vg3KwXhW3
         JVRw6w30qbQcTdMjloV/mS/CTtZ/a8i0BbbvNzt8=
Date:   Fri, 15 Oct 2021 13:28:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v4 PATCH 0/6] Solve silent data loss caused by poisoned
 page cache (shmem/tmpfs)
Message-Id: <20211015132800.357d891d0b3ad34adb9c7383@linux-foundation.org>
In-Reply-To: <20211014191615.6674-1-shy828301@gmail.com>
References: <20211014191615.6674-1-shy828301@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 14 Oct 2021 12:16:09 -0700 Yang Shi <shy828301@gmail.com> wrote:

> When discussing the patch that splits page cache THP in order to offline the
> poisoned page, Noaya mentioned there is a bigger problem [1] that prevents this
> from working since the page cache page will be truncated if uncorrectable
> errors happen.  By looking this deeper it turns out this approach (truncating
> poisoned page) may incur silent data loss for all non-readonly filesystems if
> the page is dirty.  It may be worse for in-memory filesystem, e.g. shmem/tmpfs
> since the data blocks are actually gone.
> 
> To solve this problem we could keep the poisoned dirty page in page cache then
> notify the users on any later access, e.g. page fault, read/write, etc.  The
> clean page could be truncated as is since they can be reread from disk later on.
> 
> The consequence is the filesystems may find poisoned page and manipulate it as
> healthy page since all the filesystems actually don't check if the page is
> poisoned or not in all the relevant paths except page fault.  In general, we
> need make the filesystems be aware of poisoned page before we could keep the
> poisoned page in page cache in order to solve the data loss problem.

Is the "RFC" still accurate, or might it be an accidental leftover?

I grabbed this series as-is for some testing, but I do think it wouild
be better if it was delivered as two separate series - one series for
the -stable material and one series for the 5.16-rc1 material.

