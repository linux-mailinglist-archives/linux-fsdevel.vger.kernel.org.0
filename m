Return-Path: <linux-fsdevel+bounces-38583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 858BCA043DB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 16:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A02C188643E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 15:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895EF1F2C2B;
	Tue,  7 Jan 2025 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QvqOMrVJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F471E377F
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262795; cv=none; b=Jw9KdZRLQZYwJbAYnfgWgtXpvJoabmcQTNxEw9GosxO2cRlZ+X+JAoWt+H59F56DthSZqgWLJOeb2zdsGbwaC0NlZSKEAKi80JApWQTHASu22StwIitziwVSveoMv3MrGcX5C+XpbB4nsYFy4KAi1+J/RlQETvYviWlKihYIc+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262795; c=relaxed/simple;
	bh=xE26dnVO6XMDgbHPoAfkVbYw0V6L643rv/SPpreIBZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuA+JcTn1hdnO9BgYJbggYpb29TcZu4aQHF2tzPwuJW89TMOsmwmAsTN8WbXVIcy0Hjr8PgSu6sCldYVc73cZkGG5szhA8q0sbA+tIZetnHo7bsxiPNRzSdnnj4ROIjt/xF4CmT10p6NXqILqimuKa8CEiQ2V5X+vvdzD4LSfMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QvqOMrVJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qetoDC8olD00inKUEHwLKvikulcpzGK7NhjEtmyQITQ=; b=QvqOMrVJ2sjQV0SO02gEC02TkM
	TTohKgfNTIPYkea5tDGaXDo8i8vZcvCdi6o1aHZO5GC9GZa2BYiWuwI6+9AUbL0W4WNPB+FSSWH5m
	SnCKdtdJCU6UG2SKImJPO1iCT+h1F0NEBmRaj9Nbe+BN3248xcZiZXwtHYUojJd7W7R5mZDNjrJNb
	CZEEbSUYXTN/M6lyDs1LHly8aGhcTmRNnrdUUycywvApeOr/OKKbWBA32FeOfvaoSr639EbxUkirE
	HgVcdkz0kFXy+7ol9jJxzlqe5DpGN+GXEdKNqteyhYw4X7ZaCqS2vbbb3mW5XIUs+8xC8auCJUn6Y
	SqK2gseA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVBGY-0000000GY4H-3wO6;
	Tue, 07 Jan 2025 15:13:10 +0000
Date: Tue, 7 Jan 2025 15:13:10 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: Cedric Blancher <cedric.blancher@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] sysv: Remove the filesystem
Message-ID: <20250107151310.GO1977892@ZenIV>
References: <20250106162401.21156-1-jack@suse.cz>
 <b4a292ba5a33cc5d265a46824057fe001ed2ced6.camel@kernel.org>
 <20250106233112.GI6156@frogsfrogsfrogs>
 <CALXu0UcWsAcDMZqAP=wM5mb9o0-T+sPyFxLcWpHZNbDWguLKEA@mail.gmail.com>
 <dl55ihsxe45c7bv2g7w7hlqugs3wdwebfpuanzcxe4qsvm5uzt@dzafyykaaeyj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dl55ihsxe45c7bv2g7w7hlqugs3wdwebfpuanzcxe4qsvm5uzt@dzafyykaaeyj>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 07, 2025 at 11:08:13AM +0100, Jan Kara wrote:

> > Better add a test to CI
> 
> That's easier said than done. AFAIK we don't have tools to create the
> filesystem or verify its integrity. And perhaps most importantly I don't
> know of anyone wishing to invest their time into keeping this filesystem
> alive. Are you volunteering to become a SYSV maintainer?

To be fair, it's very close to minixfs, so the burden wouldn't be all
that awful - just need to keep changes in sync, mostly.

That, however, presumes an actual mind - AI and CI won't cut it.

