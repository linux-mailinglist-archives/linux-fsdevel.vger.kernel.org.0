Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D761C320CDC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Feb 2021 19:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhBUSvo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Feb 2021 13:51:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231218AbhBUSvh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Feb 2021 13:51:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DEBB64EEC;
        Sun, 21 Feb 2021 18:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613932985;
        bh=IvgRcP7o7njVOuj5mxbLepuRde3TFoc2FITy1wIa3KY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Yps1uFhmEVLhyeGSxNZ/INTX800e5uqgTLqv86QwwQE+9PexfOmWKlYaCddPGTrBt
         /A4NT++jNOVqgQK8APalaiTm3Q2jjLtBf1Hh9kI4HZx/Aa9KF+ux6RmH9IbEspodYe
         lkHc4m8+BjyQ9vUBUGk1EDbfuSdUJ0AgcZavym8BNJwx9JKBYrGAFa/rzro0HwksDI
         AsugyobuG+RAlfvVHxxEuxEQDbGpUhiLlDFcczLShfLjnG5BdEEHhdp9mRrkT0wGT6
         fQpSLMnua0le7WHo/vnsvVFoRMzfDUa+mldCCed+P7Q62M4gZtd3KKhbe/c0DMjOGZ
         zT6aPD4hCLm6w==
Message-ID: <b76672d52ffe498259181688eaf54ec75be449e8.camel@kernel.org>
Subject: Re: [PATCH] fs/locks: print full locks information
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Luo Longjun <luolongjun@huawei.com>
Cc:     bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sangyan@huawei.com,
        luchunhua@huawei.com
Date:   Sun, 21 Feb 2021 13:43:03 -0500
In-Reply-To: <YDKP0XdT1TVOaGnj@zeniv-ca.linux.org.uk>
References: <20210220063250.742164-1-luolongjun@huawei.com>
         <YDKP0XdT1TVOaGnj@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2021-02-21 at 16:52 +0000, Al Viro wrote:
> On Sat, Feb 20, 2021 at 01:32:50AM -0500, Luo Longjun wrote:
> >  
> > 
> > @@ -2844,7 +2845,13 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
> >  	if (fl->fl_file != NULL)
> >  		inode = locks_inode(fl->fl_file);
> >  
> > 
> > -	seq_printf(f, "%lld:%s ", id, pfx);
> > +	seq_printf(f, "%lld: ", id);
> > +	for (i = 1; i < repeat; i++)
> > +		seq_puts(f, " ");
> > +
> > +	if (repeat)
> > +		seq_printf(f, "%s", pfx);
> 
> RTFCStandard(printf, %*s), please
> 
> > +static int __locks_show(struct seq_file *f, struct file_lock *fl, int level)
> > +{
> > +	struct locks_iterator *iter = f->private;
> > +	struct file_lock *bfl;
> > +
> > +	lock_get_status(f, fl, iter->li_pos, "-> ", level);
> > +
> > +	list_for_each_entry(bfl, &fl->fl_blocked_requests, fl_blocked_member)
> > +		__locks_show(f, bfl, level + 1);
> 
> Er...  What's the maximal depth, again?  Kernel stack is very much finite...

Ooof, good point. I don't think there is a maximal depth on the tree
itself. If you do want to do something like this, then you'd need to
impose a hard limit on the recursion somehow.
-- 
Jeff Layton <jlayton@kernel.org>

