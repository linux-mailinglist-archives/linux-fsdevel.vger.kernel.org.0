Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF21D3374B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 14:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbhCKNwt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 08:52:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:48456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233722AbhCKNw3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:52:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9768364F9A;
        Thu, 11 Mar 2021 13:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615470749;
        bh=R9H3mIcTDgW/Lz4wvs/Cih1NsNMa6sUb08lf3mjM1s0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=l6f2QfXm8MzB1c/HIO2ODiV4wXgEodLa+ZRQBgY+5tCw8ofsnKjbwbrI3jhPEp9V8
         qH+Ud5zX3uXKX82Pi9Py/Oa26iNo9kzbs70LOI0ULIaa+AhhWgTxMwpXoOBqLbDwFf
         Dm+/CnOJ1kXlV1KuGfms7gqyzjDKQ71mK3GCCy45TZAlgCS+5Z37mDc+3wax6iGTV0
         8NHFDFzP7uzYcI1t0XIhYO89/kkQ8pzKa5wg7go9RLUY1f4iCS4QKYR9yfbNAnLMpr
         OnLthv4p2SXgnNADPUZlpGzpHtjSYxOy0UxaRzf/J558jVb4rss1FFBzu5LsygEDZw
         wCZnZvajVbZDQ==
Message-ID: <923d0102b720657e748178c5ca4dd95fc8f81d2f.camel@kernel.org>
Subject: Re: [PATCH v3] fs/locks: print full locks information
From:   Jeff Layton <jlayton@kernel.org>
To:     Luo Longjun <luolongjun@huawei.com>, viro@zeniv.linux.org.uk,
        bfields@fieldses.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sangyan@huawei.com, luchunhua@huawei.com
Date:   Thu, 11 Mar 2021 08:52:27 -0500
In-Reply-To: <649fa593-d534-a23d-4442-2462778662df@huawei.com>
References: <20210221201024.GB15975@fieldses.org>
         <685386c2840b76c49b060bf7dcea1fefacf18176.1614322182.git.luolongjun@huawei.com>
         <f8c7a7fe8ee7fc1f1a36f35f38cc653d167b25a1.camel@kernel.org>
         <649fa593-d534-a23d-4442-2462778662df@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-03-11 at 11:45 +0800, Luo Longjun wrote:
> 在 2021/3/9 21:37, Jeff Layton 写道:
> > On Thu, 2021-02-25 at 22:58 -0500, Luo Longjun wrote:
> > > Commit fd7732e033e3 ("fs/locks: create a tree of dependent requests.")
> > > has put blocked locks into a tree.
> > > 
> > > So, with a for loop, we can't check all locks information.
> > > 
> > > To solve this problem, we should traverse the tree.
> > > 
> > > Signed-off-by: Luo Longjun <luolongjun@huawei.com>
> > > ---
> > >   fs/locks.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++--------
> > >   1 file changed, 56 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/fs/locks.c b/fs/locks.c
> > > index 99ca97e81b7a..ecaecd1f1b58 100644
> > > --- a/fs/locks.c
> > > +++ b/fs/locks.c
> > > @@ -2828,7 +2828,7 @@ struct locks_iterator {
> > >   };
> > >   
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > >   static void lock_get_status(struct seq_file *f, struct file_lock *fl,
> > > -			    loff_t id, char *pfx)
> > > +			    loff_t id, char *pfx, int repeat)
> > >   {
> > >   	struct inode *inode = NULL;
> > >   	unsigned int fl_pid;
> > > @@ -2844,7 +2844,11 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
> > >   	if (fl->fl_file != NULL)
> > >   		inode = locks_inode(fl->fl_file);
> > >   
> > > 
> > > 
> > > 
> > > 
> > > 
> > > 
> > > -	seq_printf(f, "%lld:%s ", id, pfx);
> > > +	seq_printf(f, "%lld: ", id);
> > > +
> > > +	if (repeat)
> > > +		seq_printf(f, "%*s", repeat - 1 + (int)strlen(pfx), pfx);
> > Shouldn't that be "%.*s" ?
> > 
> > Also, isn't this likely to end up walking past the end of "pfx" (or even
> > ending up at an address before the buffer)? You have this below:
> > 
> >      lock_get_status(f, fl, *id, "", 0);
> > 
> > ...so the "length" value you're passing into the format there is going
> > to be -1. It also seems like if you get a large "level" value in
> > locks_show, then you'll end up with a length that is much longer than
> > the actual string.
> 
> In my understanding, the difference of "%*s" and "%.*s" is that, "%*s" 
> specifies the minimal filed width while "%.*s" specifies the precision 
> of the string.
> 

Oh, right. I always forget about the first usage.

> Here, I use "%*s", because I want to print locks information in the 
> follwing format:
> 
> 2: FLOCK  ADVISORY  WRITE 110 00:02:493 0 EOF
> 2: -> FLOCK  ADVISORY  WRITE 111 00:02:493 0 EOF
> 2:  -> FLOCK  ADVISORY  WRITE 112 00:02:493 0 EOF
> 2:   -> FLOCK  ADVISORY  WRITE 113 00:02:493 0 EOF
> 2:    -> FLOCK  ADVISORY  WRITE 114 00:02:493 0 EOF
> 
> And also, there is another way to show there information, in the format 
> like:
> 
> 60: FLOCK  ADVISORY  WRITE 23350 08:02:4456514 0 EOF
> 60: -> FLOCK  ADVISORY  WRITE 23356 08:02:4456514 0 EOF
> 60: -> FLOCK  ADVISORY  WRITE 24217 08:02:4456514 0 EOF
> 60: -> FLOCK  ADVISORY  WRITE 24239 08:02:4456514 0 EOF
> 
> I think both formats are acceptable, but the first format shows 
> competition relationships between these locks.
> 

We might as well go with the one this patch implements. I like seeing
the chain of waiters as well, and it doesn't seem to break lslocks
(which is, to my knowledge, the only real programmatic consumer of this
file).

> In the following code:
> 
> > lock_get_status(f, fl, *id, "", 0);
> 
> repeat is 0, and in the function:
> 
> + if (repeat)
> +		seq_printf(f, "%*s", repeat - 1 + (int)strlen(pfx), pfx);
> 
> The if branch will not take effect, so it could not be -1.
> 


Good point.

Ok, I'll go ahead and put this one in linux-next for now. Assuming there
are no problems, it should make v5.13.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>

