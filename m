Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F36B352691
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 08:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhDBGc0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 02:32:26 -0400
Received: from verein.lst.de ([213.95.11.211]:42642 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229522AbhDBGc0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 02:32:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C98B968BFE; Fri,  2 Apr 2021 08:32:21 +0200 (CEST)
Date:   Fri, 2 Apr 2021 08:32:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, Michal Hocko <mhocko@suse.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Adam Nichols <adam@grimm-co.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 3/3] sysfs: Unconditionally use vmalloc for buffer
Message-ID: <20210402063221.GA5260@lst.de>
References: <20210401221320.2717732-1-keescook@chromium.org> <20210401221320.2717732-4-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401221320.2717732-4-keescook@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 03:13:20PM -0700, Kees Cook wrote:
> The sysfs interface to seq_file continues to be rather fragile
> (seq_get_buf() should not be used outside of seq_file), as seen with
> some recent exploits[1]. Move the seq_file buffer to the vmap area
> (while retaining the accounting flag), since it has guard pages that will
> catch and stop linear overflows. This seems justified given that sysfs's
> use of seq_file almost always already uses PAGE_SIZE allocations, has
> normally short-lived allocations, and is not normally on a performance
> critical path.

This looks completely weird to me.  In the end sysfs uses nothing
of the seq_file infrastructure, so why do we even pretend to use it?
Just switch sysfs_file_kfops_ro and sysfs_file_kfops_rw from using
->seq_show to ->read and do the vmalloc there instead of pretending
this is a seq_file.

> Once seq_get_buf() has been removed (and all sysfs callbacks using
> seq_file directly), this change can also be removed.

And with sysfs out of the way I think kiling off the other few users
should be pretty easy as well.
