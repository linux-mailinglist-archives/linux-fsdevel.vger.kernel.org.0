Return-Path: <linux-fsdevel+bounces-38957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAD5A0A74B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 06:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE2918890A8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2025 05:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6562A85931;
	Sun, 12 Jan 2025 05:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="V1C5Pzk/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC374632
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2025 05:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736659679; cv=none; b=SL7bS3qo5bejzy+w9CzrSOADuKkbMQce3iIgiDivGbtNgy+Wn98HYzlTLNd18G5ka7cMpIp2pddIcrtBqNooz9MqhAd8Yx4wRf8EVqo0TOaxZ2LBGr9cb97Y7vrVUXbPM5Hm9e+YRtB5LXRR/U0PBPVAxjfq2OyVM4yDO+1ssto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736659679; c=relaxed/simple;
	bh=FZJI0NwyAdhQDvuggZkPC1A75OwQnn4pL+nCY9+hMIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5vjLPvUjFUZ9CO0qDIFtyhWIzK64BZ9oStPcpsFVZa6j3qdu60d0g2CV0wSthwtdX5V6+fdOsqyHUHqjwlKMGaTuqjjX6j5s7nyNxT2uvZz4ef0Uda8YyQIs1htHW0v1BI2C0zP4Re9ksgQTeLjDxc8v1JqgUVxbZDn8kkYZGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=V1C5Pzk/; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-19.bstnma.fios.verizon.net [173.48.102.19])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50C5RiUf005035
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 00:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1736659666; bh=hsJn6lx2Sfxyjgi2rtTSEM4Cc9L/e68NGlFow50qVNM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=V1C5Pzk/6pJKAXj5Ir8UDi5x3dkdSRuYOe47T2EIaROHJn6HN23rJTuX2KtF9w091
	 E3jTHeGi7+6xX/P2DMORzWR0CmvYHnxiDZEFZDjs8euCny0xZ5aXnyQ7hs3znkbAwI
	 k394yCASrrZWGTj+0oGRlyaVxXE1s7OjXYKBoI+XmaQS59odHcj72YDBTnq9aO2P18
	 M/kMGEcowMS2bkWcJcH3EPgC9m+ZyF13eRotPUHRDFmiEBIvLNEX3ATnqND4Us+q7l
	 5k4hx27jEy5yd7vPuLOts3vebdvFv3zxfupcUcFxm+WpIEbz+lqqwYzCsviImURZCC
	 SxO3B3YgtfTSQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id DC3F815C0148; Sun, 12 Jan 2025 00:27:43 -0500 (EST)
Date: Sun, 12 Jan 2025 00:27:43 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Artem S. Tashkinov" <aros@gmx.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Spooling large metadata updates / Proposal for a new API/feature
 in the Linux Kernel (VFS/Filesystems):
Message-ID: <20250112052743.GH1323402@mit.edu>
References: <ba4f3df5-027b-405e-8e6e-a3630f7eef93@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba4f3df5-027b-405e-8e6e-a3630f7eef93@gmx.com>

On Sat, Jan 11, 2025 at 09:17:49AM +0000, Artem S. Tashkinov wrote:
> Hello,
> 
> I had this idea on 2021-11-07, then I thought it was wrong/stupid, now
> I've asked AI and it said it was actually not bad, so I'm bringing it
> forward now:
> 
> Imagine the following scenarios:
> 
>  * You need to delete tens of thousands of files.
>  * You need to change the permissions, ownership, or security context
> (chmod, chown, chcon) for tens of thousands of files.
>  * You need to update timestamps for tens of thousands of files.
> 
> All these operations are currently relatively slow because they are
> executed sequentially, generating significant I/O overhead.
> 
> What if these operations could be spooled and performed as a single
> transaction? By bundling metadata updates into one atomic operation,
> such tasks could become near-instant or significantly faster. This would
> also reduce the number of writes, leading to less wear and tear on
> storage devices.

As Amir has stated, pretty much all journalled file systems will
combine a large number of file system operations into a single
transation, unless there is an explicit request via an fsync(2) system
call.  For example, ext4 in general only closes a journal transaction
every five seconds, or there isn't enough space in the journal
(athough in practice this isn't an issue if you are using a reasonably
modern mkfs.ext4, since we've increased the default size of the
journal).

The reason why deleting a large number of files, or changing the
permissions, ownership, timestamps, etc., of a large number of files
is because you need to read the directory blocks to find the inodes
that you need to modify, read a large number of inodes, update a large
number of inodes, and if you are deleting the inodes, also update the
block allocation metadata (bitmaps, or btrees) so that those blocks
are marked as no longer in use.  Some of the directory entries might
be cached in the dentry cache, and some of the inodes might be cached
in the inode cache, but that's not always the case.

If all of the metadata blocks that you need to read in order to
accomplish the operation are already cached in memory, then what you
propose is something that pretty much all journaled file systems will
do already, today. That is, the modifications that need to be made to
the metadata will be first written to the journal first, and only
after the journal transaction has been committed, will the actual
metadata blocks be written to the storage device, and this will be
done asynchronously.

In pratice, the actual delay in doing one of these large operations is
the need to read the metadata blocks into memory, and this must be
done synchronously, since (for example), if you are deleting 100,000
files, you first need to know which inodes for those 100,000 files by
reading the directory blocks; you then need to know which blocks will
be freed by deleting each of those 100,000 files, which means you will
need to read 100,000 inodes and their extent tree blocks, and then you
need to update the block allocation information, and that will require
that you read the block allocation bitmaps so they can be updated.

> Does this idea make sense? If it already exists, or if there’s a reason
> it wouldn’t work, please let me know.

So yes, it basically exists, although in practice, it doesn't work as
well as you might think, because of the need to read potentially a
large number of the metdata blocks.  But for example, if you make sure
that all of the inode information is already cached, e.g.:

   ls -lR /path/to/large/tree > /dev/null

Then the operation to do a bulk update will be fast:

  time chown -R root:root /path/to/large/tree

This demonstrates that the bottleneck tends to be *reading* the
metdata blocks, not *writing* the metadata blocks.

Cheers,

				- Ted

