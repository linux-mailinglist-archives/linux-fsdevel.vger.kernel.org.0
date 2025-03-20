Return-Path: <linux-fsdevel+bounces-44621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B6EA6AB7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 17:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC06F984A9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 16:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940C52222AC;
	Thu, 20 Mar 2025 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kTkFiZOw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A230A21D3E2
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489308; cv=none; b=QKkM6T5LOvzloBVOwIwUme+ZADbvsLvSVDzDDNEB96Zi0rVRwrP4mbHKJTMFwMUX2MV3N6PIRSRTNREZbOljdlRl6at3UdI9OCY7ocN2N9GWYgx/F1bh5An7AtDFLTdgcYqjysG1HWJyoUrMhAsMwXl4f8ED4Y9UC34nvacDYlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489308; c=relaxed/simple;
	bh=RH0oxahZX1QzC9+FQ04CpBaOhqqR6gHsKxURudZnt54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRVweVzCmvXzzu3XjiCtzdUIOfcrl1klmKfK6iLxm4FZzUMlespVEwp4MRGs1LkUi+hyKSTXeLEu/D4ti1IPCMYc3j9W+ySTsXOpAoIVy7AvCPzZiooguUYk1U5p2UK/TsWxu8DcFyBNrUGZz+HIlTdQvuvT6R0mWVdI2rO9hNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kTkFiZOw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7gXlREmZVJUAEmqZvmByWagcVOO1jeUI+iZ1ARr94wM=; b=kTkFiZOwTP/jOaTw/WaiBAbKHk
	l/e/2vCaBtXEpy//DaTXbbAi5l3DjFOAP+eePTvzzt66DoM8QMKSj4lJwnfJQW4uZIfk7wEqk5iHp
	jQmt8bkYZ21HDBR69/63kOwFrMBx4IdW1IuksAZuJrSF7A4ee1zvi0TM+ZKRsS0K/4ebXfwQe0PNd
	43VhoRc679YyDPq9kDul8EbL2sNT7bX0NhIkkWhad4Fd0G+0hXEPB5nLoZN1wRQb0AdsMSH2ah3RT
	y8/ebHMRw+5xJ861Xq05dtQIH1CCW0U/C2Qywf/teCGsr1C5A3fQnMSQPSTziJJVSdvWnQ+8yowX0
	TvldwVcw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tvJ4E-0000000CiwS-13o1;
	Thu, 20 Mar 2025 16:48:26 +0000
Date: Thu, 20 Mar 2025 09:48:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem Suspend Resume
Message-ID: <Z9xG2l8lm7ha3Pf2@infradead.org>
References: <0a76e074ef262ca857c61175dd3d0dc06b67ec42.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a76e074ef262ca857c61175dd3d0dc06b67ec42.camel@HansenPartnership.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 20, 2025 at 11:36:17AM -0400, James Bottomley wrote:
> Part of the thought here is that other filesystems might possibly want
> suspend resume hooks as well, although not for the reasons efivarfs
> does:  Hibernate is a particularly risky operation and resume may not
> work leading to a full reboot and filesystem inconsistencies. In many
> ways, a failed resume is exactly like a system crash, for which
> filesystems already make specific guarantees.  However, it is a crash
> for which they could, if they had power management hooks, be forewarned
> and possibly make the filesystem cleaner for eventual full restore. 
> Things like guaranteeing that uncommitted data would be preserved even
> if a resume failed, which isn't something we guarantee across a crash
> today.

We finally got hibernate to freeze file system on suspend, which is the
right thing for the above reasons.

This might not work quite as well for virtual file systems tied to an
actualy resource like efivarsfs, so you might just register a fake
device to get the system suspend/resume notifications for it.  Or
whatever better way the PM and device model maintainers things that
suites, but definitively something that isn't a file system interface.


