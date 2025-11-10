Return-Path: <linux-fsdevel+bounces-67647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 733A9C45AE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 10:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0922A4E9AC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 09:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8261C2F7444;
	Mon, 10 Nov 2025 09:38:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697F9222562;
	Mon, 10 Nov 2025 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767516; cv=none; b=dq2gg+4eHXusp/j8+sUW71ceyCC/+BFgXyE3aVtZ4GAlwi20FR3rMUjahx2Z/OILtDgsdK6U4SVSbb+KGcbyn7oa/lxTbq9NfdigTjmSErclMiXcmC0vquAuOP7G41xl2YoInf8iDOboHPJIp/Wv1G8owUq4jTyAEqdtOFak6go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767516; c=relaxed/simple;
	bh=Fx4JZOM5pwAO4tGuBfnow30CBBHhIRX/+mjErIC9sNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOtAJT9owRAxkcJvmRNxOYE6d0c1+7KGAMnOE5+S2v7vvfRI3U9hnS0KydaU+AsGF/UaaSWmfei0wsBteW4A24soIBAedOvnFQzMxeiFxF+Q2NJhXhzR875z4mEpWK3OhLwnKdQynYcgbsW/haMtuLv0nn1+/0gVhto282T97Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1B978227A87; Mon, 10 Nov 2025 10:38:29 +0100 (CET)
Date: Mon, 10 Nov 2025 10:38:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Florian Weimer <fweimer@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	Matthew Wilcox <willy@infradead.org>,
	Hans Holmberg <hans.holmberg@wdc.com>, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	libc-alpha@sourceware.org
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
Message-ID: <20251110093828.GC22674@lst.de>
References: <20251106133530.12927-1-hans.holmberg@wdc.com> <lhuikfngtlv.fsf@oldenburg.str.redhat.com> <20251106135212.GA10477@lst.de> <aQyz1j7nqXPKTYPT@casper.infradead.org> <lhu4ir7gm1r.fsf@oldenburg.str.redhat.com> <20251106170501.GA25601@lst.de> <878qgg4sh1.fsf@mid.deneb.enyo.de> <aRESlvWf9VquNzx3@dread.disaster.area> <lhuseem1mpe.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lhuseem1mpe.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 10, 2025 at 06:27:41AM +0100, Florian Weimer wrote:
> Sorry, I made the example confusing.
> 
> How would the application deal with failure due to lack of fallocate
> support?  It would have to do a pwrite, like posix_fallocate does to
> today, or maybe ftruncate.  This is way I think removing the fallback
> from posix_fallocate completely is mostly pointless.

In general it would ftruncate.  If it thinks it can't work without
preallocation at all the application will fail, as again the lack
of posix_fallocate means that space can't be preallocated.


