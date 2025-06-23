Return-Path: <linux-fsdevel+bounces-52636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304A6AE4D30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 20:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A383A3358
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 18:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914FD2D3A71;
	Mon, 23 Jun 2025 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rGfem81d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8F62AEE4
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750704944; cv=none; b=FmNZyYhSd2EW8rauLmynapV7XfoqalCS2tfUTFIvtbkmsS2M0U9E07iKAr1CfrrKKikpIqgMDSBcW6QoJS9E4aeLz6rudUhNmaUttvY/ws/IkmRatL1DNvz/yjp2LkcPj8hgd1IKytSBKoDipuhNCz+KK4pNqXqbyhnOJyQ9RNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750704944; c=relaxed/simple;
	bh=iGznlE0Zp1RRmUqCa2W2cOV9bqFJcBAn9HLTK++OBDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVjfRUKY5ygXIYH/WWzeENnRaX+y56ZgP65GBZOf2KpEM2rXJfqi8veejnJgI5yXObstdmw/2VYTIwN25+jSoBUqoblTP2mPwzax7yeDExxWbTYVrMUleKkvT+iZgbUU1zyVqOTwlBbFKxn5mETCaXAyMC2zm1TotVdLq4OEF4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rGfem81d; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RuSZSqmFKJmYDQU5lR3Ublh4mC0RO55gAwVCy4R5gLY=; b=rGfem81dCCz2H0fQRO0gSDI8Nq
	W8nif/AzZlebhAi0evcyfGJQtKc782vKo/ymWFhzEtqscOEzOPcF/Mb440BZt035+m1nZtB/L6nvX
	w3jnVugtj7I/966rQ/UEmeOybP1jv5vvv5slK1JYmHuFetPTsr4s7N/3Bqo9EB4yq7yp1wsV4Ssl7
	ReXJrzMSGjo06UYRaxrKP2nQZEqZ+V1ILSkD+WKUFZ85Po95n64zmQ/2acBfdV/uW/fR4uvvaJrUa
	RsjblpZ/aCh5dXhnrj/7HkeucFqq1TtppyR9pUk5xWFxpQwBk87uQKhWhxlKctO/ggnrYW4YBGLEl
	wh/yj4Gw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTmKS-0000000GJPf-0Opq;
	Mon, 23 Jun 2025 18:55:40 +0000
Date: Mon, 23 Jun 2025 19:55:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ian Kent <raven@themaw.net>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCHES v2][RFC][CFR] mount-related stuff
Message-ID: <20250623185540.GH1880847@ZenIV>
References: <20250610081758.GE299672@ZenIV>
 <20250623044912.GA1248894@ZenIV>
 <93a5388a-3063-4aa2-8e77-6691c80d9974@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93a5388a-3063-4aa2-8e77-6691c80d9974@themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 23, 2025 at 05:06:52PM +0800, Ian Kent wrote:

> I also have revived my patch to make may_umount_tree() namespace aware
> 
> and it still seems to work fine.

Could you post it?

