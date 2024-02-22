Return-Path: <linux-fsdevel+bounces-12489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838AD85FD20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 16:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52941C24090
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 15:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2349014F9DD;
	Thu, 22 Feb 2024 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="w0/CbupC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5528E14E2EE;
	Thu, 22 Feb 2024 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617262; cv=none; b=UkNDTSREbYW2DnwCruxM0qmoRUsCdpRqzhXDixEvh1bm4OesglR7szGfDDm0K7qVaVIXgqrQeaAxOy38sedMM7d1xCg6bPFKTF2P/upOXMnXIDG0xAuSp+mkZDrRs1uXXvwRWEOO+wpEihELdBS6DsMwnnbCe7GgXSb2zXo2PnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617262; c=relaxed/simple;
	bh=6r4EIbX+1A+R+iS1NBfTYzCaLu8SYgyQ2yueIWcu2PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3NruPaWPfsFhhlkO1wXfjQjzC4BzznsE+YqfpmvkUZp3sW8Lxu3XGQlweYGnjhTX71yY851sOHvqQ4ngu2XyPtHsb5/5wLqi4u+x1yH8T889w8wBa62Q/EXLzjP38hNAPCWCmI0kQoEe/K7B9jkpQzwRUf+vy7Wwdxj0lNoLl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=w0/CbupC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1HpmxAKzkYfraoLdEHEm+a3ZNMRSibqqtuuwE9JPZYI=; b=w0/CbupCmha2bVmZGkJtvLSn4y
	qQYRWqBYjFz3iRzeU77CIZGz5QBL1ezDiFGX/ZBK/JJN0iY8N9cFHWr6kyoBBxZdj/r9kmzC3ieD2
	6hcynFX7magDhUHbKDACPEhRoQt9S6TfXOwCYvft7/ltxaoondhV1eCOyvFWRoq4ZO3Og8iaFvqTi
	5soqhHzQFBdO8eaymngAdHwqYXbIIe4HLYyi4FOoMmgsUBlJLE64VvP7sRA6+Cu19BXDnwfqcbpiW
	I7I25+3XxBvmF9h1ow3MZfmA79jlbrs1sJ6EGHUyBUJZN2qGU0Ia+YL88aAEWNKX58tFk5DOH3jqX
	s4SuGL+g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdBOs-00000005V2s-0lCt;
	Thu, 22 Feb 2024 15:54:18 +0000
Date: Thu, 22 Feb 2024 07:54:18 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org >> linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"jack@suse.com" <jack@suse.com>, Ming Lei <ming.lei@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>, Theodore Ts'o <tytso@mit.edu>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Message-ID: <ZdduKnjJx3tJsQGY@bombadil.infradead.org>
References: <e5d8cd68-b3f2-4d7b-b323-b13d18199256@nvidia.com>
 <bh5s6a4fhhlje42bzj2t22k3jpmruzkx234ks4ytuhd62tonzj@zn6h5foaqrof>
 <jfydrbb277d7ad2ypu5dottiqh4rtzm5ipf72wcjo34mmpvnl7@mjlqomulsq3q>
 <ZdZBpb4vMMVoLfhs@bombadil.infradead.org>
 <g5c3kwbalxru7gykmzdymrzf43fkriofiqtgdgcswbf4hrg65r@wdduaccaswhe>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g5c3kwbalxru7gykmzdymrzf43fkriofiqtgdgcswbf4hrg65r@wdduaccaswhe>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Feb 22, 2024 at 10:31:53AM +0100, Daniel Wagner wrote:
> On Wed, Feb 21, 2024 at 10:32:05AM -0800, Luis Chamberlain wrote:
> > > One discussion point I'd like to add is
> > > 
> > >   - running blktest against real hardare/target
> > 
> > We've resolved this in fstests with canonicalizing device symlinks, and
> > through kdevops its possible to even use PCIe passthrough onto a guest
> > using dynamic kconfig (ie, specific to the host).
> > 
> > It should be possible to do that in blktests too, but the dynamic
> > kconfig thing is outside of scope, but this is a long winded way of
> > suggestin that if we extend blktests to add a canonon-similar device
> > function, then since kdevops supports blktests you get that pcie
> > passthrough for free too.
> 
> I should have been more precise here, I was trying to say supporting
> real fabrics targets. blktests already has some logic for PCI targets
> with $TEST_DEV but I haven't really looked into this part yet.

Do fabric targets have a symlink which remains static?

  Luis

