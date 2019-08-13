Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 328E08B5D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 12:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfHMKpL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 06:45:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36614 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfHMKpL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 06:45:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id g4so2642638plo.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 03:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cNlXrM2SW6up6f8h39+QsN32T9+MeEri2gdTZtBdIao=;
        b=H3oPZsRB+NiIXo4h91rWV/QrxeJmmlQzGrpoaadA2age8oJdEigajxDwZXnlicLEzP
         sK843J+OEG0Ty3LfOE/V8rOZWeUl4AFmvXUp9zsD6TvBK8vE8vEHofSg3mQ0E0SnaNFw
         Oh4PZ61Oj4CUseaRiNYrdgjbV0EcF152esHCDDwJ0mlHgytaODMDQxyWvrgNhoXOE0+r
         4OXojW97lQq5+GCBziQ8eeHGuTa9rKc0/2A5fEoAwFjP1lRICVpRSQO1eDyWqmCmrDBO
         wQ8WChr3ZePAuE4VHtDjUoqBpWG7fCvLRt/Xl9VoQTTB8jYu8WAf0F13hsr8lMR1AMNQ
         N+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cNlXrM2SW6up6f8h39+QsN32T9+MeEri2gdTZtBdIao=;
        b=lR/4v3TTXAvs3YYkIFGAjOPXaG2Nvc3pKGjvFs7O4YiCkkZzx7UAEhimkuEqFXM/5P
         Gn3GmLmwpUAhMR46RtPccORcTYj0G0MHJHE+lfvsFnB6s2iC8h0s3+IIjOG0C6ug6iYy
         7L4xSJ/q+Y5QOD6ffWmHSRWzN8huzwjLVdeXmxvQUW0BrMv8Vz03qXRd85NFumwQF3fi
         bOnzGojIeNRTfmZZ4I4azohyGK5imLmEYuE2LOlVFHysTcw+f9dHWMRGtSMwe1CG2iy6
         CXG1ITqt5tL/PJpNoEd6hImSpJwFpL+Rb1D44vD/SDrmqn3c0yaDvjE8DuWdAiQkxXQ1
         EH+A==
X-Gm-Message-State: APjAAAVAf9PEd7nPMOIpaM5+2Sst4feWmeur/EfcHYAo5aCfLdpJFy2+
        Nnczv6Z88twWfp32vbzstsPPIpslQA==
X-Google-Smtp-Source: APXvYqwPUUaFTFZsBFrsl3V/Kic7x64GRX+HflZ+Qgw0mGGx2Ji+DAE9PkB87yBXDyPzSi71yJ/WKw==
X-Received: by 2002:a17:902:28a4:: with SMTP id f33mr19916602plb.50.1565693109938;
        Tue, 13 Aug 2019 03:45:09 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id 10sm18633085pfv.63.2019.08.13.03.45.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 03:45:09 -0700 (PDT)
Date:   Tue, 13 Aug 2019 20:45:03 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, tytso@mit.edu, riteshh@linux.ibm.com
Subject: Re: [PATCH 4/5] ext4: introduce direct IO write code path using
 iomap infrastructure
Message-ID: <20190813104501.GA28622@poseidon.bobrowski.net>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <581c3a2da89991e7ce5862d93dcfb23e1dc8ddc8.1565609891.git.mbobrowski@mbobrowski.org>
 <20190812173403.GD24564@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812173403.GD24564@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 10:34:03AM -0700, Christoph Hellwig wrote:
