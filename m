Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9191F5F82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 03:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgFKBgm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 21:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgFKBgm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 21:36:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF0EC08C5C1;
        Wed, 10 Jun 2020 18:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OhtuvvlzzHFfDg+PC4aa+VAtbxaJoSFkoyziN0s35WQ=; b=Zof5Ro+zSJ0JDzuH+aN8Xz1rcs
        /jYX6M5fhwAoI2LAWxewVrWIUvdGS2YPZDwwSXAOqx2aotpCL8ERbAkRZEIMBkZBRMY5EM8eLHrVz
        FCPHFLUlooImb9VfHjsGDsoQ2C5PkmkmHsjvUO9rfWIm+6fZFR9y24k8GJYJAVuKogGJ8AHKn3itn
        RQKWsYF8z/7AbzuarxYTQ6lKRSvi/Yg/qp7gO7lnhNG1V/y5/u7ZBwYfw2KmltZcJThWsyXcp49dO
        5ruOY5jiLmf53/pjvyv+38HS3LQX/FoFCot4ryAgrnG75aSWq5qnfmqvYqkM8ijSWo/QgmISB5SyD
        epRrrSFA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjC8e-0000EW-DB; Thu, 11 Jun 2020 01:36:16 +0000
Date:   Wed, 10 Jun 2020 18:36:16 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
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
Message-ID: <20200611013616.GM19604@bombadil.infradead.org>
References: <4ebd0429-f715-d523-4c09-43fa2c3bc338@oracle.com>
 <202005281652.QNakLkW3%lkp@intel.com>
 <365d83b8-3af7-2113-3a20-2aed51d9de91@oracle.com>
 <CAJfpegtz=tzndsF=_1tYHewGwEgvqEOA_4zj8HCAqyFdKe6mag@mail.gmail.com>
 <ffc00a9e-5c2f-0c3e-aa1e-9836b98f7b54@oracle.com>
 <20200611003726.GY23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611003726.GY23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 11, 2020 at 01:37:26AM +0100, Al Viro wrote:
> On Wed, Jun 10, 2020 at 05:13:52PM -0700, Mike Kravetz wrote:
> 
> > To address this issue,
> > - Add a new file operation f_real while will return the underlying file.
> >   Only overlayfs provides a function for this operation.
> > - Add a new routine real_file() which can be used by core code get an
> >   underlying file.
> > - Update is_file_hugepages to get the real file.
> 
> Egads...  So to find out whether it's a hugetlb you would
> 	* check if a method is NULL
> 	* if not, call it
> 	* ... and check if the method table of the result is hugetlbfs one?
> 
> Here's a radical suggestion: FMODE_HUGEPAGES.  Just have it set by
> ->open() and let is_file_hugepages() check it.  In ->f_mode.  And
> make the bloody hugetlbfs_file_operations static, while we are at it.

ITYM FMODE_OVL_UPPER.  To quote Mike:

>         while (file->f_op == &ovl_file_operations)
>                 file = file->private_data;
>         return file;

which would be transformed into:

	while (file->f_mode & FMODE_OVL_UPPER)
		file = file->private_data;
	return file;

Or are you proposing that overlayfs copy FMODE_HUGEPAGES from the
underlying fs to the overlaying fs?
