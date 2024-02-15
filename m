Return-Path: <linux-fsdevel+bounces-11740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71750856B94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 18:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1155B1F228C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 17:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AFC137C5D;
	Thu, 15 Feb 2024 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UnY3NUJl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5E01369A5;
	Thu, 15 Feb 2024 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019413; cv=none; b=skfumU710fSXZSnd9etmgWauwFxxStoVpbMPn4Qh/Dsfvei9+Rgx/CWmc4Vh6XiLK9ICuCdmnhPnXIVQ8YNDPKsEiUlrH9mSNrHcAVLXRatvy3Hu1J4hNc2IvbR+FHmM+3pkc4Ro+grT90LkUIWzorv7dftEKfXl2bfat8usf+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019413; c=relaxed/simple;
	bh=MBYgbt9thc3J7WfFaaO913gRIdhVs7NfyPZHmvhNUg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLfFZH6Fpzwpa3HR5nIoKGRzMpnom+luRyEqXf8+Z4spl/PkkRfNHLHnEIe58kGPljzUpOgJK1aU0enWFjdfJypcdvSG4xtrK6158KFoFJv5AUt7df+WcYmo28LNFhFdYNghIHGZ5SQ4MFgIQcio0DBy0Ya9oO052G0+Iutqjp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UnY3NUJl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2U5uzGzKvE0HPny7iGFcqKFiD+KmN3n5Lkb/TcYmGWs=; b=UnY3NUJlyNvZoF/m6bBufRbld4
	NVetUM6u4TytCvN46KOHqLirQtXHz8/9cBQDfIhm8UdZWel0HUNgM/Ux525SKSFp7kLnF/hga8kyI
	NmiJQ0EnKGfWfvQuvvEOAM1JcLVPoz/5LeiS31dF+6jWGDycKOuXr8oWDNPbLJyQ4KNGFwI4ZksPm
	c7bHkrMTVyjvKCM4GT46sOZoa1tSa9eio+yzYqAzbTp8NS6iIiFog5mulSvCis+6hlwMvMWaYDvZs
	j2+MJYc8GrjWd1O4dzW9bd/anfN/bxKkK/9Jcr4Tq/Evfiu8Gzp8MP6MnL4o8L20EToLS2gSRSQDX
	2v45SaUQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rafsB-0000000HFe7-1gNN;
	Thu, 15 Feb 2024 17:50:11 +0000
Date: Thu, 15 Feb 2024 09:50:11 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: David Disseldorp <ddiss@suse.de>, Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH fstests] common/config: fix CANON_DEVS=yes when file does
 not exist
Message-ID: <Zc5O07ug7e4HVmKD@bombadil.infradead.org>
References: <20240214174209.3284958-1-mcgrof@kernel.org>
 <20240215145422.2e12bb9b@echidna>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215145422.2e12bb9b@echidna>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Feb 15, 2024 at 02:54:22PM +1100, David Disseldorp wrote:
> On Wed, 14 Feb 2024 09:42:08 -0800, Luis Chamberlain wrote:
> 
> > CANON_DEVS=yes allows you to use symlinks for devices, so fstests
> > resolves them back to the real backind device. The iteration for
> > resolving the backind device works obviously if you have the file
> 
> s/backind/backing

Zorro, can you do the minor edit?

> > present, but if one was not present there is a parsing error. Fix
> > this parsing error introduced by a0c36009103b8 ("fstests: add helper
> > to canonicalize devices used to enable persistent disks").
> > 
> > Fixes: a0c36009103b8 ("fstests: add helper to canonicalize devices used to enable persistent disks"
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> Reviewed-by: David Disseldorp <ddiss@suse.de>

Thanks!

  Luis

