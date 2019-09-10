Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBD45AE80B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2019 12:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbfIJK04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Sep 2019 06:26:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36714 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbfIJK04 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:26:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id y22so11294835pfr.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2019 03:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xpMwYrMj0JCUefC3R/F8uLVaeqHT3pdUsMCxxoo34M0=;
        b=Q6a3ZtUHh+oF3nS4bd+r59coZ8xc8KJc3o6GYoeEFOVXK9asgswP5jGwNxVDw5f2rF
         pnu2F5Q7VURa+qhPdvX5rF6AZ6SG/X4H8CDtifIA5BSU81Fk7dRaAEBJP+d2qWHlF89d
         oTCbH+IrQUYJlBBsgi2qErquc1IxgzZt8cN+ty/OJ9KXPANmauYg7QLzRoadX0FkXF1z
         God2D0UKfz5khWVgPh3x0mUwkWgVXKu/Son1ML2GcY2BAX8POr9+Qyl3FUQS2TRvhG3M
         S/ufvzusja7sYgp3mCA1k3cArBrgIl5BVjlYpkz/7yHln29dcYZzqNRg5NJ8Yg6EFR6/
         QvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xpMwYrMj0JCUefC3R/F8uLVaeqHT3pdUsMCxxoo34M0=;
        b=BGccNvsGHyqiyZD5nXMXGMvZpZsu/3vo1uYEYDNeyO0tegj5SU+JnReUeJglM2CvFO
         PUyKTJ0vEtpFDBHx8Lk8YSSTBa+2ta02jdLtYLMZ9UaaxhmmiaqqplNEVAlZODso0tCO
         JBJVECk5LXN16Qhh/3HtbuprjOnRreGO4j5rQdPU8lEO2oJPYrurZgi61zzRt7Ilbx83
         kMRPfMf6shJTs7VXK+xI1CqVXXyBEsAMHoG2w1jgaNqW7htg7PwzTBlBGTEFcRHJ++Eq
         8+zNgvtOzC5j2PflyGmPnaNYrlp+XKDftwX2CYHPwL2lS15adtS6qGsWkBP9X1LkLRG5
         MnhQ==
X-Gm-Message-State: APjAAAXaxR0J9u/exWW9IrIthQYcr5uHrJOHfZ0P+k6VQC6TrKMWe5iM
        6nVPG0jNKqq/xle7SPGXkV4wmBR/4XIQ
X-Google-Smtp-Source: APXvYqxBGnxXjhhRtHEQc6fpQY8tTZLmVogYJm/5G0YtnAFKhKelTUIRAZb4kUkJiYJaCstXsuVrVA==
X-Received: by 2002:a65:56c1:: with SMTP id w1mr26518414pgs.395.1568111209986;
        Tue, 10 Sep 2019 03:26:49 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id h1sm22770149pfk.124.2019.09.10.03.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 03:26:49 -0700 (PDT)
Date:   Tue, 10 Sep 2019 20:26:43 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: Re: [PATCH v2 2/6] ext4: move inode extension/truncate code out from
 ext4_iomap_end()
Message-ID: <20190910102643.GA9013@bobrowski>
References: <cover.1567978633.git.mbobrowski@mbobrowski.org>
 <c1e9b23ced988587dfec399021a5b62983745842.1567978633.git.mbobrowski@mbobrowski.org>
 <20190909081729.3555C42041@d06av24.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909081729.3555C42041@d06av24.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 09, 2019 at 01:47:28PM +0530, Ritesh Harjani wrote:
> On 9/9/19 4:49 AM, Matthew Bobrowski wrote:
> > +static int ext4_handle_inode_extension(struct inode *inode, loff_t offset,
> > +				       ssize_t len, size_t count)
> > +{
> > +	handle_t *handle;
> > +	bool truncate = false;
> > +	ext4_lblk_t written_blk, end_blk;
> > +	int ret = 0, blkbits = inode->i_blkbits;
> > +
> > +	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> > +	if (IS_ERR(handle)) {
> > +		ret = PTR_ERR(handle);
> > +		goto orphan_del;
> > +	}
> > +
> > +	if (ext4_update_inode_size(inode, offset + len))
> > +		ext4_mark_inode_dirty(handle, inode);
> > +
> > +	/*
> > +	 * We may need truncate allocated but not written blocks
> > +	 * beyond EOF.
> > +	 */
> > +	written_blk = ALIGN(offset + len, 1 << blkbits);
> > +	end_blk = ALIGN(offset + len + count, 1 << blkbits);
> 
> why add len in end_blk calculation?
> shouldn't this be like below?
> 	end_blk = ALIGN(offset + count, 1 << blkbits);

I don't believe that would be entirely correct. The reason being is that the
'end_blk' is meant to represent the last logical block which we should expect
to have used for the write operation. So, we have the 'offset' which
represents starting point, 'len' which is the amount of data that has been
written, and 'count' which is the amount of data that we still have left over
in the 'iter', if any.

The count in the 'iter' is decremented as that data is copied from it. So if
we did use 'offset' + 'count', in the instance of a short write, we
potentially wouldn't truncate any of the allocated but not written blocks. I
guess this would hold true for the DAX code path at this point, seeing as
though for the DIO case we pass in '0'.

> > +/*
> > + * The inode may have been placed onto the orphan list or has had
> > + * blocks allocated beyond EOF as a result of an extension. We need to
> > + * ensure that any necessary cleanup routines are performed if the
> > + * error path has been taken for a write.
> > + */
> > +static int ext4_handle_failed_inode_extension(struct inode *inode, loff_t size)
> > +{
> > +	int ret = 0;
> 
> No need of ret anyways.
> 
> 
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
> > +	return ret;
> 
> can directly call for `return 0;`

True.

--<M>--
