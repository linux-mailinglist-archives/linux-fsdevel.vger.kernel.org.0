Return-Path: <linux-fsdevel+bounces-20778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABF88D7AB8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 06:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB50F1C213EE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 04:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF2A18E3F;
	Mon,  3 Jun 2024 04:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="djNta4cJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0C310F1;
	Mon,  3 Jun 2024 04:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717388483; cv=none; b=U4EKG5VReAbes/MOd+RaIOOd8lSzkz9aJdLdMpb9lr0ESBtbz4CZw2vD4ggKTGTRb13FyPfXp+tI9G8JzMQgq/YjapQLPJ7Mcvt5o0XqsPIM8163kcR9ck+TMP3/o27xyRxSAKGpTtYJ0OELVOKMzHdhbQ1FRK6VeTmqe4s9WNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717388483; c=relaxed/simple;
	bh=SNXuoG7G49CyPjlS/0kFiwme3PuzasR7iDQtmZK1Cn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgI6F7QckQXBtZccPjE4rynPgzqcsMX3/Xx2hm7bC2cHWpx1bvc6snnqYOFwzABjYoR5/5OvNabJRBx0In1Dq10Zsf5x3uHL7GtVm8H9Mip3IlEYQd9QpdjfaUTHQXL9YrlIrqbo/0KmYM2Pwt9xBKK5rFTsf1Me5CaKf6d4nr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=djNta4cJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0vxTDSVzCVRSihsSVFtuGL4BJR8wJ68tmUrgMWWoh04=; b=djNta4cJ3k7aRO5ua40KZt9ERI
	wXUgvlu0RFpevrrf02BIOciNgnfurVXvRAsAccnfHS/zHsjHGuWfXkG7c+La6vHQCj+mS5zvjmxPs
	AlyPbrtr1ukjOAWx0w8GU8m2K2Jl26b6amdABbW+d78wnEBvjBji/RhAH2dK++vwYjMJsdF84W67O
	ChYJQ3M2mEnOXWnWmPdBJRfg2XXkD47LgjncgAdcXJb9R46VQ75BnbSVCS3CENVWC3T7GozjULaCJ
	JYokaxzZNFAHvl/KsiopnmyGynKXx4jD345En2enpWBHZtgDFpkhle7TjVkTg38XLiWbraYRi8fux
	DnT4KulQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sDzC8-00BNqd-22;
	Mon, 03 Jun 2024 04:21:16 +0000
Date: Mon, 3 Jun 2024 05:21:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: syzbot <syzbot+42986aeeddfd7ed93c8b@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] INFO: task hung in vfs_rmdir (2)
Message-ID: <20240603042116.GL1629371@ZenIV>
References: <00000000000054d8540619f43b86@google.com>
 <20240603035649.GK1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603035649.GK1629371@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 03, 2024 at 04:56:49AM +0100, Al Viro wrote:
> On Sun, Jun 02, 2024 at 08:50:18PM -0700, syzbot wrote:
> 
> > If you want syzbot to run the reproducer, reply with:
> 

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6 v5.0

