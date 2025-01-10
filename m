Return-Path: <linux-fsdevel+bounces-38909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA75A09C57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 21:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F241F188C8D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 20:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E455215160;
	Fri, 10 Jan 2025 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9rXifLm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEFF206F1D;
	Fri, 10 Jan 2025 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736540378; cv=none; b=rLyOr4R7UKvjBg+5i19zeQ68UZ9taLauD0NMJM0+JxK5fxyTcjCXtfcMCROeqLQW7ecZAKFdCUHc12R+6PlIZyegHY3kX1LxQf38PzusQg0DSM02b3HTvGGHB+LRPRbNjCTp4qoXfrIsyITT6sjf2ViESRlwqFzAQmX7wjjTHXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736540378; c=relaxed/simple;
	bh=gZPW62WzVNAvcfUCAglWQWZL0TezkbONp6sQUbf8o9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5AhKN1X1Xp45oN/IPVJWcG2SZ8WTI+76Tf87Mlsk+g4iL6pc2R/4ZOLLwMk7hw2Ndq83njGERI89gUggKENEkEsgSoRqj+VDEY3X11NP4nQK7cNoKc1BVbq/27uXlm6G6xKZZqXXmhQnO5U1vjrYp1A3BfD2zDPTOEB7NezlcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9rXifLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E67C4CED6;
	Fri, 10 Jan 2025 20:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736540378;
	bh=gZPW62WzVNAvcfUCAglWQWZL0TezkbONp6sQUbf8o9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9rXifLm0rqZlJmxt5gWHu+Peu3Pt8AS7yfRihF/iXvd+D8jytszYlxCNlbGtlrST
	 meXe844Ox5kt64DVC5i0JsPrQB7rinNHiTqCWs05eu0sR9jo9udpaVhXZXElWBmWR3
	 qaxszXicGIDRX0M/LrvUQfAV6ym7YoxH4m3HcBlWWWtts8YZa7V66tIs0pANy3PV5i
	 57n3asODmQfhjPZlm784x5v+50ax40iGhRzh2JRwz9fSo3lznEhNMLctrboLZzF/z2
	 PrkJlVd/O+DHscDbdb34Nt/sszMlm0QuAnmNtM7DCFwZEtYNaU0jnHZxi8H1n2vmkw
	 ATYSu4ANepsQQ==
Date: Fri, 10 Jan 2025 10:19:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Juntong Deng <juntong.deng@outlook.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com,
	Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: per st_ops kfunc allow/deny mask. Was: [PATCH bpf-next v6 4/5]
 bpf: Make fs kfuncs available for SYSCALL program type
Message-ID: <Z4GA2dhj1PZWTvSv@slm.duckdns.org>
References: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080E0DFE4F9BAFFDB9D113B99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQLU=W7fuEQommfDYrxr9A2ESV7E3uUAm4VUbEugKEZbkQ@mail.gmail.com>
 <AM6PR03MB50805EAC8B42B0570A2F76B399032@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQJYVLEs8zr414j1xRZ_DAAwcxiCC-1YqDOt8oF13Wf6zw@mail.gmail.com>
 <CAPhsuW7KYss11bQpJo-1f7Pdpb=ky2QWQ=zoJuX3buYm1_nbFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW7KYss11bQpJo-1f7Pdpb=ky2QWQ=zoJuX3buYm1_nbFA@mail.gmail.com>

Hello,

On Thu, Jan 09, 2025 at 12:49:39PM -0800, Song Liu wrote:
...
> Shall we move some of these logics from verifier core to
> btf_kfunc_id_set.filter()? IIUC, this would avoid using extra
> KF_* bits. To make the filter functions more capable, we
> probably need to pass bpf_verifier_env into the filter() function.

FWIW, doing this through callbacks (maybe with predefined helpers and
conventions) seems like the better approach to me given that this policy is
closely tied to specific subsystem (sched_ext here). e.g. If sched_ext want
to introduce new kfunc groups or rules, the changes being contained within
sched_ext implementation would be nicer.

Thanks.

-- 
tejun

