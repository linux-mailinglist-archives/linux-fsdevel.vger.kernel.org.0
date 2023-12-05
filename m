Return-Path: <linux-fsdevel+bounces-4869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB0D8054DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 13:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02451C20AAD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 12:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5757461FBB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGRbNWQ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6BDD2F2;
	Tue,  5 Dec 2023 11:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BB3C433C8;
	Tue,  5 Dec 2023 11:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701774875;
	bh=73OmEx/ffdjmiPEOThkveKIEzd2DYDI4NvXIfUxZjdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGRbNWQ+IVQsfsMM9YLNcHR1m+fzzIM0EaRQrWrQL/rBcp8r3DBycTQdbHRA3dOe2
	 1doWXZaDiDWl331klEewtGDlvTUyY02UQoBkw2bXQDnawc6ApM6Abh2EjT+juFRe/n
	 +PTbAjPNNw4IwxnKyjjJ4oKjKIQzqLBrsnsP3OnZzdug4c5s7gs/ATpUeYcZH9EzPo
	 hi6PdxLFwShnchuxaeJLJ8fOIXHiDUAzll/enY/d//GIFDG3na4pqSeTnDPiL7ggXY
	 WKVyCh8Zx8d1alPNFf7wUDxz6UJyXpBCKznT+eKMD3exFCutM8YNpO1zIPMnv0t2Uk
	 smO5K6e9ZvNiA==
Date: Tue, 5 Dec 2023 12:14:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Oleg Nesterov <oleg@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] Allow a kthread to declare that it calls
 task_work_run()
Message-ID: <20231205-altbacken-umbesetzen-e5c0c021ab98@brauner>
References: <20231204014042.6754-1-neilb@suse.de>
 <20231204014042.6754-2-neilb@suse.de>
 <e9a1cfed-42e9-4174-bbb3-1a3680cf6a5c@kernel.dk>
 <170172377302.7109.11739406555273171485@noble.neil.brown.name>
 <a070b6bd-0092-405e-99d2-00002596c0bc@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a070b6bd-0092-405e-99d2-00002596c0bc@kernel.dk>

On Mon, Dec 04, 2023 at 03:09:44PM -0700, Jens Axboe wrote:
> On 12/4/23 2:02 PM, NeilBrown wrote:
> > It isn't clear to me what _GPL is appropriate, but maybe the rules
> > changed since last I looked..... are there rules?
> > 
> > My reasoning was that the call is effectively part of the user-space
> > ABI.  A user-space process can call this trivially by invoking any
> > system call.  The user-space ABI is explicitly a boundary which the GPL
> > does not cross.  So it doesn't seem appropriate to prevent non-GPL
> > kernel code from doing something that non-GPL user-space code can
> > trivially do.
> 
> By that reasoning, basically everything in the kernel should be non-GPL
> marked. And while task_work can get used by the application, it happens
> only indirectly or implicitly. So I don't think this reasoning is sound
> at all, it's not an exported ABI or API by itself.
> 
> For me, the more core of an export it is, the stronger the reason it
> should be GPL. FWIW, I don't think exporting task_work functionality is
> a good idea in the first place, but if there's a strong reason to do so,

Yeah, I'm not too fond of that part as well. I don't think we want to
give modules the ability to mess with task work. This is just asking for
trouble.

