Return-Path: <linux-fsdevel+bounces-8675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC2383A147
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 06:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0F61C274D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 05:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB54DDAF;
	Wed, 24 Jan 2024 05:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H8Uiidv2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8161C155
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 05:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706073694; cv=none; b=hgmILG5ABbATyH7DpJ/cIesm/bmnupwqw1Iznmfk3bEbTMuFBwytgkxrI2N41Nii9I2dNGdf7Kd0THX1lg/GtPbgL8309GV20lKrdMKRCjB2C05NnQOc1cF3PTfsDV4Dp6hvUY7fCe++lYNn0k0g3Rr2EqgSo8IrRIZCE8DUkoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706073694; c=relaxed/simple;
	bh=CKb2tyZIP+FuZ5e1BqO9asq5O0csnOnEV8Yuykngyks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpD2EPnustDCPu4azw3zJUkuTut6F3HOXjXBlLVFU9NgNoLoK2RswkB5g/6Q0lbk5GIPi9u6t2TO8VGJZ4rkI9ZjZlK7an8AHOxOrwU/ZJJqGbuXESeauJcWAdu8J6wvFUtj9zCBXFOClhKteWxzVdCZPYm8pED8AN69KjAL2JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H8Uiidv2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zB3dQVS8dpyiY60aMdRu0nc0YEkvvS/7aqkagc80g8M=; b=H8Uiidv2osxA4OJPaq3pvPzo3c
	S6sVXgwxUbLpv68z5Wb2BNeEXn+PXADWglP3Aq5WWbfFhzcJgQwiMonf+O7C/MYlBfv9REc0TXccM
	ZY860AO5RGv2PU3Ss66g4lyvkjDYR1SmGpi4b3C6OCRl3ZuJx445y0P0rJecyW21wGSyK0bmIFbHL
	f3Qw4HLJzeJfmR9J/MTuHSB3d6bH8FYCgaa0zhxwQjJ0AQTSVPR72fC/1b3vYYR15cf4v76ex+gug
	ARlqhUWviTJCqpaDsnzJqHaWlABMKM2k49j7JO5eLpwPidCm02AMAuf9Y0LyeH3ml0PzHCH+xWxkR
	3p66CYwA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSVhZ-00000005Uqu-3ZU9;
	Wed, 24 Jan 2024 05:21:29 +0000
Date: Wed, 24 Jan 2024 05:21:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
	"sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"Andy.Wu@sony.com" <Andy.Wu@sony.com>,
	"Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: Re: [PATCH] exfat: fix file not locking when writing zeros in
 exfat_file_mmap()
Message-ID: <ZbCeWQnoc8XooIxP@casper.infradead.org>
References: <PUZPR04MB63168A32AB45E8924B52CBC2817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZPR04MB63168A32AB45E8924B52CBC2817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>

On Wed, Jan 24, 2024 at 05:00:37AM +0000, Yuezhang.Mo@sony.com wrote:
> inode->i_rwsem should be locked when writing file. But the lock
> is missing when writing zeros to the file in exfat_file_mmap().

This is actually very weird behaviour in exfat.  This kind of "I must
manipulate the on-disc layout" is not generally done in mmap(), it's
done in ->page_mkwrite() or even delayed until we actually do writeback.
Why does exfat do this?



