Return-Path: <linux-fsdevel+bounces-12306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F1F85E60A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843D91F23E5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 18:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA438563C;
	Wed, 21 Feb 2024 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZrO2uyKR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C463C068;
	Wed, 21 Feb 2024 18:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540329; cv=none; b=EgOzOnYQj2ADrnhKYI5E0GSaHrCkAZTuuIXVsfdN8c2++GwqCQqujK93Pd0t9sc5PicMO7jsV2lAEypQXwp0K3BaPtjNlxN2tA401gOvZovWDRs1zZYyLWT+hsdAwmF2A9olbvfUtv2ZKuyRoRzpIbzAh9GhZZkcAmCCBSgRU6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540329; c=relaxed/simple;
	bh=bb8pB2eoj/Btk1l1s9aJVec1B4JKrTegC8XaW2ssF0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnZStk2K9vR6DIKR565w1Yz4wy+3t2YSumujfzYxNC5/vz1lLHXLuq3gQgSDeI09IyAURmMpRxpcoRB0XThuwuq7L4J3UnlzMqqKvY6hxc7juOpZ5flDi+ZCfJPo9MsV3uIweH5g1Z/AwbazL56cg5bkS5MCtJx7KXlRya4OYos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZrO2uyKR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BCKZ1UBP4Wj/w6fEAFQYv1+qM8ci73Vx/Xa7GoifUw8=; b=ZrO2uyKRURv7NKxC0fIP2J3xTJ
	5aUn8dvIporTrkVsfqFaarZ8vIrFDXA0APLBTWQGcppmInFwfbSwI284e6EqfFelqf74nQ9i3qt4Y
	pfQyA8gfNxf0N4vlPusCfluknnGBzWUrGFEwxDCtkTIAEwncj1HWR1vfCszBoWPHYeD6/6jNp66as
	TsbIr48skQvOckSfIEaYDGzpq2HRst1Ir7D1h+ACRWj0PmVm0//LYSwXNjNcApZrPkp8/1VoyGV6O
	Zxi6lF6axGHGxHYYIKWoTRPaR/+lDgFzbur5FY/8QBiXFJJa65OUZ5zeAqxWsCFl9D+PtoQDvMJ3t
	bv/HlGmg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcrO1-000000027Ck-1ypC;
	Wed, 21 Feb 2024 18:32:05 +0000
Date: Wed, 21 Feb 2024 10:32:05 -0800
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
Subject: Re: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Message-ID: <ZdZBpb4vMMVoLfhs@bombadil.infradead.org>
References: <e5d8cd68-b3f2-4d7b-b323-b13d18199256@nvidia.com>
 <bh5s6a4fhhlje42bzj2t22k3jpmruzkx234ks4ytuhd62tonzj@zn6h5foaqrof>
 <jfydrbb277d7ad2ypu5dottiqh4rtzm5ipf72wcjo34mmpvnl7@mjlqomulsq3q>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jfydrbb277d7ad2ypu5dottiqh4rtzm5ipf72wcjo34mmpvnl7@mjlqomulsq3q>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Jan 23, 2024 at 04:07:48PM +0100, Daniel Wagner wrote:
> On Wed, Jan 17, 2024 at 09:50:50AM +0100, Daniel Wagner wrote:
> > On Tue, Jan 09, 2024 at 06:30:46AM +0000, Chaitanya Kulkarni wrote:
> > > For storage track, I would like to propose a session dedicated to
> > > blktests. It is a great opportunity for the storage developers to gather
> > > and have a discussion about:-
> > > 
> > > 1. Current status of the blktests framework.
> > > 2. Any new/missing features that we want to add in the blktests.
> > > 3. Any new kernel features that could be used to make testing easier?
> > > 4. DM/MD Testcases.
> > > 5. Potentially adding VM support in the blktests.
> > 
> > I am interested in such a session.
> 
> One discussion point I'd like to add is
> 
>   - running blktest against real hardare/target

We've resolved this in fstests with canonicalizing device symlinks, and
through kdevops its possible to even use PCIe passthrough onto a guest
using dynamic kconfig (ie, specific to the host).

It should be possible to do that in blktests too, but the dynamic
kconfig thing is outside of scope, but this is a long winded way of
suggestin that if we extend blktests to add a canonon-similar device
function, then since kdevops supports blktests you get that pcie
passthrough for free too.

  Luis

