Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917A91DEE0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 19:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbgEVRTG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 13:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730471AbgEVRTG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 13:19:06 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A113CC061A0E
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 10:19:05 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jcBJw-00DbVN-Lc; Fri, 22 May 2020 17:18:56 +0000
Date:   Fri, 22 May 2020 18:18:56 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Krzysztof Wilczynski <kw@linux.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Remove duplicated flag from VALID_OPEN_FLAGS
Message-ID: <20200522171856.GU23230@ZenIV.linux.org.uk>
References: <20200522133723.1091937-1-kw@linux.com>
 <20200522154719.GS23230@ZenIV.linux.org.uk>
 <20200522170119.GA31139@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200522170119.GA31139@bombadil.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 22, 2020 at 10:01:19AM -0700, Matthew Wilcox wrote:
> On Fri, May 22, 2020 at 04:47:19PM +0100, Al Viro wrote:
> > On Fri, May 22, 2020 at 01:37:23PM +0000, Krzysztof Wilczynski wrote:
> > > From: Krzysztof Wilczyński <kw@linux.com>
> > > 
> > > Also, remove extra tab after the FASYNC flag, and keep line under 80
> > > characters.  This also resolves the following Coccinelle warning:
> > > 
> > >   include/linux/fcntl.h:11:13-21: duplicated argument to & or |
> > 
> > Now ask yourself what might be the reason for that "duplicated argument".  
> > Try to figure out what the values of those constants might depend upon.
> > For extra points, try to guess what has caused the divergences.
> > 
> > Please, post the result of your investigation in followup to this.
> 
> I think the patch is actually right, despite the shockingly bad changelog.
> He's removed the duplicate 'O_NDELAY' and reformatted the lines.

So he has; my apologies - the obvious false duplicate in there would be
O_NDELAY vs. O_NONBLOCK and I'd misread the patch.

Commit message should've been along the lines of "O_NDELAY occurs twice
in definition of VALID_OPEN_FLAGS; get rid of the duplicate", possibly
along with "Note: O_NONBLOCK in the same expression is *not* another
duplicate - on sparc O_NONBLOCK != O_NDELAY (done that way for ABI
compatibility with Solaris back when sparc port began)".
