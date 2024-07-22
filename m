Return-Path: <linux-fsdevel+bounces-24048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 564CF938A9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 10:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009221F21A3A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 08:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAF9160860;
	Mon, 22 Jul 2024 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V18Tb31l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89F918E1F;
	Mon, 22 Jul 2024 08:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721635264; cv=none; b=qbLzpyHQkWa8vlkpr4fo2pUYb0Ntu9MYZBcA3pIoA53WXtgAxeeaP1fv6qAHm7P1ge4tM7wNwiSgGQUP9NXDELSPpnF85EdHUF2M1AQL6fdqVgckmvneZyhwZN3RuYHoYNia3calyoXuWYRU38O2yM4eD4oc13hgwZZLyNHdG8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721635264; c=relaxed/simple;
	bh=C/fmVx1XBGViGJy8nynN61Qs9KcCoQgHWiBUt/Q1PmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/Tp9VcBrZHBYr+F6Pddo8pody+ei+q1fTxLRBWcwIfXMBvzI6nyMiegP9GEHKaQlgGGdGKIkdvhd6YpjMnwRDvDZVQklFsbcMPAQjIKoM4S8m2Dhjx9pOs9ZO3mAjqw5w1Pti/zYHzoE/rROqZw0EqVxkggkIsaaHVUPfYWwIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V18Tb31l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC93DC116B1;
	Mon, 22 Jul 2024 08:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721635263;
	bh=C/fmVx1XBGViGJy8nynN61Qs9KcCoQgHWiBUt/Q1PmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V18Tb31lM4hXKQ5NSehbuqG9PSAgP3ixVB3zJUGX97ViKi2F5M3rqU6RAunr7MiWb
	 LAGeO997JJUmUL5lNwp1NNXtLkPJILZOEMP3ErP6JAUbVVTHPMGKf/dUDlPytR0bSJ
	 Gtg7sePOkOD7nW1E/23tu+ksD8Qc6uKCWv5oCBoUURePXOVGyaeoBtAJmwEom/y/3F
	 1FsPVmp7pcw3pptBL1kuSPtse3OD6MAVNIfU3kCcs0G7dlHtCKuWPNfScBarwQhlbL
	 7t5GTut+VqM9WCo1iGpTEVtqIXoyGURudXTwasmC6v6nidazhGvwrOgNwayDyT+dUo
	 25zOJSaWKPFFQ==
Date: Mon, 22 Jul 2024 10:00:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+34a0ee986f61f15da35d@syzkaller.appspotmail.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs/pidfs: when time ns disabled add check for ioctl
Message-ID: <20240722-graben-narren-76c25de0f0dd@brauner>
References: <000000000000cf8462061db0699c@google.com>
 <tencent_7FAE8DB725EE0DD69236DDABDDDE195E4F07@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_7FAE8DB725EE0DD69236DDABDDDE195E4F07@qq.com>

On Sun, Jul 21, 2024 at 02:23:12PM GMT, Edward Adam Davis wrote:
> syzbot call pidfd_ioctl() with cmd "PIDFD_GET_TIME_NAMESPACE" and disabled
> CONFIG_TIME_NS, since time_ns is NULL, it will make NULL ponter deref in
> open_namespace.
> 
> Reported-and-tested-by: syzbot+34a0ee986f61f15da35d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=34a0ee986f61f15da35d
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---

Hm, nsproxy is really messy in that regard. Some namespaces will always
be set to init_<type>_ns and others will be set to NULL.

That's an invitation for bugs such as this. Imho the correct fix is to
change nsproxy to always set nsp-><type>_ns to init_<type>_ns and no
code ever needs to worry about dereferencing NULL.

But that'll require more changes so this seems an appropriate fix for now.

