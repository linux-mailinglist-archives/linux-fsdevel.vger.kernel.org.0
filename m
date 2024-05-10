Return-Path: <linux-fsdevel+bounces-19260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF7A8C23AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95491288C15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F0617084A;
	Fri, 10 May 2024 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OskplMLl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BDA1649CF;
	Fri, 10 May 2024 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340884; cv=none; b=qIXFCvlDqs9LXgjWnfBK6I8NEFSeFk7wJsdg8fPUmpiYupCwIP2xJcKnp2ucGOzeZz9Oo2rsnLRO1Q9hmnaKJ03Q3ShX6bQU4pgANguybddcvPCR+NmswxgDvcDi6SWrTl/DLd5ABHu8U30fQ0tuf015OCOuW8pOeCDYHWUKab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340884; c=relaxed/simple;
	bh=dSYh0o4FrQWjhbR6gOXgRr+tiUkuUSJQCNgMoK+ri4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNkWbf/s0khulRjg2Y03nar3v0iTLo1W45vb9yhfJtYPi+sBmrkGZcXo6qb04KKDyzjdX1ongmJXb+PJOpWKmIlVOLaBxrihG7mCebuWJCEXULiLv0evqVpcjnyUPR/6M+MYDdYNSq6h9Zz3dlzHtB+e7xUEZ+6JLqAqbvhWhYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OskplMLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3823C113CC;
	Fri, 10 May 2024 11:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715340883;
	bh=dSYh0o4FrQWjhbR6gOXgRr+tiUkuUSJQCNgMoK+ri4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OskplMLlg9XVl8lx2+cIzBGyfVPwM1qV6P4S5ficunln+xZ1XLnRlxALUa13Ijgl5
	 svPbK/aOTS4MKiA7LMkA8Hk4Xqis68W5zAuCS0lUWMIw98yumRhR0j1YWWWxZoi/sY
	 0sNauDPfBYRLwXbMDcKs5xiYxDLOd5rsRDdjeXJufUQGqIdrM0H1fBeelMwaX++pt9
	 xx/zWnlAAJeUa7b2SgmOCK3nh03LXpERaly0i833tidQgA5jqEZYZcWEEc9wpik1Ok
	 lXSUmRtyh2P25xv6RkiCZmUYTBaJwwNBXw+Desa7xsJ0WYZW0kmcQTL6CHlN/WLigU
	 hcqYwRwuHPfmw==
Date: Fri, 10 May 2024 13:34:39 +0200
From: Christian Brauner <brauner@kernel.org>
To: syzbot <syzbot+e25ef173c0758ea764de@syzkaller.appspotmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] WARNING in stashed_dentry_prune (2)
Message-ID: <20240510-blechnapf-bienen-b9b049b1bb28@brauner>
References: <0000000000009f0651061647bd5e@google.com>
 <000000000000decb7906180aae28@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000decb7906180aae28@google.com>

On Thu, May 09, 2024 at 12:47:02PM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 2558e3b23112adb82a558bab616890a790a38bc6

So this sent me on a wild goose chase. In the last couple of weeks I got
multiple reports from syzbot (3-4, I think) that all reported bugs
reproduced against trees that were way behind mainline. So in this example:

#syz fix: pidfs: remove config option

