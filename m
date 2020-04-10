Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 382561A3DA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 03:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDJBLW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 21:11:22 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56798 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgDJBLW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 21:11:22 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMiCV-00FcYm-1b; Fri, 10 Apr 2020 01:11:19 +0000
Date:   Fri, 10 Apr 2020 02:11:19 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Karel Zak <kzak@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] proc/mounts: add cursor
Message-ID: <20200410011119.GH23230@ZenIV.linux.org.uk>
References: <20200409212214.GG28467@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409212214.GG28467@miu.piliscsaba.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 09, 2020 at 11:22:14PM +0200, Miklos Szeredi wrote:

> @@ -1249,42 +1277,50 @@ struct vfsmount *mnt_clone_internal(cons
>  static void *m_start(struct seq_file *m, loff_t *pos)
>  {
>  	struct proc_mounts *p = m->private;
> +	struct mount *mnt = NULL;
>  
>  	down_read(&namespace_sem);
> -	if (p->cached_event == p->ns->event) {
> -		void *v = p->cached_mount;
> -		if (*pos == p->cached_index)
> -			return v;
> -		if (*pos == p->cached_index + 1) {
> -			v = seq_list_next(v, &p->ns->list, &p->cached_index);
> -			return p->cached_mount = v;
> -		}
> -	}
> +	lock_ns_list(p->ns);
> +	if (!*pos)
> +		list_move(&p->cursor.mnt_list, &p->ns->list);
> +	if (!list_empty(&p->cursor.mnt_list))
> +		mnt = mnt_skip_cursors(p->ns, &p->cursor);
> +	unlock_ns_list(p->ns);

Huh?  What's that if (!list_empty()) about?  The case where we have reached
the end of list, then did a read() with an lseek() in between?

If so, then this is out of place under your spinlock; "is on the list"
state changes only synchronously (seq_file ->lock serializes all of
that).  *If* this is what you've meant, I'd suggest
	/* read after we'd reached the end? */
	if (*pos && list_empty(...))
		return NULL;
	lock_ns_list(p->ns);
	if (!*pos)
		list_move(...); /* rewind on lseek or initial read */
	mnt = mnt_skip_cursors(...);
	unlock_ns_list(p->ns);

Or am I misreading your intent there?  Confused...
