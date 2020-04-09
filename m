Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7926B1A3A04
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 20:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgDISvc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 14:51:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52348 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDISvc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UThGtuKmzrY2tbYaUi/vOzlVPrlMS79aTYBebv6WLZc=; b=St1+WyQneC1T/0LuqZqacoW0LO
        RusuaoOaleeipF3nWAZcKac+erz+gWX/y7/J0/JqXaHr8H9kn/Pr7NOqGTmsafijXY/EhoysZ+Vte
        YxmCh55b6WTkMsEK/q03H0HbzAZNzyK60w/uawCA5CUqzHNWNCxbZmqrhJHkxEDVnKiQ7ghfX4BZz
        uVSgvEi49tQ+ruSkOSzw8j84hFKXn/nMYnUyE+T4vG3vTnsSi7JVwcZsGBEOAtSvKN0Kx1hmCaT2n
        09L2hXQewJNLEDAHGxKDcEcEj42pgvEeeVtXTPuxCneOvVQCbZchbCEX0Y2VlotyUnkfizvuvzZgP
        6tTEzWhQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMcGy-0002z1-W4; Thu, 09 Apr 2020 18:51:32 +0000
Date:   Thu, 9 Apr 2020 11:51:32 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: is this hang in a rename syscall is known?
Message-ID: <20200409185132.GY21484@bombadil.infradead.org>
References: <CAN-5tyF9JX1VaevFcvDKAcHa1XTgYznOMwW+LMigA-awqn_m7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyF9JX1VaevFcvDKAcHa1XTgYznOMwW+LMigA-awqn_m7w@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 09, 2020 at 12:44:25PM -0400, Olga Kornievskaia wrote:
> Hi folks,
> 
> Getting this hang on a 5.5 kernel, is this a known issue? Thank you.

I haven't seen it reported.

> Apr  7 13:34:53 scspr1865142002 kernel:      Not tainted 5.5.7 #1
> Apr  7 13:34:53 scspr1865142002 kernel: "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Apr  7 13:34:53 scspr1865142002 kernel: dt              D    0 24788
> 24323 0x00000080
> Apr  7 13:34:53 scspr1865142002 kernel: Call Trace:
> Apr  7 13:34:53 scspr1865142002 kernel: ? __schedule+0x2ca/0x6e0
> Apr  7 13:34:53 scspr1865142002 kernel: schedule+0x4a/0xb0
> Apr  7 13:34:53 scspr1865142002 kernel: schedule_preempt_disabled+0xa/0x10
> Apr  7 13:34:53 scspr1865142002 kernel: __mutex_lock.isra.11+0x233/0x4e0
> Apr  7 13:34:53 scspr1865142002 kernel: ? strncpy_from_user+0x47/0x160
> Apr  7 13:34:53 scspr1865142002 kernel: lock_rename+0x28/0xd0

This task is doing a cross-directory rename() operation.  We only allow
one of those in progress per filesystem at any given time (because they're
quite rare and rearranging the tree like that plays merry havoc with the
locking, which you need to prevent a directory becoming its own ancestor).

So the question is, who else is in the middle of a rename operation and
has blocked for a long time while holding the s_vfs_rename_mutex?

As I recall, you work on NFS, so has something weird been going on with
your network?

