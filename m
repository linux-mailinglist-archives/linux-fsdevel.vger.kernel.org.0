Return-Path: <linux-fsdevel+bounces-24358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B421093DD71
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 07:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32C93B21816
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 05:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A351864C;
	Sat, 27 Jul 2024 05:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="STBp318R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37E21B86E0
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jul 2024 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722059275; cv=none; b=agOZsPEZBITXoZJ3+xNiSN07wsYyjMGnmTbZ677HFm41u2BVPPstOVznmmk+N7kLgiZl4+Czb2p4STz0qr6UFroOXQLFjmyJ4Hp/1v6UUaFh/KQunymbcZql5xa+JsvXFVeONOHFWkcDo+qE21LymR+1dr1hXtugP4mE3GVFF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722059275; c=relaxed/simple;
	bh=ln5NTakwSSNf0pLbN2vKA1hAEvoY08AWdFsn0HbEjds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDUpuVmA0gblkrKQJShXrNsvEpidY0phbA9bWS9xjHJTjmmxeUSrUQdAAdvhSmfC2toSSznAp2UGPbY2tzZnPIrOzcfCT2aLVwCEl2prt25xtv2GF17l94B0Zvw+jcW/7VZQujipaxR1rlDPrugYg/pDStcRyf2JFYaqiC/omIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=STBp318R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89F9C32781;
	Sat, 27 Jul 2024 05:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722059275;
	bh=ln5NTakwSSNf0pLbN2vKA1hAEvoY08AWdFsn0HbEjds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=STBp318RJJkng2MU9cFb9t6xqJ1YSEundwIFKBFFczhm1GAGppmhBxAwUG71L2Eah
	 gNZ82czSGNj3XNkHSDIAxk0TxLQwO3+B661ph9k9LMSgHNO3qM/z+F69ELcejiudOo
	 ILRuqcQKrBfxkQ6HIglcL93s0GKoNkbQUFV3qjEM=
Date: Sat, 27 Jul 2024 07:47:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com
Subject: Re: hfsplus: Initialize directory subfolders in hfsplus_mknod
Message-ID: <2024072704-scorpion-pretzel-cecb@gregkh>
References: <20240727052349.74139-1-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727052349.74139-1-simeddon@gmail.com>

On Sat, Jul 27, 2024 at 10:53:50AM +0530, Siddharth Menon wrote:
> hfsplus: Initialize directory subfolders in hfsplus_mknod

Shouldn't this be in the subject line only?

And no [PATCH]?

> Addresses uninitialized subfolders attribute being used in `hfsplus_subfolders_inc` and `hfsplus_subfolders_dec`.

Linewrap please.

> 
> Fixes: https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
> Reported-by: syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/x/report.txt?x=16efda06680000
> Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> ---
>  fs/hfsplus/dir.c | 3 +++
>  1 file changed, 3 insertions(+)

As this is a v2 patch, you must describe below the --- line what changed
from the first one.

thanks,

greg k-h

