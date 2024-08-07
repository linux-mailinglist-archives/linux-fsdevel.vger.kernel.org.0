Return-Path: <linux-fsdevel+bounces-25356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358FC94B1C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 23:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A07EAB22477
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 21:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90EC1494DC;
	Wed,  7 Aug 2024 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1Ob/gV3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11017148857;
	Wed,  7 Aug 2024 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723064773; cv=none; b=dLDUH1MCnWOlAR3JS381ihpZ+my0Qw9lBhhAD8bw6v4HJ8vXn+KyJqRqNash0dw+4nKZ89N8x+jZazvJj2gtWEJJzQPh4UBP55jNndP9kbXuLqO5p0B4bsn3vG+LtJmDRvtQ8/B1+EeyboQqNY/gWGghQ3/A62bDKh+LqdjI56A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723064773; c=relaxed/simple;
	bh=1ePz3DLStgqHL7yUL425MmkW+cQHQdIV9etyzi9jYG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxNMcLc5Se3oJbAOB3i0MFjURfRRPPDWybqILzTuSkbVZAdcVFD14L2vhPN7FDrOTMTZCMa1CMxhDBaKRqU0xXBtOKI3IQewKq+/dL0GR81rvH18cW2bl5kmEje2AXwzQBv9/4ZhydiPoX4/zIYH0EHDIsBXSgOJ2GGv4eo0msU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1Ob/gV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87874C32781;
	Wed,  7 Aug 2024 21:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723064772;
	bh=1ePz3DLStgqHL7yUL425MmkW+cQHQdIV9etyzi9jYG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o1Ob/gV3WcAT5BcFUJ0/QTTW5Stk8UX8Qt5RCTHuv/KSm2dxXQ6Qa3JkCttK78x0d
	 7uuUA1fadpfDiittlU3mMuMGOQnF+r55hMdaze5RYNu1w1grczqLVqjTebtXlD8CnC
	 Rd8WVLYVoeAh+d6fb+vN1tBJjdojAKv0PgphQ72lxcQeMmZmNM6kiNgLCRuNKwTFRr
	 hGVl3ekCpWMwwIEwRUvhys900G47rwDhyGzhE1+tdXfjbI8N0ZnVOztDVkcAj/KSL7
	 yTGA8YvRA+G2VHectvoWI9OchWD+N+7DQ14zcrY4JvoNOMdpEHe01RTBJEsLBLmEzU
	 hcrLHcLURQNkg==
Date: Wed, 7 Aug 2024 14:06:12 -0700
From: Kees Cook <kees@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
	jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
	wojciech.gladysz@infogain.com, ebiederm@xmission.com,
	linux-mm@kvack.org
Subject: Re: [PATCH] exec: drop a racy path_noexec check
Message-ID: <202408071404.4A44CFFF@keescook>
References: <20240805-fehlbesetzung-nilpferd-1ed58783ad4d@brauner>
 <20240805131721.765484-1-mjguzik@gmail.com>
 <20240806-atmen-planen-f0eb6e830d8e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806-atmen-planen-f0eb6e830d8e@brauner>

On Tue, Aug 06, 2024 at 09:06:17AM +0200, Christian Brauner wrote:
> On Mon, 05 Aug 2024 15:17:21 +0200, Mateusz Guzik wrote:
> > Both i_mode and noexec checks wrapped in WARN_ON stem from an artifact
> > of the previous implementation. They used to legitimately check for the
> > condition, but that got moved up in two commits:
> > 633fb6ac3980 ("exec: move S_ISREG() check earlier")
> > 0fd338b2d2cd ("exec: move path_noexec() check earlier")
> > 
> > Instead of being removed said checks are WARN_ON'ed instead, which
> > has some debug value
> > 
> > [...]
> 
> Applied to the vfs.misc branch of the vfs/vfs.git tree.

NAK, please drop this patch. I want to keep the "redundant"
path_noexec(), since it still provides meaningful signal. We can remove
it from the WARN_ON_ONCE(), but I don't want to drop it.

-- 
Kees Cook

