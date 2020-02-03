Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0491500D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 05:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgBCEAz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Feb 2020 23:00:55 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42930 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgBCEAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Feb 2020 23:00:55 -0500
Received: by mail-pg1-f194.google.com with SMTP id w21so1303650pgl.9;
        Sun, 02 Feb 2020 20:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rr8HCvzHGy43zP4xWeCYuUUUoHY3g639VB8x/Nydnlg=;
        b=muo9tv8kjF11m+vSPjqfEII/CZlpoxWRQgX5XYoLk1hjHyL+cVNJGj4bmkAYXzizak
         Y4i91wtr2ujHX07+XLbFejWyoqTSv9vJBLIpTyKRb9d2bWbxgac+OpiTZqfkDLOzB7ee
         zyR/RQPUwhb4SNboWPaHLBVcZBtRPCKQpbO835cOLmDYEmFQ2rtA5UHQZKuX5ZiXjwhV
         kJw6cotpt3LtfSjgPsn7vEKpBHzoc837OBa7+G+RusS0dcQ2LjjphwWSyj2EzPtlzSi/
         5WlfbkzwXfeqZXAT1Zgh7qAb2k1Y5ZkoS70bn2iQi6O2jZQU3S3gNwmX0zv6STsIxsBQ
         fzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rr8HCvzHGy43zP4xWeCYuUUUoHY3g639VB8x/Nydnlg=;
        b=ocnf1lXuXBMZ4AJHhSXwQa5lq9er7rO0JtS/nCvWYbqTmx5sfvGlx1Cyc9MmfN+O+1
         RmTKD9UuiICbTEa60anSMfbSbB0mbSRVXD128BpTj8Ps5fvhsKnmIhePBa6d/pms7ftJ
         vKGfwL9o5I+kNA8kp/t3XVdKI6MziAk4XhK0F6Jut6BASX+jyUQiyrOfUD59//1nBnv0
         dby6Ch0vWr7GYiwHiM5xfZWeQn0VlK1v/QWa5EUVyF0pTfIBK0tSv6fYJpOCqhoNhaPo
         d/RDvQoGa1Uz5qPlbFHBRd9bjxomGT8vwpem8liFOo/hCjr6VTgWkq9CeWH6eVWzVEKc
         /osg==
X-Gm-Message-State: APjAAAW//l1x9ElfNy7TQ+0Jw87cdsEUzRgbkyGMAyBF7sMeLyBykqDO
        n48HtHZJa2elj2nPRulF+J0=
X-Google-Smtp-Source: APXvYqw6sOBM5hkQdEcY93EBISXIcWxUa5iFOJ0ybi1o8lz/TCOyKmjVlPeCcfdTU561dRtnIHT7cA==
X-Received: by 2002:a62:e80a:: with SMTP id c10mr22435421pfi.129.1580702454450;
        Sun, 02 Feb 2020 20:00:54 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id 28sm14213294pgl.42.2020.02.02.20.00.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 02 Feb 2020 20:00:53 -0800 (PST)
Date:   Mon, 3 Feb 2020 12:00:51 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] fuse: Allow parallel DIO reads and check NOWAIT case for
 DIO writes
Message-ID: <20200203040051.GB11846@cqw-OptiPlex-7050>
References: <1580614487-1341-1-git-send-email-qiwuchen55@gmail.com>
 <07d333db-9ed3-2628-673e-cb614c31f29e@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07d333db-9ed3-2628-673e-cb614c31f29e@fastmail.fm>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 02, 2020 at 10:25:43PM +0100, Bernd Schubert wrote:
> 
> 
> > @@ -1518,6 +1525,9 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
> >  
> >  		res = __fuse_direct_read(&io, to, &iocb->ki_pos);
> >  	}
> > +	inode_unlock_shared(inode);
> > +
> > +	file_accessed(iocb->ki_filp);
> 
> 
> Shouldn't the file_accessed() in different patch, with a description? It
> looks totally unrelated to locking?
>
Thanks for your remind! file_accessed() is used to update atime for
every direct read, it's totally unrelated to locking. I will separate
it to another patch.
