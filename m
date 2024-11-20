Return-Path: <linux-fsdevel+bounces-35288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F183A9D368A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 10:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF123285F94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B80B19C566;
	Wed, 20 Nov 2024 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unsejYua"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641E3149C42;
	Wed, 20 Nov 2024 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093963; cv=none; b=HYHI5kO5UOMPeHXpwoT5FC4SfMgxt0ce+MZlmbF+hrrlaE2kzjvkjP8f6hlWSqCYp1fpPVX60Pq09YX5BQOmGmZeV8/7p0FXJVBmZRzvDmMdXjYlIkj9xXY8CnZlZ4cbrRNglyQntTh+Hg626ZrUD7dWE1Cf2skhqipKQRcSfbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093963; c=relaxed/simple;
	bh=qwCr0Gre7wQLjjxcjoyM/08A5mIW1ALVpH56QzeTtHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atA6dVQ54B2w1377XLP4R4ZFR5v+qiYf78jNPHzA4ahWGv2FBy9skMFtpl5RJB6/w/3dROcSvadsah9LAvL2WHhf0PVqZa/+cjOO7MVo3LzGWu8oXooXcTvLk5xmeOXfRekAuo2JChNIeHvluxcRV6PeXIHXnuDOg8/PvmSLOj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unsejYua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDEEC4CECD;
	Wed, 20 Nov 2024 09:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732093962;
	bh=qwCr0Gre7wQLjjxcjoyM/08A5mIW1ALVpH56QzeTtHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=unsejYuao4mN67vnfrpLIXVoLDfptJrAD9vfM1nnPJY4XXdqJqWzWLAdP4eZJyUpS
	 VhJCmyP2n2WR/zdWk9sUmHeyLomNMjD4exC5V8aPNJ3SI+aFjyTFhZinqm21JbW1z3
	 T0QJUO5RnuO3ipk4fx/HerlkLxMQ/X46iWFqI/uwTEzSeNU2ItMFheVgxKhsmVRoe0
	 fBZ5lJ8o3nu9KXRA8eMRN0og/CWGCKWi8qAFsqETxJ0i1Kn6dNBXZZbp3SSAghgrqE
	 7+L3U519yAjngOfKXpXns2wCbLS32qXPxIItsqauflwX4X7PrjoHul5un4N+AwNa/2
	 SUeot7qxgY8rg==
Date: Wed, 20 Nov 2024 10:12:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 0/5] bpf: Add open-coded style process file
 iterator and bpf_fget_task() kfunc
Message-ID: <20241120-campieren-thermal-a2587b7b01f5@brauner>
References: <AM6PR03MB50804C0DF9FB1E844B593FDB99202@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080BCAC62436057A03B334499202@AM6PR03MB5080.eurprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AM6PR03MB5080BCAC62436057A03B334499202@AM6PR03MB5080.eurprd03.prod.outlook.com>

On Tue, Nov 19, 2024 at 06:40:12PM +0000, Juntong Deng wrote:
> I noticed that the path_d_path_kfunc_non_lsm test case failed in BPF CI,
> I will fix it in the next version.
> 
> But before that, I would like to get some feedback. :)

Please resend once -rc1 is out and rebased to upstream where - as you
noticed - all fdget_rcu() variants are gone.

