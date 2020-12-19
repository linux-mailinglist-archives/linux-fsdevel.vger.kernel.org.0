Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982462DF04D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Dec 2020 16:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgLSPuk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Dec 2020 10:50:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbgLSPuk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Dec 2020 10:50:40 -0500
Message-ID: <9a1263329effe436a970d5aa61a4cfad3098a076.camel@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608393000;
        bh=S8E27cwLiPYNCQUCXeSvdn1L+ynFVEr0RCHiNOi2ibY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Z1j25sbkOpnPBM/fk8JyzTWrAAg3rSNNMlGpzCFJkh8nzSb8quOKDedtjr2eIU/Mt
         xI5X2eOlJ2ysIIcjFF1kmHJjjqO9zS1/tbvKHeoZ+6Yr+gv7Iy+4OaaDvDijj339X8
         n72SmcfEIcBm7+NFXaC9X4mAXuXRzYsueIygnKitElP6vOEqBDOmYvkQt6xwNykAHB
         ojc/9GyhVA260inpx5cn8Srb8rB5Yc8hkxdi5PDK+xyukLDKmaomOdN66z8XS2KF7J
         FUsjByjtdtA079gL845EzxUEW1OXVMdyePKFB6Q94T+6TpAMHEhdUykIhQnot7YzRq
         DSvxq/DrF75Vw==
Subject: Re: [PATCH v3] errseq: split the ERRSEQ_SEEN flag into two new flags
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Date:   Sat, 19 Dec 2020 10:49:58 -0500
In-Reply-To: <20201219153312.GS15600@casper.infradead.org>
References: <20201217150037.468787-1-jlayton@kernel.org>
         <20201219061331.GQ15600@casper.infradead.org>
         <f84f3259d838f132029576b531d81525abd4e1b8.camel@kernel.org>
         <20201219153312.GS15600@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2020-12-19 at 15:33 +0000, Matthew Wilcox wrote:
> On Sat, Dec 19, 2020 at 07:53:12AM -0500, Jeff Layton wrote:
> > On Sat, 2020-12-19 at 06:13 +0000, Matthew Wilcox wrote:
> > > On Thu, Dec 17, 2020 at 10:00:37AM -0500, Jeff Layton wrote:
> > > > Overlayfs's volatile mounts want to be able to sample an error for their
> > > > own purposes, without preventing a later opener from potentially seeing
> > > > the error.
> > > 
> > > umm ... can't they just copy the errseq_t they're interested in, followed
> > > by calling errseq_check() later?
> > > 
> > 
> > They don't want the sampling for the volatile mount to prevent later
> > openers from seeing an error that hasn't yet been reported.
> 
> That's why they should use errseq_check(), not errseq_check_and_advance()
> ...

If you sample it without setting the OBSERVED (aka SEEN) bit, then you
can't guarantee that the next error that occurs will be recorded. The
counter won't be bumped unless that flag is set.

-- 
Jeff Layton <jlayton@kernel.org>

