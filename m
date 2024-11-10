Return-Path: <linux-fsdevel+bounces-34166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463D49C3524
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 23:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730551C21669
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Nov 2024 22:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A092D158D79;
	Sun, 10 Nov 2024 22:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P5VZaYVy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637AA17C91;
	Sun, 10 Nov 2024 22:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731278930; cv=none; b=nh1eqL0X41ra5p7NmVlgTzBVJH5gew3cpmEcPLUhkcchGLG8j/Hg03OvjCV9mMjwM6IdUGOrwEt3ZgT8E0M8OiqcEa+3OxSdLXfMFj7ovVMA7PWAllqHoKxul5XBMRL4Z5OmZ2I3aExBWkBhWapnPXgIsSWrEYxpAJG37mzXhWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731278930; c=relaxed/simple;
	bh=dmSr1yNL31xbQOZB+w4HaSNYSV12QslQ+ubaTRjUIQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s99n+uvkuBbWSJruu1fHkT1AYa3+8HVnUqpjRDh+EmOt0Ou4tfVibdmAxhTkj+36dqQsH4xwPYh15yNq4Fr09MFeAOOEx+S6ZUK71F8uNlQcrkFS5TGS7HNDbjuf49CUXoDCejAZgJfnTXZ3Si3FvOuxGH6rZGygL1hcBTIl1p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P5VZaYVy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dmSr1yNL31xbQOZB+w4HaSNYSV12QslQ+ubaTRjUIQI=; b=P5VZaYVyGK4K2D8HH9F8QchkxZ
	VGTjvfJfY21eYyY9msQs5zCg/Vgz4tBclrBSjh5rd7QNMNUH23HS52JBBoH5LuSmAgtK+jK6P9nwx
	b1KkCyDF/o8v89dtedH7xgpCCvHoK/xRsOwyj+9hpo9cPt3Fg0PEj1U9UBWN3pKpGmhIawEtLrsJn
	RQtKFFrwLV8MN+1Hsw6bhn3Nerp08Sdl4LqSzNlu5u/VrEA0NTUlQs99Imfv3XsJYGhYt5BtTGos8
	Ok/EjywuY510iuPShkw2JAOLyP4081Byq7M3uuNmvDimuYwlkUxVKfaOurmGvrn06AXLN3304FQwt
	cRVDkyeA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAGjc-0000000BwQw-1muw;
	Sun, 10 Nov 2024 22:48:44 +0000
Date: Sun, 10 Nov 2024 22:48:44 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
	fstests@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	stable@vger.kernel.org, Leah Rumancik <leah.rumancik@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: generic/645 failing on ext4, xfs (probably others) on all LTS
 kernels
Message-ID: <ZzE4TEPz5xuK6Y4M@casper.infradead.org>
References: <20241110180533.GA200429@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241110180533.GA200429@mit.edu>

On Sun, Nov 10, 2024 at 01:05:33PM -0500, Theodore Ts'o wrote:
> (2) How much do we care that generic/645 is failing on LTS kernels?
> Are user/applications going to notice or care?

... if userspace applications won't notice this breakage, then why do we
run this test?


