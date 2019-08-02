Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 039D07FB90
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 15:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbfHBNwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 09:52:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54089 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfHBNwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:52:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so68070948wmj.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Aug 2019 06:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=4iCSxAIvBlYJIgaeJMhcomVXIi5YkwMuPk2gt2B09vc=;
        b=AJ47VfjGrUy5n7ym47TpXvaCBbeE6sem4qojJGKYOTIUF7VGfZrhlEsn+0250akxuh
         ebju1XiCEVrQqEHrEyW/jm0MNLeoL34pxoJQ98sqmLto/YjKTV7jSHb9hLbURtAlByTf
         ujuPaPeD4HsnfvWL+sZBnmG3zHxYuM7TJyZqqScKEzQdU4/S8dNof6MTNz+MH1m37zDh
         mK5M0gTdEKOggjFmcCMjUhbjVGV3pqJk4jLZJiUEk54caUJVx/AvnDXsLIGGhhCXfvm/
         m4TUfRLm3MW/8mp8nVEfJn0DDyXdsJJ/T/0h3wIASGauE3DaWOx/KhF1pw+aCD6aKz7A
         pdPA==
X-Gm-Message-State: APjAAAWNC7znr7q4vwFZx43tV1qO85mYUdaxW1RCi/6dJoR+2yxB6+/s
        PHTYoPSLYw+j9iYFBakMR1+acMTwg6q8QQ==
X-Google-Smtp-Source: APXvYqw36dF2C614V4ttPwrsggR751z+7YFbOp9AlwCIaO15VXBKbUJ41TFEtOl97bIW35+IZzb91w==
X-Received: by 2002:a7b:c4c1:: with SMTP id g1mr4867520wmk.14.1564753956850;
        Fri, 02 Aug 2019 06:52:36 -0700 (PDT)
Received: from pegasus.maiolino.io (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id 4sm174537720wro.78.2019.08.02.06.52.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 06:52:36 -0700 (PDT)
Date:   Fri, 2 Aug 2019 15:52:34 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 8/9] Use FIEMAP for FIBMAP calls
Message-ID: <20190802135233.rkwsgwfp6n5pj457@pegasus.maiolino.io>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-9-cmaiolino@redhat.com>
 <20190731232254.GW1561054@magnolia>
 <20190731233133.GB1561054@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731233133.GB1561054@magnolia>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > > index b485190b7ecd..18a798e9076b 100644
> > > --- a/fs/xfs/xfs_iops.c
> > > +++ b/fs/xfs/xfs_iops.c
> > > @@ -1113,6 +1113,11 @@ xfs_vn_fiemap(
> > >  	struct fiemap_extent_info *fieinfo)
> > >  {
> > >  	int	error;
> > > +	struct	xfs_inode	*ip = XFS_I(inode);
> > 
> > Would you mind fixing the indentation to match usual xfs style?
> > 
> > > +
> > > +	if (fieinfo->fi_flags & FIEMAP_KERNEL_FIBMAP)
> > > +		if (xfs_is_reflink_inode(ip) || XFS_IS_REALTIME_INODE(ip))
> > > +			return -EINVAL;
> > 
> > The xfs part looks ok to me.
> 
> No it doesn't.  This check ought to be xfs_is_cow_inode() to match the
> code being removed in the last patch:
> 
> if ((fieinfo->fi_flags & FIEMAP_KERNEL_FIBMAP) &&
>     (xfs_is_cow_inode(ip) || XFS_IS_REALTIME_INODE(ip)))
> 	return -EINVAL;
> 

Agreed, will fix

> > --D
> > 

-- 
Carlos
