Return-Path: <linux-fsdevel+bounces-35651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAE69D6ACA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 19:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69119281BF5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 18:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ECB15098F;
	Sat, 23 Nov 2024 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HFvI8M8j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CFB17C2;
	Sat, 23 Nov 2024 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732386463; cv=none; b=cEII47AycpW8IL8FW+JimkgURCWwQGxifaDyhyHSLJj7CVEeujqUXjY0mOHGFdT2EG7SZL60fCBLeM4rYdebalkxtdbcCF2yAXr4FHBK1/ihmEseU9Mzc6UWieQ/8m7uJslDEAtUNySbLhw2mal8di0BN+SxXPiR4mjzd8z8q24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732386463; c=relaxed/simple;
	bh=LA4ip6xEZWpJXB5jy+aOmy3SYHg9OHysBsS8/gpV4DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvBD4jPxc4zMeXWngimRVjT//DLi6wevjP+xWSn0ccaWbUBfvfI2zZKbU8kfFGryUJ6vrYMEUpWldz81po/XkuEZ4eAanqYfXC4rFaJILC7u6j9nZ+7hpjPVUU99oi/aUX4zcA5HQkhUSBN1HbqWF1jrVrs1Qx8B6erUHbio41g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HFvI8M8j; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OpZoXe5XWl4Cs2t4USf16gKmE4quBTnPnOIK7o601Ps=; b=HFvI8M8jDEJBR/p6x+unkkaMk5
	y/49+olZd0HRffX7KpcdHHSvpiw8VN+w48UQiT5Eu7BXB+mje70iVU6B3IcoLGUQWapw8qcr7nkKR
	M5hnmFTjwwyNw1hkbhbbdJn9HYticYo1pX0HhymGVU7SVZigslSO2B/LY6HatP+S+1hD20feLiIXh
	+GLvpUSocobuvXtuzpMoruZoa1sCZ6MbyO+TUH9AwmlP0V9VQSHlWT+rJD3mJN003/KID8veqnX/F
	G2ODJ0H/UX9sZkgctkFl7NRP5P96QWNSSp5lTM9++/H39nWvKhHlqdeto2OIqBQSHEkGYCJgwTmys
	DSJuAMTw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEuqw-00000000tCe-3lDS;
	Sat, 23 Nov 2024 18:27:30 +0000
Date: Sat, 23 Nov 2024 18:27:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jinliang Zheng <alexjlzheng@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, mcgrof@kernel.org, kees@kernel.org,
	joel.granados@kernel.org, adobriyan@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	flyingpeng@tencent.com, Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH 0/6] Maintain the relative size of fs.file-max and
 fs.nr_open
Message-ID: <20241123182730.GS3387508@ZenIV>
References: <20241123180901.181825-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123180901.181825-1-alexjlzheng@tencent.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Nov 24, 2024 at 02:08:55AM +0800, Jinliang Zheng wrote:
> According to Documentation/admin-guide/sysctl/fs.rst, fs.nr_open and
> fs.file-max represent the number of file-handles that can be opened
> by each process and the entire system, respectively.
> 
> Therefore, it's necessary to maintain a relative size between them,
> meaning we should ensure that files_stat.max_files is not less than
> sysctl_nr_open.

NAK.

You are confusing descriptors (nr_open) and open IO channels (max_files).

We very well _CAN_ have more of the former.  For further details,
RTFM dup(2) or any introductory Unix textbook.

