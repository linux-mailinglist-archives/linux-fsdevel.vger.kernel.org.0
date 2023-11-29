Return-Path: <linux-fsdevel+bounces-4183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5D97FD6DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 13:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AF828130C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 12:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDBA1DDD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOggLREL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01FF1D521;
	Wed, 29 Nov 2023 11:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DB2C433C8;
	Wed, 29 Nov 2023 11:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701258220;
	bh=6hxakAmZIQItNkD76sjQSF/47UpUdJ+ouDdRtONsXGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOggLRELEWXcQMxKJNdbflVMplqVs1d4oSFZVtSvmNNvSIFVTXoEb7tMaarWGgp5n
	 SQvQ0XbsjD/9KVI6qacU5DD0JTLkFSmOnHtYDCv91tsumKeJ9kZbdPMqxEgdvYZydf
	 TIdUDPKMmjNry2UBwuyoaNuPkkRN0hcNFttoEp8AqxMQAGMB0szOe8vPvuShf0nxCx
	 2tqlvm6XWQYYNZrxVdd34UPB+Zt6057uBH88fQzfG3jBIz8CzkI+XjpyJKgqdTpeZx
	 QoJfoWXJaxoYtjQbKJXh2WZRTfC+CrQlmAdQlAyuuGt5soT3PtwC5+5ogURFuOxBpV
	 weh+Z4iphCbEg==
Date: Wed, 29 Nov 2023 12:43:36 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
Message-ID: <20231129-querschnitt-urfassung-3ebd703c345a@brauner>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
 <ZWUfNyO6OG/+aFuo@tissot.1015granger.net>
 <170113056683.7109.13851405274459689039@noble.neil.brown.name>
 <20231128-blumig-anreichern-b9d8d1dc49b3@brauner>
 <170121362397.7109.17858114692838122621@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <170121362397.7109.17858114692838122621@noble.neil.brown.name>

> If an nfsd thread only completes the close that it initiated the close
> on (which is what I am currently proposing) then there would be at most
> one, or maybe 2, fds to close after handling each request.  While that
> is certainly a non-zero burden, I can't see how it can realistically be
> called a DOS.

The 10s of millions of files is what makes me curious. Because that's
the workload that'd be interesting.

> > It feels that this really needs to be tested under a similar workload in
> > question to see whether this is a viable solution.
> > 
> 
> Creating that workload might be a challenge.  I know it involved
> accessing 10s of millions of files with a server that was somewhat
> memory constrained.  I don't know anything about the access pattern.
> 
> Certainly I'll try to reproduce something similar by inserting delays in
> suitable places.  This will help exercise the code, but won't really
> replicate the actual workload.

