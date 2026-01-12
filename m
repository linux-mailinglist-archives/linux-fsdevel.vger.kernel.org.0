Return-Path: <linux-fsdevel+bounces-73300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7B0D148CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 18:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E510D30164E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 17:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2320530F7F0;
	Mon, 12 Jan 2026 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xbpP05sU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C73424397A;
	Mon, 12 Jan 2026 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240351; cv=none; b=IlHUwnRllzkrjsvspeAMgEVGX+MuLR13/jTx1Ai/nZ/VTgjbbwbjnBRCW2nFp61ja/gLxBpDxIZD59vEuRpNWBDCbE0n/pMmhHIu93d6Ax8Wj/Ap9TERfcfTkblRizZQrzIKzdn9bHJaNgz0LKd2u56p+Vdgr0Brxqh7mzs8pBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240351; c=relaxed/simple;
	bh=k8nPYs3rXacj725h+SEC2czJgrYsjeMGwUmsnXgOvLM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tFCG1s22IzsshAwLEVMuqiTp3/UvnxvdCoU0l+oUWnCopwRmKYrgHd7bzq+H7LvDHB2eFQWESOraElygTyl3Y20s+QBnI0hshtMGyOfxiZIsf32tuVWTrxAp7WuVlLLEwOIKKfASnrzlay6NhJWMFlAFxlsfJmSJs6Fo35qsAUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xbpP05sU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22ADC116D0;
	Mon, 12 Jan 2026 17:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768240351;
	bh=k8nPYs3rXacj725h+SEC2czJgrYsjeMGwUmsnXgOvLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xbpP05sUG3HxYqGrUdXQ2dW4JI/hkWvA1ECrvw2o12Gf1l5jUauLxtutxGKKPJjCN
	 FKo5vaJ4Io3jd8T5/v8Hw9BsnKuX0AHVhS6JaC/KEmMJKUvMcrlYBqaKpldD+vHlFA
	 lqtAvCqI3A7c9tT7n+BzRB/q/UqviGR05kktfwC4=
Date: Mon, 12 Jan 2026 09:52:30 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] fat: avoid parent link count underflow in rmdir
Message-Id: <20260112095230.167359094e9c48577b387e18@linux-foundation.org>
In-Reply-To: <CALf2hKu=M8TALyqv=Tv9Vu98UKUcFjWix1n5D9raMKYqqZtY5A@mail.gmail.com>
References: <20260101111148.1437-1-zhiyuzhang999@gmail.com>
	<87secph8yi.fsf@mail.parknet.co.jp>
	<87ms2idcph.fsf@mail.parknet.co.jp>
	<CALf2hKu=M8TALyqv=Tv9Vu98UKUcFjWix1n5D9raMKYqqZtY5A@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 01:45:18 +0800 Zhiyu Zhang <zhiyuzhang999@gmail.com> wrote:

> Hi OGAWA,
> 
> Sorry, I thought the further merge request would be done by the maintainers.
> 
> What should I do then?

That's OK - I have now taken a copy of the patch mainly to keep track
of it.  It won't get lost.

I thought Christian was handling fat patches now, but perhaps that's a
miscommunication?


