Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1751D0CA6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 12:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbfJIKS6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 06:18:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37677 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729575AbfJIKS6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:18:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id y5so1337009pfo.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Oct 2019 03:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oIq9HQZybaT5LehXQ1gvS/VSaj5oLWiEUpcMmo+ewr0=;
        b=t3LR45cpQr9PWFRAeblcjOXZBnUalUgBZaWvg19Jnd1Xnbi41tiTReJLZKojg5eCwX
         nVTY9L95yzQvECrDUL5br95AHxrEk4wfE4JjqJpdWLr4IidpHTJ28klWZRpiX03K0qSF
         kscq5bP9qS/sKD+kWNwvO/2USWAR61MQRYFwnq4BSIOr0gx+FSfbTavDRo4QqG3+XkCO
         gkxz+FD366lThYcbtsyjOcLd2oypHSafKAO8/TpRfSibDqd85ga1omYj4CqjJ8R5vtsa
         wKFpYA+6hXdri5AIj54ER5qkS2avvveUnEucgPx6cDFkcOhjqgRaHDkI3KGGtch9Tyjy
         I8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oIq9HQZybaT5LehXQ1gvS/VSaj5oLWiEUpcMmo+ewr0=;
        b=cTkG3XGqYKb9DS8GJpu31NH9Sh3qWy2xc7I3fYHTc5ImKHhMSzRk+JFPuPjFkVEOml
         v6Yv//AGUNkoEYkDGEyQLDgb00TVkcIIJmmJ80iLbvLsQxQlrvpMW/gSBELqES2HhCU2
         PcPob7TKJkW5Itu/nClVbXZGPPKDdBm7UDZs2B7eq9qL21wilBhr4K3YFSWfhri9xuDT
         oZvnFAdJyx7O6XfTITRuyz0F7dwXzKUaQJnsDL08zsLjxAgZRP7vkmO89V5w4IA6nrwD
         MRsWOA3Lamv6MlWBPpaph+AYHC+/EhXrBmvUrUuPDQ9NVOoliezX6Y1nVeLPF3UWLfcS
         m/rw==
X-Gm-Message-State: APjAAAVnFJy2nOlNTblGyww7F11XwuGxXFyWN9nWoj2BqOwb8DwaM5sf
        a8NVB0rumjrvmIu5cwR5O6nF
X-Google-Smtp-Source: APXvYqzc1yb0hBwBdn+0ISE8F55E6iop1a/P+FlzvNAKHKVDqfWCrgmqL5ZrSs4+NfjkMqqZYfBIXQ==
X-Received: by 2002:a65:640a:: with SMTP id a10mr3382479pgv.270.1570616337111;
        Wed, 09 Oct 2019 03:18:57 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id h14sm1808500pfo.15.2019.10.09.03.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 03:18:56 -0700 (PDT)
Date:   Wed, 9 Oct 2019 21:18:50 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 5/8] ext4: move inode extension/truncate code out from
 ->iomap_end() callback
Message-ID: <20191009101848.GG2125@poseidon.bobrowski.net>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <da556191f9dba2b477cce57665ded57bfd396463.1570100361.git.mbobrowski@mbobrowski.org>
 <20191008112512.GH5078@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008112512.GH5078@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 01:25:12PM +0200, Jan Kara wrote:
> On Thu 03-10-19 21:34:18, Matthew Bobrowski wrote:
> Looks good to me. Fell free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks Jan!

> Just small nits below:
> 
> > +static int ext4_handle_inode_extension(struct inode *inode, loff_t offset,
> > +				       ssize_t written, size_t count)
> > +{
> > +	int ret = 0;
> 
> I think both the function and callsites may be slightly simpler if you let
> the function return 'written' or error (not 0 or error). But I'll leave
> that decision upto you.

Hm, don't we actually need to return 0 for success cases so that
iomap_dio_complete() behaves correctly i.e. increments iocb->ki_pos,
etc?

> > +	handle_t *handle;
> > +	bool truncate = false;
> > +	u8 blkbits = inode->i_blkbits;
> > +	ext4_lblk_t written_blk, end_blk;
> > +
> > +	/*
> > +         * Note that EXT4_I(inode)->i_disksize can get extended up to
> > +         * inode->i_size while the IO was running due to writeback of
> > +         * delalloc blocks. But the code in ext4_iomap_alloc() is careful
> > +         * to use zeroed / unwritten extents if this is possible and thus
> > +         * we won't leave uninitialized blocks in a file even if we didn't
> > +         * succeed in writing as much as we planned.
> > +         */
> 
> Whitespace damaged here...

I'll fix this.

--<M>--
