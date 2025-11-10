Return-Path: <linux-fsdevel+bounces-67654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23D8C45B9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 10:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F153F3B80B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 09:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8640301480;
	Mon, 10 Nov 2025 09:48:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B563310F1;
	Mon, 10 Nov 2025 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768122; cv=none; b=eYR8B7n8SyLlnfniTyePIt/miEihIgFVV+81ZPm01ppba8JoN0Pi/fLuSp6bKb6LbejvYuuKybMFf8QlFefBFt+b+XsXiENE9KZlznazJRsEqbyjEIqnl9JK/8MO6FwGrYxq111ZnF35NB+pEqZE8DfhB4ED6V8dxJGAs9JuuuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768122; c=relaxed/simple;
	bh=1DjRNZxFtuPeyaCM+BTZgQhWC2kIMmjGBedH0BhikCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2PD1UGYv3gMg8J8indGazX1bCVCPz5R2dNqL9t+pM6r+sQdJFx8nZNi+6euqg1/0auqzx8AwKM+F1lS6H4SiXqMktBQCj7R1cF7A9gIjnPUV2vCzKvexyk7WQn+OkwjfODDhtw2R9OyeLZMfgCGjAt2qTQceTaUKmDZ++ZLF9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8BF80227A87; Mon, 10 Nov 2025 10:48:31 +0100 (CET)
Date: Mon, 10 Nov 2025 10:48:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Christoph Hellwig <hch@lst.de>, Florian Weimer <fweimer@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Hans Holmberg <hans.holmberg@wdc.com>, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, libc-alpha@sourceware.org
Subject: truncatat? was, Re: [RFC] xfs: fake fallocate success for always
 CoW inodes
Message-ID: <20251110094829.GA24081@lst.de>
References: <20251106133530.12927-1-hans.holmberg@wdc.com> <lhuikfngtlv.fsf@oldenburg.str.redhat.com> <20251106135212.GA10477@lst.de> <aQyz1j7nqXPKTYPT@casper.infradead.org> <lhu4ir7gm1r.fsf@oldenburg.str.redhat.com> <20251106170501.GA25601@lst.de> <878qgg4sh1.fsf@mid.deneb.enyo.de> <20251110093140.GA22674@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110093140.GA22674@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 10, 2025 at 10:31:40AM +0100, Christoph Hellwig wrote:
> fallocate seems like an odd interface choice for that, but given that
> (f)truncate doesn't have a flags argument that might still be the
> least unexpected version.
> 
> > Maybe add two flags, one for the ftruncate replacement, and one that
> > instructs the file system that the range will be used with mmap soon?
> > I expect this could be useful information to the file system.  We
> > wouldn't use it in posix_fallocate, but applications calling fallocate
> > directly might.
> 
> What do you think "to be used with mmap" flag could be useful for
> in the file system?  For file systems mmap I/O isn't very different
> from other use cases.

The usual way to pass extra flags was the flats at for the *at syscalls.
truncate doesn't have that, and I wonder if there would be uses for
that?  Because if so that feels like the right way to add that feature.
OTOH a quick internet search only pointed to a single question about it,
which was related to other confusion in the use of (f)truncate.

While adding a new system call can be rather cumbersome, the advantage
would be that we could implement the "only increase file size" flag
in common code and it would work on all file systems for kernels that
support the system call.

