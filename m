Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5FE1A4233
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 07:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgDJFPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 01:15:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59386 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgDJFPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 01:15:00 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMm0H-00Flag-Ro; Fri, 10 Apr 2020 05:14:57 +0000
Date:   Fri, 10 Apr 2020 06:14:57 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Karel Zak <kzak@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] proc/mounts: add cursor
Message-ID: <20200410051457.GI23230@ZenIV.linux.org.uk>
References: <20200410050522.GI28467@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410050522.GI28467@miu.piliscsaba.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 10, 2020 at 07:05:22AM +0200, Miklos Szeredi wrote:
> +	/* read after we'd reached the end? */
> +	if (*pos && list_empty(&mnt->mnt_list))
> +		return NULL;
> +
> +	lock_ns_list(p->ns);
> +	if (!*pos)
> +		mnt = list_first_entry(&p->ns->list, typeof(*mnt), mnt_list);
> +	mnt = mnt_skip_cursors(p->ns, mnt);
> +	unlock_ns_list(p->ns);
>  
> -	p->cached_event = p->ns->event;
> -	p->cached_mount = seq_list_start(&p->ns->list, *pos);
> -	p->cached_index = *pos;
> -	return p->cached_mount;
> +	return mnt;
>  }

Hmm...  I wonder if it would be better to do something like
	if (!*pos)
		prev = &p->ns->list.next;
	else
		prev = &p->mnt.mnt_list.next;
	mnt = mnt_skip_cursors(p->ns, prev);

>  static void *m_next(struct seq_file *m, void *v, loff_t *pos)
>  {
>  	struct proc_mounts *p = m->private;
> +	struct mount *mnt = v;
> +
> +	lock_ns_list(p->ns);
> +	mnt = mnt_skip_cursors(p->ns, list_next_entry(mnt, mnt_list));

... and mnt = mnt_skip_cursors(p->ns, &mnt->mnt_list.next);
