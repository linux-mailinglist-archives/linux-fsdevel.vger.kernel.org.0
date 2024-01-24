Return-Path: <linux-fsdevel+bounces-8759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2199183AB4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 15:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8645DB29F9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 14:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B92F77F3A;
	Wed, 24 Jan 2024 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bhcj5QFU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337F277F04
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706104959; cv=none; b=XZwmTewwkuueK+4Fm0+7utjMBy68PMzyEZF7iraJqQ51jBZkIpG6M/f5LGj6y5Q2bz31qDhx8HpGi9c7rH1VkTvrhs4grgehAVvh0dNC7nS3pEf6zNgdJ6R07t3vmXmU2mAT8Lbx+3noRlr/4tW7l6pXJaI7aGF8y9daovEz1UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706104959; c=relaxed/simple;
	bh=pfHAnczln2fvb4QjdW4ObQMDhktThefgnOWykCN+pOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zk2sj62FvnK2ACa3s3Mx0EPc3lSkmtg3y4Rzv+n69l5fDa0somXZWJYHJksVBTdcEZn4E8F4urXgycwFdl0iIjjAe81al4GoAM0cyFRuqeczBV56xP5CW4pjOZAFM+3HgV+2Cd630y2K4nRarJVAg2HDLaJAKhixgXOY9OdxABw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bhcj5QFU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VO9z9UwG5VRkSNrRUFjq/aYmNFw6fl6NaZvDJVfRVdw=; b=bhcj5QFUrJ2VhdnJ6nYGj8muC+
	kpiAbwCCICOMIRoM5premMF0+5u2i9iNIqqPBFlAPmqET+WNO+2sUWZRWnIbDv9SJ41lieqdDss6W
	r+qn5RJp/xrTuOW9L+lvw4miRFgBoyP4H9bwngzKbw3Vwu6GQBTx7tnSezHBu4Nz04FayZukFPjLB
	oLBxe3AdcFIdeH9WySR6bKjBVB68h8vHpk7u4rf8Wsy2uutlFLSfIA8HU3IQfSImNCQun0gxTDxH8
	p89yXU4ACU1JAHlSl6oR8Y8bJkRpAwJkwC61Le3ly7KBXaG6P0JiEFt3ZpNi0iHnaWo1zubrdJCZi
	51otND1g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSdpo-00000006osy-0F9W;
	Wed, 24 Jan 2024 14:02:32 +0000
Date: Wed, 24 Jan 2024 14:02:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
	"sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] exfat: fix file not locking when writing zeros in
 exfat_file_mmap()
Message-ID: <ZbEYd-JfKMTDN-Tv@casper.infradead.org>
References: <PUZPR04MB63168A32AB45E8924B52CBC2817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <ZbCeWQnoc8XooIxP@casper.infradead.org>
 <PUZPR04MB63168DC7A1A665B4EB37C996817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZPR04MB63168DC7A1A665B4EB37C996817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>

On Wed, Jan 24, 2024 at 10:05:15AM +0000, Yuezhang.Mo@sony.com wrote:
> From: Matthew Wilcox <willy@infradead.org> 
> Sent: Wednesday, January 24, 2024 1:21 PM
> To: Mo, Yuezhang <Yuezhang.Mo@sony.com>
> Subject: Re: [PATCH] exfat: fix file not locking when writing zeros in exfat_file_mmap()
> > On Wed, Jan 24, 2024 at 05:00:37AM +0000, mailto:Yuezhang.Mo@sony.com wrote:
> > > inode->i_rwsem should be locked when writing file. But the lock
> > > is missing when writing zeros to the file in exfat_file_mmap().
> > 
> > This is actually very weird behaviour in exfat.  This kind of "I must
> > manipulate the on-disc layout" is not generally done in mmap(), it's
> > done in ->page_mkwrite() or even delayed until we actually do writeback.
> > Why does exfat do this?
> 
> In exfat, "valid_size" describes how far into the data stream user data has been
> written and "size" describes the file size.  Return zeros if read "valid_size"~"size".

Yes, it's like a very weak implementation of sparse files.  There can
only be one zero range and it must be at the end (as opposed to most
unix derived filesystems which allow arbitrary zero ranges anywhere in
the file).

> For example,
> 
> (1) xfs_io -t -f -c "pwrite -S 0x59 0 1024" $filename
>      - Write 0x59 to 0~1023
>      - both "size" and "valid_size" are 1024

Yes.

> (2) xfs_io -t -f -c "truncate 4K" $filename
>      - "valid_size" is still 1024
>      - "size" is changed to 4096
>      - 1024~4095 is not zeroed
>      - return zeros if read 1024~4095

Yes.

> (3) xfs_io -t -f -c "mmap -rw 0 3072" -c  "mwrite -S 0x5a 2048 512" $filename
>      (3.1) "mmap -rw 0 3072"
>               -  write zeros to 1024~3071
>               -  "valid_size" is changed to 3072
>               - "size" is still 4096

That's not what the code says you do.  Is this from a trace or were you
making up an example?

        loff_t start = ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
        loff_t end = min_t(loff_t, i_size_read(inode),
                        start + vma->vm_end - vma->vm_start);
                ret = exfat_file_zeroed_range(file, ei->valid_size, end);


vm_end - vm_start will be 4kB because Linux rounds to PAGE_SIZE even if
you ask to map 3072 bytes.

In any case, most filesystems do not do this, and I don't understand why
exfat does.  Just because a file is mmaped writable doesn't mean that
we're necessarily going to write to it.  The right thing to do here is
defer the changing of ->valid_size until you have already written back
the new data.

>      (3.2) "mwrite -S 0x5a 2048 512"
>              - write 0x5a to 2048~2559
>              - "valid_size" is still 3072
>              -  "size" is still 4096
> 
> To avoid 1024~2047 is not zeroed and no need to update "valid_size" in (3.2),
> I zero 1024~3071 in (3.1).
> 
> If you have a better solution, welcome to contribute to  exfat or share your
> solution in detail.

Update ->valid_size in the writeback path.  If I'm reading
exfat_get_block() correctly, you already correctly zero pages in the page
cache that are read after ->valid_size, so there is very little work for
you to do.


Oh!  I just figured out why you probably do it this way.

(1) xfs_io -t -f -c "pwrite -S 0x59 0 1024" $filename
(2) xfs_io -t -f -c "truncate 4T" $filename
(3) xfs_io -t -f -c "mmap -rw 3T 4096" -c  "mwrite -S 0x5a 3T 512" $filename

Now (at whatever point you're delaying writing zeroes to) you have to
write 3TB of zeroes.  And it's probably better to do that at mmap time
than at page fault time, so you can still return an error.  It's a bit
weird to return ENOSPC from mmap, but here we are.

It'd be nice to have a comment to explain this.  Also, it seems to me
that I can write a script that floods the kernel log with:

                        exfat_err(inode->i_sb,
                                  "mmap: fail to zero from %llu to %llu(%d)",
                                  start, end, ret);

That error message should probably be taken out entirely (maybe use a
tracepoint if you really want some kind of logging).

