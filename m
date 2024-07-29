Return-Path: <linux-fsdevel+bounces-24385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CB693EA35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 02:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C021C20615
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 00:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0287E8F44;
	Mon, 29 Jul 2024 00:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="K0Vz2vMk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7332838B;
	Mon, 29 Jul 2024 00:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722211289; cv=none; b=BMsfeYbriFY1IWtBjnt5tuHqUpnFtVw759/s6GpxtLCFLfVDEgdxn4I3XhGmNUO3WOA0Fvey6SWDHofjecYRegRwoKgJVoWhZ6vtSIUT2YfrGl98wT1Yvop6A3k720WfhK9DJzs7l8EgpYyeYHik7Jizu3nDttopbu7ss3BBW7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722211289; c=relaxed/simple;
	bh=Y17ivoUEZqJMec1bdUlKse1yfK2OEne8uUS4d7z9pdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W44pHBoaG/3Fn/CTm2QkqZHIkQk9PbKQubppobYVo9HOvF93vmhxi9drxApytwbhQ0vWPAtmt7u1MNTsvUVQhIpbSKiRBUdNwDwEyWrWX1wLiMl1kVyu3Oxt0g4cdFzmd6aH+5LSatZiffmNN8xo8hMEiBqt+T9y6exvRCGB6Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=K0Vz2vMk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1iJrhw/cvkglGTTLotlyOAN80Woc3csC6LR3rVH+UOA=; b=K0Vz2vMkgB3eYtKojYPQO3NJBf
	J4CVTPwMpvqdjynwfIWVs8E1pchr11aQTyEZ0cFbrBZkweB0B4ISTeSjZemNXhDkyWAE0YPJZk9PA
	cPpMRR9tMUXcfO693sQMh2kic2IkXvP7Zh2B5wvl58/r8wjlxjgn/rPap0gDNkv0oMgAOv83FNgF5
	SAndXyO92NaKsYdhreZxIgk2zZF2REybzGLsUIxqu1HZ+c5rE8B7ONN+ONRligLdqbRsIo919bCxM
	a6AHetFHrectBW3L6EmLTGPKLbwTpXm7cvtJ735iGP7bwI0ZTuaco2ja1ZjuRdcDbRtAilSIWlvGR
	D/dFYMWg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYDpM-00000002ZPg-24By;
	Mon, 29 Jul 2024 00:01:24 +0000
Date: Mon, 29 Jul 2024 01:01:24 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Steve French <smfrench@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	CIFS <linux-cifs@vger.kernel.org>
Subject: Re: Why do very few filesystems have umount helpers
Message-ID: <20240729000124.GH99483@ZenIV>
References: <CAH2r5ms+vyNND3XPkBo+HYEj3-YMSwqZJup8BSt2B3LYOgPF+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5ms+vyNND3XPkBo+HYEj3-YMSwqZJup8BSt2B3LYOgPF+A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Jul 28, 2024 at 02:09:14PM -0500, Steve French wrote:

> Since umount does not notify the filesystem on unmount until
> references are closed (unless you do "umount --force") and therefore
> the filesystem is only notified at kill_sb time, an easier approach to
> fixing some of the problems where resources are kept around too long
> (e.g. cached handles or directory entries etc. or references on the
> mount are held) may be to add a mount helper which notifies the fs
> (e.g. via fs specific ioctl) when umount has begun.   That may be an
> easier solution that adding a VFS call to notify the fs when umount
> begins.

Huh?

"references on the mount being held" is not something any userland
helpers have a chance to help with.

What exactly gets leaked in your tests?  And what would that userland
helper do when umount happens due to the last process in given namespace
getting killed, for example?  Any unexpected "busy" at umount(2) time
would translate into filesystem instances stuck around (already detached
from any mount trees) for unspecified time; not a good thing, obviously,
and not something a userland helper had a chance to help with...

Details, please.

