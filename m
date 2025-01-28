Return-Path: <linux-fsdevel+bounces-40248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE30A211FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 20:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6B3166631
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 19:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BA31DED66;
	Tue, 28 Jan 2025 19:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ab8M+HZ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C94913BADF;
	Tue, 28 Jan 2025 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738091448; cv=none; b=GkBn3rU/kHFlnLu3eVVOqaUBhrAC+oK8NZ/k/pNgcLx9sAgW8KLM7y8qUObmM8+EYpqkHkzwj8DdVLpf9PdqPC5lhLpn45uaV3Phh68Tc/mOruZOEdzHDzB0HGAM88oOz9KTKzcAl7Th7DwRPqrXNA2NpndAXuLNecCqj8MauFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738091448; c=relaxed/simple;
	bh=jvVjfJzusy/T2TFETbNIWWcoexj5Y83nv715DHc81ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7bS349KozohkphG40CzPAVyw+siJWoS5uXrLRgJPeKOH5tjyXEcAvHHtk7Y69ASSk8zQcI+b5U2tIBuIIjlaREdSEGCZOlX8pNPUPC3fpFo6izIKh8mIodmqWgNxHHuDj3ihV1v+3pdBlVvY9Wozu0/AGA7rFGoJmRvZXMKaOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ab8M+HZ6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bbMLXJyynd4nYkMR/7HO4+Jzw6FmMDgG7jfaJOUdBxU=; b=ab8M+HZ6Fn9AEtWNK8cMRzU4wU
	+LQjbdNX2p5owXiTC3COpG92H077aarRc+F98k223qJ2pMQl++mekh2N0zGEIhuOzV7F1irS0OO3H
	F9ip2PZ63/8wtaqbHrRBi1YE9HagnXbIHaqpKpotO/mouutbTzn62cJC1J1EL2cJz2FfZ50UvKgf0
	S3ww+gTYEIueP/MSpwlY3GaBfC/Eg2zfhUird0WRgZTsFPfDXiZ7ACcceoogRcYrO+R/M9gmGZIVh
	wmxV8M1V2GPhL5xnCkckO/KT0LuECf8BFyi6rNWi6M+B3BOEtSyyJwCwIwvZ4lV9K18Q8LAHUt64I
	BkS8SjDA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tcqyw-0000000EWLb-2hCw;
	Tue, 28 Jan 2025 19:10:42 +0000
Date: Tue, 28 Jan 2025 19:10:42 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [linus:master] [do_pollfd()]  8935989798:
 will-it-scale.per_process_ops 11.7% regression
Message-ID: <20250128191042.GO1977892@ZenIV>
References: <202501261509.b6b4260d-lkp@intel.com>
 <20250127192616.GG1977892@ZenIV>
 <Z5ilYwlw9+8/9N3U@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5ilYwlw9+8/9N3U@xsang-OptiPlex-9020>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 28, 2025 at 05:37:39PM +0800, Oliver Sang wrote:

> > Just to make sure it's not a geniune change of logics somewhere,
> > could you compare d000e073ca2a, 893598979838 and d000e073ca2a with the
> > delta below?  That delta provably is an equivalent transformation - all
> > exits from do_pollfd() go through the return in the end, so that just
> > shifts the last assignment in there into the caller.
> 
> the 'd000e073ca2a with the delta below' has just very similar score as
> d000e073ca2a as below.

Not a change of logics, then...  AFAICS, the only differences in code generation
here are different spills and conditional fput() not taken out of line.

I'm somewhat surprised by the amount of slowdowns, TBH...  Is there any
chance to get per-insn profiles for those?  How much time is spent in
each insn of do_poll()/do_pollfd()?

