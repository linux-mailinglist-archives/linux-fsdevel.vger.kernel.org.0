Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3AC2E0E04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 18:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgLVR4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 12:56:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727094AbgLVR4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 12:56:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608659725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r2se/Af1BmxrHuTv790CtQ4dQJwj2Jydor4De9zLCdc=;
        b=NrhJX8exodjAftIAeAd1FzE/H0vi6Zp2laVhuapVbSg5CtnVp2nRdfj6h7EzVmsjqpxMKF
        9di82Jwj9UyVZpOEnXqheQW3FYCro9RPfiBiH/sDt3P6LINFJDizMblcSglROtvFXhehUJ
        kn/AxgRvs/z+w7C3bVGfjhz4E0633FA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-J7FzT1AtNgu2cjBN8etUiA-1; Tue, 22 Dec 2020 12:55:21 -0500
X-MC-Unique: J7FzT1AtNgu2cjBN8etUiA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20E9A1005D4C;
        Tue, 22 Dec 2020 17:55:19 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-207.rdu2.redhat.com [10.10.114.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFBBE5D705;
        Tue, 22 Dec 2020 17:55:18 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 701D3220BCF; Tue, 22 Dec 2020 12:55:18 -0500 (EST)
Date:   Tue, 22 Dec 2020 12:55:18 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, jlayton@kernel.org,
        amir73il@gmail.com, sargun@sargun.me, miklos@szeredi.hu,
        jack@suse.cz, neilb@suse.com, viro@zeniv.linux.org.uk, hch@lst.de
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
Message-ID: <20201222175518.GD3248@redhat.com>
References: <20201221195055.35295-1-vgoyal@redhat.com>
 <20201221195055.35295-4-vgoyal@redhat.com>
 <20201222162027.GJ874@casper.infradead.org>
 <20201222162925.GC3248@redhat.com>
 <20201222174637.GK874@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222174637.GK874@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 22, 2020 at 05:46:37PM +0000, Matthew Wilcox wrote:
> On Tue, Dec 22, 2020 at 11:29:25AM -0500, Vivek Goyal wrote:
> > On Tue, Dec 22, 2020 at 04:20:27PM +0000, Matthew Wilcox wrote:
> > > On Mon, Dec 21, 2020 at 02:50:55PM -0500, Vivek Goyal wrote:
> > > > +static int ovl_errseq_check_advance(struct super_block *sb, struct file *file)
> > > > +{
> > > > +	struct ovl_fs *ofs = sb->s_fs_info;
> > > > +	struct super_block *upper_sb;
> > > > +	int ret;
> > > > +
> > > > +	if (!ovl_upper_mnt(ofs))
> > > > +		return 0;
> > > > +
> > > > +	upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
> > > > +
> > > > +	if (!errseq_check(&upper_sb->s_wb_err, file->f_sb_err))
> > > > +		return 0;
> > > > +
> > > > +	/* Something changed, must use slow path */
> > > > +	spin_lock(&file->f_lock);
> > > > +	ret = errseq_check_and_advance(&upper_sb->s_wb_err, &file->f_sb_err);
> > > > +	spin_unlock(&file->f_lock);
> > > 
> > > Why are you microoptimising syncfs()?  Are there really applications which
> > > call syncfs() in a massively parallel manner on the same file descriptor?
> > 
> > This is atleast theoritical race. I am not aware which application can
> > trigger this race. So to me it makes sense to fix the race.
> > 
> > Jeff Layton also posted a fix for syncfs().
> > 
> > https://lore.kernel.org/linux-fsdevel/20201219134804.20034-1-jlayton@kernel.org/
> > 
> > To me it makes sense to fix the race irrespective of the fact if somebody
> > hit it or not. People end up copying code in other parts of kernel and
> > and they will atleast copy race free code.
> 
> Let me try again.  "Why are you trying to avoid taking the spinlock?"

Aha.., sorry, I misunderstood your question. I don't have a good answer.
I just copied the code from Jeff Layton's patch.

Agreed that cost of taking spin lock will not be significant until
syncfs() is called at high frequency. Having said that, most of the
time taking spin lock will not be needed, so avoiding it with
a simple call to errseq_check() sounds reasonable too.

I don't have any strong opinions here. I am fine with any of the
implementation people like.

Vivek

