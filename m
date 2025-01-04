Return-Path: <linux-fsdevel+bounces-38374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2813AA01136
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 01:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FA8164551
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 00:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6180C846D;
	Sat,  4 Jan 2025 00:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pcsEFWZ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703A636C;
	Sat,  4 Jan 2025 00:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735949053; cv=none; b=iyPWauxDEXG4oXgYkqKd8KWKmteXSSioGX04jFBzEQbX/4iNTWPqsFAw2rgcy8ldbAJwo0ZAIvnPjpp4QybKCNQD8U6qieZQbfQH29+ce/wOwNFX/nu+dsDCEy47mNg1DQcmFr8A5RZ8ueaCckW6y2Wi4gQ4XvN44ovofjUbyqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735949053; c=relaxed/simple;
	bh=Yy++yQU15UJak0FuUUPzCKeuieQdmhTX/GEkQwQJS5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlkSpXM7ebaQLMuJ8UAE6Ll1bfxHdWgP/GDCEBUB0cSNtf0lPmiJOeo2GX9pLaOoG+9bktmjM9mZ6C61EjHqQfaChcHWbT7SNFhPInTfEooI1UjuAm/kOvHklMycjlKcUlO2YIprWaFK2w6xcGwLe24cJNwnvFCwFlk9cis9BEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pcsEFWZ8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KhgMglCFXQO4QMPJMWxdpuWJUo3MEmsC6qyW1d13b0E=; b=pcsEFWZ8AG17xPc1KtJaamACaH
	ej0smnjBTeKivYKWPQpq/Xu9Zsb3tidmZd74Lsig47wt04b8DeEOdRY4ZBtnzq3BPbkgWPfthNnDL
	5k6Zi4iGp2XC1GqomDROvCilnim6DsN8T9HEISE2tyR8LlelDVs56aZAFTEs8euM/HH7x1IlI6c0l
	NiPegODVHvQR3jgc502lA5PmPPQGFOcr2yuTtKN1d6CBk87XLGXjaZYlS9HPHRXUCJ8+eamJ0r/TV
	foGvfCjxsUA7GQXiZ1LXTtfeb5550FuHrZYUl5QK1NNEMIdGRhyS9gLcIZK/xSUCr7vlfkZEuFrnK
	miWX1o/g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tTreC-0000000FE4G-1CrK;
	Sat, 04 Jan 2025 00:04:08 +0000
Date: Sat, 4 Jan 2025 00:04:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: "INFO: rcu detected stall in sys_sendfile64" in Linux kernel
 version 6.13.0-rc2
Message-ID: <20250104000408.GE1977892@ZenIV>
References: <CAKHoSAtoy8UMwt_iXyFdrU1Zh4Q63oZb=BtjbPmJQ3zp+fxQKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHoSAtoy8UMwt_iXyFdrU1Zh4Q63oZb=BtjbPmJQ3zp+fxQKQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jan 03, 2025 at 04:20:28PM +0800, cheung wall wrote:
> Hello,
> 
> I am writing to report a potential vulnerability identified in the
> Linux Kernel version 6.13.0-rc2. This issue was discovered using our
> custom vulnerability discovery tool.
> 
> HEAD commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4 (tag: v6.13-rc2)
> 
> Detailed Call Stack:
> 
> ------------[ cut here begin]------------

Ugh...  Your tool is, by the look of it, some kind of fuzzer.
If that is correct, you really need to do a lot of things
for it to be useful.

"Something done by my userland code has ended up with this spew into
kernel log" _may_ be of use in some cases, but examples you've posted
are not of that sort.

The things missing:
	* what _was_ done by the userland to trigger that?
	* how reproducible it is?
	* which commit (if any) has introduced that behaviour?
Might or might not be available, but "bump the version number to
6.13-rc2" is very unlikely to be it.
	* can the reproducer (if available) be trimmed down?

You really would be better off if you described what that tool is
trying to do and what are your plans for it - missing parts, etc.

As it is, you are dumping a stream of low-quality output on people
who are not in position to do anything useful with it.  In effect,
you are training everyone to ignore anything you post, which is
probably not the desired result.

