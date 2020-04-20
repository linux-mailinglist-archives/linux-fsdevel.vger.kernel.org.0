Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927681B0787
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 13:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgDTLh0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 07:37:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgDTLh0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:37:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8506206D4;
        Mon, 20 Apr 2020 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587382646;
        bh=Xv91P5BFptk8v+4mIKZ+00d8+7F5VJtrztWk8yf18OE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tOrmDT5lwCv65vrxCr9jX+FR3MiROr1B0tBeLYOqXE1JoBeM2AKzaJw2H3qogzh5I
         Ol0OzyvuedbPW5V9FmjfELaa2Pfxl4OCdHXOXA246WAhHVbHk23Z/IS3z1Dw8SizOO
         syR02sCdoPudeAcz5kEXxvhow0oZCgJhtEi6OGO8=
Date:   Mon, 20 Apr 2020 13:37:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] blktrace: move debugfs file creation to its own
 function
Message-ID: <20200420113724.GB3906674@kroah.com>
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-8-mcgrof@kernel.org>
 <c0457200-4273-877f-a28d-8c744c7ae7c1@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0457200-4273-877f-a28d-8c744c7ae7c1@acm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 19, 2020 at 03:55:15PM -0700, Bart Van Assche wrote:
> On 4/19/20 12:45 PM, Luis Chamberlain wrote:
> > +static int blk_trace_create_debugfs_files(struct blk_user_trace_setup *buts,
> > +					  struct dentry *dir,
> > +					  struct blk_trace *bt)
> > +{
> > +	int ret = -EIO;
> > +
> > +	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,
> > +					       &blk_dropped_fops);
> > +
> > +	bt->msg_file = debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops);
> > +
> > +	bt->rchan = relay_open("trace", dir, buts->buf_size,
> > +				buts->buf_nr, &blk_relay_callbacks, bt);
> > +	if (!bt->rchan)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> 
> How about adding IS_ERR() checks for the debugfs_create_file() return
> values?

No, please no, I have been removing all of that nonsense from the kernel
for the past 3-4 releases.  You should never care about the return value
from that call, just save it off and move on.

as it is, this is correct.

greg k-h
