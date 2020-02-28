Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2139217410C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 21:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgB1Ufm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 15:35:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:54530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1Ufm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 15:35:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CB895AE95;
        Fri, 28 Feb 2020 20:35:40 +0000 (UTC)
Date:   Fri, 28 Feb 2020 14:35:38 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com
Subject: Re: [PATCH v2] iomap: return partial I/O count on error in
 iomap_dio_bio_actor
Message-ID: <20200228203538.s52t64zcurna77cu@fiona>
References: <20200220152355.5ticlkptc7kwrifz@fiona>
 <20200221045110.612705204E@d06av21.portsmouth.uk.ibm.com>
 <20200225205342.GA12066@infradead.org>
 <20200228194401.o736qvvr4zpklyiz@fiona>
 <20200228195954.GJ29971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228195954.GJ29971@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11:59 28/02, Matthew Wilcox wrote:
> On Fri, Feb 28, 2020 at 01:44:01PM -0600, Goldwyn Rodrigues wrote:
> > +++ b/fs/iomap/direct-io.c
> > @@ -264,7 +264,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
> >  		size_t n;
> >  		if (dio->error) {
> >  			iov_iter_revert(dio->submit.iter, copied);
> > -			copied = ret = 0;
> > +			ret = 0;
> >  			goto out;
> 
> There's another change here ... look at the out label
> 
> out:
>         /* Undo iter limitation to current extent */
>         iov_iter_reexpand(dio->submit.iter, orig_count - copied);
>         if (copied)
>                 return copied;
>         return ret;
> 
> so you're also changing by how much the iter is reexpanded.  I
> don't know if it's the appropriate amount; I still don't quite get the
> iov_iter complexities.
> 

Ah, okay. Now I understand what Christoph was saying.

I suppose it is safe to remove iov_iter_reexpand(). I don't see any
other goto to this label which will have a non-zero copied value.
And we have already performed the iov_iter_revert().

-- 
Goldwyn
