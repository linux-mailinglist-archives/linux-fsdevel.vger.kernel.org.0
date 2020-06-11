Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497791F5F41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 02:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgFKAhq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 20:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgFKAhq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 20:37:46 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B64C08C5C1;
        Wed, 10 Jun 2020 17:37:45 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jjBDi-006jDe-TJ; Thu, 11 Jun 2020 00:37:27 +0000
Date:   Thu, 11 Jun 2020 01:37:26 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Colin Walters <walters@verbum.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: [PATCH v2] ovl: provide real_file() and overlayfs
 get_unmapped_area()
Message-ID: <20200611003726.GY23230@ZenIV.linux.org.uk>
References: <4ebd0429-f715-d523-4c09-43fa2c3bc338@oracle.com>
 <202005281652.QNakLkW3%lkp@intel.com>
 <365d83b8-3af7-2113-3a20-2aed51d9de91@oracle.com>
 <CAJfpegtz=tzndsF=_1tYHewGwEgvqEOA_4zj8HCAqyFdKe6mag@mail.gmail.com>
 <ffc00a9e-5c2f-0c3e-aa1e-9836b98f7b54@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffc00a9e-5c2f-0c3e-aa1e-9836b98f7b54@oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 05:13:52PM -0700, Mike Kravetz wrote:

> To address this issue,
> - Add a new file operation f_real while will return the underlying file.
>   Only overlayfs provides a function for this operation.
> - Add a new routine real_file() which can be used by core code get an
>   underlying file.
> - Update is_file_hugepages to get the real file.

Egads...  So to find out whether it's a hugetlb you would
	* check if a method is NULL
	* if not, call it
	* ... and check if the method table of the result is hugetlbfs one?

Here's a radical suggestion: FMODE_HUGEPAGES.  Just have it set by
->open() and let is_file_hugepages() check it.  In ->f_mode.  And
make the bloody hugetlbfs_file_operations static, while we are at it.
