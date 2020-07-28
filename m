Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6E6230B8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 15:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgG1NiV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 09:38:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:41448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729986AbgG1NiV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:38:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8CBFDAD36;
        Tue, 28 Jul 2020 13:38:31 +0000 (UTC)
Date:   Tue, 28 Jul 2020 08:38:17 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Avi Kivity <avi@scylladb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [PATCH] fs: Return EOPNOTSUPP if block layer does not support
 REQ_NOWAIT
Message-ID: <20200728133817.lurap7lucjx7q7bw@fiona>
References: <20181213115306.fm2mjc3qszjiwkgf@merlin>
 <833af9cb-7c94-9e69-65cb-abd3cee5af65@scylladb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <833af9cb-7c94-9e69-65cb-abd3cee5af65@scylladb.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19:08 22/07, Avi Kivity wrote:
> 
> On 13/12/2018 13.53, Goldwyn Rodrigues wrote:
> > For AIO+DIO with RWF_NOWAIT, if the block layer does not support REQ_NOWAIT,
> > it returns EIO. Return EOPNOTSUPP to represent the correct error code.
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > ---
> >   fs/direct-io.c | 11 +++++++----
> >   1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/direct-io.c b/fs/direct-io.c
> > index 41a0e97252ae..77adf33916b8 100644
> > --- a/fs/direct-io.c
> > +++ b/fs/direct-io.c
> > @@ -542,10 +542,13 @@ static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)
> >   	blk_status_t err = bio->bi_status;
> >   	if (err) {
> > -		if (err == BLK_STS_AGAIN && (bio->bi_opf & REQ_NOWAIT))
> > -			dio->io_error = -EAGAIN;
> > -		else
> > -			dio->io_error = -EIO;
> > +		dio->io_error = -EIO;
> > +		if (bio->bi_opf & REQ_NOWAIT) {
> > +			if (err == BLK_STS_AGAIN)
> > +				dio->io_error = -EAGAIN;
> > +			else if (err == BLK_STS_NOTSUPP)
> > +				dio->io_error = -EOPNOTSUPP;
> > +		}
> >   	}
> >   	if (dio->is_async && dio->op == REQ_OP_READ && dio->should_dirty) {
> 
> 
> In the end, did this or some alternative get applied? I'd like to enable
> RWF_NOWAIT support, but EIO scares me and my application.
> 

No, it was not. There were lot of objections to return error from the
block layer for a filesystem nowait request.

-- 
Goldwyn
