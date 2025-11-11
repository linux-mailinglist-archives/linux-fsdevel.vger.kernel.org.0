Return-Path: <linux-fsdevel+bounces-67931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D17C4E349
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 14:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF6E3AC91B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 13:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F8434250A;
	Tue, 11 Nov 2025 13:41:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1038033121E;
	Tue, 11 Nov 2025 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868461; cv=none; b=IzIihlEJZleOhwq2CxWWfvAmEC6Gje/uxVC+tH57ZiMmfL1IBd1epdo58Cea6lpS724DnkRlcuALH+0LnOP5vv6fAQ7sMfIJhz8BaDcFxCoLXwUGU0loXOrZF7BYk2xAtOk7ZOcPLszyyGjAtmbldr5k98SJ8FARjfkv1BkkBLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868461; c=relaxed/simple;
	bh=XxB0ZGyv31koe51CUNbQjeRNDFOX4C7Jft4vuVG+Thc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kw6k6QJ5j4ckRJCGe+J2Te5vWYke/odYJGnq6FDKaXXjLincvrgB13QW+rbb+rFgJRBydjhQkX5wxw66W6mzPx+BTJ0JANT9S4X+DYqdyw85NZeDZyZVoVqOIWfdIvVFyeQAMpXqT9WJ/NHT9yvLYdmzg68TlA1oQsPHo7CvJys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 761E5227AAA; Tue, 11 Nov 2025 14:40:56 +0100 (CET)
Date: Tue, 11 Nov 2025 14:40:56 +0100
From: hch <hch@lst.de>
To: Florian Weimer <fweimer@redhat.com>
Cc: hch <hch@lst.de>, Hans Holmberg <Hans.Holmberg@wdc.com>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
Message-ID: <20251111134056.GA748@lst.de>
References: <20251106133530.12927-1-hans.holmberg@wdc.com> <lhuikfngtlv.fsf@oldenburg.str.redhat.com> <20251106135212.GA10477@lst.de> <aQyz1j7nqXPKTYPT@casper.infradead.org> <20251106144610.GA14909@lst.de> <8b9e31f4-0ec6-4817-8214-4dfc4e988265@wdc.com> <20251111090547.GC11723@lst.de> <lhu4ir0kiei.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lhu4ir0kiei.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 11, 2025 at 10:50:13AM +0100, Florian Weimer wrote:
> > On Tue, Nov 11, 2025 at 08:31:30AM +0000, Hans Holmberg wrote:
> >> In stead of returning success in fallocate(2), could we in stead return
> >> an distinct error code that would tell the caller that:
> >> 
> >> The optimized allocation not supported, AND there is no use trying to
> >> preallocate data using writes?
> >> 
> >> EUSELESS would be nice to have, but that is not available.
> >> 
> >> Then posix_fallocate could fail with -EINVAL (which looks legit according
> >> to the man page "the underlying filesystem does not support the operation")
> >> or skip the writes and return success (whatever is preferable)
> >
> > The problem is that both the existing direct callers of fallocate(2)
> > including all currently released glibc versions do not expect that
> > return value.
> 
> That could be covered by putting a flag into the mode argument of
> allocate that triggers the new behavior.

Which basically makes it a new mode, just encoded as a flag for all
purposes ;-)


