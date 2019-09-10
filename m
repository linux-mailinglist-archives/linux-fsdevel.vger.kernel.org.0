Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10912AE832
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2019 12:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393809AbfIJKbz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Sep 2019 06:31:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39286 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392363AbfIJKby (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:31:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id i1so2437753pfa.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2019 03:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xlKn3ut4vJcecpSFo5ylYLz+gUFXNHMgr09jHtOfi9Q=;
        b=GXE8L9tSnveu2iVuduadVJeglQ4bnnfqAlcLeq/VN65weRcTs4U9mZt6PS+/vNxczU
         kO/v5DolLrdcSJR7vqByi75hL8jH6lNjz9Tefic7i00tRdx6agM3RarSprAzlFiiHi3V
         rm/HTVmdlW7BbdTzfErW28LbNwkPGqrXvjgiYl1P2d9NWNYSPuQz+9g7IQDVZ+DKT6mM
         ZXeOhdYpm+yEQP+KJ15POogaWM/e/cDkdCkX0WDcvxRjGc8oQT/iyxyJBfSk0FYgpkuS
         JUwXonJnuGjKbs0ijFNEJXil/EsG2e+pjT/mJCqLgorMikbT2YbC8t5gxLIiPs+luK8z
         khig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xlKn3ut4vJcecpSFo5ylYLz+gUFXNHMgr09jHtOfi9Q=;
        b=Ztpy58x5vLf/2ysU0lkhEofoTe//6DkexadWvlrz9999bff/bkUPngy5gw2Pm4dJx8
         JOlfdQ0zjtaeuYQcRJvA6Uenh0MNVt7FfmtEbwv4h1BdK4b6y/2a2zwWb8qYjx7+j7Ij
         3Jf6H/LRmBpCJWTjOl+hnmL8iefIh2KYL6COLtUlT+EBHAZuMNqo/OTV1P94CuRXsrOm
         8I47NvEOE50r2qTKBbn+mcLh4KK88yNAv2BnYYCx52qN54JCvRjTUTs55j2rsgHfTKWy
         EOg8q+PRSWanV9iRvK0CwPkqZCgyiCuNfIQ/3LPusafoEkYQGhpUYjqupELKrA6jg4Dp
         3wPw==
X-Gm-Message-State: APjAAAV8r82nqb5gGwn/E1NSRHaqZR1G7gKJbfYFW2MNdrkAMp0PjU2y
        BQrma/mDz/Cr63xbH25o70EX
X-Google-Smtp-Source: APXvYqxHDSwEVqtXgjuGD1AVo0jHCnopb6R2ZF59TkaLWbxO0pKqi/EzCUwBXhJpvfH5u+KRoe8FqA==
X-Received: by 2002:a63:f04:: with SMTP id e4mr26222183pgl.38.1568111513639;
        Tue, 10 Sep 2019 03:31:53 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id c11sm37380483pfj.114.2019.09.10.03.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 03:31:52 -0700 (PDT)
Date:   Tue, 10 Sep 2019 20:31:47 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: Re: [PATCH v2 5/6] ext4: introduce direct IO write path using iomap
 infrastructure
Message-ID: <20190910103147.GA10579@bobrowski>
References: <cover.1567978633.git.mbobrowski@mbobrowski.org>
 <7c2f0ee02b2659d5a45f3e30dbee66b443b5ea0a.1567978633.git.mbobrowski@mbobrowski.org>
 <20190909092617.07ECB42041@d06av24.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909092617.07ECB42041@d06av24.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 09, 2019 at 02:56:15PM +0530, Ritesh Harjani wrote:
> On 9/9/19 4:49 AM, Matthew Bobrowski wrote:
> > +/*
> > + * For a write that extends the inode size, ext4_dio_write_iter() will
> > + * wait for the write to complete. Consequently, operations performed
> > + * within this function are still covered by the inode_lock().
> > + */
> Maybe add a comment that on success this returns 0.

OK, can do.

> > +static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
> > +				 unsigned int flags)
> > +{
> > +	int ret = 0;
> No need to initialize ret.
> 
> 
> > +	loff_t offset = iocb->ki_pos;
> > +	struct inode *inode = file_inode(iocb->ki_filp);
> > +
> > +	if (error) {
> > +		ret = ext4_handle_failed_inode_extension(inode, offset + size);
> > +		return ret ? ret : error;
> > +	}
> > +
> > +	if (flags & IOMAP_DIO_UNWRITTEN) {
> > +		ret = ext4_convert_unwritten_extents(NULL, inode,
> > +						     offset, size);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	if (offset + size > i_size_read(inode)) {
> > +		ret = ext4_handle_inode_extension(inode, offset, size, 0);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +	return ret;
> Directly return 0, since if it falls here it mans it is a success case.
> You are anyway returning error from above error paths.

OK, sure.

--<M>--
