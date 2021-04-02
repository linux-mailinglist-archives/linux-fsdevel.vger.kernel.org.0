Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A86352733
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 10:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhDBIEb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 04:04:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233521AbhDBIE3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 04:04:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC3FF61104;
        Fri,  2 Apr 2021 08:04:25 +0000 (UTC)
Date:   Fri, 2 Apr 2021 10:04:23 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <20210402080423.t26zd34p2oxbzvuj@wittgenstein>
References: <cover.1617258892.git.osandov@fb.com>
 <0e7270919b461c4249557b12c7dfce0ad35af300.1617258892.git.osandov@fb.com>
 <CAHk-=wgpn=GYW=2ZNizdVdM0qGGk_iM_Ho=0eawhNaKHifSdpg@mail.gmail.com>
 <YGbIwOv0yq0z8i8K@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGbIwOv0yq0z8i8K@relinquished.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 02, 2021 at 12:33:20AM -0700, Omar Sandoval wrote:
> On Thu, Apr 01, 2021 at 09:05:22AM -0700, Linus Torvalds wrote:
> > On Wed, Mar 31, 2021 at 11:51 PM Omar Sandoval <osandov@osandov.com> wrote:
> > >
> > > + *
> > > + * The recommended usage is something like the following:
> > > + *
> > > + *     if (usize > PAGE_SIZE)
> > > + *       return -E2BIG;
> > 
> > Maybe this should be more than a recommendation, and just be inside
> > copy_struct_from_iter(), because otherwise the "check_zeroed_user()"
> > call might be quite the timesink for somebody who does something
> > stupid.
> 
> I did actually almost send this out with the check in
> copy_struct_from_iter(), but decided not to for consistency with
> copy_struct_from_user().
> 
> openat2() seems to be the only user of copy_struct_from_user() that
> doesn't limit to PAGE_SIZE, which is odd given that Aleksa wrote both

Al said there's nothing wrong with copying large chunks of memory so we
shouldn't limit the helper but instead limit the callers which have
expectations about their size limit:
https://lore.kernel.org/lkml/20190905182801.GR1131@ZenIV.linux.org.uk/

Christian
