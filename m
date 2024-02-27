Return-Path: <linux-fsdevel+bounces-12911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D008685BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 02:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40B3284F37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 01:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8FD4C8B;
	Tue, 27 Feb 2024 01:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NlFVz9jq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FF34C6F
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 01:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708997268; cv=none; b=htOnuVlua15ZJ5PSU2q15QScCNp1MshVDArFFRxpe2VGqdj8MWl1X6fDPt9+0eOCZKyxd0c9LCGTeXlmVADQi0ibusANZiuS2EfLEI5T80pnWjT/GCkqr+uCl9khTR1aZwj4YxIevgjlHU4HZ7oK+gK0dz9zG6wZf4DyF7qnqfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708997268; c=relaxed/simple;
	bh=z087l6hQkJGoRMgoD8JQ8fv0QSMskIjmtAjI3IVwQU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyEhpNkFMVsane9hts/AE0FNelSaLHGO122S2Pe4bl3LPrQAhmEqQjU7ykm1WPw0viE4YNmmFO+xk/m1sDBoSem9b3TRHK/9ikXtCT2g39ZJ5QpoICwomFcCRF3npCWp+eU1AoCNYUW7Y35+EaBMMWdvHLs9f3dm5qfYayr9nF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NlFVz9jq; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 Feb 2024 20:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708997263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCK/NQhBoPr81ElFtD9qUO3bzHMkQYrIvvTQEfD4gpE=;
	b=NlFVz9jqeDN/b68Vm3ZNO23eXtexuoRYiuxteYWlihUaOeHzk3ctb8cK3Gk3oE0f8jKq7j
	Y5TYGJUn4YpkSMGQMp6LX+ZACoZNhdQ2C1k4ULxaW/aVSgmOCcjH+MQKWvLUjo3LkieRy1
	z78/na8HwD5La2CEat5JpTcf/p4Za8s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Alexander Viro <aviro@redhat.com>, 
	Bill O'Donnell <billodo@redhat.com>, Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH RFC] vfs: always log mount API fs context messages to
 dmesg
Message-ID: <rzgt47eohuiuattzg7avpsnk4zci7avpwd4p7viiuec3s7t75k@q2rp2hjastzq>
References: <9934ed50-5760-4326-a921-cee0239355b0@redhat.com>
 <20240223-beraten-pilzbefall-6ca15beab35b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-beraten-pilzbefall-6ca15beab35b@brauner>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 23, 2024 at 04:06:29PM +0100, Christian Brauner wrote:
> On Thu, Feb 22, 2024 at 09:22:52AM -0600, Eric Sandeen wrote:
> > As filesystems are converted to the new mount API, informational messages,
> > errors, and warnings are being routed through infof, errorf, and warnf
> > type functions provided by the mount API, which places these messages in
> > the log buffer associated with the filesystem context rather than
> > in the kernel log / dmesg.
> > 
> > However, userspace is not yet extracting these messages, so they are
> > essentially getting lost. mount(8) still refers the user to dmesg(1)
> > on failure.
> 
> I mean sure we can do this. But we should try without a Kconfig option
> for this.
> 
> But mount(8) and util-linux have been switched to the new mount api in
> v2.39 and libmount already has the code to read and print the error
> messages:

Why was there not an API flag to indicate when userspace is listening
for these?

