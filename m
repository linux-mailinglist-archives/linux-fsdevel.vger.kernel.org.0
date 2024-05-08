Return-Path: <linux-fsdevel+bounces-18979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAF58BF3CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 02:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8DDB1F23AF9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 00:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13566637;
	Wed,  8 May 2024 00:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pyeEWPst"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0A338F
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 00:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715129226; cv=none; b=lhyhP80Vo/Y9Jfm/dsxyqvAcL+VmO5Zc2etxaN0UcPUwvEN/qC+N8Baiz19egJTcGxDDITfps22T1cgVZ4XjtbJ2XILQBYAQsZWU0cqHAcIa3WIjph8ZF5ETMgHchBeyn5jzikv2LuzW6rlOu8aX22N+W30uIufE1E1WwNs3ZjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715129226; c=relaxed/simple;
	bh=4iA153pUeaiyVF85jDdmV8T05YYcZBwB7fVuhdlgu20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFzHCw2e7OMtRGKWinuEgVPU233rouw1OPjpW65kjkY1Fj4rW2urvYN3aALilL1xoct10NQ8vk8+zD80oOt0nuHmh3ROJLZ5t0Kbx6otbg04R2TH6JJLzphPyUbG612BYB5kH7jNhrhs7CHbV269IbexHLJIHaNSyIrlEbRb9cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pyeEWPst; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=U7uqyWdn2SaSL6RZPdyIesCMSrCPjug7Qx6B3IUZgQ4=; b=pyeEWPst+6xFgVz6B5Pyvxkimv
	Pbdfwvikb5hd7C36cKqBnEImgH8WzTbYxrUh5jj8cdTWJEyFF0FteajQVOwbxb2j2OhZrOK3WAcUq
	xP8tE1pdCXwo/s7czlEDtSuIvNoqIEMqD3Cpbn34lMcnHwxgyCwug/wpThJCgcGsXqYqsbfNZL5GD
	7bG3z/8aUboH0uJvK6pJcy890QNNS0nPgdminffrI6LzqP/9vqFxZ5rNoXktlM9DifEbLB1SzgTsY
	RA2+4LO3/er8+yVJGN29Wut1OaNXI2OpKwnWTiIIqhn3vSknOCdA/2ijlWaI0AgAQZy/4glajYrij
	+V26dyrA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s4VSV-00Fbxd-0R;
	Wed, 08 May 2024 00:46:59 +0000
Date: Wed, 8 May 2024 01:46:59 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Dawid Osuchowski <linux@osuchow.ski>, jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fs: Create anon_inode_getfile_fmode()
Message-ID: <20240508004659.GM2118490@ZenIV>
References: <20240426075854.4723-1-linux@osuchow.ski>
 <20240426-singt-abgleichen-2c4c879f3808@brauner>
 <20240508004106.GL2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508004106.GL2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, May 08, 2024 at 01:41:06AM +0100, Al Viro wrote:

> So it looks like you forgot to push vfs.misc as well...

BTW, IME it's useful to have all merges either go from tips of
named branches or from tags - easier to catch that kind of
SNAFU when one forgets to push the topical out.  You can
easily see it in e.g. gitk.

