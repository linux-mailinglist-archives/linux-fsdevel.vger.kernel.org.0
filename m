Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D9BA6A55
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 15:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfICNsf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 09:48:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57838 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfICNsf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:48:35 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.1 #3 (Red Hat Linux))
        id 1i59Ae-0003on-Cg; Tue, 03 Sep 2019 13:48:32 +0000
Date:   Tue, 3 Sep 2019 14:48:32 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qian Cai <cai@lca.pw>, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: "fs/namei.c: keep track of nd->root refcount status" causes boot
 panic
Message-ID: <20190903134832.GH1131@ZenIV.linux.org.uk>
References: <7C6CCE98-1E22-433C-BF70-A3CBCDED4635@lca.pw>
 <20190903123719.GF1131@ZenIV.linux.org.uk>
 <20190903130456.GA9567@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903130456.GA9567@infradead.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 06:04:56AM -0700, Christoph Hellwig wrote:
> On Tue, Sep 03, 2019 at 01:37:19PM +0100, Al Viro wrote:
> > On Tue, Sep 03, 2019 at 12:21:36AM -0400, Qian Cai wrote:
> > > The linux-next commit "fs/namei.c: keep track of nd->root refcount status” [1] causes boot panic on all
> > > architectures here on today’s linux-next (0902). Reverted it will fix the issue.
> > 
> > <swearing>
> > 
> > OK, I see what's going on.  Incremental to be folded in:
> > 
> > diff --git a/include/linux/namei.h b/include/linux/namei.h
> > index 20ce2f917ef4..2ed0942a67f8 100644
> > --- a/include/linux/namei.h
> > +++ b/include/linux/namei.h
> > @@ -20,8 +20,8 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
> >  #define LOOKUP_FOLLOW		0x0001	/* follow links at the end */
> >  #define LOOKUP_DIRECTORY	0x0002	/* require a directory */
> >  #define LOOKUP_AUTOMOUNT	0x0004  /* force terminal automount */
> > -#define LOOKUP_EMPTY		0x4000	/* accept empty path [user_... only] */
> > -#define LOOKUP_DOWN		0x8000	/* follow mounts in the starting point */
> > +#define LOOKUP_EMPTY		0x8000	/* accept empty path [user_... only] */
> > +#define LOOKUP_DOWN		0x10000	/* follow mounts in the starting point */
> >  
> >  #define LOOKUP_REVAL		0x0020	/* tell ->d_revalidate() to trust no cache */
> >  #define LOOKUP_RCU		0x0040	/* RCU pathwalk mode; semi-internal */
> 
> Any chance to keep these ordered numerically to avoid someone else
> introdcing this kind of bug again later on?

Not sure what would be the best way to do it...  I don't mind breaking
the out-of-tree modules, whatever their license is; what I would rather
avoid is _quiet_ breaking of such.
