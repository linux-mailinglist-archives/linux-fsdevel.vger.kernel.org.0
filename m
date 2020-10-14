Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEEC28EA36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 03:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388946AbgJOBe5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 21:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgJOBeh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:34:37 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C2BC05112F;
        Wed, 14 Oct 2020 16:09:00 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSptC-000OCK-41; Wed, 14 Oct 2020 23:08:58 +0000
Date:   Thu, 15 Oct 2020 00:08:58 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel-team@fb.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: fix NULL dereference due to data race in
 prepend_path()
Message-ID: <20201014230858.GL3576660@ZenIV.linux.org.uk>
References: <20201014204529.934574-1-andrii@kernel.org>
 <CAHk-=wiE04vsfJmZ-AyWJHfNdGa=WmBYt4bP3aN+sTP05=QXXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiE04vsfJmZ-AyWJHfNdGa=WmBYt4bP3aN+sTP05=QXXA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 02:49:18PM -0700, Linus Torvalds wrote:
> On Wed, Oct 14, 2020 at 2:40 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Fix data race in prepend_path() with re-reading mnt->mnt_ns twice without
> > holding the lock. is_mounted() does check for NULL, but is_anon_ns(mnt->mnt_ns)
> > might re-read the pointer again which could be NULL already, if in between
> > reads one of kern_unmount()/kern_unmount_array()/umount_tree() sets mnt->mnt_ns
> > to NULL.
> 
> This seems like the obviously correct fix, so I think I'll just apply
> it directly.
> 
> Al? Holler if you have any issues with this..

See upthread.  If you've already grabbed it, I'll just push a followup cleanup.
