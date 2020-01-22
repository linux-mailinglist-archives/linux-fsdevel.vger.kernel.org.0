Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3A00145AFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 18:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgAVRln (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 12:41:43 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38948 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVRlm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:41:42 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iuK0P-000izi-Q7; Wed, 22 Jan 2020 17:41:29 +0000
Date:   Wed, 22 Jan 2020 17:41:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v1 1/6] fs/readdir: Fix filldir() and filldir64() use of
 user_access_begin()
Message-ID: <20200122174129.GH23230@ZenIV.linux.org.uk>
References: <a02d3426f93f7eb04960a4d9140902d278cab0bb.1579697910.git.christophe.leroy@c-s.fr>
 <CAHk-=whTzEu5=sMEVLzuf7uOnoCyUs8wbfw87njes9FyE=mj1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whTzEu5=sMEVLzuf7uOnoCyUs8wbfw87njes9FyE=mj1w@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 22, 2020 at 08:13:12AM -0800, Linus Torvalds wrote:
> On Wed, Jan 22, 2020 at 5:00 AM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
> >
> > Modify filldir() and filldir64() to request the real area they need
> > to get access to.
> 
> Not like this.
> 
> This makes the situation for architectures like x86 much worse, since
> you now use "put_user()" for the previous dirent filling. Which does
> that expensive user access setup/teardown twice again.
> 
> So either you need to cover both the dirent's with one call, or you
> just need to cover the whole (original) user buffer passed in. But not
> this unholy mixing of both unsafe_put_user() and regular put_user().

I would suggest simply covering the range from dirent->d_off to
buf->current_dir->d_name[namelen]; they are going to be close to
each other and we need those addresses anyway...
