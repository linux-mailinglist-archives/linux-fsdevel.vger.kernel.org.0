Return-Path: <linux-fsdevel+bounces-31203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D9B992FFD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C026E1C23A64
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340D71D958E;
	Mon,  7 Oct 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ADC7X/XI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB67B5338D;
	Mon,  7 Oct 2024 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312637; cv=none; b=Scl7ZQpPboDVPexttXmDebqdDjXzpSMSFEmQ4vgtplJ3RCyhSh2546/9y7z74fCerczyMtm07LuBdRLx+IWwRwttDnzxmJGKq5bRgOjBm6cQxQ4Hdd2RQdt6LQgMPiNR91fu97T0z71pdHciJtnHbAFcTnKJ9ET29ZtCoLFV/ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312637; c=relaxed/simple;
	bh=UbpbFvTNOVZRFax6Q3Rv/M1ysuIYRGy2GDLq5E3AuR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBSMolxqGskK5eVeG0gdDt69TA5/OBY+S4T6x5JltjsJoWz+PG5t1GgDp4jHC2ryloa8RIF99bSfQikcjkD+9KM+2faSTGo7EyKvE8oSE/wPenCzCjF/Wz5tdcN+40shsh73wfAQogTro38IAby6EuxhklHVGqK61EMo0lThJew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ADC7X/XI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iHiwZTTEd2jFO0zmdAQaCGTn6HE3o2CfaOkXTF2rcik=; b=ADC7X/XIwnfIKCjEEPRoWK4x6z
	rrbccgcePd9ReoBn4iUM1gEde0RFz6NxrE8Vkur55I4r5Ip7LNLqjVB+BEI6EHhDrR9PwubvzYJFj
	I99MkVcayy7mdcxyOg0z619NRG3TC/RMn9qNA1Yq/dn135LwZ18T6CVLOSe1Drcv1tE/xpkraC4Kv
	1WUR/I+7nt9C6lWEqCRITujZkRcX/rm9tQcXV+nEi7AgZgJr31s3rMBK6t90VV3gi1pUdTRjF5Wmd
	mmS4hn9GYs5sLLyrusXgTt96KHW/EmGr7NctvDGof5thXMvaByOuRuIKMjf+y7zjEgm4JDOgkGGrM
	ucUfRk3A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxp4E-00000001cCs-0Bzc;
	Mon, 07 Oct 2024 14:50:34 +0000
Date: Mon, 7 Oct 2024 15:50:34 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] namespace: Use atomic64_inc_return() in alloc_mnt_ns()
Message-ID: <20241007145034.GM4017910@ZenIV>
References: <20241007085303.48312-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007085303.48312-1-ubizjak@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Oct 07, 2024 at 10:52:37AM +0200, Uros Bizjak wrote:
> Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
> to use optimized implementation and ease register pressure around
> the primitive for targets that implement optimized variant.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> ---
>  fs/namespace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 93c377816d75..9a3c251d033d 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3901,7 +3901,7 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
>  	}
>  	new_ns->ns.ops = &mntns_operations;
>  	if (!anon)
> -		new_ns->seq = atomic64_add_return(1, &mnt_ns_seq);
> +		new_ns->seq = atomic64_inc_return(&mnt_ns_seq);

On which load do you see that path hot enough for the change to
make any difference???

Seriously, if we have something that manages that, I would like
to know - the same load would be a great way to stress a lot of
stuff in fs/namespace.c and fs/pnode.c...

