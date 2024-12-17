Return-Path: <linux-fsdevel+bounces-37626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE289F4AF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 13:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E59616D1B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 12:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37F61F37DB;
	Tue, 17 Dec 2024 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGSXyM+o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2071C1F3D56;
	Tue, 17 Dec 2024 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734438616; cv=none; b=CkuFJk1Zu4gcsogKnZxfppBRkqiDUWDAnugAxb/vQ1VF/uJryApe54jX5GxD+YYnxBVkOvE96B1QXImxk5fsujopJ3m6eLMqmtlwAc191Oly9RFsOnaktimZ74FRErHI+XPLVoGNlYzZOFXUbpd6k2/nTB81iT5wutDRWWsuQDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734438616; c=relaxed/simple;
	bh=y1xVSAe/4eu15UxXcRycpvtb+jFMM0AlSUmFDNOnipg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDvivWrG6B1yKkFCW3WFCO6PSKvLN/M8GBpP9vj/ZyI9EWw6uEitq3Ead0wmmn0ZcMI8JH3F1pmirmxG4RTUlwpkurd2KFiq2R55b7jcz0V3oc4tLrm4cUjhM0fWIOoiUN+9yH7eQtgJdCZEw2MP256CNlypaIy0N/nb8X/9vN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGSXyM+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255EDC4CEDD;
	Tue, 17 Dec 2024 12:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734438615;
	bh=y1xVSAe/4eu15UxXcRycpvtb+jFMM0AlSUmFDNOnipg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tGSXyM+oPXdxRgQT+ollMf949nZYjRtHOIiUvSvAV9qvPeL2+QyaRhr61cSkOuEor
	 l/YXQAPtq+xhL0lPu4zJYidAM7WKExknDF0N4grhfF8gYwTRICFlgq71R6DtBiGP/q
	 JM6PRfZyNqzvVYIfbqfKd/1W65kGeEljw/LpDz2gg8Q/CVVNy7vnKacJG9hDaGxHEI
	 DoJBH3jVhpqm11vmlMv9KJ7roIGPdoK1FS5NMioMcaTk8fvfT33/WAqEFDkTBaq0xv
	 cj9rX5oiwL4id7/lelVmgpXgsdj46e+KR2ljzsMFQ209LMXpKJi8N02JzMH59zIfcw
	 Ril5HaYzNqzLQ==
Date: Tue, 17 Dec 2024 13:30:08 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Juntong Deng <juntong.deng@outlook.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 4/5] bpf: Make fs kfuncs available for
 SYSCALL and TRACING program types
Message-ID: <20241217-bespucken-beimischen-339f3cc03dc2@brauner>
References: <AM6PR03MB508010982C37DF735B1EAA0E993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50804FA149F08D34A095BA28993D2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <20241210-eckig-april-9ffc098f193b@brauner>
 <CAADnVQKdBrX6pSJrgBY0SvFZQLpu+CMSshwD=21NdFaoAwW_eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKdBrX6pSJrgBY0SvFZQLpu+CMSshwD=21NdFaoAwW_eg@mail.gmail.com>

On Tue, Dec 10, 2024 at 10:58:52AM -0800, Alexei Starovoitov wrote:
> On Tue, Dec 10, 2024 at 6:43 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Dec 10, 2024 at 02:03:53PM +0000, Juntong Deng wrote:
> > > Currently fs kfuncs are only available for LSM program type, but fs
> > > kfuncs are generic and useful for scenarios other than LSM.
> > >
> > > This patch makes fs kfuncs available for SYSCALL and TRACING
> > > program types.
> >
> > I would like a detailed explanation from the maintainers what it means
> > to make this available to SYSCALL program types, please.
> 
> Sigh.

Hm? Was that directed at my question? I don't have the background to
judge this and this whole api looks like a giant footgun so far for
questionable purposes.

I have a hard time seeing parts of CRIU moved into bpf especially
because all of the userspace stuff exists.

> This is obviously not safe from tracing progs.
> 
> From BPF_PROG_TYPE_SYSCALL these kfuncs should be safe to use,
> since those progs are not attached to anything.
> Such progs can only be executed via sys_bpf syscall prog_run command.
> They're sleepable, preemptable, faultable, in task ctx.
> 
> But I'm not sure what's the value of enabling these kfuncs for
> BPF_PROG_TYPE_SYSCALL.

