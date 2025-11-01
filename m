Return-Path: <linux-fsdevel+bounces-66654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6282C278B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 07:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E083BDBDA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 06:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C4927FD68;
	Sat,  1 Nov 2025 06:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="h6vT9EhZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC8A126C17;
	Sat,  1 Nov 2025 06:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761977165; cv=none; b=ER9z5SuiuibdbMYfxNjiXQnj1XRi/4xLvxRKWrZbQq6oDQ75d4RWrA52ZoFO0hEjqefv0/jxZR2JgYaEWElqS9htueYqy7ZIuINqzqdu6j8+ciD+/JhhseNZX6op4rG41ACSrwZZqeGYlN5IepbtgWfOuHy2mZr5epKpB40Hwb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761977165; c=relaxed/simple;
	bh=gYrncJmArK3RNa4qqvrSOt4IFgnoAuk+me9d9nS8WBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7aMbLVKyyBXkP+pfKa5AMgoK5qa1H2UdZiFXKLWmfm4gPawUz3vaXlMBw5SNsTOkQ2682YDcZ63hfzVyMDJPIAGQzc7dTdRjKKI1Qbc0eyMdB+LL06bQiWKUSpLKjdiA9ExRxUB+3gEs4cVznTK9onqLv9qNeC/N5NieAgUt4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=h6vT9EhZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XWsNnOEHkuis54uMq6f1l6L+DC+6mSqsUWNG6xGTRgI=; b=h6vT9EhZLLPHTd0JmdDJcWFroi
	nMXA1nQtgP2vCHie1ZQbT/mBSs9GtcBJB7KTavV4K/JXn9X083UtqPJMGyvYxHJz1hdefrMvC64t8
	Sg/v+C+jz2pVLwfsTDzFKWdNpyo94JjgHzesdd8LWiBfKmfjelUUHZ0j3Cc0HrpVHy9Zda93olCbw
	7VSZGyOb5miPYFO9Mz35RlI8Oo/bDlPIgQdN4laD4apbxbp4rIwY9CCmYJAOw4E/PJ136dUX1U8vl
	h3Ncns7+1vF+DhtteztWHb1bKMFKDXcKr72wy6PXXRjNxo6D8bUtes4Qlute16OV+WpWEOicfUWsb
	NwrcrI1w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vF4kO-00000005EgC-1gtl;
	Sat, 01 Nov 2025 06:05:56 +0000
Date: Sat, 1 Nov 2025 06:05:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: touch up predicts in putname()
Message-ID: <20251101060556.GA1235503@ZenIV>
References: <20251029134952.658450-1-mjguzik@gmail.com>
 <20251031201753.GD2441659@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031201753.GD2441659@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Oct 31, 2025 at 08:17:53PM +0000, Al Viro wrote:

> 0) get rid of audit_reusename() and aname->uptr (I have that series,
> massaging it for posting at the moment).  Basically, don't have
> getname et.al. called in retry loops - there are few places doing
> that, and they are not hard to fix.

See #work.filename-uptr; I'll post individual patches tomorrow morning,
hopefully along with getname_alien()/take_filename() followups, including
the removal of atomic (still not settled on the calling conventions for
getname_alien()).

> I'll post the ->uptr removal series tonight or tomorrow; figuring out the right
> calling conventions for getname_alien() is the main obstacle for (1--3) ATM...

