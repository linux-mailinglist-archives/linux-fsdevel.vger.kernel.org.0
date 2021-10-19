Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B8A434162
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 00:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhJSWcd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 18:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhJSWcc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 18:32:32 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89404C06161C;
        Tue, 19 Oct 2021 15:30:19 -0700 (PDT)
Date:   Wed, 20 Oct 2021 07:30:07 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1634682616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3eYlirUPJWlfZnDuhuK3/qZsVNkj8Tn2KKROW5g83xA=;
        b=lEGQDiuVrgN0IyPFKKxOVGyYWZoqRUnW+bUEsVWpJV7nXwQa7p74+yUOSZZ96Wf8T76Eno
        HVEiQZSTOqqZZdamYa3vlqmNuKb2oBiqKRJnHjxA28gxIxc9RJ9hYA8GtjQAMZGzrcKApd
        PaAMmc0ohdoMJ3ynOSzZH9buRxObENk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Yang Shi <shy828301@gmail.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v4 PATCH 5/6] mm: shmem: don't truncate page if memory failure
 happens
Message-ID: <20211019223007.GA2324358@u2004>
References: <20211014191615.6674-1-shy828301@gmail.com>
 <20211014191615.6674-6-shy828301@gmail.com>
 <20211019055221.GC2268449@u2004>
 <CAHbLzkqfbsnUtxZCs0JK_b_G95id1D0q=c_hCuuZe7i6q_6oDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkqfbsnUtxZCs0JK_b_G95id1D0q=c_hCuuZe7i6q_6oDQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 10:29:51AM -0700, Yang Shi wrote:
> On Mon, Oct 18, 2021 at 10:52 PM Naoya Horiguchi
> <naoya.horiguchi@linux.dev> wrote:
> >
> > On Thu, Oct 14, 2021 at 12:16:14PM -0700, Yang Shi wrote:
...
> > > @@ -2466,7 +2467,15 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
> > >                       return -EPERM;
> > >       }
> > >
> > > -     return shmem_getpage(inode, index, pagep, SGP_WRITE);
> > > +     ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
> > > +
> > > +     if (*pagep && PageHWPoison(*pagep)) {
> >
> > shmem_getpage() could return with pagep == NULL, so you need check ret first
> > to avoid NULL pointer dereference.
> 
> Realy? IIUC pagep can't be NULL. It is a pointer's pointer passed in
> by the caller, for example, generic_perform_write(). Of course,
> "*pagep" could be NULL.

Oh, I simply missed this. You're right. Please ignore my comment on this.

- Naoya Horiguchi
