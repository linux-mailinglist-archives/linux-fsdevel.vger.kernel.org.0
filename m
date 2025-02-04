Return-Path: <linux-fsdevel+bounces-40697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F9CA26B40
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 06:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 108F57A168B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 05:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1F91D61AA;
	Tue,  4 Feb 2025 05:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R5QTgmaF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1449018EAD;
	Tue,  4 Feb 2025 05:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738646215; cv=none; b=hmvLurxb0Ym29JFGtcd+Y0hE+fn7ik9ubBeQtd+ydQq8m1USISnw8Z8Vc1n/K1mDEBn8tAdlI73dKtTuFfDRX4uftHFwC8DSxl7+OSaEhGs50f3WUahSnaadUJTMbfyuFCMJUQm/Ze9i1a4tmwY1dp8RfF+8MlT/jTDAkvUTBhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738646215; c=relaxed/simple;
	bh=y3SIq+5cNHBMYlPZJHqv8AIPsncNJ7FZ4n5K0nCxZtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuYAnetZ/bBOgPyFe3ibECQ3b+A298GvEY8UhVhDDhUOYF3qLSM+WjIPdEsiFamTzPf+Y+YfvOypMRGy81rruB0vnT3pBaRpNZF068IaiHWSXbLzs2AzQSzno9xEL8PAij4g1Ke8HDgKHBSixJo8E+rjp/UsQk9N/DGJVZrAbsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R5QTgmaF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PmeBjIffRL0zJ/a26qdx0jVpYYzHUWrXmf4N6s0YxoI=; b=R5QTgmaFwsOME8RxXRUqufs/1r
	eoSrFIUdMTP7O2PueADyXds61eV/Zlq3A+btbQEEHv4utvniqvoGXf/23yV5CQ4aBUUMvTXIDfigi
	Ajyd+G96JhhWOFx4Os66TW7pFAq6bDQsZQBDmL9Un/0XBACIMn2zgUL4P6S+a9ve7JipIzf59cgyy
	3xNAw0SfUGThYa+6fH1BaGonhaEramVy4OLfeq5QhdG2B//VwZMLMZhKHyUi+YA9dijWwyn4SLauY
	1EkFORChX47n7XUMmeCePgnYFNj4yyRgyHfLJ5GU2Jrqeiim+8Jsi97xqV0ls7lHVfHk+e0Kq/4BC
	YIypNtGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tfBIl-0000000HGYs-3eYO;
	Tue, 04 Feb 2025 05:16:47 +0000
Date: Mon, 3 Feb 2025 21:16:47 -0800
From: "hch@infradead.org" <hch@infradead.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"hch@infradead.org" <hch@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z6GivxxFWFZhN7jD@infradead.org>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
 <cfe11af2-44c5-43a7-9114-72471a615de7@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfe11af2-44c5-43a7-9114-72471a615de7@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Feb 03, 2025 at 06:57:13PM +0530, Kanchan Joshi wrote:
> But, patches do exactly that i.e., hardware cusm support. And posted 
> numbers [*] are also when hardware is checksumming the data blocks.

I'm still not sure why you think the series implements hardware
csum support.

The buf mode is just a duplicate implementation of the block layer
automatic PI.  The no buf means PRACT which let's the device auto
generate and strip PI.  Especially the latter one (which is the
one that was benchmarked) literally provides no additional protection
over what the device would already do.  It's the "trust me, bro" of
data integrity :)  Which to be fair will work pretty well as devices
that support PI are the creme de la creme of storage devices and
will have very good internal data protection internally.  But the
point of data checksums is to not trust the storage device and
not trust layers between the checksum generation and the storage
device.

IFF using PRACT is an acceptable level of protection just running
NODATASUM and disabling PI generation/verification in the block
layer using the current sysfs attributes (or an in-kernel interface
for that) to force the driver to set PRACT will do exactly the same
thing.


