Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7913ED0B3D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 11:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbfJIJby (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 05:31:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43025 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfJIJbx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:31:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id a2so1237419pfo.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2019 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kRwGuJ3Z1w4orY8QbOKxpUxozCDZla3/A5WPD537bEo=;
        b=O1ezDfSH84PuIoqX/PAnA8VZ2qWhvdldsQ1OgtFWqCDjde4BiS2PHLkT9IRrkvDE8N
         RDzIfE5o9qj2czst4sStXqKL5f499Z85e7ZDJOQN3Awp0nMrOUdaTuKQv6TRg9+SBC56
         B6gFljPw42NnjfS37m83Go+yK4RC+MlIWsSE3H/96hUy3qNpaOwBvojlKnGdL5eCkPyP
         exDBUtoWtNXpUjh8hrEx59kpghBMaUZrFV5wM1yVls1A4e4xOnMDf0+UVcE5MQey89b2
         C4c3c/SZmKbuv1YP3+Vnc4JbQm7QEBgGg+40a6LiweMVOvvWTPLTyMbIkP3nkZZy2sm9
         2+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kRwGuJ3Z1w4orY8QbOKxpUxozCDZla3/A5WPD537bEo=;
        b=DzWSKHGo1YmA1gIjyN8kWtiNJXgUb+bFE9Va036JRFupVadU2s8FJ7EJmeYcviIXXb
         p5VqDCZmq258mdTs/qiFimpPpZfIYEugY8i+IWbKCoHEWAL6E35DlKf7N5j9C9Mb4V5b
         pon3kquVS33C7D1kaJbc4tzPfr1145SuskeZPThDntIqLFf7UWSCe9jK946ugdTZQgCc
         rqgQx7NiPjpx2mpol59R+4o505Vr9IFAQ0OzpROMbUdsEeXdGFtG1klfcCa2KIj5l0+O
         CbKj27DrGyNjjDJ9F+wbjYQu/dOHaC8Eay5TWyS/ikSoN8KPDNFXb7QI88mT2Ph9g8p5
         gpUg==
X-Gm-Message-State: APjAAAUbvDF4/400IQq5P/TEQCkMNg6C33nydY9Db9RGUaR3pN8yZnz/
        LzqIZ6rlrqTyMVNTpJm2Ibh+
X-Google-Smtp-Source: APXvYqxxU1TsVsd/WhnZ8S4/DbhtJuP9H5Zl17BMmDhrD1TFjUz562odaZUlcJ2flcD1Tu4UZ8w5/Q==
X-Received: by 2002:a62:283:: with SMTP id 125mr2735157pfc.137.1570613512888;
        Wed, 09 Oct 2019 02:31:52 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id g6sm1926197pgk.64.2019.10.09.02.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 02:31:52 -0700 (PDT)
Date:   Wed, 9 Oct 2019 20:31:46 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 2/8] ext4: move out IOMAP_WRITE path into separate
 helper
Message-ID: <20191009093144.GD2125@poseidon.bobrowski.net>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <99b317af0f20a170fba2e70695d7cca1597fb19a.1570100361.git.mbobrowski@mbobrowski.org>
 <20191009062242.87D244204B@d06av24.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009062242.87D244204B@d06av24.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 11:52:41AM +0530, Ritesh Harjani wrote:
> On 10/3/19 5:03 PM, Matthew Bobrowski wrote:
> Minor comment, but otherwise.
> Patch looks good to me. You may add:
> 
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

*nod* - Thank you!

> >   static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> >   			    unsigned flags, struct iomap *iomap)
> >   {
> > @@ -3500,62 +3556,16 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> >   			}
> >   		}
> >   	} else if (flags & IOMAP_WRITE) {
> > -		int dio_credits;
> > -		handle_t *handle;
> > -		int retries = 0;
> > -
> > -		/* Trim mapping request to maximum we can map at once for DIO */
> > -		if (map.m_len > DIO_MAX_BLOCKS)
> > -			map.m_len = DIO_MAX_BLOCKS;
> > -		dio_credits = ext4_chunk_trans_blocks(inode, map.m_len);
> > -retry:
> > -		/*
> > -		 * Either we allocate blocks and then we don't get unwritten
> > -		 * extent so we have reserved enough credits, or the blocks
> > -		 * are already allocated and unwritten and in that case
> > -		 * extent conversion fits in the credits as well.
> > -		 */
> > -		handle = ext4_journal_start(inode, EXT4_HT_MAP_BLOCKS,
> > -					    dio_credits);
> > -		if (IS_ERR(handle))
> > -			return PTR_ERR(handle);
> > -
> > -		ret = ext4_map_blocks(handle, inode, &map,
> > -				      EXT4_GET_BLOCKS_CREATE_ZERO);
> > -		if (ret < 0) {
> > -			ext4_journal_stop(handle);
> > -			if (ret == -ENOSPC &&
> > -			    ext4_should_retry_alloc(inode->i_sb, &retries))
> > -				goto retry;
> > -			return ret;
> > -		}
> > -
> > -		/*
> > -		 * If we added blocks beyond i_size, we need to make sure they
> > -		 * will get truncated if we crash before updating i_size in
> > -		 * ext4_iomap_end(). For faults we don't need to do that (and
> > -		 * even cannot because for orphan list operations inode_lock is
> > -		 * required) - if we happen to instantiate block beyond i_size,
> > -		 * it is because we race with truncate which has already added
> > -		 * the inode to the orphan list.
> > -		 */
> > -		if (!(flags & IOMAP_FAULT) && first_block + map.m_len >
> > -		    (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits) {
> > -			int err;
> > -
> > -			err = ext4_orphan_add(handle, inode);
> > -			if (err < 0) {
> > -				ext4_journal_stop(handle);
> > -				return err;
> > -			}
> > -		}
> > -		ext4_journal_stop(handle);
> > +		ret = ext4_iomap_alloc(inode, flags, first_block, &map);
> 
> We don't need "first_block" argument here. Since
> map->m_lblk saves first_block directly above in the same function.

You're right. I will change that.

> No strong objection against ext4_iomap_alloc, but
> maybe ext4_iomap_map_write sounds better?
> Either way is fine though.

I like 'ext4_iomap_alloc', because it's performing allocation in
preparation for a write being performed on behalf of iomap. :)

--<M>--

