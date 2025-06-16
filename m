Return-Path: <linux-fsdevel+bounces-51797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28783ADB965
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 21:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C04018902DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 19:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DDA1E9B29;
	Mon, 16 Jun 2025 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IiLzNa+C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6016CBA53
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750101454; cv=none; b=vCXxqaL7srhZ6LrWOiqClSTHcH+Md6tTM/pPb/yVftUDlMQdFAFVbSH5K7Tn1NTLtmbRfbNz5wIrGaruD5tYuGd2x3oKBunstaUWE+eZW5kRnv5VYYxH527N72GK7hxbVYwYZlNylAg1S5oqgXzT9QdHs+qQ9RgN0IwcwxCbSpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750101454; c=relaxed/simple;
	bh=Yq9IswGxnCLMI7R3vxusmuabsRd2e9w649YrN4R8DxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+A6kRVOCmygiAJkFVr9SB228ypyCSlgg27oRLq3qwGQ1N/Vc2ahA5XaKuc0omd55L4Zmy4bLzuC17vgG2Kt8s5aRnLf2HRQTNy2j3QCQnKXt01/vOLAuh1VU7HXDfLAGngSBA+NcBIa3rHf2W+rfyMm8lp1AoA5sMY2MKmwryA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IiLzNa+C; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hqqW56jgXEzeKEca02AnTXvZmBni1cw0WW666gF1W9k=; b=IiLzNa+CvRPU6d54Ov9s6oG0/r
	9quy8IP2Xdnb4oEucKVZxj77Zs4deYxEs+eeMsaTWzHrgyrbvDYhTdq7LCURvdNlNzxoSdliLid20
	oMOVICfRpY0JdvdWxqm1cKAvxBPZmlkHFijjGCHi1cttJl3liPMkSY2J9popLEqsPxvItp1r0wi8T
	608c83BOtf2J4AMmC297DsbSacgF8J81CFOOmlNnDAeEM2lKAEQQrvnpK9hbOFwBUdbnFnvJ1LK/O
	RvckmsngQoOVjseuL8lST7THQa0xdACTu/sEhO2/ZI63jIRt/wcuZ9STfuzrBGYQ/MmCKHuYq73Rg
	laniugOA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRFKk-00000001bsI-3civ;
	Mon, 16 Jun 2025 19:17:30 +0000
Date: Mon, 16 Jun 2025 20:17:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neil@brown.name,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 4/8] binfmt_misc: switch to locked_recursive_removal()
Message-ID: <20250616191730.GI1880847@ZenIV>
References: <20250614060050.GB1880847@ZenIV>
 <20250614060230.487463-1-viro@zeniv.linux.org.uk>
 <20250614060230.487463-4-viro@zeniv.linux.org.uk>
 <20250616-gewidmet-parodie-bbbc15feb741@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616-gewidmet-parodie-bbbc15feb741@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 16, 2025 at 04:43:06PM +0200, Christian Brauner wrote:
> On Sat, Jun 14, 2025 at 07:02:26AM +0100, Al Viro wrote:
> > ... fixing a mount leak, strictly speaking.
> 
> Imho all those entries in binfmt_misc should probably just all be
> switched to call dont_mount(). Zero reason to support this.

Might as well, but that's a separate story.  IMO this commit
makes sense on its own...

