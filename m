Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2762E0D66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 17:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgLVQa6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 11:30:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38953 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727867AbgLVQa6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 11:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608654572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=330C06jTiNvB+VfbF+h/kv6HlOA3dmvIyjYI7GiU5SU=;
        b=TLofyIZm6JKSWWbRsqvBMwvQz/E4HULuJBr72oRJXAxeYIfnwz7ikyo+ZhkNW+RuLtHB5w
        t5UBP+SYI0z7mJ6fiR+W73rUTr+Zn/9Pk3oZRegvbIACJzLeW1qeF+H+015rm1+avjRzCj
        F8J50Unifjm16ikoFZqGQ7/1elqz3mw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-E2dyRNjlNGyH2nTvvLTtRg-1; Tue, 22 Dec 2020 11:29:28 -0500
X-MC-Unique: E2dyRNjlNGyH2nTvvLTtRg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E919D107ACF5;
        Tue, 22 Dec 2020 16:29:25 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-207.rdu2.redhat.com [10.10.114.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4F365D9CC;
        Tue, 22 Dec 2020 16:29:25 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 39A65220BCF; Tue, 22 Dec 2020 11:29:25 -0500 (EST)
Date:   Tue, 22 Dec 2020 11:29:25 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, jlayton@kernel.org,
        amir73il@gmail.com, sargun@sargun.me, miklos@szeredi.hu,
        jack@suse.cz, neilb@suse.com, viro@zeniv.linux.org.uk, hch@lst.de
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
Message-ID: <20201222162925.GC3248@redhat.com>
References: <20201221195055.35295-1-vgoyal@redhat.com>
 <20201221195055.35295-4-vgoyal@redhat.com>
 <20201222162027.GJ874@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222162027.GJ874@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 22, 2020 at 04:20:27PM +0000, Matthew Wilcox wrote:
> On Mon, Dec 21, 2020 at 02:50:55PM -0500, Vivek Goyal wrote:
> > +static int ovl_errseq_check_advance(struct super_block *sb, struct file *file)
> > +{
> > +	struct ovl_fs *ofs = sb->s_fs_info;
> > +	struct super_block *upper_sb;
> > +	int ret;
> > +
> > +	if (!ovl_upper_mnt(ofs))
> > +		return 0;
> > +
> > +	upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
> > +
> > +	if (!errseq_check(&upper_sb->s_wb_err, file->f_sb_err))
> > +		return 0;
> > +
> > +	/* Something changed, must use slow path */
> > +	spin_lock(&file->f_lock);
> > +	ret = errseq_check_and_advance(&upper_sb->s_wb_err, &file->f_sb_err);
> > +	spin_unlock(&file->f_lock);
> 
> Why are you microoptimising syncfs()?  Are there really applications which
> call syncfs() in a massively parallel manner on the same file descriptor?

This is atleast theoritical race. I am not aware which application can
trigger this race. So to me it makes sense to fix the race.

Jeff Layton also posted a fix for syncfs().

https://lore.kernel.org/linux-fsdevel/20201219134804.20034-1-jlayton@kernel.org/

To me it makes sense to fix the race irrespective of the fact if somebody
hit it or not. People end up copying code in other parts of kernel and
and they will atleast copy race free code.

Vivek

