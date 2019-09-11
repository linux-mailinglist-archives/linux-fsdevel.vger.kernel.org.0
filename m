Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3ECEAFCE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 14:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfIKMjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 08:39:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40007 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfIKMjN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 08:39:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so11470587pgj.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2019 05:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4lHFBU6SXujhDxpzZ6crK+hUiX4HRVXLWKbkqR+joTI=;
        b=kVN8OiBAsSmlrWar2he0qz0DqTHGBP7me9DfkTJqqXsWQYfVMzkJB8z//7GYjH36VX
         ytymYi4yAqZbXKAnBN9qzdMvdOei1yEz46mxPmcd0cPFUYK/PLAyj7lVLjWjO3m7wV2a
         Jo5T59JQCTDHCooQGlHisbUKVFottsuJnc289BoFfUS1bKe3N1n97Gs2Qb7byum9UCJr
         fhAuqWHigxgo4BZrhxKo7OfoAL6PenIGjFdvHbPmMxEG/2kuaqkXw1YpWLwAVqvJsHX6
         huM4xuQj24YsIR/4G0MCmUSphCoofCx98RrRiFJ4sB/zCDEQOTxHpOmQ6tdwWpmMhCho
         qBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4lHFBU6SXujhDxpzZ6crK+hUiX4HRVXLWKbkqR+joTI=;
        b=dhW5LtlO7HFBZ7RC44hjeBLbwCLAmkpSQL9hytCBdoLmovpOCWXlUfBiIcYh3rrJOJ
         Q7JHEDJJjbhSd0aXFwFuK3FAgA2HFNr2IQhUThUIVNuCSa6/R3TTucCiYNaXomoa/mSE
         korfQrgtu9Ir4JxL1f8TkE9RYasbnhSovkbKgMg3caqr4Ilc1AptJx43FHCbpCjOQW1W
         /8vP036hzV7cxS89sjlrE/oINGcD0fcZV24FGj2LG5JUcAelN9E5ntJqbjZyCk0kGCXb
         mMdIEeCTopsqIskk0zKSG5Mmvua6HsxD9k6hUsbDhQrAiaw5iKLo0tOkK3dms9eEVmLZ
         nvng==
X-Gm-Message-State: APjAAAVmrWz5zyttlpFQJ3hwMQDLQub29a1hV41axR4Sm4RhvycCxp6+
        V1S9CWaNCjrBA8hiTTSLtj3K
X-Google-Smtp-Source: APXvYqw/FDFJ2NyPG5lJ2GxCXJJTDu7p8HKQSNqflvKQfD5rw2hETsgwAaDhCRw08KBVqp9yFoy+3g==
X-Received: by 2002:aa7:9735:: with SMTP id k21mr43135380pfg.174.1568205552566;
        Wed, 11 Sep 2019 05:39:12 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id w6sm50123564pfw.84.2019.09.11.05.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 05:39:11 -0700 (PDT)
Date:   Wed, 11 Sep 2019 22:39:05 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: Re: [PATCH v2 5/6] ext4: introduce direct IO write path using iomap
 infrastructure
Message-ID: <20190911123905.GA26735@bobrowski>
References: <cover.1567978633.git.mbobrowski@mbobrowski.org>
 <7c2f0ee02b2659d5a45f3e30dbee66b443b5ea0a.1567978633.git.mbobrowski@mbobrowski.org>
 <20190909092617.07ECB42041@d06av24.portsmouth.uk.ibm.com>
 <20190911080853.43B954C04E@d06av22.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190911080853.43B954C04E@d06av22.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 11, 2019 at 01:38:52PM +0530, Ritesh Harjani wrote:
> On 9/9/19 2:56 PM, Ritesh Harjani wrote:
> > On 9/9/19 4:49 AM, Matthew Bobrowski wrote:
> > > @@ -217,6 +218,14 @@ static ssize_t ext4_write_checks(struct kiocb
> > > *iocb, struct iov_iter *from)
> > >       if (ret <= 0)
> > >           return ret;
> > > 
> > > +    ret = file_remove_privs(iocb->ki_filp);
> > > +    if (ret)
> > > +        return 0;
> > > +
> > > +    ret = file_update_time(iocb->ki_filp);
> > > +    if (ret)
> > > +        return 0;
> > > +
> > >       if (unlikely(IS_IMMUTABLE(inode)))
> > >           return -EPERM;
> 
> Maybe we can move this up. If file is IMMUTABLE no point in
> calling for above actions (file_remove_privs/file_updatetime).

Yep, sure could do this. In fact, I think we could put this above
generic_write_checks().

> Also why not use file_modified() API which does the same.

Ah, nice. Indeed we can, thanks for simplifying it.

> > > @@ -234,6 +243,34 @@ static ssize_t ext4_write_checks(struct kiocb
> > > *iocb, struct iov_iter *from)
> > >       return iov_iter_count(from);
> > >   }
> > > 
> > > +static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
> > > +                    struct iov_iter *from)
> > > +{
> > > +    ssize_t ret;
> > > +    struct inode *inode = file_inode(iocb->ki_filp);
> > > +
> > > +    if (iocb->ki_flags & IOCB_NOWAIT)
> > > +        return -EOPNOTSUPP;
> > > +
> > > +    if (!inode_trylock(inode))
> > > +        inode_lock(inode);
> 
> Is it really needed to check for trylock first?
> we can directly call for inode_lock() here.

You're right, no need to do this dance. We can call inode_lock() directly.

> > > +
> > > +    ret = ext4_write_checks(iocb, from);
> > > +    if (ret <= 0)
> > > +        goto out;
> > > +
> > > +    current->backing_dev_info = inode_to_bdi(inode);
> > > +    ret = generic_perform_write(iocb->ki_filp, from, iocb->ki_pos);
> > > +    current->backing_dev_info = NULL;
> > > +out:
> > > +    inode_unlock(inode);
> > > +    if (likely(ret > 0)) {
> > > +        iocb->ki_pos += ret;
> > > +        ret = generic_write_sync(iocb, ret);
> > > +    }
> > > +    return ret;
> > > +}
> > > +
> > > +    if (!ext4_dio_checks(inode)) {
> > > +        inode_unlock(inode);
> > > +        /*
> > > +         * Fallback to buffered IO if the operation on the
> > > +         * inode is not supported by direct IO.
> > > +         */
> > > +        return ext4_buffered_write_iter(iocb, from);
> > > +    }
> > > +
> > > +    ret = ext4_write_checks(iocb, from);
> This can modify the count in iov_iter *from.

Good point. We'll recalculate the iter 'count' again.

Thank you for the review/suggestions, highly appreciated.

--<M>--
