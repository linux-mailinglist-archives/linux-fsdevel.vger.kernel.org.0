Return-Path: <linux-fsdevel+bounces-10579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFAC84C6B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 09:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F391C211E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 08:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5C0208DA;
	Wed,  7 Feb 2024 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rd10.de header.i=@rd10.de header.b="VIv5xsHN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570EC208AB;
	Wed,  7 Feb 2024 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.247.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707296181; cv=none; b=Zwd55a82UooVWKZe26OXYy1I2K4sB++xczFBW+NW8Ry/N8L6/+JuQ++uIrbqw1aNQweDgzcRGzJX/GJjKrMFDIISL7urzum4COTzEk1+ibx4WQp5C8+6Ua8w0cxew/biErRzVZYWenGO0M/kNv6kIT70MOvNTCyvpBpNnD1LfwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707296181; c=relaxed/simple;
	bh=hQLsu9QVFob2/dvSmHbdXYU6EeLIXsfZju9GLkYVD8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEXaFSkfvHdCWy/lUkvt5sawD2C7g3Ywe9xVvL5ukeDjkx8yL6A9Dp6b4N9Yj638Pdb0pF/hWeGssJ7XuF91paxb4UddSrHnGHqmfAK7T8MwfsvvCNbj5NWonoNFU0esJDEhaITE7oUHsGw2xysfdMsEl3ZxXJwNPivXbnRd18E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rd10.de; spf=pass smtp.mailfrom=rd10.de; dkim=pass (2048-bit key) header.d=rd10.de header.i=@rd10.de header.b=VIv5xsHN; arc=none smtp.client-ip=46.38.247.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rd10.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rd10.de
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4TVDVb0WVZz7y5h;
	Wed,  7 Feb 2024 09:56:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rd10.de; s=key2;
	t=1707296167; bh=hQLsu9QVFob2/dvSmHbdXYU6EeLIXsfZju9GLkYVD8Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VIv5xsHNQ05SpC4/MZca45lpK3r3Qjb13BOY8r94NrftmITj9J6aSkE1MYzoTjD2E
	 2edoD6kaxcUQyS5VlRS1Y+Mlrw1wGF2d3k7ahniOGRej6IafY/eLBWN+BtuRrbdf33
	 OYSOqntHwBmY6/VlKUwiFyxX8jD5I5TneMHTnt7+rgEjU4whU49L9SB39bJQBYrP88
	 WjS67z6IZe2DbKQjP7GPzuUVoX1uP9zMjbPB7pT+rFyZVgftgIBUHcWD7HC99YrjQe
	 FcYY+NAT6r9bRT943uEtfGGCpMy+mymgtywvRaSOWpiu+6OXSJAD/lIsIoOi6UGXJK
	 vMOyke0+zKXuA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4TVDVb065Lz4xqg;
	Wed,  7 Feb 2024 09:56:07 +0100 (CET)
Received: from mx2eb1.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4TVDVY3B6Vz8svQ;
	Wed,  7 Feb 2024 09:56:05 +0100 (CET)
Received: from [IPV6:2003:cf:cf11:7f00:8b09:c0e3:8f50:94ce] (p200300cfcf117f008b09c0e38f5094ce.dip0.t-ipconnect.de [IPv6:2003:cf:cf11:7f00:8b09:c0e3:8f50:94ce])
	by mx2eb1.netcup.net (Postfix) with ESMTPSA id BCE5B1005CA;
	Wed,  7 Feb 2024 09:56:00 +0100 (CET)
Authentication-Results: mx2eb1;
        spf=pass (sender IP is 2003:cf:cf11:7f00:8b09:c0e3:8f50:94ce) smtp.mailfrom=rdiez-2006@rd10.de smtp.helo=[IPV6:2003:cf:cf11:7f00:8b09:c0e3:8f50:94ce]
Received-SPF: pass (mx2eb1: connection is authenticated)
Message-ID: <ec454090-da42-4943-9685-67e2b5a040ca@rd10.de>
Date: Wed, 7 Feb 2024 09:56:00 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SMB 1.0 broken between Kernel versions 6.2 and 6.5
Content-Language: en-GB, es
To: Steve French <smfrench@gmail.com>
Cc: dhowells@redhat.com, linux-cifs@vger.kernel.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Matthew Ruffell <matthew.ruffell@canonical.com>
References: 
 <CAH2r5mswELNv2Mo-aWNoq3fRUC7Rk0TjfY8kwdPc=JSEuZZObw@mail.gmail.com>
 <20240207034117.20714-1-matthew.ruffell@canonical.com>
 <CAH2r5mu04KHQV3wynaBSrwkptSE_0ARq5YU1aGt7hmZkdsVsng@mail.gmail.com>
 <CAH2r5msJ12ShH+ZUOeEg3OZaJ-OJ53-mCHONftmec7FNm3znWQ@mail.gmail.com>
 <CAH2r5muiod=thF6tnSrgd_LEUCdqy03a2Ln1RU40OMETqt2Z_A@mail.gmail.com>
From: "R. Diez" <rdiez-2006@rd10.de>
In-Reply-To: 
 <CAH2r5muiod=thF6tnSrgd_LEUCdqy03a2Ln1RU40OMETqt2Z_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <170729616117.21343.14938697758165760910@mx2eb1.netcup.net>
X-Rspamd-Queue-Id: BCE5B1005CA
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: vVsr0i55I4alXppxIkwa5s9J4vaetZWhQMwyxB/u

Hallo Steve:

I wonder what would happen if the SMB server said it can take a maximum of 2048 Bytes, and you insist on 4096. Would the connection still work later on? Wouldn't it be better to abort the connection with a descriptive error message?

You stated that this scenario is very unlikely, but my Linux client is negotiating 16580 bytes at the moment, so if PAGE_SIZE happens to be 64 KiB, that wouldn't be very unlikely any more.

About this other change:

if (round_up(ctx->wsize, 4096) != ctx->wsize)
   cifs_dbg(VFS, "wsize should be a multiple of 4096\n")

All my SMB connections have been automated, therefore I am very unlikely to realise of such a warning. It would also mislead people using the current Kernel versions into thinking that this limitation is there to stay.

If the SMB client cannot really honour the user request, wouldn't it be better to fail? In any case, how about mentioning in the error or warning message that this is only a temporary limitation?

The second version of your patch file looks like a VIM swap file. I gather you attached the wrong file. The best way to fix this is obviously to switch to Emacs. ;-)

Regards,
   rdiez


