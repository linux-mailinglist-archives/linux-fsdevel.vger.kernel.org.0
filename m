Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E108B94C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 14:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbfHMM7B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 08:59:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46765 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbfHMM7A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:59:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id q139so3282652pfc.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 05:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BtgHrm08etfJjpF5KZmN8TsxqVOwcQO1JBv4H+Dr5cg=;
        b=wEmr3cZiUAc2JpvdtUVMLKLT9KycYfEQTCLPN6raNK0E8SO/r2D6MAsFB8sxobyYTB
         JKHsJgYhlJ71M2Rlf1ky2eEywEQE1JgqOuuGQm+6KVHDcnZn4XWKc8NshLfPWMTv8dHQ
         9Ac288GNUhb8Cum4V/duyv4hUCR86xG5Uuv8PJaE8K6Wb/IkZ0Bt3TOExh2Da7X8EfGG
         zAFjRbflE8ZDCijWL3TdCjVc3Beqo0oi7dVa6rxuXlTTtpSNi9W40Hz+3i+6e/yjBJpb
         moSTb4d4/BQkNFf3UZP7KPmE8TYoL+t/56kin8CzTW45xpfBb3aM4+pUtYz0oq52jHZE
         zvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BtgHrm08etfJjpF5KZmN8TsxqVOwcQO1JBv4H+Dr5cg=;
        b=e8Q2O22yC6aTvP2WAL+BjCp0ezQrWLTpCLWsrteLBQYHtof0sibYDpiy3sJgUpDUeG
         ckKWMrmnP6AcK4l+rzGgrNK43uzs2vse+UZwjMmzIwQskMowRaxLsxz1GcRyaJ0Z3Kmh
         4dEV0lgwb6TynXYvevzw/zsEFIIVk/N+rFWsmJyDR9LLi0LvpgQy8HHU2K0TFNPhcPXL
         JC/OnBNZKLYvR9Q3RqJG9hDyWKV1gLLB/bb/Krxfe68munOh6TCNNqrIwCgFXmliFLlU
         eBsVbl9F75U/MkzdiD3m+e3HFeHsojL8a8pod6pwhv9wzHHf541yMk9yHN7PDgNYa9v2
         vHqw==
X-Gm-Message-State: APjAAAVpCMPQKaw4R8AgczYcipewo7+id6aJ3x9Ips0ufLwWkR5vIeIN
        cAiNCmE46rwt2uD4NVRaDsV6pvAmNg==
X-Google-Smtp-Source: APXvYqy/dcEWOI6c0eEjj5GAJ7wsf/ExpRRYdw8Xmi1ZmvBRpibcJa9dVGYOBop6r31MeVz4JOMGCw==
X-Received: by 2002:a63:89c7:: with SMTP id v190mr33058801pgd.299.1565701134413;
        Tue, 13 Aug 2019 05:58:54 -0700 (PDT)
Received: from neo.Home ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id x1sm22171627pfj.182.2019.08.13.05.58.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 05:58:53 -0700 (PDT)
Date:   Tue, 13 Aug 2019 22:58:42 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     RITESH HARJANI <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, tytso@mit.edu
Subject: Re: [PATCH 4/5] ext4: introduce direct IO write code path using
 iomap infrastructure
Message-ID: <20190813125840.GA10187@neo.Home>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <581c3a2da89991e7ce5862d93dcfb23e1dc8ddc8.1565609891.git.mbobrowski@mbobrowski.org>
 <20190812170430.982E552051@d06av21.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190812170430.982E552051@d06av21.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 10:34:29PM +0530, RITESH HARJANI wrote:
