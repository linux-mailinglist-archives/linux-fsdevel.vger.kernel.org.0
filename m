Return-Path: <linux-fsdevel+bounces-74777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB1HFEhZcGlvXQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 05:42:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C66E4511FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 05:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFC134E2F0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 04:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38523C1FFC;
	Wed, 21 Jan 2026 04:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mmd1v900"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C242D4813
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 04:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768970559; cv=none; b=fgnGZhHic4esS13UJ3GymNu96DeguLJo8akapna611AE9KokJ5qT+n9tTfDEjyLx81ysiegP60mubgvQ7G4IAJ7xkMObL6aTHtx87aKd6rKaS2YTHR+YSnMKKwOwk6vv8hr77Ys/9lB0Y6KT+4/mLEwmYYeWpm40ft5be9bUaKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768970559; c=relaxed/simple;
	bh=kNbRLapT3MUHraMR+7e1S1T4gcR5+v4l+PJIwknTby8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbhLZGK0h9a40RuOjZW0zxNlxiZBCkT+8EGgL22I+cBTvAKictqvk7KR4rG20jf4dUGXUJBc987xccPdnzCetun28MuRfk+I0HOWvwfzuLVq0Sb/DkV1tY7JczzTNUwVmSDxdx5E8AZONwewq07CeRHfnuOnZbkCrltbDHI/zsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Mmd1v900; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=/847oJACzOLtXktSIg7r6Iv3lrn/6PhKb07tthhFIB8=; b=Mmd1v900AmloA/c8a52dViykaV
	3KlN2skLMalaVGn87K0oVWS3MXAihSY0Pe35jP+5z21G58trKkCJmhU3xQFf+E7kCNGMx/uDbMoLj
	UkyhJRKvSG7SEBw8T+iP1Oyu8bon24NE7anDF2uJGEBR2li66K+7Ec3br/Ztt+Mk0jJDc4Ry8DKoD
	4B++WCpD4Pz6XHsLeh5bRA2V/uhfNMEDIpfek633GYE1D/Ayfm8kw0IfBzkG6maGMhrfD3ukpKTIm
	m6yiVYakHKvVXgRJ20fEaZ7GwEB+jbztjzbPHi7Cz9bDuafDHz0uirTkFUgdVDOPAdwzrQ7IZ4tZX
	m/sFB1RQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viQ35-0000000Ft9e-3opl;
	Wed, 21 Jan 2026 04:42:31 +0000
Date: Wed, 21 Jan 2026 04:42:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org,
	hch@infradead.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iomap: fix readahead folio refcounting race
Message-ID: <aXBZN2tzg5MyrnAb@casper.infradead.org>
References: <20260116015452.757719-1-joannelkoong@gmail.com>
 <20260116015452.757719-2-joannelkoong@gmail.com>
 <aWmn2FympQXOMst-@casper.infradead.org>
 <CAJnrk1Zs2C-RjigzuhU-5dCqZqV1igAfAWfiv-trnydwBYOHfA@mail.gmail.com>
 <aWqxgAfDHD5mZBO1@casper.infradead.org>
 <CAJnrk1YJFV5aE2U6bK1PpTBp5tfkRzBK5o24AhidYFUfQnQjNQ@mail.gmail.com>
 <20260117023002.GD15532@frogsfrogsfrogs>
 <CAJnrk1ZSnrMLQ-g4XCAhb1nXBWE_ueEM_uTreUNxuT-3z_z-DA@mail.gmail.com>
 <aXAmwHNte1TvHbvj@casper.infradead.org>
 <CAJnrk1Z-eTJGMEJfAcJG0T3gwVcO7C1vayYaK9Rb3POar2=Jcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Z-eTJGMEJfAcJG0T3gwVcO7C1vayYaK9Rb3POar2=Jcw@mail.gmail.com>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74777-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[infradead.org,none];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,infradead.org:email,infradead.org:dkim,casper.infradead.org:mid]
X-Rspamd-Queue-Id: C66E4511FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 08:12:10PM -0800, Joanne Koong wrote:
> On Tue, Jan 20, 2026 at 5:07 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Jan 20, 2026 at 04:34:22PM -0800, Joanne Koong wrote:
> > > But looking at some of the caller implementations, I think my above
> > > implementation is wrong. At least one caller (zonefs, erofs) relies on
> > > iterative partial reads for zeroing parts of the folio (eg setting
> > > next iomap iteration on the folio as IOMAP_HOLE), which is fine since
> > > reads using bios end the read at bio submission time (which happens at
> > > ->submit_read()). But fuse ends the read at either
> > > ->read_folio_range() or ->submit_read() time. So I think the caller
> > > needs to specify whether it ends the read at ->read_folio_range() or
> > > not, and only then can we invalidate ctx->cur_folio. I'll submit v4
> > > with this change.
> >
> > ... but it can only do that on a block size boundary!  Which means that
> > if the block size is smaller than the folio size, we'll allocate an ifs.
> > If the block size is equal to the folio size, we won't allocate an IFS,
> > but neither will the length be less than the folio size ... so the return
> > of -EIO was dead code, like I said.  Right?
> 
> Maybe I'm totally misreading this then, but can't the file size be
> non-block-aligned even if the filesystem is block-based, which means
> "iomap->length = i_size_read(inode) - iomap->offset" (as in
> zonefs_read_iomap_begin()) isn't guaranteed to always be a
> block-aligned mapping length (eg leading to the case where plen <
> folio_size and block_size == folio_size)? I see for direct io writes
> that the write size is enforced to be block-aligned (in
> zonefs_file_dio_write()) and seq files must go through direct io, but
> I don't see that this applies to buffered writes for non-seq files,
> which I think means inode->i_size can be non-block-aligned.

I think the important thing is that a block device can only do I/O in
units of block size!  Let's work an example.

Lets say we're on a 4KiB block device and have a 4KiB folio.  The file in
question is a mere 700 bytes in size.  Regardless of what the filesystem
asks iomap for (700 bytes or 4096 bytes), the BIO that goes to the
device instructs it to read one 4KiB block.  Once the read has completed,
all bytes in the folio are now uptodate and the completion handler can
call folio_end_read().

If we were on a 512 byte block device, we'd allocate an IFS, do an I/O
for 2 * 512 byte blocks and zero the remaining 3KiB with memset().
Whichever of the memset() or read-completion happened later calls
folio_end_read().

(some filesystems zero post-EOF bytes after the DMA has completed;
I believe ntfs3 does, for example.  But I don't think XFS or iomap does
that; it relies on post-EOF bytes being zeroed in the writeback path)

