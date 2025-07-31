Return-Path: <linux-fsdevel+bounces-56399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB39AB17127
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 14:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38A5E7B9006
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 12:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8162C15B6;
	Thu, 31 Jul 2025 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="PaBbkIKN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D460D2C15AC;
	Thu, 31 Jul 2025 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964716; cv=none; b=FtQPVSxXFCt+nFrCAy726O346z7Li4jdb6oUTmVAtTF5nE0fPypNVzYRmtxkj8d0L2Um2cDOeQLERujKw7V7Bze99mKUC+MddzGl5yWYxtKDDV7C5vUxn/iQRhGD21z/vAFubeSrSIgvEtz1/vhGm72pbCBJSVgREJ/0Zw7JRMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964716; c=relaxed/simple;
	bh=K9yrhTsnhyVrEmPO39ozdocHN8115ue4s/EKisz0M38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lExuS95NDR3ShcQTcw959m/n1Rk2GWrvQDLrvv7XTuyrR8nYV8IedU5s8G17cwJ/YYb6uqa0VqCocNMx/LTwGBH2zjPoW8drHxWbeR+z/DpkzakbmsFt0edH01Xs0sJHTIo41Q85rfdJp6o8Cu/0WOtgY8NfqMIZvYMzngjitVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=PaBbkIKN; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 2ED9D14C2D3;
	Thu, 31 Jul 2025 14:25:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1753964711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lKMAQygJDNslq3XHuJ3zmDHFxLSUSF2cjx8vbtFuTOA=;
	b=PaBbkIKNmjfRY/xR1aXFkbUUEnpFJPKc53y/b1vbtXvGbz1xJCUA0TCflNxPLwu9kIC4Tq
	GoH+E6KU372mKJlG/GG8yfyyE/nyoojDIylDHymzaio4hyr4TZjNwBI+Sdw+oVpc4LvxMP
	3eqVBLVKfl5RuCJ/V6iurLX5mlMJND0B7MmGNt0oHU9CjMu+4apZqUSvUxHl2gMjswS5DX
	P3Yl7JW9yRdNP4Zj8RuVeWQuaU80p1z1iToMzwvi6Yz/wwnxYDQh8RRgwZe+zgedk+KWgg
	PZjCfatj5s0NiH8zJfZGYHdtPuvtHl6IUN72hhBN0d1ZIHJMmXCGOTH2gL6aKw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 891bc4a8;
	Thu, 31 Jul 2025 12:25:07 +0000 (UTC)
Date: Thu, 31 Jul 2025 21:24:52 +0900
From: asmadeus@codewreck.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ericvh@kernel.org, lucho@ionkov.net,
	linux_oss@crudebyte.com, dhowells@redhat.com
Subject: Re: [PATCH V2 0/4] 9p: convert to the new mount API
Message-ID: <aItglBck_Ubo7udq@codewreck.org>
References: <20250730192511.2161333-1-sandeen@redhat.com>
 <aIqa3cdv3whfNhfP@codewreck.org>
 <fb7e2cc2-a13a-4ff7-b4ab-8f39492d3f76@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb7e2cc2-a13a-4ff7-b4ab-8f39492d3f76@redhat.com>

Eric Sandeen wrote on Wed, Jul 30, 2025 at 08:38:17PM -0500:
> > I think the main contention point here is that we're moving some opaque
> > logic that was in each transport into the common code, so e.g. an out of
> > tree transport can no longer have its own options (not that I'm aware of
> > such a transport existing anyway, so we probably don't have to worry
> > about this)
> 
> I had not thought about out of tree transports. And I was a little unsure
> about moving everything into fs/9p/* but I'm not sure I saw any other way
> to do it in the new framework. @dhowells?

I've had a quick look as well and I don't see either -- parameters are
parsed one at a time so we can't do the two passes needed to first get
the transport out of the arguments and then instantiate a transport and
parse again.
I really think it's fine in practice, just something to remember.

> > OTOH this is also a blessing because 9p used to silently ignore unknown
> > options, and will now properly refuse them (although it'd still silently
> > ignore e.g. rdma options being set for a virtio mount -- I guess there's
> > little harm in that as long as typos are caught?)
> 
> Well, that might be considered a regression. Such conversions have burned
> us before, so if you want, it might be possible to keep the old more
> permissive behavior ... I'd have to look, not sure.

From my understanding we just need to make v9fs_parse_param return 0
instead of 'opt' if fs_parse() < 0, but I think it's fine to error on
unknown options (more in line with other filesystems at least)
We can reconsider this and make it a non-error when or if someone
complains about it.

-- 
Dominique Martinet | Asmadeus

