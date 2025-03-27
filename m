Return-Path: <linux-fsdevel+bounces-45176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD55A740B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 23:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5748417306C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 22:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2FB1DE89A;
	Thu, 27 Mar 2025 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="WO2NqXtj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2901DC19F;
	Thu, 27 Mar 2025 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743113950; cv=none; b=q78xRPpDoSQ0WWBx1eBCg8zsPwTpIFjp05SRFOmST+PV3Qa5eu4iMY8ckojj9ZrBdyskwtm4N44K9Cg5WX0GagKl0hOGe+do9eGqvsrn0y+poKyPXxSo+V/TGZtvd5eqGBpqeiLCvbLHurAwhg6fvfVL8a91NnMY23xWbF+TgDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743113950; c=relaxed/simple;
	bh=EThSdzu+15gU7gEvdqhKoX1OiJqDzQIpQPoC942Ka88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+MpAZ7Kb2+5qPTHUjK22vOmcg4Ypuc4c6GggZo1YdcxgM9SQPF9lnHiSnapz7LeEZTjzFIEJKwiOxkuoWEhxM/d/82oN09CBhCKd8FodvFJHzMXDlHu3ZlTLZT7a8onq5DRtAJgioELMaujNy/4X3zUFbDDRXViiSiPHgI3Jwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=WO2NqXtj; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 8827F14C2D3;
	Thu, 27 Mar 2025 23:18:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1743113940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xvfcd7UldS5M+GO2GfhqsTALxikBxHBkBI2yvLg2dho=;
	b=WO2NqXtjP9krNrGl7RsoByiWULpiOyunWRIxN73edQJ333Qgf0fZdnfR87tjaN4D2p0NHS
	PK5O/AiyNuc9vu4G900T5bZjxvsCfqTfAYEb8ufu98kQeAtcGI7wbu/PNSvlI4wk2cqfov
	gnb9dYGo86l7tKtbFK2TONYWHZQMect6IsCuhf/K8s+3LPVRNUGgZFAaYGndVuNnrBHqwi
	W1KxvVNVBq1pjowoxR33frevrSlBvA8yXxaNiSWrCVLTyuFHcP6tjJ7F2ALucyBbpuyVCR
	lN55TX7kx/iPaH5j2SDC86xJ/KBu6eXKNwHiiq7h9Gvg3Q1VX/BGDpJGu1DxXA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 5a99a325;
	Thu, 27 Mar 2025 22:18:53 +0000 (UTC)
Date: Fri, 28 Mar 2025 07:18:38 +0900
From: asmadeus@codewreck.org
To: syzbot <syzbot+62262fdc0e01d99573fc@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, dhowells@redhat.com, ericvh@kernel.org,
	jack@suse.cz, jlayton@kernel.org, kprateek.nayak@amd.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux_oss@crudebyte.com, lucho@ionkov.net, mjguzik@gmail.com,
	netfs@lists.linux.dev, oleg@redhat.com, swapnil.sapkal@amd.com,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_write_iter
Message-ID: <Z-XOvkE-i2fEtRZS@codewreck.org>
References: <377fbe51-2e56-4538-89c5-eb91c13a2559@amd.com>
 <67e5c0c7.050a0220.2f068f.004c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67e5c0c7.050a0220.2f068f.004c.GAE@google.com>

syzbot wrote on Thu, Mar 27, 2025 at 02:19:03PM -0700:
> BUG: KASAN: slab-use-after-free in p9_conn_cancel+0x900/0x910 net/9p/trans_fd.c:205
> Read of size 8 at addr ffff88807b19ea50 by task syz-executor/6595

Ugh, why...
Ah, if ->request() fails p9_client_rpc assumes the request was not
written (e.g. write error), so you can't return an error after the
list_add_tail call in p9_fd_request.

I think you can call p9_conn_cancel with the error and return 0 anyway,
and this paticular workaround will probably work, regardless of whether
it's the correct thing to do here (still haven't had time to look at the
patch here)

Sorry for this mess (even if most of it predates me...)
-- 
Dominique