> > +	if (offset + count > i_size_read(inode) ||
> > +	    offset + count > EXT4_I(inode)->i_disksize) {
> > +		ext4_update_i_disksize(inode, inode->i_size);
> > +		extend = true;
> > +	}
> > +
> > +	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, ext4_dio_write_end_io);
> > +
> > +	/*
> > +	 * Unaligned direct AIO must be the only IO in flight or else
> > +	 * any overlapping aligned IO after unaligned IO might result
> > +	 * in data corruption.
> > +	 */
> > +	if (ret == -EIOCBQUEUED && (unaligned_aio || extend))
> > +		inode_dio_wait(inode);
> 
> Could you please add explain & add a comment about why we wait in AIO DIO
> case
> when extend is true? As I see without iomap code this case was not present
> earlier.

Because while using the iomap infrastructure for AIO writes, we return to the
caller prior to invoking the ->end_io() handler. This callback is responsible
for performing the in-core/on-disk inode extension if it is deemed
necessary. If we don't wait in the case of an extend, we run the risk of
loosing inode size consistencies in addition to things leading to possible
data corruption...

> > +
> > +	if (ret >= 0 && iov_iter_count(from)) {
> > +		overwrite ? inode_unlock_shared(inode) : inode_unlock(inode);
> > +		return ext4_buffered_write_iter(iocb, from);
> > +	}
> should not we copy code from "__generic_file_write_iter" which does below?
> 
> 3436                 /*
> 3437                  * We need to ensure that the page cache pages are
> written to
> 3438                  * disk and invalidated to preserve the expected
> O_DIRECT
> 3439                  * semantics.
> 3440                  */

Hm, I don't see why this would be required seeing as though the page cache
invalidation semantics pre and post write are handled by iomap_dio_rw() and
iomap_dio_complete(). But, I could be completely wrong here, so we may need to
wait for some others to provide comments on this.

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
> Could you please check & confirm on below points -
> 1. Do you see a problem @above in case of *overwrite* with extents mapping?
> It will fall into EXT4_GET_BLOCKS_IO_CREATE_EXT case.
> So are we piggy backing on the fact that ext4_map_blocks first call
> ext4_ext_map_blocks
> with flags & EXT4_GET_BLOCKS_KEEP_SIZE. And so for overwrite case since it
> will return
> val > 0 then we will anyway not create any blocks and so we don't need to
> check overwrite
> case specifically here?
> 
> 
> 2. For cases with flags passed is 0 to ext4_map_blocks (overwrite &
> fallocate without extent case),
> we need not start the journaling transaction. But in above we are doing
> ext4_journal_start/stop unconditionally
> & unnecessarily reserving dio_credits blocks.
> We need to take care of that right?

Hm, I think you raise valid points here.

Jan, do you have any comments on the above? I vaguely remember having a
discussion around dropping the overwrite checks in ext4_iomap_begin() as we're
removing the inode_lock() early on in ext4_dio_write_iter(), so it woudln't be
necessary to do so. But, now that Ritesh mentioned it again I'm thinking it
may actually be required...

> >   		if (ret < 0) {
> >   			ext4_journal_stop(handle);
> >   			if (ret == -ENOSPC &&
> > @@ -3581,10 +3611,10 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> >   		iomap->type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
> >   		iomap->addr = IOMAP_NULL_ADDR;
> >   	} else {
> > -		if (map.m_flags & EXT4_MAP_MAPPED) {
> > -			iomap->type = IOMAP_MAPPED;
> > -		} else if (map.m_flags & EXT4_MAP_UNWRITTEN) {
> > +		if (map.m_flags & EXT4_MAP_UNWRITTEN) {
> >   			iomap->type = IOMAP_UNWRITTEN;
> > +		} else if (map.m_flags & EXT4_MAP_MAPPED) {
> > +			iomap->type = IOMAP_MAPPED;
> Maybe a comment as to explaining why checking UNWRITTEN before is necessary
> for others.
> So in case of fallocate & DIO write case we may get extent which is both
> unwritten & mapped (right?).
> so we need to check if we have an unwritten extent first so that it will
> need the conversion in ->end_io
> callback.

Yes, that is essentially correct.

--M
