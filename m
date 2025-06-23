Return-Path: <linux-fsdevel+bounces-52470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC065AE349A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 07:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B53816E1F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 05:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0091C862E;
	Mon, 23 Jun 2025 05:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cRjlKDol"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F847261A;
	Mon, 23 Jun 2025 05:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750655433; cv=none; b=kYdhqwlcwOOk3A7BT3Xxu50DuRqZhObJr1Pl/zgezw+Sj7oreN5leTswLKP4eGSmYgek8eZpQ//dy0ezclX8zC/B086ZRqwvs+xkof0LNXYNz2+pC3W3xUB+RBuXJDSn2IAB+erccX9o81Q+pR1N5O0tjEI793K7zV7EGFVNQSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750655433; c=relaxed/simple;
	bh=6kD9WA/msEBzQ4d/wDN+HUeMDVqZq/ihtwFg42v7DrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQiGJK+W3KzoHBL8IYabHlbdD6/iPo+krA0P1PAJzDT3FQKMe84a54wNGlC6qo0e4JhhoUrqt2fTv2fOAkV1ODPROfueVIeLUk2VSis01v48lfIG3MOLWlTNoRebBU6zR2A9Zkvs84+n9C0PYqlSTKv2EIzl3UdYJMhgmm8OIpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cRjlKDol; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q+FZE4gcDMJ91Suso80fBifZjwYA0+I+UV5JuTDpVJY=; b=cRjlKDol6p8bfT7LCAV7ePH45C
	XzsFZ4u8IxnhbMajrfYp5nNZbR4CWCfFxyffpS7dqjoW9hl78dzdMZBlr8HjSq4svF8i0I0M5vF9n
	a2Yg2pCHCsnI5q2RKJ4VzMgdOz872AyjMfNvnkDAXeUjiaz33n735oGKP4FsBoubQCjEfT7Yz9QKE
	fYFdxjAgy4YzJ6rGliJFWOcbOwaBVkbFA8VULB3VKxWfCSeDnPMWnhxJy5dAUO3WhmamOOcFUZ5ub
	B/+dsp8OyBPqNfUUPzbE5rQ9q9beKbDMA9WizieTKjMUafu54Pk2eLFpbjM/raA6du9grYILK9g1a
	j7Ze2uuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZRl-00000001ao1-1EON;
	Mon, 23 Jun 2025 05:10:21 +0000
Date: Sun, 22 Jun 2025 22:10:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: alexjlzheng@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] fs: fix the missing export of vfs_statx() and
 vfs_fstatat()
Message-ID: <aFjhvbtyeTIV3A3k@infradead.org>
References: <20250618121429.188696-1-alexjlzheng@tencent.com>
 <z6fahv4cjyelnqry3wozfktorwiyokh5vxg6d34iiblp4wimpu@uq3of5u7d65r>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z6fahv4cjyelnqry3wozfktorwiyokh5vxg6d34iiblp4wimpu@uq3of5u7d65r>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 18, 2025 at 05:51:55PM +0200, Jan Kara wrote:
> Well, we don't export symbols just because they might be useful. Usually we
> require *in tree* users of the interface to export a symbol. You apparently
> have an out of tree module that was using these functions and 09f1bde4017e
> broke it. Keeping things out of tree is your choice but why should we care
> and support you in working outside of a community?

Yes, of course.

I'm pretty annoyed that we get a lot of these silly exports, mostly from
big companies in the android space.  I'm not sure if this is elaborate
trolling, or if their training about Linux development is really so
spectacularly bad.


