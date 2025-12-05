Return-Path: <linux-fsdevel+bounces-70808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B057CA6F96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 10:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB2193012EC2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 09:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45471315D3B;
	Fri,  5 Dec 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxqFSCEr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481FB2FFF90;
	Fri,  5 Dec 2025 09:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764927883; cv=none; b=b5FG1qbm5po8QZpjEycs7kVdVZl6A+YIJY8q9a2pn4GULabLJM9NjE1a8YG/RO+TqBfCjxmLKAJmAq/DIWDPd3E1e0zu/pFiSXZCjLK1Bxp4JW4YSmNGACF2ajJgfzMnMjY+ABXl1VxtREWvaa0UgPFiRov0iRHpH4NXha1/9iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764927883; c=relaxed/simple;
	bh=udCIKNVbj5VIeL/XJ/kAXSOxBxnLagX3GjK6hyUqdr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqV+knJYQ00h5nLQ2kQkn5huDePbXWdq5f3Dr0c0cXn3swIKSVKJHiBConW+AeEADzOaa20HvLrvGQ26yKwKgKySMY2MUVKWnPjoAbmoMm1CL4GVJWMSOYobH1M6DZB75wnEE4Kflfs7D3UI/kwabLx611XKRDCxzGmoq0VV0gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxqFSCEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1C9C4CEF1;
	Fri,  5 Dec 2025 09:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764927881;
	bh=udCIKNVbj5VIeL/XJ/kAXSOxBxnLagX3GjK6hyUqdr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RxqFSCErwnEzXkl1iAumg/dA1wfmx+PQohp9yO2IfmNWSWfaxaFdBQcooNOYXrhcx
	 7SVkBaZgGEWXuxSbKRLb7kjupheGxtvx/DGrir2Xt5PCsedXzbuvPgO+tp7oltNt0V
	 WnMK8NSX95dJ7MEOsBeGj8IVOCWLiN069X8Bz1tWRkeNXGrz4rTraUCshS6anUjd2t
	 r/CPMfyJjZ/ZEG8aNALM2hLLbGZh768LDTTwMCSNw04aH7unAllBxoy4d1f/R/puhf
	 cunsSBO66v49C+3WgM2J0go5GTGJHhIssgKDUVR/S1yhP8RqVan/6uL89jomogGwnJ
	 0ARgS9B2CDQFQ==
Date: Fri, 5 Dec 2025 10:44:34 +0100
From: Christian Brauner <brauner@kernel.org>
To: Xin Long <lucien.xin@gmail.com>
Cc: syzbot <syzbot+984a5c208d87765b2ee7@syzkaller.appspotmail.com>, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, jack@suse.cz, 
	kuba@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com, mjguzik@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] kernel BUG in sctp_getsockopt_peeloff_common
Message-ID: <20251205-erdball-lautlos-3f621b4dcc82@brauner>
References: <692d66d3.a70a0220.2ea503.00b2.GAE@google.com>
 <692e11fe.a70a0220.d98e3.018e.GAE@google.com>
 <CADvbK_ewub4ZZK-tZg8GBQbDFHWhd9a48C+AFXZ93pMsssCrUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADvbK_ewub4ZZK-tZg8GBQbDFHWhd9a48C+AFXZ93pMsssCrUg@mail.gmail.com>

> But I triggered a similar call trace with FAULT_INJECTION on net-next.git:

Thank you, I'll send a revert.

