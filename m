Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 616EDBC534
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 11:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395409AbfIXJuw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 05:50:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35516 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392592AbfIXJuw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 05:50:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id a24so1032154pgj.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2019 02:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KP3ygMAQcqcQDcZ3quRP4RvDD/ax05m9chGvKN8GjEQ=;
        b=xmqgf7fILmOdgiQ9igMqtMEnqctaqr/9aMHQ0wp7vIdNvUKJVnxoaozQFyzLJyw1tC
         uwcCaSZQfISmursWWKqtlUZ6o7ZmN7y9vixTVfvPfXLKCMvSLAVKc108vGf/lTQwNNvG
         QRI0X4bsg4kwsbQdWhpViXa9soQBVpLOPHK1TIwJqbmhAxqS8Bsu41qTkpIpiS9PrGv5
         KCo/2liK3fZIjG97bK1VELtR/90yzELlKDwO1lBNDC/0bzP7JPKtMuSOFTYxxXXU7ifI
         z7LMmBk/dMslzXnDZQ9XqdBuIZHesjCAvH1kj2lHRt8bLjKMaeh8RpbTNs2CRUdaxYRH
         HjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KP3ygMAQcqcQDcZ3quRP4RvDD/ax05m9chGvKN8GjEQ=;
        b=KLRhH8SKvCyX+1EkpHU9QIBVG61QPEURly5wu3hJ2bm/nPyYm105KZ4wKtsmYZjK2l
         m+NazRvJHvD2Pp6yQ+41EcvY/SOLSR7DbjfaxR+SVzIIEObBWpM+u4ttO7XrKyAiNhNU
         EFJBaRIDzgmrUQ5YhZFoxubxJoSZWFe1x0c2gIfzcR4rSOjUeaTZPGbjUzbTF0nopa4z
         wkZhMCQ0mG5oKgsc40+6KGUyofMCKR0zKL6eLGGa2Va97E92EGNWZlAQXPMKyF+91YK0
         9jDbSUmdDkw4LWk7b0X443unRqVSKgHSEhCZOw663PSJ7r0ZesloDIr/5bpee/mri85g
         s7cQ==
X-Gm-Message-State: APjAAAXD1rWhIQ3p4gTO45urv/xuYeCsJIspNZizF6DqT4nMnR8ga7st
        eAIoS5HWKRH7TLiV1TSqj+cb
X-Google-Smtp-Source: APXvYqwya17V2dVgrStvbblc/AFj+boI86h/Bo1/1YRsbCxn+e4U1i0ffv7gJVc9fmQGnnMt12euNA==
X-Received: by 2002:a62:7883:: with SMTP id t125mr2426174pfc.204.1569318651092;
        Tue, 24 Sep 2019 02:50:51 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id q13sm4952434pjq.0.2019.09.24.02.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 02:50:50 -0700 (PDT)
Date:   Tue, 24 Sep 2019 19:50:44 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: Re: [PATCH v3 2/6] ext4: move inode extension/truncate code out from
 ext4_iomap_end()
Message-ID: <20190924095044.GB17526@bobrowski>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <784214745d589dd2bdcde2d69a69e837e6980592.1568282664.git.mbobrowski@mbobrowski.org>
 <20190923162115.GG20367@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923162115.GG20367@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 23, 2019 at 06:21:15PM +0200, Jan Kara wrote:
> On Thu 12-09-19 21:04:00, Matthew Bobrowski wrote:
> > @@ -233,12 +234,90 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
> >  	return iov_iter_count(from);
> >  }
> >  
> > +static int ext4_handle_inode_extension(struct inode *inode, loff_t offset,
> > +				       ssize_t len, size_t count)
> 
> Traditionally, we call one of the length arguments 'copied' or 'written' to
> denote actual amount of data processed and the original length is called
> 'len' or 'length' in iomap code. Can you please rename the arguments to
> follow this convention?

Sure, I will go with 'written'.

> > +/*
> > + * The inode may have been placed onto the orphan list or has had
> > + * blocks allocated beyond EOF as a result of an extension. We need to
> > + * ensure that any necessary cleanup routines are performed if the
> > + * error path has been taken for a write.
> > + */
> > +static int ext4_handle_failed_inode_extension(struct inode *inode, loff_t size)
> > +{
> > +	handle_t *handle;
> > +
> > +	if (size > i_size_read(inode))
> > +		ext4_truncate_failed_write(inode);
> > +
> > +	if (!list_empty(&EXT4_I(inode)->i_orphan)) {
> > +		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> > +		if (IS_ERR(handle)) {
> > +			if (inode->i_nlink)
> > +				ext4_orphan_del(NULL, inode);
> > +			return PTR_ERR(handle);
> > +		}
> > +		if (inode->i_nlink)
> > +			ext4_orphan_del(handle, inode);
> > +		ext4_journal_stop(handle);
> > +	}
> > +	return 0;
> > +}
> > +
> 
> After some thought, I'd just drop this function and fold the functionality
> into ext4_handle_inode_extension() by making it accept negative 'len'
> argument indicating error. The code just happens to be the simplest in that
> case (see below).
> 
> > @@ -255,7 +334,18 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >  	if (ret)
> >  		goto out;
> >  
> > +	offset = iocb->ki_pos;
> >  	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
> > +	if (ret > 0 && iocb->ki_pos > i_size_read(inode))
> > +		error = ext4_handle_inode_extension(inode, offset, ret,
> > +						    iov_iter_count(from));
> 
> You need to sample iov_iter_count(from) before calling dax_iomap_rw(). At
> this point iov_iter_count(from) is just what's left in the iter after
> writing what we could.
> 
> Also I don't think the condition iocb->ki_pos > i_size_read(inode) is
> correct here. Because it may happen that offset + count > i_size so we
> allocate some blocks beyond i_size but then we manage to copy only less so
> offset + ret == iocb->ki_pos <= i_size and you will not call
> ext4_handle_inode_extension() to truncate allocated blocks beyond i_size.

Yeah, this makes sense. I will implement it this way. Once again, appreciate
your suggestions.
 
> So I'd just call ext4_handle_inode_extension() unconditionally like:
> 
> 	error = ext4_handle_inode_extension(inode, offset, ret, len);
> 
> and have a quick check at the beginning of that function to avoid starting
> transaction when there isn't anything to do. Something like:
> 
> 	/*
> 	 * DIO and DAX writes get exclusion from truncate (i_rwsem) and
> 	 * page writeback (i_rwsem and flushing all dirty pages).
> 	 */
> 	WARN_ON_ONCE(i_size_read(inode) != EXT4_I(inode)->i_disksize);
> 	if (offset + count <= i_size_read(inode))
> 		return 0;
> 	if (len < 0)
> 		goto truncate;
> 
> 	... do the heavylifting with transaction start, inode size update,
> 	and orphan handling...
> 
> 	if (truncate) {
> truncate:
> 		ext4_truncate_failed_write(inode);
> orphan_del:
> 		/*
> 		 * If the truncate operation failed early the inode
> 		 * may still be on the orphan list. In that case, we
> 		 * need try remove the inode from the linked list in
> 		 * memory.
> 		 */
> 		if (inode->i_nlink)
> 			ext4_orphan_del(NULL, inode);
> 	}

--<M>--
