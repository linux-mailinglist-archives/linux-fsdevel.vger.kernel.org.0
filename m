Return-Path: <linux-fsdevel+bounces-50558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB972ACD546
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 04:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FE318994F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 02:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99368528E;
	Wed,  4 Jun 2025 02:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="V0Mzya7Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1983D6D;
	Wed,  4 Jun 2025 02:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749003694; cv=none; b=tAXI9YW85rcd7Oq1bdfM6/2ZM58oVWCPi67rLRflTt2M3x1megXxzWbwHdl2XmdiRkX7q6lmraCfcQUfTNp/RWJe5Wa40eSmIX2pZT5bBb0Gb+oHFCJHWy/zRCqlijhFjGqKLWGsgcg5RxvDVqvZr9nX9bdB7747OvQt3lRdo+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749003694; c=relaxed/simple;
	bh=5yrqUa0x0g+cdwxrzxtarbOEwNp/DCo2TgkxsjybKmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oB0obid7saAx6FbCioSB/m8vYUPuXKODTn37LtQ+wwI6za06RSc9lnxwkTIopUbmLLw+FIVqWDKfD4xIzpPm++H9a9zAeK8csZCyV16wXB4wpqlIPfo2Drtrf6p+yDeIDsj+xcpRZ0c4jQYS/+Pje9I7ZVosdiWJVuUbd2r1ecA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=V0Mzya7Z; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QXvujt7fwaqpLkKeJFFbFk6xgaXBzikXJO4XuseFYqs=; b=V0Mzya7ZsQHMPCJLTnwi2ZWYqN
	dJfqEsTOhfUm6zx7U/UbriOlWBIxG5Y4oUOstfSOp2Fcz1HF1/lNYSTRu6kDcJ+oZlwiej7Lp0RXL
	sh+sDX0PNlzfBGQJB0oRmwmkQIiTldNJtf9eyiNQ5eVmHa3/B0m3eVq4oTPjSw+Hxw1R1mFi+E7fG
	N807HU+3anvk7+8GHtGB8nnBD+aoLe1FyKrY+THzdcKOsUe4PmvhavrZjQPMmfQynJzs7r/dzW6ps
	m4aGbC6qxiMPktz0MExrkc6mi3sXU9L/lD3VYF9tqhmrEPOP98goZPCtXo8n/LtR+oVDtd80sR8bt
	g9IczQ1A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMdks-00000001yVI-1qyY;
	Wed, 04 Jun 2025 02:21:26 +0000
Date: Wed, 4 Jun 2025 03:21:26 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Tingmao Wang <m@maowtm.org>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Song Liu <song@kernel.org>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Jan Kara <jack@suse.cz>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] Restart pathwalk on rename seqcount change
Message-ID: <20250604022126.GF299672@ZenIV>
References: <cover.1748997840.git.m@maowtm.org>
 <7452abd023a695a7cb87d0a30536e9afecae0e9a.1748997840.git.m@maowtm.org>
 <20250604005546.GE299672@ZenIV>
 <9245d92c-9d23-4d10-9f2d-7383b1a1d9a9@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9245d92c-9d23-4d10-9f2d-7383b1a1d9a9@maowtm.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jun 04, 2025 at 02:12:11AM +0100, Tingmao Wang wrote:
> On 6/4/25 01:55, Al Viro wrote:
> > On Wed, Jun 04, 2025 at 01:45:45AM +0100, Tingmao Wang wrote:
> >> +		rename_seqcount = read_seqbegin(&rename_lock);
> >> +		if (rename_seqcount % 2 == 1) {
> > 
> > Please, describe the condition when that can happen, preferably
> > along with a reproducer.
> 
> My understanding is that when a rename is in progress the seqcount is odd,
> is that correct?
> 
> If that's the case, then the fs_race_test in patch 2 should act as a
> reproducer, since it's constantly moving the directory.
> 
> I can add a comment to explain this, thanks for pointing out.

Please, read through the header declaring those primitives and read the
documentation it refers to - it's useful for background.

What's more, look at the area covered by rename_lock - I seriously suspect
that you are greatly overestimating it.

