Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31D12E9E48
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 20:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbhADTn2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 14:43:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34569 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbhADTn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 14:43:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609789321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DFTJFha9FhyF/9pADUAkOyw1Behx7NK51FU77ZYVlXE=;
        b=D56Y5HjUpc2FfFfUE3thqJ5AZfEB4Dm1wthPNj7sgFGew4LknEiZN8B1bFisxW5atLPCiK
        yr4v5M4319zYft2HhQpKGwOQ7cFKuMwAVTfQkUpNhX10ksQmGj04roSSzh6/zwatJFj/B3
        elfOAwrI5wT/zC7am8oL7+czjm775tg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-q9QmwUIhOxaGnByj1D9pVA-1; Mon, 04 Jan 2021 14:41:58 -0500
X-MC-Unique: q9QmwUIhOxaGnByj1D9pVA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F4B510054FF;
        Mon,  4 Jan 2021 19:41:56 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-2.rdu2.redhat.com [10.10.115.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E59755D765;
        Mon,  4 Jan 2021 19:41:55 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 6EAA9220BCF; Mon,  4 Jan 2021 14:41:55 -0500 (EST)
Date:   Mon, 4 Jan 2021 14:41:55 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, amir73il@gmail.com,
        sargun@sargun.me, miklos@szeredi.hu, willy@infradead.org,
        jack@suse.cz, neilb@suse.com, viro@zeniv.linux.org.uk, hch@lst.de
Subject: Re: [PATCH 2/3] vfs: Add a super block operation to check for
 writeback errors
Message-ID: <20210104194155.GE63879@redhat.com>
References: <20201221195055.35295-1-vgoyal@redhat.com>
 <20201221195055.35295-3-vgoyal@redhat.com>
 <3b488048b666f22108e7660eb32e10860a75784a.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b488048b666f22108e7660eb32e10860a75784a.camel@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 23, 2020 at 07:48:52AM -0500, Jeff Layton wrote:
> On Mon, 2020-12-21 at 14:50 -0500, Vivek Goyal wrote:
> > Right now we check for errors on super block in syncfs().
> > 
> > ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
> > 
> > overlayfs does not update sb->s_wb_err and it is tracked on upper filesystem.
> > So provide a superblock operation to check errors so that filesystem
> > can provide override generic method and provide its own method to
> > check for writeback errors.
> > 
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/sync.c          | 5 ++++-
> >  include/linux/fs.h | 1 +
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/sync.c b/fs/sync.c
> > index b5fb83a734cd..57e43a16dfca 100644
> > --- a/fs/sync.c
> > +++ b/fs/sync.c
> > @@ -176,7 +176,10 @@ SYSCALL_DEFINE1(syncfs, int, fd)
> >  	ret = sync_filesystem(sb);
> >  	up_read(&sb->s_umount);
> >  
> > 
> > -	ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
> > +	if (sb->s_op->errseq_check_advance)
> > +		ret2 = sb->s_op->errseq_check_advance(sb, f.file);
> > +	else
> > +		ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
> >  
> > 
> >  	fdput(f);
> >  	return ret ? ret : ret2;
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 8667d0cdc71e..4297b6127adf 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1965,6 +1965,7 @@ struct super_operations {
> >  				  struct shrink_control *);
> >  	long (*free_cached_objects)(struct super_block *,
> >  				    struct shrink_control *);
> > +	int (*errseq_check_advance)(struct super_block *, struct file *);
> >  };
> >  
> > 
> >  /*
> 
> Also, the other super_operations generally don't take a superblock
> pointer when you pass in a different fs object pointer. This should
> probably just take a struct file * and then the operation can chase
> pointers to the superblock from there.

Ok, I will drop super_block * argument and just pass in "struct file *".

Vivek

>  
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

