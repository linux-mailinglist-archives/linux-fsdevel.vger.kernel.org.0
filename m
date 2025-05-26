Return-Path: <linux-fsdevel+bounces-49876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 516F5AC459A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 01:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32CF3BC096
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 23:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0471F4E34;
	Mon, 26 May 2025 23:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Esfs1Pce"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FDC151990
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748303766; cv=none; b=Md1cmieWx/7ZezcZnDMYUGF8iUrrWQ5FmavEx/AnUDH34ZlY+UY5h+lGXZUABoX+FC+9hpDiaPH0X93A6yoE064PSn+JOPFotaiFPIFI22MR9HgMzHYiqEvRJU5QJ6DzagzJFCvpU08tVhGTR2wC9m+44wIqQw//bNQ/VO47GhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748303766; c=relaxed/simple;
	bh=XRjqI7PDkLF+ozsx+1MQp5UAbP4b2nztWUttfDFgQC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzUysjPcuR/Pta2P+5eYgQk8tzTUT4r9JG6QTPM0/U+UkoSwiToYgdWFGcdmCT2fymHXH9WWB8YF0wz1muJU8SzpZ75v4bmj8gUQYScVnjDiyDON0tK6XB69FX0JtV2A4Dbh4AP/IiLHLQNMo+vCn8GpDDcL4oDZvtei8uecLrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Esfs1Pce; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iAOYq91qWwus1dfJa2GUyQF68CIwI09li6jVil7zs0c=; b=Esfs1Pce2Jd0QZNAzzISvFUOXP
	bItX/U+s58dc2vGhJGpZC7n0c5J9pU/0A4sr8B4I9jKPuvdSW5pkhVsHzahG7QmqfJrG1z+CeHZOK
	+lQm+UYgZifU8ugVTWd7Y6SN2I3blIK2rBYHVKwNphCPHgZKmozEdYEiKZtj9jVWYle6H6BhlwoSn
	4P+1ka1TjLx9qbKVjgQPkS6eXCpNHBD0zorvzAkcQfuzE+P3pJlloEiMRyJmpSuPXnMzcAczgs7zx
	tCH4jHB4vvHCXoLOjTxxcccq0ljvod54tQyQ/EtSndFuFN/gxLj6d44qZZCbm4qAkj4R2nNZtBj1B
	dd9Fpu/Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJhfk-00000009CMs-1Afp;
	Mon, 26 May 2025 23:56:00 +0000
Date: Tue, 27 May 2025 00:56:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] regression from 974c5e6139db "xfs: flag as supporting
 FOP_DONTCACHE" (double free on page?)
Message-ID: <20250526235600.GZ2023217@ZenIV>
References: <20250525083209.GS2023217@ZenIV>
 <20250525180632.GU2023217@ZenIV>
 <40eeba97-a298-4ae1-9691-b5911ad00095@suse.cz>
 <431cb497-b1ad-40a0-86b1-228b0b7490b9@kernel.dk>
 <6741c978-98b1-4d6f-af14-017b66d32574@kernel.dk>
 <3d123216-c412-4779-8461-b6691d7cafc7@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d123216-c412-4779-8461-b6691d7cafc7@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, May 26, 2025 at 11:38:53AM -0600, Jens Axboe wrote:
> > I'll poke a bit more...
> 
> I _think_ we're racing with the same folio being marked for writeback
> again. Al, can you try the below?

It seems to survive on top of v6.15^^

