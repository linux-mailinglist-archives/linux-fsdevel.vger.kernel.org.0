Return-Path: <linux-fsdevel+bounces-7887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AE782C5DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 20:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D739DB23358
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 19:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B05515AF0;
	Fri, 12 Jan 2024 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dwl8D39X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D26F14F63
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 19:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zKyXdIL5lqan9z8DOu/8JpHXpM2eeHiUoebUuo0bCU8=; b=dwl8D39XQCwdYzmJd1PWvsPNdt
	UdwU6wVcLbxyE7xtoFIg9ImdjKrqomgAFBk7pP9mqD2yEB8syKyKPadovtT2/r4nNc4lFGeV0sjba
	uATZsbF0vxX7lFAoeCzMjUyoAHGUDjai6x14ceR3fjQQvC+f5iJ+NXfx5aksjKHJ/QWQXxGgvGME/
	SoM91GtmjqZuM9OoOuiFnQjQ+FQFQXApHwM5h1Ox5LMWeOC9WH7AH8HKgyE039inl1atfBEvnaHc7
	TxmoPSYHuRfl//b2peRiaJFu2aCeFEjM2XfH08sX0DYP6mxT116qmAdkSbV9kOKpoZ0NhXXL1eHZc
	6xsvBEnQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rON9w-00F9I4-1l;
	Fri, 12 Jan 2024 19:25:40 +0000
Date: Fri, 12 Jan 2024 19:25:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] bcachefs locking fix
Message-ID: <20240112192540.GE1674809@ZenIV>
References: <20240112072954.GC1674809@ZenIV>
 <degsfnsjxknfeizu7mow5vqwel27zdtfxa3p5yxt2l7cd74ndo@5z6424jtcra6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <degsfnsjxknfeizu7mow5vqwel27zdtfxa3p5yxt2l7cd74ndo@5z6424jtcra6>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jan 12, 2024 at 10:22:39AM -0500, Kent Overstreet wrote:
> On Fri, Jan 12, 2024 at 07:29:54AM +0000, Al Viro wrote:
> > Looks like Kent hadn't merged that into his branch for some reason;
> > IIRC, he'd been OK with the fix and had no objections to that stuff
> > sitting in -next, so...
> 
> I did, but then you said something about duplicate commit IDs? I thought
> that meant they were going through your tree.

Huh?  Same patch applied in two trees => problem.  A tree pulling a branch
from another => perfectly fine, as long as the branch pulled is not rebased
in the first tree.  So something like "I have a patch your tree needs,
but I might end up doing more stuff on top of it for my own work" can be
solved by creating a never-rebased branch in my tree, with just the stuff
that might need to be shared and telling you to pull from it.  After that each
of us can ignore the other tree.  No conflicts in -next, no worries about
the order of pull requests to mainline...

