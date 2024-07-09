Return-Path: <linux-fsdevel+bounces-23354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8706592AF54
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 07:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1DE1F220B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 05:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356B812E1C4;
	Tue,  9 Jul 2024 05:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mj8GGL6d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890C21E898;
	Tue,  9 Jul 2024 05:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720501973; cv=none; b=mVNtk0UiEcEIrLNnfD3ueADHk+MRDX+EamxIz3p9qSw3J+6PIMGzOf4RXMaYyGgYb9pj8IdT8uLyVAGv0K7o1FEXAS3yKuq/pSc0UOjpqwbiS/li7D/dQj0rhsellCuPmwbYG+k0EwxdvPu+dwMy6WmdCN9J3VCOwxRwrkEKhqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720501973; c=relaxed/simple;
	bh=aceBRwM5ID61P+BREL6dxg07RyjfDWaDx995C45T2qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCw+ui+wObzG7wUncKYrRK7eT6OBabSNfJslZwRJKc9ruyCdvptDp1/PHOwLU+dBCwaL5Dv97DQitXDKM4fdg2ps73MsNhLoxR7MDAiYl7md2x/dOgClKDPLmhEPbOx13BVtsohX4ZJ3G2foWwarWcOGxur2zY4yfFgNLZIXbgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mj8GGL6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6511EC32782;
	Tue,  9 Jul 2024 05:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720501973;
	bh=aceBRwM5ID61P+BREL6dxg07RyjfDWaDx995C45T2qM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mj8GGL6d6Wn5VXzdgteMgTxTHpxcqCAsOhJINcCA8NSDRBfNm31YZ/TPQYXEiCyn9
	 fAvEwTEgqblZX08PNk3CxIMggtKrxEYQkeRMuQ2pfe3HN6JwF/CiSIrgCoD/u2rjbW
	 GycEAKtpD7wNaBod+MvCR5Ltfjdzv7OYxa7HH9iRnqGnOkEQFBqwUvPHCaXOS8ZdL0
	 heocxfvjPk+/3xr6dbzSYBt3Ssqz9pP1gzHHNpB8aPq+qqH6Vurmd9w+cT1Xi9uX8M
	 vdaihh9K8ePjEDhFbjMt3bVjnKIQq9byYq/zROUgAn2m1xgyam52scB4Rc6kWTdc+8
	 0b/DmwTusbF2g==
Date: Tue, 9 Jul 2024 07:12:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	syzbot <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com>, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [syzbot] [lsm?] general protection fault in
 hook_inode_free_security
Message-ID: <20240709-grasen-liedchen-b62a8c9f150a@brauner>
References: <00000000000076ba3b0617f65cc8@google.com>
 <CAHC9VhSmbAY8gX=Mh2OT-dkQt+W3xaa9q9LVWkP9q8pnMh+E_w@mail.gmail.com>
 <20240515.Yoo5chaiNai9@digikod.net>
 <20240516.doyox6Iengou@digikod.net>
 <20240627.Voox5yoogeum@digikod.net>
 <202406271019.BF8123A5@keescook>
 <20240708.hohNgieja0av@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240708.hohNgieja0av@digikod.net>

> bypass?  Shouldn't we call all the inode_free_security() hooks in
> inode_free_by_rcu()?  That would mean to reserve an rcu_head and then
> probably use inode->i_rcu instead.

Note that you can't block in call_rcu(). From a cursory look at the
implementers of the hook it should be fine though.

