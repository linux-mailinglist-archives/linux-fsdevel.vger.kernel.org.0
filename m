Return-Path: <linux-fsdevel+bounces-16934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D797F8A5269
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 15:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019661C21CB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 13:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5402B7351A;
	Mon, 15 Apr 2024 13:56:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FED1E896
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189394; cv=none; b=gtPlI9/uhU0GKoY3OSQKzfUdJIh1xJbfcM+/8CGE8v6BKlhPJUVUXVf+Yn0bB8DtVxZP4IqUrKrwD5zNj0fBcF46m7JY00Tkt7UTGvrB7cc14OuHKDUeIBHdLLznJQmpgLeKN1sIYDVRcPkFBo4zjfTWgDlkoPsII8g4/BSCmNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189394; c=relaxed/simple;
	bh=+VVV7sQD/TURqBaQ3o4+GnmR1SYFSqIiY2IQytgOeyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwS7mrk10ZrBX/XXSuIpYQSZ3bt9mukoTjSvMdnLnU4UC+r6qFm7kvDWQwGS/JStGaoHi1J87MyVKmbY5QXFHSSpGFvyZDGC7VV53i9Act8J7W8oGdfgWRu/1whyj8LsXz4JVP2pTBKK3TIUSVW82GC+1GIyT/VohClBzuQ2Cvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78d677dca70so245502785a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 06:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713189390; x=1713794190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8W/huyXe05bmHkZ7p3zhmV/PsnRvwctPQtMd0KsVdw=;
        b=eb6vPP6CAEqGpp0V+7O+EsInL09/s7beznlAJBjdDrkj4kpDJ8OpeheuciilqXWTxd
         BtCdMlcKiM+jPf+WLldQ337Faf/gXYf9h5Zb5/T3VGAAzxoPkav4U6J05XOsCfxEyzCO
         lS1EWGDaLwE3vmxNgDf6nxW38/OCo2WoFsKA6BcQh5XHEJ2dNT/R4HlRqrIpX2+iPhoH
         pIw3g3jDLHisur9wcheNFce0/AnNlAQqlWohzAm/KQkLOhspzKWsFh1upWO+pX0/Smol
         CrIwc1YMr745AqgKM5oE8rdE0znf666V6RkmiyQCCXUpKz9fs9YakwAe7opOxQVymEjG
         7Phg==
X-Forwarded-Encrypted: i=1; AJvYcCWMine7L5sdO4cbfVDXSJQYhPOhujbyLROdQ+XF8xU5vcxeyyHojel5D4H0S9tWXEW4hwO/DJONDGqGr/8Xegw36vZlsaWD/QFJtcbMTQ==
X-Gm-Message-State: AOJu0YyiLx04stJ80+7a3N8aV2KuiswcZAwJNXOUvC/Y9sfgicLF9qiy
	tpRDsQPU24ILG1VzyPd3ClbxNpoVq0c0/DQiRM7JYd9CT5Ac2H6vSv+HVZmKbSk=
X-Google-Smtp-Source: AGHT+IGyhwxIGf0/tZcTU4Qo6zY7NFezwol5Iq8ThT/YVXI3g8yDqaQ6a06haDbA8lDnpkm4O991xA==
X-Received: by 2002:ae9:f718:0:b0:78d:5f83:4f77 with SMTP id s24-20020ae9f718000000b0078d5f834f77mr10863669qkg.37.1713189390431;
        Mon, 15 Apr 2024 06:56:30 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id x10-20020ae9e90a000000b0078d6d22a0c3sm6383346qkf.90.2024.04.15.06.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:56:29 -0700 (PDT)
Date: Mon, 15 Apr 2024 09:56:28 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH v2 04/34] md: port block device access to file
Message-ID: <Zh0yDCvqO8rXcXpz@redhat.com>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-4-adbd023e19cc@kernel.org>
 <Zhzyu6pQYkSNgvuh@fedora>
 <20240415-haufen-demolieren-8c6da8159586@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415-haufen-demolieren-8c6da8159586@brauner>

On Mon, Apr 15 2024 at  8:35P -0400,
Christian Brauner <brauner@kernel.org> wrote:

> On Mon, Apr 15, 2024 at 05:26:19PM +0800, Ming Lei wrote:
> > Hello,
> > 
> > On Tue, Jan 23, 2024 at 02:26:21PM +0100, Christian Brauner wrote:
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >  drivers/md/dm.c               | 23 +++++++++++++----------
> > >  drivers/md/md.c               | 12 ++++++------
> > >  drivers/md/md.h               |  2 +-
> > >  include/linux/device-mapper.h |  2 +-
> > >  4 files changed, 21 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > > index 8dcabf84d866..87de5b5682ad 100644
> > > --- a/drivers/md/dm.c
> > > +++ b/drivers/md/dm.c
> > 
> > ...
> > 
> > > @@ -775,7 +778,7 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
> > >  {
> > >  	if (md->disk->slave_dir)
> > >  		bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
> > > -	bdev_release(td->dm_dev.bdev_handle);
> > > +	fput(td->dm_dev.bdev_file);
> > 
> > The above change caused regression on 'dmsetup remove_all'.
> > 
> > blkdev_release() is delayed because of fput(), so dm_lock_for_deletion
> > returns -EBUSY, then this dm disk is skipped in remove_all().
> > 
> > Force to mark DMF_DEFERRED_REMOVE might solve it, but need our device
> > mapper guys to check if it is safe.
> > 
> > Or other better solution?
> 
> Yeah, I think there is. You can just switch all fput() instances in
> device mapper to bdev_fput() which is mainline now. This will yield the
> device and make it able to be reclaimed. Should be as simple as the
> patch below. Could you test this and send a patch based on this (I'm on
> a prolonged vacation so I don't have time right now.):
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 56aa2a8b9d71..0f681a1e70af 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -765,7 +765,7 @@ static struct table_device *open_table_device(struct mapped_device *md,
>         return td;
> 
>  out_blkdev_put:
> -       fput(bdev_file);
> +       bdev_fput(bdev_file);
>  out_free_td:
>         kfree(td);
>         return ERR_PTR(r);
> @@ -778,7 +778,7 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
>  {
>         if (md->disk->slave_dir)
>                 bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
> -       fput(td->dm_dev.bdev_file);
> +       bdev_fput(td->dm_dev.bdev_file);
>         put_dax(td->dm_dev.dax_dev);
>         list_del(&td->list);
>         kfree(td);
> 
> 

Thanks. I'll work with Ming and others to take care of it. Have a great vacation!

