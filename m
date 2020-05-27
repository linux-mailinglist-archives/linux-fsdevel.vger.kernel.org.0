Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9601E4ECA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 22:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgE0UFa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 16:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgE0UFa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 16:05:30 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209A6C05BD1E;
        Wed, 27 May 2020 13:05:30 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1je2Im-00GTzv-F9; Wed, 27 May 2020 20:05:24 +0000
Date:   Wed, 27 May 2020 21:05:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] fs: Add an explicit might_sleep() to iput
Message-ID: <20200527200524.GG23230@ZenIV.linux.org.uk>
References: <20200527141753.101163-1-kpsingh@chromium.org>
 <20200527190948.GE23230@ZenIV.linux.org.uk>
 <CACYkzJ5MkWjVPo1JK68+fVyX7p=8bsi9P-C6nR=LYGJw04f9sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACYkzJ5MkWjVPo1JK68+fVyX7p=8bsi9P-C6nR=LYGJw04f9sw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 27, 2020 at 09:50:46PM +0200, KP Singh wrote:
> On Wed, May 27, 2020 at 9:09 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Wed, May 27, 2020 at 04:17:53PM +0200, KP Singh wrote:
> > > From: KP Singh <kpsingh@google.com>
> > >
> > > It is currently mentioned in the comments to the function that iput
> > > might sleep when the inode is destroyed. Have it call might_sleep, as
> > > dput already does.
> > >
> > > Adding an explicity might_sleep() would help in quickly realizing that
> > > iput is called from a place where sleeping is not allowed when
> > > CONFIG_DEBUG_ATOMIC_SLEEP is enabled as noticed in the dicussion:
> >
> > You do realize that there are some cases where iput() *is* guaranteed
> > to be non-blocking, right?
> 
> Yes, but the same could be said about dput too right?

Theoretically, but note that even there dput(NULL) won't trigger that.

> Are there any callers that rely on these cases? (e.g. when the caller is
> sure that it's not dropping the last reference to the inode).

Not sure - there might be.  Try and see if it gives false positives,
but I would rather have it done in -next circa -rc1, so we could see
what falls out and withdraw that if there turn out to be some.

One thing I definitely want to avoid is a flow of BS patches of
"warning is given, therefore we must do something, this is something,
let's do it" variety.  Right now we have just under 700 callers in
the tree, most of them in individual filesystems; I'm not up to
auditing that pile on the moments notice...
