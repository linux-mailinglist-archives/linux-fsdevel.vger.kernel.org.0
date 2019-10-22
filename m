Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D90CDFB5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 04:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbfJVCHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 22:07:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47010 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730494AbfJVCHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:07:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id e15so8936166pgu.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 19:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0JwAmtHOYWZzbAoHm6MZ4x4Kbi7xu3d1X9nugY2jRZk=;
        b=0zlX1sGraaAG4YSwawsg10r1ERG2KCTNW4YnGhgKB2bj/h6YU+maZWaXBHHXfZS6/y
         CUbRrFkQWD4cfX+Gjhsn8hatDfNjGLAX5IiY4wXoN0WSDq211lXyI6iNfMV83Em4XjpN
         nYoU/wtXwh7ZuD2MeJZ4a37dMPcxKN4iyicdXgPrJuyUSGbwgOwWVP0O1BYDQTwH9Val
         Q4nqUChBf+ltzukLun6ku3p2HiBu+ckUlBuoCRXQtOvuC9PSbafk2FL56IhrzyZVVolN
         /3AY52Pphg7LNrNiiVuUSfdIo2HAVwiXDkONBYBZRetrEpGh7fEBO9yFlQCaN5h55CSn
         rvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0JwAmtHOYWZzbAoHm6MZ4x4Kbi7xu3d1X9nugY2jRZk=;
        b=hCsne4hog38Uv/cHqq//i9KS1JFhz6sXOzTPuLs8+TnvLErQsBAbxtDMA1ej9Z153D
         7MazY7slRQgMl04t4B4/CYdtx8QtlZU/hFeBU0BbrZT3CBE+JfuP/sNdP5nA/TKaBItX
         W5BT0VSwtyB86Xrv4soARLv1kiPlwmNQRp8GKASbpfrYF7gFnhcrkPg8pF6z4tdspxMh
         zjJLX1yaOcx4jfbn3ovUzB8EGYmj8fpGX1vC7MmZjoOSr9zQjdbDMsn4kVmuh7S3YKJB
         ZwvULyVW/bp2h7p0s26HicNlNOXlUzFdfOZy2lwcvfG+Je+44vO7SEUC9FqRlUXQG1QX
         83ow==
X-Gm-Message-State: APjAAAU4ql5vQC5RIZHRbK16yJrBPYVQBmzaikIeyh6JDgK5M1ObjKKu
        0YfJpaybQDOzNdVQ08/9XWFl
X-Google-Smtp-Source: APXvYqy6B3lisv6xickC54UBWAWA1x94sagNl15UXW/HfSUifxvjy0b2+ep1SBrXFTjTXDXm7Q9W/A==
X-Received: by 2002:a63:c80a:: with SMTP id z10mr1025759pgg.290.1571710043634;
        Mon, 21 Oct 2019 19:07:23 -0700 (PDT)
Received: from athena.bobrowski.net (n1-41-199-60.bla2.nsw.optusnet.com.au. [1.41.199.60])
        by smtp.gmail.com with ESMTPSA id f188sm19792372pfa.170.2019.10.21.19.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 19:07:23 -0700 (PDT)
Date:   Tue, 22 Oct 2019 13:07:17 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 09/12] ext4: move inode extension/truncate code out
 from ->iomap_end() callback
Message-ID: <20191022020717.GF5092@athena.bobrowski.net>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <629e86cf14761cdb716bce57feec9997abdd6ff6.1571647179.git.mbobrowski@mbobrowski.org>
 <20191021135337.GH25184@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021135337.GH25184@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 03:53:37PM +0200, Jan Kara wrote:
> On Mon 21-10-19 20:18:56, Matthew Bobrowski wrote:
> > In preparation for implementing the iomap direct I/O modifications,
> > the inode extension/truncate code needs to be moved out from the
> > ext4_iomap_end() callback. For direct I/O, if the current code
> > remained, it would behave incorrrectly. Updating the inode size prior
> > to converting unwritten extents would potentially allow a racing
> > direct I/O read to find unwritten extents before being converted
> > correctly.
> > 
> > The inode extension/truncate code now resides within a new helper
> > ext4_handle_inode_extension(). This function has been designed so that
> > it can accommodate for both DAX and direct I/O extension/truncate
> > operations.
> > 
> > Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> > ---
> >  fs/ext4/file.c  | 71 ++++++++++++++++++++++++++++++++++++++++++++++++-
> >  fs/ext4/inode.c | 48 +--------------------------------
> >  2 files changed, 71 insertions(+), 48 deletions(-)
> > 
> 
> The patch looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thank you!

> > +static ssize_t ext4_handle_inode_extension(struct inode *inode, ssize_t written,
> > +					   loff_t offset, size_t count)
> 
> IMHO a bit more logical ordering of arguments would be 'inode, offset,
> written, count'...

Funnily enough, I originally had the arguments ordered as you've
suggested, but then decided to reorder them this way last minute. No
objections to reshuffling them around.

--<M>--
