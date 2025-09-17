Return-Path: <linux-fsdevel+bounces-62017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF754B81C7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 22:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF237A87C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 20:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E39C293C44;
	Wed, 17 Sep 2025 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pXM2EaFe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C6A34BA33;
	Wed, 17 Sep 2025 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758141280; cv=none; b=RdWA2js1SER7FC0WDOnItfH8EpsZ6r5/1bRLN52XLPlLGDNQmVN525du9c1+HK290VYt0XQ+0Nf/BXeIsWveffLOEBJStrInBkTjBHwv8wq9VdWSr6pusaSwzF2rG5mkvaXZNG06E+7P1VE6rArlpgzdNhE17I8+aLUl/THKJds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758141280; c=relaxed/simple;
	bh=wJ2H9w5VvxNYHCRcsQg5Z1g8vTDOiTZ9tN4zAqkcR8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4WorLdNSxcCtXSKNI0ZDGudnByskmEyPBqK4sBmjHmYfMNKJ9wBVqwFsdxYmzKNmI/3U8qjgkKYnUTTcdlWo82XeApRlF18RTXWB7DkZs5t/34Eftmkx46UUFVwIl0xL7spO+hy3wlK+HS4cSohiP7CA/sGkZpiRc4T0u5tAZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pXM2EaFe; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i2FyUTSryb04l5gvAh3w6KlExZLY4l7x5oIgcrw5oM0=; b=pXM2EaFeZioAqlsirFHgLLE3js
	Y6ZdJCSBwDng3gOcV5WrmK6EhVOHSK4rJmZpJ51Q2DI8/6SQUpYlrYmV5VTZd0pbu1v5+pd1W+kXn
	DjAmnWP6aELjliaJecTwfU0LS3+eR9EwDBl5PaZ/Ul8mWoT5gfh8l7J+tn/7CsvdgkazhugGbKKP2
	uBFJ84s3j+lPkoWBivvqOnnAHKopZTVqkYVyIKLduQOtNYdFYmqcrrPtMuwNtHHNE6cAv/0QSWTn/
	GxWvdnPe1vccOBexPhYIZTogN+P/3pofZt80l5aSeaLDRtnFZsRTvxhLCkJ2l4OMS624z0RLgm7SD
	hD18Zszw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyyrL-00000007w67-1w83;
	Wed, 17 Sep 2025 20:34:35 +0000
Date: Wed, 17 Sep 2025 21:34:35 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Max Kellermann <max.kellermann@ionos.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	ceph-devel@vger.kernel.org
Subject: Re: Need advice with iput() deadlock during writeback
Message-ID: <20250917203435.GA39973@ZenIV>
References: <CAKPOu+-QRTC_j15=Cc4YeU3TAcpQCrFWmBZcNxfnw1LndVzASg@mail.gmail.com>
 <4z3imll6zbzwqcyfl225xn3rc4mev6ppjnx5itmvznj2yormug@utk6twdablj3>
 <CAKPOu+--m8eppmF5+fofG=AKAMu5K_meF44UH4XiL8V3_X_rJg@mail.gmail.com>
 <CAGudoHEqNYWMqDiogc9Q_s9QMQHB6Rm_1dUzcC7B0GFBrqS=1g@mail.gmail.com>
 <20250917201408.GX39973@ZenIV>
 <CAGudoHFEE4nS_cWuc3xjmP=OaQSXMCg0eBrKCBHc3tf104er3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHFEE4nS_cWuc3xjmP=OaQSXMCg0eBrKCBHc3tf104er3A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 17, 2025 at 10:23:00PM +0200, Mateusz Guzik wrote:

> This should be equivalent to some random piece of code holding onto a
> reference for a time.

As in "Busy inodes after unmount"?

> I would expect whatever unmount/other teardown would proceed after it
> gets rid of it.

Gets rid of it how, exactly?

> Although for the queue at hand something can force flush it.

Suppose two threads do umount() on two different filesystems.  The first
one to flush picks *everything* you've delayed and starts handling that.
The second sees nothing to do and proceeds to taking the filesystem
it's unmounting apart, right under the nose of the first thread doing
work on both filesystems...

