Return-Path: <linux-fsdevel+bounces-64071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F6FBD7463
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 06:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524BF3BA7C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 04:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241CC30B522;
	Tue, 14 Oct 2025 04:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f0jihNJe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D6127874F;
	Tue, 14 Oct 2025 04:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760416754; cv=none; b=Ns0jx0dEait9GKq3JnEhwTuYcP4/UJB0XR3tqYEZXhV6j0m3wvbE4WJS2mYtEUgKe+RK4h6UirT1zjFDuB7i0EbrYeKFS0Pi8EsHQL/LsCmUoTPVCLM1Dp0pxT0Y8F9Qe+Diccva4+/9WqVCyHvMOv0jVjtr9JsTDrt2moy2tQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760416754; c=relaxed/simple;
	bh=fapzwgcGjG+V5CkiDbjIlIxMFTYSi6qZfdyKFA970Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8hKBRlEv1Z43Aryat/m6v3hDCsE/Q+f+Ba/xrBSYJjWbE2EDSQCvsCPWXsEAt3u+atzZbG7QV/OMjYXupGpa9IPt26iywyGexkPqBv9DfT7Jik+5K1soUlDudhMQsu/4BCH/4p5tmYyEh1mzHz8bjmBiTM0sHS5JtA/zDi/its=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f0jihNJe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=fapzwgcGjG+V5CkiDbjIlIxMFTYSi6qZfdyKFA970Vk=; b=f0jihNJeMOPpCafMBwGEgooIWq
	af9jdd1cIYl2z03GpGTgXKsowGa0hMjGw+QH6pQPN7WDAoyMQHI6vCp/9eKgM+E1WEXOTpPI0A9dw
	xgr3dgdogn+oxzacmVl1o/uyrq+VgjYsi92JaBaMenzrRFUVc+KC2PLnkLJNPz73/1FynTtn8L5yR
	+ALzfUtxSBSXEVb19MFYqCuJ9lWXzg365QrOyk9Kl1P5AV+NxbQfTDPd9NzuC6WUBgZ+Xbod5T+Th
	WfR7+3KH3xhgQt9gUg7N7jmr9Id+LEZGxArNRWGhlkEtZnK3h+bFGeL2ZLOFvHmVuShytXk51y4RU
	qnuro2Wg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Woa-0000000F7cu-17Ns;
	Tue, 14 Oct 2025 04:39:12 +0000
Date: Mon, 13 Oct 2025 21:39:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com, Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Anand Jain <anand.jain@oracle.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>
Subject: Re: [RFC PATCH 1/1] ovl: Use fsid as unique identifier for trusted
 origin
Message-ID: <aO3T8BGM6djYFyrz@infradead.org>
References: <20251014015707.129013-1-andrealmeid@igalia.com>
 <20251014015707.129013-2-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014015707.129013-2-andrealmeid@igalia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 13, 2025 at 10:57:07PM -0300, André Almeida wrote:
> Some filesystem have non-persistent UUIDs, that can change between
> mounting, even if the filesystem is not modified. To prevent
> false-positives when mounting overlayfs with index enabled, use the fsid
> reported from statfs that is persistent across mounts.

Please fix btrfs to not change uuids, as that completely defeats the
point of uuids.


