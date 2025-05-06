Return-Path: <linux-fsdevel+bounces-48296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E2DAACE7F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 22:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC004E19CA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 20:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9534B1E56;
	Tue,  6 May 2025 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lQ7b3eHW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0728EEBA;
	Tue,  6 May 2025 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746561610; cv=none; b=XpZFAD2pC3vHnpeA3KQ1ocsTaysNjTC7+LZgcgPz6UOYaSai6SYe2+yaA8kzP5HHdDRfQOriHDV2s+VfiVqp9Q9PNqFQW9X9WYu54T2uKnAy74Oc8EhMb4j/NNMdyZu8Y7F/bt3ICIZ7MyKgnOhDO7AfANGKP8QGnRahT14XXz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746561610; c=relaxed/simple;
	bh=aFZS5WSfb1URGZv1SDPNrk4LBpkQ35lBMTJUnAxBllI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X46OrXVB+V6HbQjK6x+XRKsSFUcg0Mt+O78YN5o8S8WquVGo68blWM/7jyMtFwzVLA/knNvZ0vxk4Kv7WKqpJwp9xjE2QgWl2jAVnSzNi0MnbsJg52tt4rK/AkndmHkCv15PgcowgKoGo558UG0JNax5O3wdP6IFfwu1P79unR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lQ7b3eHW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gOvzC6f0esoVdwgqsYKGPniXTXPdQ+Pwsm6Rs6U/rWM=; b=lQ7b3eHWIawvCO4iJcLRNgSgaT
	+z8m6fn+KCNu8+yYj7EO0ZoJdJXzh3ZRyA3nAKHVv9gmfDOT2PM+MIKgftvVo1nYP5oKMm4TlklwS
	48kMoUWvyf4Ch+S9oteaEzj+Ko12ZeaesoCtV1GJxXfpe734HmZYOyipJ5EqqKxix54NdQIkSnKel
	um2mPvJ7GFPny3ujxDG9n1r0sQgWDr7Md2SRpwhCxawJhfwWR+1tGGCo+CROQ1CoiFxPgTu6IZL1d
	Zq17LUXi0NVS2NS1FrX/Qbh3zwUL3mwhSb+AKgdOz1T9MPxD4yR1r+Fn16v+5QGRH80pVfrBnEhxB
	HrcMLzMQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCOSU-0000000CTd8-04xn;
	Tue, 06 May 2025 20:00:06 +0000
Date: Tue, 6 May 2025 21:00:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Klara Modin <klarasmodin@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <20250506200005.GV2023217@ZenIV>
References: <20250505030345.GD2023217@ZenIV>
 <20250506193405.GS2023217@ZenIV>
 <2lti24dmmhgthwqu7fm2bhvnsjk5ptwisxco6s6gkoo7m4scgw@ucy5letoospc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2lti24dmmhgthwqu7fm2bhvnsjk5ptwisxco6s6gkoo7m4scgw@ucy5letoospc>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 06, 2025 at 09:52:39PM +0200, Klara Modin wrote:

> > +		up_write(&fc->root->d_sb->s_umount);
> 
> Looks like this one crept back in.

Yes ;-/  I really need to get some coffee...

