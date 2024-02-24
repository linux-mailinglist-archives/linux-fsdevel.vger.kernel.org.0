Return-Path: <linux-fsdevel+bounces-12653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8D98622C3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 06:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D3B1C21E15
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 05:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB5B171D4;
	Sat, 24 Feb 2024 05:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMyDHcPr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0F279F4
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 05:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708753965; cv=none; b=QRufH+d/dCSvHBSveCHGqc8aj9LfXTNPEO2mtgr7TnrtaWcRbaiU58zESSxN8P+U2AF6E92QK3gAZqRG43d4igS/c5w+RI8yS10pJllldesTg4tXuQqrr/+cVjRaJ4rcI/Ao1S5p+3S/IcB8y79ukA/OrZP/DHzUEInH5Rrk1ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708753965; c=relaxed/simple;
	bh=TABqdo2wQsMVr7dQvCpnCLcETPrmYGxUn8glUwnKg8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9kUUhjyhq1gb12i6DZThh7WLlDwRb1O3eYZuTt4PH3vXyOztsqWZPtc9pz3VdhJ8Z2MJ2sBecp3aLy4NCkCwnXRi0Knb7QfrHdrvLWRs6qjYxJ2oe8wk/wz6DUYM4mYIopSQG8PqsdCkUhqdfUHXtbUBb1g7kzczc0DHJSi6k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMyDHcPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F26BC43390;
	Sat, 24 Feb 2024 05:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708753965;
	bh=TABqdo2wQsMVr7dQvCpnCLcETPrmYGxUn8glUwnKg8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMyDHcPrYQd4dq8nOiYNWvR9TP/X5rdmKnRTCOlXj2tLkFbaVUX0eizZaF1/BlG9p
	 XxWVHeTQi05c169ET3foGYIdN+0+2y1CYvj8v3yMxgClZzc6Uv/9p+bhCNNBjwC/MK
	 Lk6vo/65SBiS7JaBmtqe2dHVdNOsuJsv0yG29/tiPP580NC44FDPRWSfJr5+q3Y2ck
	 J0RBiLPOPe+lgcI36LEJf19m+ybUYE5RnREaTJzMy2DQdJi4aDkP5J3eOg/58/SkIA
	 ZqC+HOVhxWfoo9qngUE3o1xJ1Ci6+Lm453G22usFHs/+0Js7X3U/8RxrSNUiEZzcJ+
	 yGTQpoFaO62XQ==
Date: Sat, 24 Feb 2024 06:52:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>, 
	Heiko Carstens <hca@linux.ibm.com>, Al Viro <viro@kernel.org>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240224-westseite-haftzeit-721640a8700b@brauner>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <20240222190334.GA412503@dev-arch.thelio-3990X>
 <20240223-delfin-achtlos-e03fd4276a34@brauner>
 <20240223-schusselig-windschatten-a108c9034c5b@brauner>
 <CAHk-=wg0D8g_97_pakX-tC2DnANE-=6ZNY5bz=-hP+uHYyh4=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg0D8g_97_pakX-tC2DnANE-=6ZNY5bz=-hP+uHYyh4=g@mail.gmail.com>

On Fri, Feb 23, 2024 at 01:58:36PM -0800, Linus Torvalds wrote:
> On Fri, 23 Feb 2024 at 13:26, Christian Brauner <brauner@kernel.org> wrote:
> >
> > So, the immediate fix separate from the selinux policy update is to fix
> > dbus-broker which we've done now:
> >
> > https://github.com/bus1/dbus-broker/pull/343
> 
> Why is that code then continuing the idiocy of doing different things
> for different error conditions?

Not under my control unfortunately.

> Also, honestly, if this breaks existing setups, then we should fix the
> kernel anyway. Changing things from the old anonymous inodes to the
> new pidfs inodes should *not* have caused any LSM denial issues.
> 
> You used the same pointer to dbus-broker for the LSM changes, but I
> really don't think this should have required LSM changes in the first
> place. Your reaction to "my kernel change caused LSM to barf" should
> have made you go "let's fix the kernel so that LSM _doesn't_ barf".
> 
> Maybe by making pidfs look exactly like anonfs to LSM. Since I don't
> see the LSM change, I'm not actually sure exactly what LSM even
> reacted to in that switch-over.

This is selinux. So I think this is a misunderstanding. This isn't
something we can fix in the kernel. If Selinux is in enforcing mode in
userspace and it encounters anything that it doesn't know about it will
deny it by default. And the policy is entirely in userspace including
declaring new types for stuff like nsfs or pidfs to allow it. There's
just nothing to do in the kernel.

The Selinux policy update in userspace would always have to happen just
like it had to for nsfs. Usually that happens after a change has landed
and people realize breakage or realize that new functionality isn't
available. This time it's just interacting with bad error handling in
dbus-broker.

