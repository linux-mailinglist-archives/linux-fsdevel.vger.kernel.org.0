Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6CF0815A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 11:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfHEJkX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 05:40:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46972 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfHEJkX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:40:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so83687053wru.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2019 02:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=9n8TC1iXml/++w4AmWIXNjrxlyXyHgk1bMp3unb0bXc=;
        b=seaIG0TxSJyXZKHPSDhvUCUlzAXizEYyLk0Ag3dgImAAWspJXAFvPNsglbRIWRkv3N
         bIcdZ1NRAmDYRghQTqzAViB3tY8YspyvvH3AfMu1KpFGpwN0grqEOAKhFcOaJdF3i8jy
         +Yu+w4a8v6Jtg7pzNIBJAZkXdKmPc8jgj4QghDOSdyuiTDnpkqkQp34IldhHpn11+uY3
         aLCD50/Y4QrWTaBEejNNwns9ktLpjJQzsY/xvL7lWLrPnnCM5jnYCChxEHnAsa7ylmEl
         +3E0VcUMRVlsod0WvlwA5OyauXjRexrYX4tfzFNp3TjgV/ID5H6Hsj4wi4q3jOw7d8qa
         kXGw==
X-Gm-Message-State: APjAAAWzLL0mWAqEYpABzl9k++r9BzF71GkleZZzq07XbG8hH1xj8nwc
        BjL8u6RvY5SzlDin3ozYRSPfbw==
X-Google-Smtp-Source: APXvYqxBpvy02ufmtDCUsesCWncLQzj3mdvdDT4pdKH6hPhIxDjdRcpRcI6VOEqPaKfZegchYWT+zw==
X-Received: by 2002:adf:edd1:: with SMTP id v17mr76724414wro.348.1564998021012;
        Mon, 05 Aug 2019 02:40:21 -0700 (PDT)
Received: from pegasus.maiolino.io (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id d16sm76768049wrv.55.2019.08.05.02.40.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 02:40:20 -0700 (PDT)
Date:   Mon, 5 Aug 2019 11:40:18 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/9] fs: Move start and length fiemap fields into
 fiemap_extent_info
Message-ID: <20190805094017.3tcskxxpssjolfmg@pegasus.maiolino.io>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-6-cmaiolino@redhat.com>
 <20190731232837.GZ1561054@magnolia>
 <20190802095115.bjz6ejbouif3wkbt@pegasus.maiolino.io>
 <20190802151519.GH7138@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802151519.GH7138@magnolia>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 08:15:19AM -0700, Darrick J. Wong wrote:
> On Fri, Aug 02, 2019 at 11:51:16AM +0200, Carlos Maiolino wrote:
> > > >  
> > > >  STATIC int
> > > >  xfs_vn_fiemap(
> > > > -	struct inode		*inode,
> > > > -	struct fiemap_extent_info *fieinfo,
> > > > -	u64			start,
> > > > -	u64			length)
> > > > +	struct inode		  *inode,
> > > > +	struct fiemap_extent_info *fieinfo)
> > > >  {
> > > > -	int			error;
> > > > +	u64	start = fieinfo->fi_start;
> > > > +	u64	length = fieinfo->fi_len;
> > > > +	int	error;
> > > 
> > > Would be nice if the variable name indentation was consistent here, but
> > > otherwise the xfs part looks ok.
> > 
> > These fields are removed on the next patch, updating it is really required?
> 
> Yes, please.

NP then

> > > > +	u64		fi_start;
> > > > +	u64		fi_len;
> > > 
> > > Comments for these two new fields?
> > 
> > Sure, how about this:
> > 
> >        u64           fi_start;            /* Logical offset at which
> >                                              start mapping */
> >        u64           fi_len;              /* Logical length of mapping
> >                                              the caller cares about */
> > 
> > 
> > btw, Above indentation won't match final result
> 
> Looks good to me.

Will update the fields, thanks for the review

> 
> > 
> > Christoph, may I keep your reviewed tag by updating the comments as above?
> > Otherwise I'll just remove your tag
> > 
> > > 
> > > --D
> > > 
> > > > +	unsigned int	fi_extents_mapped;	/* Number of mapped extents */
> > > > +	unsigned int	fi_extents_max;		/* Size of fiemap_extent array */
> > > > +	struct		fiemap_extent __user *fi_extents_start;	/* Start of
> > > > +								   fiemap_extent
> > > > +								   array */
> > > >  };
> > > >  int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
> > > >  			    u64 phys, u64 len, u32 flags);
> > > > @@ -1841,8 +1844,7 @@ struct inode_operations {
> > > >  	int (*setattr) (struct dentry *, struct iattr *);
> > > >  	int (*getattr) (const struct path *, struct kstat *, u32, unsigned int);
> > > >  	ssize_t (*listxattr) (struct dentry *, char *, size_t);
> > > > -	int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start,
> > > > -		      u64 len);
> > > > +	int (*fiemap)(struct inode *, struct fiemap_extent_info *);
> > > >  	int (*update_time)(struct inode *, struct timespec64 *, int);
> > > >  	int (*atomic_open)(struct inode *, struct dentry *,
> > > >  			   struct file *, unsigned open_flag,
> > > > @@ -3199,11 +3201,10 @@ extern int vfs_readlink(struct dentry *, char __user *, int);
> > > >  
> > > >  extern int __generic_block_fiemap(struct inode *inode,
> > > >  				  struct fiemap_extent_info *fieinfo,
> > > > -				  loff_t start, loff_t len,
> > > >  				  get_block_t *get_block);
> > > >  extern int generic_block_fiemap(struct inode *inode,
> > > > -				struct fiemap_extent_info *fieinfo, u64 start,
> > > > -				u64 len, get_block_t *get_block);
> > > > +				struct fiemap_extent_info *fieinfo,
> > > > +				get_block_t *get_block);
> > > >  
> > > >  extern struct file_system_type *get_filesystem(struct file_system_type *fs);
> > > >  extern void put_filesystem(struct file_system_type *fs);
> > > > -- 
> > > > 2.20.1
> > > > 
> > 
> > -- 
> > Carlos

-- 
Carlos
