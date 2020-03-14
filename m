Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 293AE18539B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 02:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgCNBAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 21:00:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51198 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgCNBAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 21:00:55 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCvAV-00B8Rf-AJ; Sat, 14 Mar 2020 01:00:47 +0000
Date:   Sat, 14 Mar 2020 01:00:47 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH v4 12/69] teach handle_mounts() to handle RCU mode
Message-ID: <20200314010047.GQ23230@ZenIV.linux.org.uk>
References: <20200313235303.GP23230@ZenIV.linux.org.uk>
 <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
 <20200313235357.2646756-12-viro@ZenIV.linux.org.uk>
 <CAHk-=whGqaTtjP-0PkWrTsbbwPihazCx1oeSsLTSB6itZzbZiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whGqaTtjP-0PkWrTsbbwPihazCx1oeSsLTSB6itZzbZiA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 13, 2020 at 05:28:12PM -0700, Linus Torvalds wrote:
> Oh, and here you accidentally fix the problem I pointed out about
> patch 11, as you move the code:
> 
> On Fri, Mar 13, 2020 at 4:54 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > +               if (unlikely(!*inode))
> > +                       return -ENOENT;
> 
> Correct test added.
> 
> > -                       if (unlikely(!inode))
> > -                               return -ENOENT;
> 
> Incorrect test removed.
> 
> And again, maybe I'm misreading the patch. But it does look like it's
> wrong in the middle of the series, which would make bisection if
> there's some related bug "interesting".

Bisect hazard on botched reordering, actually.  Fixed (IOW, that should've
been if (!*inode) already in #11).
