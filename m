Return-Path: <linux-fsdevel+bounces-61462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C37FB587F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B0E206905
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 22:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CBD2DCF62;
	Mon, 15 Sep 2025 22:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KRInvItP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABBA21A420;
	Mon, 15 Sep 2025 22:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977149; cv=none; b=O4w5DHWSEmb8HCXc90tM8yynhOwk6/nLsW0T1P28OcFfCUrGlyDq+iWUZVmk8yXx9PMcekV2SG61wJ7zeUDG3cl8/bVeaNuwhkbwAlPaL0JeXnS3BAqvNqsj1kFE9Lj0R7b9s44i9+WFZxrygRZG56ymELC/Cj8EYfIz290dU6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977149; c=relaxed/simple;
	bh=1/okIRx6o6vXJ31CVPKT9oMoMrLI+nwNYwzkdKXP1jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLmOal2Iy6ZxqK42X3cpO1nW586wmBXSu03AbyWhNsEU26Fig35XfF7Yd/5efBjB3Yo91IDHOhvoCQiVgxzeLTALH+ZXshTRhNxy/O1e85SapjlqR5aF6UlxqdwochCPFDtdKSniH/iTzU1cDgtnyZQIL8cDU7qg0MmsaUkXMHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KRInvItP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mdyKMuWGpTGQ0ttuPEqL6sr1d5oGlQeSkZeqJKPbKkQ=; b=KRInvItPTiQ7sozyuVsD7co6HF
	vxfW8ElvkU/dhOCccE2SPJnhwzjpdgiOudDzvaWosTn2ujITQSuhw7alUhf6nk27jQ62/s1P4Z6a2
	Nu/Y0ZoYsh5JhxpXdsgsugp+acqkD/MgSbHBi0BrV+0J2JdPCPa2X9GoHVyQ2TVK/3Svjx8ag6WFY
	StuNrAayldaXINOzw97HMRjLYeSQ7d0qfCww1rnvlxGC93WoQiJ/jesCwguey8dI9yVKzoy6kbnsk
	nR22zsssC3HmfdCm/v0STAhQTazT3X4Zquqfw2qfLCRjHftac+ivCetImKyTataYaGh/WZrTwjYmR
	4gui8AyQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyIA2-00000001xLm-0jr3;
	Mon, 15 Sep 2025 22:59:02 +0000
Date: Mon, 15 Sep 2025 23:59:02 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 11/33] net: use ns_common_init()
Message-ID: <20250915225902.GK39973@ZenIV>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-11-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-work-namespace-v2-11-1a247645cef5@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Sep 12, 2025 at 01:52:34PM +0200, Christian Brauner wrote:

> +	ret = ns_common_init(&net->ns, ns_ops, false);
					       ^^^^^
> +	if (ret)
> +		return ret;

How would that possibly fail?  You are not trying to grab inum here,
what's there to fail?

> @@ -559,7 +572,9 @@ struct net *copy_net_ns(unsigned long flags,
>  		goto dec_ucounts;
>  	}
>  
> -	preinit_net(net, user_ns);
> +	rv = preinit_net(net, user_ns);
> +	if (rv < 0)
> +		goto dec_ucounts;

Ditto.

