Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5725B1A32FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 13:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgDILNv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 07:13:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58578 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgDILNv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 07:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xgyWc+C/Qvem1xN46K0M+TXREhrtdXsS/uhgmGa+3jM=; b=jjvxviOXcyBrG6JwwfxfZwe7xT
        Ik8ZyMKifZ8WTpskcuJ/WnuV7KEwb/C5vMBCBuC5Hel8gg3DlG/Nht0nScPXcAXY09rwAPt0IIxjn
        1jEA0G64q/arbTFe2kXMcUZUnfg2rModYe1wk5YwM7EsCVKpHyCFHA5n40IhAQ/KMjlJBE4aZtM5A
        BuCNRJoB12j192H+P2a5rPfHTTIp0K9LzKGCn+QEnW/6iaT6srapUTZbn/t8e5S8u3rHhdnoAnC6n
        0chBDiXZsYY6ZeffnDYju5EMJn6tqlMv92nRjkeoN/gQw/35I5OqYBAxiLbLJXKn8bjIAI6hW8ZPp
        WmUZlqKg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMV80-00086M-UF; Thu, 09 Apr 2020 11:13:48 +0000
Date:   Thu, 9 Apr 2020 04:13:48 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc/mounts: add cursor
Message-ID: <20200409111348.GR21484@bombadil.infradead.org>
References: <20200409091858.GE28467@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409091858.GE28467@miu.piliscsaba.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 09, 2020 at 11:18:58AM +0200, Miklos Szeredi wrote:
> @@ -1249,31 +1277,48 @@ struct vfsmount *mnt_clone_internal(cons
>  static void *m_start(struct seq_file *m, loff_t *pos)
>  {
>  	struct proc_mounts *p = m->private;
> +	struct mount *mnt;
>  
>  	down_read(&namespace_sem);
> -	if (p->cached_event == p->ns->event) {
> -		void *v = p->cached_mount;
> -		if (*pos == p->cached_index)
> -			return v;
> -		if (*pos == p->cached_index + 1) {
> -			v = seq_list_next(v, &p->ns->list, &p->cached_index);
> -			return p->cached_mount = v;
> +	lock_ns_list(p->ns);
> +	if (!*pos) {
> +		list_move(&p->cursor.mnt_list, &p->ns->list);
> +		p->cursor_pos = 0;
> +	} else if (p->cursor_pos != *pos) {
> +		/* Non-zero seek.  Could probably just return -ESPIPE... */

Umm, that's not how calling seek() on a seqfile works.  I don't think
you can hit this case.  Follow seq_lseek() as it calls traverse().

