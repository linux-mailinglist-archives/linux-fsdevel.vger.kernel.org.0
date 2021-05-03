Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B909E37223E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 23:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhECVKj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 17:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECVKi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 17:10:38 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BEBC061573;
        Mon,  3 May 2021 14:09:44 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ldfou-00AkQv-2m; Mon, 03 May 2021 21:09:36 +0000
Date:   Mon, 3 May 2021 21:09:36 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nfs@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 10/12] nfsd: Avoid non-flexible API in seq_quote_mem()
Message-ID: <YJBmkNky4QfFhPD1@zeniv-ca.linux.org.uk>
References: <20210503204907.34013-1-andriy.shevchenko@linux.intel.com>
 <20210503204907.34013-11-andriy.shevchenko@linux.intel.com>
 <YJBi5NU2WmZPYbBG@zeniv-ca.linux.org.uk>
 <CAHp75VfZKX_oYzoAA9Mbya1_+hP6+1mDKqyfy9d=hsokEAGQsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfZKX_oYzoAA9Mbya1_+hP6+1mDKqyfy9d=hsokEAGQsQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 03, 2021 at 11:56:41PM +0300, Andy Shevchenko wrote:
> On Mon, May 3, 2021 at 11:54 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Mon, May 03, 2021 at 11:49:05PM +0300, Andy Shevchenko wrote:
> > > string_escape_mem_ascii() followed by seq_escape_mem_ascii() is completely
> > > non-flexible and shouldn't be exist from day 1.
> > >
> > > Replace it with properly called string_escape_mem().
> >
> > NAKed-by: Al Viro <viro@zeniv.linux.org.uk>
> >
> > Reason: use of seq_get_buf().  Which should have been static inline in
> > fs/seq_file.c, to start with.
> 
> I see.
> 
> > Again, any new uses of seq_get_buf()/seq_commit() are grounds for automatic
> > NAK.  These interfaces *will* be withdrawn.
> 
> You meant that this is no way to get rid of this guy?
> Any suggestions how to replace that API with a newer one?

seq_escape_mem(), perhaps?
