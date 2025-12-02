Return-Path: <linux-fsdevel+bounces-70430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD8AC9A1C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 06:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906443A5D58
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 05:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DFB2F691C;
	Tue,  2 Dec 2025 05:41:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CC32951A7;
	Tue,  2 Dec 2025 05:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764654072; cv=none; b=hXfmEGEzTEtlSI9eya/u+m3bsg0RB+z/CFT3xxgP6fmGPp70ybkrQzqLHRTDog94xlYyJXcVkXcNz4IqNgT3h7c/XyGcpnXmT4DEGb7dQyy+LTyBI0GOFXTpD1KsBtRn4UGD21JdB1ZNpp9OwdgQbu5fFU8Te0mzTpyUf3pTTMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764654072; c=relaxed/simple;
	bh=ygwkRLf7Hxrgygs5etYPgdBT/a1ZHnFxKchbjkoqSrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tdagto4BBDNxWd8OTSfUEiQygm2Wn8H3Mbsc6L9gsh1h/kZO9TFqisCoj7CoBhqcfC4Q5vrJq8p/soSElCbOEZazGlASBsdoraQniTAEjxVgBhdzB0qX79zJqyvcGFqsTeQZEG63Z2+bItZ1h+Ny8CRxn4SCh8dweNYGADH7ytI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A291168AA6; Tue,  2 Dec 2025 06:41:05 +0100 (CET)
Date: Tue, 2 Dec 2025 06:41:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, tytso@mit.edu, jack@suse.cz, djwong@kernel.org,
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com,
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
	ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
	gunho.lee@lge.com
Subject: Re: [PATCH v2 01/11] ntfsplus: in-memory, on-disk structures and
 headers
Message-ID: <20251202054105.GA15524@lst.de>
References: <20251127045944.26009-1-linkinjeon@kernel.org> <20251127045944.26009-2-linkinjeon@kernel.org> <aS1AUP_KpsJsJJ1q@infradead.org> <aS1WGgLDIdkI4cfj@casper.infradead.org> <CAKYAXd-UO=E-AXv4QiwY6svgjdO59LsW_4T6YcmJuW9nXZJEzg@mail.gmail.com> <aS16g_mwGHqbCK5g@infradead.org> <aS2AAKmGcNYgJzx6@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS2AAKmGcNYgJzx6@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 01, 2025 at 11:46:08AM +0000, Matthew Wilcox wrote:
> On Mon, Dec 01, 2025 at 03:22:43AM -0800, Christoph Hellwig wrote:
> > On Mon, Dec 01, 2025 at 07:13:49PM +0900, Namjae Jeon wrote:
> > > CPU intensive spinning only occurs if signals are delivered extremely
> > > frequently...
> > > Are there any ways to improve this EINTR handling?
> > > Thanks!
> > 
> > Have an option to not abort when fatal signals are pending?
> 
> I'd rather not add a sixth argument to do_read_cache_folio().

I can understand that, OTOH unexpected failure modes aren't nice either.

> And I'm not sure the right question is being asked here.  Storage can
> disappear at any moment -- somebody unplugs the USB device, the NBD
> device that's hosting the filesystem experiences a network outage, etc.

Yes, and we fully need to handle that.

> So every filesystem _should_ handle fatal signals gracefully.

Absolutely,

> The task
> must die, even if it's in the middle of reading metadata.  I know that's
> not always the easiest thing to do, but it is the right thing to do.

A few fatal_signal_pending isn't helping with that.  What is needed is
to make sure all error completions happen in this case, preferably
in a timely way so that all resources get unlocked and cleaned up.

A strategic fatal_signal_pending() here and there can help to speed this
up, but is has not effect on the fundamentals of file system error
handling.  In fact in some places it will make the error handling much
harder because you now have to handle extra corner cases.

