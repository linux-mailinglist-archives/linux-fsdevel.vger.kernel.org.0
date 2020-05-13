Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215F61D1F99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 21:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390735AbgEMTsz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 15:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732218AbgEMTsz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 15:48:55 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DA3C061A0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 12:48:54 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYxN4-007iqG-8X; Wed, 13 May 2020 19:48:50 +0000
Date:   Wed, 13 May 2020 20:48:50 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/12] vfs patch queue
Message-ID: <20200513194850.GY23230@ZenIV.linux.org.uk>
References: <20200505095915.11275-1-mszeredi@redhat.com>
 <CAJfpegtNQ8mYRBdRVLgmY8eVwFFdtvOEzWERegtXbLi9T2Ytqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtNQ8mYRBdRVLgmY8eVwFFdtvOEzWERegtXbLi9T2Ytqw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 09:47:07AM +0200, Miklos Szeredi wrote:
> On Tue, May 5, 2020 at 11:59 AM Miklos Szeredi <mszeredi@redhat.com> wrote:
> >
> > Hi Al,
> >
> > Can you please apply the following patches?
> 
> Ping?  Could you please have a look at these patches?
> 
> - /proc/mounts cursor is almost half the total lines changed, and that
> one was already pretty damn well reviewed by you
> 
> - unprivileged whiteout one was approved by the security guys
> 
> - aio fsync one is a real bug, please comment on whether the patch is
> acceptable or should I work around it in fuse
> 
> - STATX_MNT_ID extension is a no brainer, the other one may or may not
> be useful, that's arguable...
> 
> - the others are not important, but I think useful
> 
> - and I missed one (faccess2); amending to patch series

I can live with that, modulo couple of trivial nits.  Have you tested the
/proc/mounts part for what happens if it's opened shitloads of times,
with each instance lseek'ed a bit forward (all to the same position, that
is)?  That, in principle, allows an unpriveleged user to pile a lot of list
entries and cause serious looping under a spinlock...
