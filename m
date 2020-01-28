Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E201614BC76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 15:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgA1O6x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 09:58:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45070 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726735AbgA1O6w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580223532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J9dup7HkrusSVVs3WtrZZpcnlSHPtUcbtBH6WbbXS20=;
        b=J30K3AORJ3u894nARd8dIl1Z30S+r4Q/OamxYtefkwp+hkTdfx4+9EZLUGAX0FGGjgvTdp
        p3dVKHZIYWQiu56NmsW+HJZcuZz1xMLSLUvXxen3u9qD24RmxhHGvNth9qq6AjjgqkCYBs
        8KZIF0F/gaXYoVo2IQfEHfgh8EgTqBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-qOK9YP5uP1yGI5aGU72MxA-1; Tue, 28 Jan 2020 09:58:47 -0500
X-MC-Unique: qOK9YP5uP1yGI5aGU72MxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 879C18010C9;
        Tue, 28 Jan 2020 14:58:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id A7FC85C290;
        Tue, 28 Jan 2020 14:58:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 28 Jan 2020 15:58:43 +0100 (CET)
Date:   Tue, 28 Jan 2020 15:58:38 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Solar Designer <solar@openwall.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v7 02/11] proc: add proc_fs_info struct to store proc
 information
Message-ID: <20200128145837.GD17943@redhat.com>
References: <20200125130541.450409-1-gladkov.alexey@gmail.com>
 <20200125130541.450409-3-gladkov.alexey@gmail.com>
 <20200128134337.GC17943@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128134337.GC17943@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/28, Oleg Nesterov wrote:
>
> On 01/25, Alexey Gladkov wrote:
> >
> >  static int proc_init_fs_context(struct fs_context *fc)
> >  {
> >  	struct proc_fs_context *ctx;
> > +	struct pid_namespace *pid_ns;
> >
> >  	ctx = kzalloc(sizeof(struct proc_fs_context), GFP_KERNEL);
> >  	if (!ctx)
> >  		return -ENOMEM;
> >
> > -	ctx->pid_ns = get_pid_ns(task_active_pid_ns(current));
> > +	pid_ns = get_pid_ns(task_active_pid_ns(current));
> > +
> > +	if (!pid_ns->proc_mnt) {
> > +		ctx->fs_info = kzalloc(sizeof(struct proc_fs_info), GFP_KERNEL);
> > +		if (!ctx->fs_info) {
> > +			kfree(ctx);
> > +			return -ENOMEM;
> > +		}
> > +		ctx->fs_info->pid_ns = pid_ns;
> > +	} else {
> > +		ctx->fs_info = proc_sb_info(pid_ns->proc_mnt->mnt_sb);
> > +	}
> > +
>
> it seems that this code lacks put_pid_ns() if pid_ns->proc_mnt != NULL
> or if kzalloc() fails?

OK, this is fixed in 6/11.

Oleg.

