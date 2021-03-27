Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214E834BA33
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Mar 2021 00:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhC0XeG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Mar 2021 19:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhC0Xds (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Mar 2021 19:33:48 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216FEC0613B1;
        Sat, 27 Mar 2021 16:33:47 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lQIQz-000KUP-T2; Sat, 27 Mar 2021 23:33:38 +0000
Date:   Sat, 27 Mar 2021 23:33:37 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+283ce5a46486d6acdbaf@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in filp_close (2)
Message-ID: <YF/A0eZdQwi0/PJU@zeniv-ca.linux.org.uk>
References: <00000000000069c40405be6bdad4@google.com>
 <CACT4Y+baP24jKmj-trhF8bG_d_zkz8jN7L1kYBnUR=EAY6hOaA@mail.gmail.com>
 <20210326091207.5si6knxs7tn6rmod@wittgenstein>
 <CACT4Y+atQdf_fe3BPFRGVCzT1Ba3V_XjAo6XsRciL8nwt4wasw@mail.gmail.com>
 <CAHrFyr7iUpMh4sicxrMWwaUHKteU=qHt-1O-3hojAAX3d5879Q@mail.gmail.com>
 <20210326135011.wscs4pxal7vvsmmw@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326135011.wscs4pxal7vvsmmw@wittgenstein>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 26, 2021 at 02:50:11PM +0100, Christian Brauner wrote:
> @@ -632,6 +632,7 @@ EXPORT_SYMBOL(close_fd); /* for ksys_close() */
>  static inline void __range_cloexec(struct files_struct *cur_fds,
>  				   unsigned int fd, unsigned int max_fd)
>  {
> +	unsigned int cur_max;
>  	struct fdtable *fdt;
>  
>  	if (fd > max_fd)
> @@ -639,7 +640,12 @@ static inline void __range_cloexec(struct files_struct *cur_fds,
>  
>  	spin_lock(&cur_fds->file_lock);
>  	fdt = files_fdtable(cur_fds);
> -	bitmap_set(fdt->close_on_exec, fd, max_fd - fd + 1);
> +	/* make very sure we're using the correct maximum value */
> +	cur_max = fdt->max_fds;
> +	cur_max--;
> +	cur_max = min(max_fd, cur_max);
> +	if (fd <= cur_max)
> +		bitmap_set(fdt->close_on_exec, fd, cur_max - fd + 1);
>  	spin_unlock(&cur_fds->file_lock);
>  }

Umm...  That's harder to follow than it ought to be.  What's the point of
having
        max_fd = min(max_fd, cur_max);
done in the caller, anyway?  Note that in __range_close() you have to
compare with re-fetched ->max_fds (look at pick_file()), so...

BTW, I really wonder if the cost of jerking ->file_lock up and down
in that loop in __range_close() is negligible.  What values do we
typically get from callers and how sparse does descriptor table tend
to be for those?
