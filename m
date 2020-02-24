Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7DE169C92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 04:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBXDRJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 22:17:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:40854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbgBXDRJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 22:17:09 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 864B020675;
        Mon, 24 Feb 2020 03:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582514228;
        bh=/HxwppNKkT1kyDN3qXhCwbz67TGUKxsrBHQM6eDoJk0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UoIyYySn7Rec2UDqle2YDg0gtssCXAt3WBCCuhnl24f9XJmlokz+crC+px95GWpeu
         Blnloqz8a2P7JZpyjDaT/ybJDmdajW5h1bx21xhlWL6nX/s0emeYCazGoc0WZ9DTzt
         d/wB0Xqdc4a1BmFhcvfCQB6zVzVdFXVT4EMq7KZo=
Date:   Sun, 23 Feb 2020 19:17:07 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     dchinner@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, guro@fb.com, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] protect page cache from freeing inode
Message-Id: <20200223191707.0a55e949fad943b04c2b65e7@linux-foundation.org>
In-Reply-To: <1582450294-18038-1-git-send-email-laoar.shao@gmail.com>
References: <1582450294-18038-1-git-send-email-laoar.shao@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 23 Feb 2020 04:31:31 -0500 Yafang Shao <laoar.shao@gmail.com> wrote:

> On my server there're some running MEMCGs protected by memory.{min, low},
> but I found the usage of these MEMCGs abruptly became very small, which
> were far less than the protect limit. It confused me and finally I
> found that was because of inode stealing.
> Once an inode is freed, all its belonging page caches will be dropped as
> well, no matter how may page caches it has. So if we intend to protect the
> page caches in a memcg, we must protect their host (the inode) first.
> Otherwise the memcg protection can be easily bypassed with freeing inode,
> especially if there're big files in this memcg.
> The inherent mismatch between memcg and inode is a trouble. One inode can
> be shared by different MEMCGs, but it is a very rare case. If an inode is
> shared, its belonging page caches may be charged to different MEMCGs.
> Currently there's no perfect solution to fix this kind of issue, but the
> inode majority-writer ownership switching can help it more or less.

What are the potential regression scenarios here?  Presumably a large
number of inodes pinned by small amounts of pagecache, consuming memory
and CPU during list scanning.  Anything else?

Have you considered constructing test cases to evaluate the impact of
such things?

