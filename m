Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FCD2EA627
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 08:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbhAEHuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 02:50:54 -0500
Received: from verein.lst.de ([213.95.11.211]:60398 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbhAEHuy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 02:50:54 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CE7D168BEB; Tue,  5 Jan 2021 08:50:10 +0100 (CET)
Date:   Tue, 5 Jan 2021 08:50:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [RFC PATCH V3 1/1] block: reject I/O for same fd if block size
 changed
Message-ID: <20210105075009.GA30039@lst.de>
References: <20210104130659.22511-1-minwoo.im.dev@gmail.com> <20210104130659.22511-2-minwoo.im.dev@gmail.com> <20210104171108.GA27235@lst.de> <20210104171141.GB27235@lst.de> <20210105010456.GA6454@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105010456.GA6454@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 05, 2021 at 10:04:56AM +0900, Minwoo Im wrote:
> It was a point that I really would like to ask by RFC whether we can
> have backpointer to the gendisk from the request_queue.  And I'd like to
> have it to simplify this routine and for future usages also.

I think it is the right thing to do, at least mid-term, although I
don't want to enforce the burden on you right now.

> I will restrict this one by checking GENHD_FL_UP flag from the gendisk
> for the next patch.
> 
> > 
> > Alternatively we could make this request_queue QUEUE* flag for now.
> 
> As this patch rejects I/O from the block layer partition code, can we
> have this flag in gendisk rather than request_queue ?

For now we can as the request_queue is required.  I have some plans to
clean up this area, but just using a request_queue flag for now is
probably the simplest, even if it means more work for me later.
