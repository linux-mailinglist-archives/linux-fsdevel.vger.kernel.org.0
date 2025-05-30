Return-Path: <linux-fsdevel+bounces-50139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D94AC87C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 07:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4BC3A929C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 05:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA331EB5FD;
	Fri, 30 May 2025 05:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQSop8Gq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EDB1E3DE8;
	Fri, 30 May 2025 05:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748582504; cv=none; b=IcrDvmZc3hxhsF9g5H3DntqpClb2FQLPyHjDLvB5Cw0BdpxrHk2qMGfirMLPiMFnCXHyvirygGAXadOnceL0n38L9/qOZlqvj0t4KJpeTTvMwrcrPjzkGq3016wKFWEpagMvOkgnWoOnuOWfJwFCGrZ/W4NQdMh/gWcuk1PLqL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748582504; c=relaxed/simple;
	bh=6GtyjWgTMcrJWZp97aOKpurW7V3N2yGrsSmdcIKOhK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJXUitLTm6e9OYz/4qdO8M3za/T6R51t2kK/jrPOljuo7jw1u3a+sruLiBx3aE81kWyZaGJ68CfISq/dzUpbXOoy8WPeQ26SP+bG9lzlWllUZPfvNikGQgZagSrBxhVt3ERUyT3CQZYUrTs2G4M87dQ2BxLkOKtmWnikZ35GUp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQSop8Gq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7596BC4CEED;
	Fri, 30 May 2025 05:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748582503;
	bh=6GtyjWgTMcrJWZp97aOKpurW7V3N2yGrsSmdcIKOhK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQSop8GqsDAL4hWo/RY513CbLEFaNs486dz5ZrmHE2E++y0eYEknXCzduVAGt1/Gq
	 gqCs4qtwUQ8T4IKvRhWEcaF2ICBGDpRY0O+LAAJYEDWLHRIO3WFQwXUn7+B9xpSISd
	 Xg8o2vL2eQ3M9+xOhpWD2NbfICUBoN46BNjF7tSGKxaHQeJggG1XUV2hAeXdbSvDPw
	 ne7fa4pNOsXtmm8Hf6qCjja981SO8tt3Py8N7D4PqPUNzuGz/Y0HaI0kV2rnCJ7p9K
	 P2WLq7BRBdLuSppqSW62UXzEE1qM/OnfwVymmqqMaY9N+BVCpCBnrVVUBsj9Ba758h
	 g24sz6aTeqdJg==
Date: Fri, 30 May 2025 07:21:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Yangtao Li <frank.li@vivo.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] hfs: correct superblock flags
Message-ID: <20250530-gutmachen-pudding-d69332f92e08@brauner>
References: <20250519165214.1181931-1-frank.li@vivo.com>
 <20250519165214.1181931-2-frank.li@vivo.com>
 <ca3b43ff02fd76ae4d2f2c2b422b550acadba614.camel@dubeyko.com>
 <SEZPR06MB5269D12DE8D4F48AF96E7409E867A@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <e388505b98a96763ea8b5d8197a9a2a17ec08601.camel@ibm.com>
 <7deb63a4-1f5f-4d6c-9ff4-0239464bd691@vivo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7deb63a4-1f5f-4d6c-9ff4-0239464bd691@vivo.com>

On Thu, May 29, 2025 at 10:25:02AM +0800, Yangtao Li wrote:
> +cc Christian Brauner
> 
> 在 2025/5/29 05:26, Viacheslav Dubeyko 写道:
> > On Wed, 2025-05-28 at 16:37 +0000, 李扬韬 wrote:
> > > Hi Slava,
> > > 
> > > > I am slightly confused by comment. Does it mean that the fix introduces more errors? It looks like we need to have more clear explanation of the fix here.
> > > 
> > > I'll update commit msg.
> > > 
> > > > s->s_flags |= SB_NODIRATIME | SB_NOATIME;
> > > 
> > > IIUC, SB_NOATIME > SB_NODIRATIME.
> > > 
> > 
> > Semantically, it's two different flags. One is responsible for files and another
> > one is responsible for folders. So, this is why I believe it's more safe to have
> > these both flags.
> 
> To be honest, from my point of view, SB_NOATIME is more like disabling atime
> updates for all types of files, not just files. I would like to know what
> vfs people think, whether we need to use both flags at the same time.

SB_NODIRATIME should be a subset of SB_NOATIME. So all you should need
is SB_NOATIME to disable it for all files.

