Return-Path: <linux-fsdevel+bounces-59460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62509B39057
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 03:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90DB01C23F1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 01:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9F81DC075;
	Thu, 28 Aug 2025 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qsToXU6q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2C86FC5
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756342822; cv=none; b=JHB87b1WajR+K9DvjbgtvdJCP927QNi6PesOUHYUMRLKm5dbygjTJ3AFiXuc/4FWx2yUkdxIQR22I4tgRj4D4tuXU3dGK/IinWoqi3ZmhCcA8VkfOlqkuGWkoqnwajPP1F3894BbVd/PXlYy8VsrEHGA5r8ku+KsLTkLZFDKE34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756342822; c=relaxed/simple;
	bh=QVTmUf1Cti3J/ea6gZl38Ej1TXrgPzXDfH5Ek25/2rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzqSXlyaC2Pu9/qsimTFnAzexdgseTkHzrLHDbukrgOKsIMv9tqDPN2pR8+4DRDBhL1dEkJQFfgniqRO2lS7vv5Ccr3OpAaKv+32biyndN2QMPBC/WMvXM8Sj3PBrORvQxy6J2wpEKTZ1eYtQjGGTSx/tFEev5WiAskSxdF3B1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qsToXU6q; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WcFw8P5flxdvAg1/qBS3YRBi/Zt6GOqaOojM1hN4t6k=; b=qsToXU6qPts4G/W7/OtYExlCro
	1ud571eFdafQl9sPURRq3pdcb4M77kIHGnjAp0xhgW+DCSf2QDK0vy0llvDicA6qcDPFMmqyxv+Y4
	h83Y7PYzh2sCS4MiputGmVeqiwzGDyakfP0adfhkYaUdWkKIk1ddCpyP87BUeDgy7QIZDW+cwvEdT
	5pTtcev3B0kYhmdRBYRqWMoY74ob78YGKljF0tLmV04LIDE9pIRzBJNYN/3wwUimtQwTXiQcxa9X9
	Cu9lelD29R5ge3kki1dyad1wcLO29EjgjdHqzsTV1+W+3ZY7zBKT6QtPUKUnqPly4kXwO55ZksE7C
	9BUzv5yA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urQzx-0000000DWs6-35RT;
	Thu, 28 Aug 2025 01:00:17 +0000
Date: Thu, 28 Aug 2025 02:00:17 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCHED][RFC][CFT] mount-related stuff
Message-ID: <20250828010017.GZ39973@ZenIV>
References: <20250825044046.GI39973@ZenIV>
 <20250825-glanz-qualm-bcbae4e2c683@brauner>
 <20250825161114.GM39973@ZenIV>
 <20250825174312.GQ39973@ZenIV>
 <20250826-umbenannt-bersten-c42dd9c4dc6a@brauner>
 <CAHk-=whBm4Y=962=HuYNpbmYBEq-7X8O_aOAPQpqFKv5h5UbSA@mail.gmail.com>
 <CAHk-=wgWD9Kyzyy53iL=r4Qp68jhySp+8pHxfqfcxT3amoj5Bw@mail.gmail.com>
 <20250827-military-grinning-orca-edb838@lemur>
 <CAHk-=wiwiuG93ZeGdTt0n79hzE5HGwSU=ZWW61cc_6Sp9qkG=w@mail.gmail.com>
 <20250827-sandy-dog-of-perspective-54c2ce@lemur>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-sandy-dog-of-perspective-54c2ce@lemur>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 27, 2025 at 08:41:02PM -0400, Konstantin Ryabitsev wrote:

> I'm not sure what you mean. The Link: trailer is added when the maintainer
> pulls in the series into their tree. It's not put there by the submitter. The
> maintainer marks a reliable mapping of "this commit came from this thread" and
> we the use this info for multiple purposes:

You are overloading the terms here - "pull" as in (basically) git am and "pull"
as in git pull and its ilk...

And I still don't understand how is that supposed to apply when patches are
_developed_ in git branches.  In situation when submitter == maintainer.