> > +	if (error) {
> > +		if (offset + size > i_size_read(inode))
> > +			ext4_truncate_failed_write(inode);
> > +
> > +		/*
> > +		 * The inode may have been placed onto the orphan list
> > +		 * as a result of an extension. However, an error may
> > +		 * have been encountered prior to being able to
> > +		 * complete the write operation. Perform any necessary
> > +		 * clean up in this case.
> > +		 */
> > +		if (!list_empty(&EXT4_I(inode)->i_orphan)) {
> > +			handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> > +			if (IS_ERR(handle)) {
> > +				if (inode->i_nlink)
> > +					ext4_orphan_del(NULL, inode);
> > +				return PTR_ERR(handle);
> > +			}
> > +
> > +			if (inode->i_nlink)
> > +				ext4_orphan_del(handle, inode);
> > +			ext4_journal_stop(handle);
> > +		}
> > +		return error;
> 
> I'd split this branch into a separate function just to keep the
> end_io handler tidy.

Good idea. I'll do that...

> > +	if (ret == -EIOCBQUEUED && (unaligned_aio || extend))
> > +		inode_dio_wait(inode);
> > +
> > +	if (ret >= 0 && iov_iter_count(from)) {
> > +		overwrite ? inode_unlock_shared(inode) : inode_unlock(inode);
> > +		return ext4_buffered_write_iter(iocb, from);
> > +	}
> > +out:
> > +	overwrite ? inode_unlock_shared(inode) : inode_unlock(inode);
> > +	return ret;
> 
> the ? : expression here is weird.
> 
> I'd write this as:
> 
> 	if (overwrite)
> 		inode_unlock_shared(inode);
> 	else
> 		inode_unlock(inode);
> 
> 	if (ret >= 0 && iov_iter_count(from))
> 		return ext4_buffered_write_iter(iocb, from);
> 	return ret;
> 
> and handle the only place we jump to the current out label manually,
> as that always does an exclusive unlock anyway.

Yeah, the ternary operators do look weird here and I'd prefer if we
also dropped them. I was at a point where I was trying to clean up
some of the code, but I had been staring at the screen for so long my
brain went numb and couldn't think of how to do this neatly. I'm happy
with this suggestion. :-)

> > +		if (IS_DAX(inode)) {
> > +			ret = ext4_map_blocks(handle, inode, &map,
> > +					      EXT4_GET_BLOCKS_CREATE_ZERO);
> > +		} else {
> > +			/*
> > +			 * DAX and direct IO are the only two
> > +			 * operations currently supported with
> > +			 * IOMAP_WRITE.
> > +			 */
> > +			WARN_ON(!(flags & IOMAP_DIRECT));
> > +			if (round_down(offset, i_blocksize(inode)) >=
> > +			    i_size_read(inode)) {
> > +				ret = ext4_map_blocks(handle, inode, &map,
> > +						      EXT4_GET_BLOCKS_CREATE);
> > +			} else if (!ext4_test_inode_flag(inode,
> > +							 EXT4_INODE_EXTENTS)) {
> > +				/*
> > +				 * We cannot fill holes in indirect
> > +				 * tree based inodes as that could
> > +				 * expose stale data in the case of a
> > +				 * crash. Use magic error code to
> > +				 * fallback to buffered IO.
> > +				 */
> > +				ret = ext4_map_blocks(handle, inode, &map, 0);
> > +				if (ret == 0)
> > +					ret = -ENOTBLK;
> > +			} else {
> > +				ret = ext4_map_blocks(handle, inode, &map,
> > +						      EXT4_GET_BLOCKS_IO_CREATE_EXT);
> > +			}
> > +		}
> 
> I think this could be simplified down to something like:
> 
> 		int flags = 0;
> 
> 		...
> 
> 		/*
> 		 * DAX and direct IO are the only two operations currently
> 		 * supported with IOMAP_WRITE.
> 		 */
> 		WARN_ON(!IS_DAX(inode) && !(flags & IOMAP_DIRECT));
> 
> 		if (IS_DAX(inode))
> 			flags = EXT4_GET_BLOCKS_CREATE_ZERO;
> 		else if (round_down(offset, i_blocksize(inode)) >=
> 				i_size_read(inode)) {
> 			flags = EXT4_GET_BLOCKS_CREATE;
> 		else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> 			flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
> 
> 		/*
> 		 * We cannot fill holes in indirect tree based inodes as that
> 		 * could expose stale data in the case of a crash.  Use the
> 		 * magic error code to fallback to buffered IO.
> 		 */
> 		if (!flags && !ret)
> 			ret = -ENOTBLK;

This also seems OK to me.

> > @@ -3601,6 +3631,8 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> >  static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
> >  			  ssize_t written, unsigned flags, struct iomap *iomap)
> >  {
> > +	if (flags & IOMAP_DIRECT && written == 0)
> > +		return -ENOTBLK;
> 
> This probably wants a comment, too.  But do we actually ever end up
> here?

Sure, I can append a comment. Also, I don't believe that we can
completely drop the ->iomap_end() callback as hinted in one of your
other comments. The reason I say this is because we still need this to
catch the case where an error an occurs within 'iomap_actor_t'. If
that happens to be, within iomap_dio_rw() we wait for IO completion
before returning and then we fallback to buffered IO to complete the
remainder of the IO. We will also be able to reuse the extent that was
allocated when preparing for direct IO if we do this.

--M
