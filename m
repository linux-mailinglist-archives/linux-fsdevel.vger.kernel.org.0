Return-Path: <linux-fsdevel+bounces-27636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D76A963145
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 21:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A361F26E99
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 19:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374111ABEDC;
	Wed, 28 Aug 2024 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nv/YdFhb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036091A4F06
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874652; cv=none; b=SlPErUBUwrFL0nuWJ5542b4hGZRB4WSRST5+q8rqArh7GNTJNJXGUPsWBha5tbB1g+6ArflpKTNhbHnxxQKRDBFtVQdFsdvmgdnpxmVB87wN6GQIOXK0VEMCdFl9i1SRaYQWZrsqzc32t1OR5b2JGog953yX7mQORlSj9WXfQug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874652; c=relaxed/simple;
	bh=X4rhzoi97/kWqBNE9hKLgab+nkAfzfQvtt/VopAKmOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwGVsta9ELK1zCc41uBlUEKmGKIbdhmChrEirky8QhmGVHOKjVR+G7vSp5QOwjMYVS5elT90InutG0Mt2Q3CgfX6m9W2ZfBXmdjXEiD/IvolJ4IXBJxsa6KNRdhOm2AzoS2m9LjcVFsN74QPI2F2V0sf+Q9AKfp/abU/aoKdIfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Nv/YdFhb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f9XJzI8nAlUI+YGzluf8I0GNXyRea7BOjvKQgiszlYQ=; b=Nv/YdFhbCnk0RGVEcTiOkcvTm0
	UQI+th3V8vAzJh0YfV1HRJvoff1RUAATBp8sJJG29Af49Rzq9Fgwqm1MiNOx9WdICwy8dFNgFuccP
	RMHYfAaxmC1+08a6Y6BkGoYPfXjKxdi44msQ4osRImJrn0rJAJGpsFUqYx9T4VGxjBGGqfY7aLXEd
	+KeDUE3ZVvYi//pKiCvZZI+ZVl/65u5GuKQitwJFyA+wDhVR1xrnYSo/nTBIFbetIFdzYoXEaKKn8
	cQGePZHxFjIVOBC93mhxfPxMpy4OQGJ3yxTc274Wcnj5EC4RiqfolDgV//LggZsdeRGqXvJmb6iyT
	Ro1RVHyw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sjOgp-00000000yPv-3oTY;
	Wed, 28 Aug 2024 19:50:47 +0000
Date: Wed, 28 Aug 2024 20:50:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Subject: Re: VFS caching of file extents
Message-ID: <Zs9_l1w0SuJO4ZbO@casper.infradead.org>
References: <Zs97qHI-wA1a53Mm@casper.infradead.org>
 <Zs9+mm8bElKJmz65@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs9+mm8bElKJmz65@tissot.1015granger.net>

On Wed, Aug 28, 2024 at 03:46:34PM -0400, Chuck Lever wrote:
> On Wed, Aug 28, 2024 at 08:34:00PM +0100, Matthew Wilcox wrote:
> > There are a few problems I think this can solve.  One is efficient
> > implementation of NFS READPLUS.
> 
> To expand on this, we're talking about the Linux NFS server's
> implementation of the NFSv4.2 READ_PLUS operation, which is
> specified here:
> 
>   https://www.rfc-editor.org/rfc/rfc7862.html#section-15.10
> 
> The READ_PLUS operation can return an array of content segments that
> include regular data, holes in the file, or data patterns. Knowing
> how the filesystem stores a file would help NFSD identify where it
> can return a representation of a hole rather than a string of actual
> zeroes, for instance.

Thanks for the reference; I went looking for it and found only the
draft.

Another thing this could help with is reducing page cache usage for
very sparse files.  Today if we attempt to read() or page fault on a
file hole, we allocate a fresh page of memory and ask the filesystem to
fill it.  The filesystem notices that it's a hole and calls memset().
If the VFS knew that the extent was a hole, it could use the shared zero
page instead.  Don't know how much of a performance win this would be,
but it might be useful.

