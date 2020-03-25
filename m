Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2112192AAE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 15:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgCYOCK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 10:02:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48968 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbgCYOCK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:02:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH6bf-002WDe-9O; Wed, 25 Mar 2020 14:02:07 +0000
Date:   Wed, 25 Mar 2020 14:02:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <cai@lca.pw>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Null-ptr-deref due to "sanitized pathwalk machinery (v4)"
Message-ID: <20200325140207.GM23230@ZenIV.linux.org.uk>
References: <4CBDE0F3-FB73-43F3-8535-6C75BA004233@lca.pw>
 <20200324214637.GI23230@ZenIV.linux.org.uk>
 <A32DAE66-ADBA-46C7-BD26-F9BA8F12BC18@lca.pw>
 <20200325021327.GJ23230@ZenIV.linux.org.uk>
 <5281297D-B66E-4A4C-9B41-D2242F6B7AE7@lca.pw>
 <20200325040359.GK23230@ZenIV.linux.org.uk>
 <20200325055830.GL23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325055830.GL23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 05:58:30AM +0000, Al Viro wrote:
> On Wed, Mar 25, 2020 at 04:03:59AM +0000, Al Viro wrote:
> 
> > Lovely.  So
> > 	* we really do get NULL nd->path.dentry there; I've not misread the
> > trace.
> > 	* on the entry into link_path_walk() nd->path.dentry is non-NULL.
> > 	* *ALL* components should've been LAST_NORM ones
> > 	* not a single symlink in sight, unless the setup is rather unusual
> > 	* possibly not even a single mountpoint along the way (depending
> > upon the userland used)
> 
> OK, I see one place where that could occur, but I really don't see how that
> could be triggered on this pathname, short of very odd symlink layout in
> the filesystem on the testbox.

... which, apparently, is what you've got there (/var/run -> ../run), so
stepping into that braino is not implausible.  Could you check if the
fix below fixes what you've observed?  I am folding it in anyway (into
"lift all calls of step_into() out of follow_dotdot/follow_dotdot_rcu") -
it's an obvious braino introduced in the commit in question, but I'd
like a confirmation that this _is_ what you've caught.


>  Does the following fix your reproducer?
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 311e33dbac63..4082b70f32ff 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1805,6 +1805,8 @@ static const char *handle_dots(struct nameidata *nd, int type)
>  			error = step_into(nd, WALK_NOFOLLOW,
>  					 parent, inode, seq);
>  		}
> +		if (unlikely(error))
> +			return ERR_PTR(error);
>  
>  		if (unlikely(nd->flags & LOOKUP_IS_SCOPED)) {
>  			/*
