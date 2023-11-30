Return-Path: <linux-fsdevel+bounces-4410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB817FF250
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D531C20400
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89026495DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKH2GVzt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862EF495EA;
	Thu, 30 Nov 2023 14:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5879C433C7;
	Thu, 30 Nov 2023 14:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701353919;
	bh=KWh6WrvRBA/2y9C3DeEyxrAn6hfNwQA1TgM/LAr/cbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rKH2GVztBJVr9VrPuidBNfh17LuITLFr0quPg6mvsC8ofPB4+mMGM4vHBUJ9ViEjt
	 lHo9Wqx8mtKuDeoJj6EdWARnmohWzMl+MuP6cyIBqsIvOz+8uA2fra+Ybse0ENEbq4
	 lL3uRUVXHPM/RsIn5KCMFyRhONgSJ0tmjMX0X8G3qGQmbKW990CnipJrJPatZcoTIP
	 mme0Ut6q5B0GxCQhT/0jLItZV95iEjo4Bpg0qY9DJXy2yb9deIDk+bijdnrUyzFv93
	 7mWLPSBe1C82QttfBNTeYVAoQenI1D/4Awu8m0WwGvk4t8F0cCAJUA3qUiRJALm4Yn
	 loYtiDl6b9QfQ==
Date: Thu, 30 Nov 2023 15:18:33 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, keescook@chromium.org,
	kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH v11 bpf-next 02/17] bpf: add BPF token delegation mount
 options to BPF FS
Message-ID: <20231130-zivildienst-weckt-4888b2689eea@brauner>
References: <20231127190409.2344550-1-andrii@kernel.org>
 <20231127190409.2344550-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127190409.2344550-3-andrii@kernel.org>

On Mon, Nov 27, 2023 at 11:03:54AM -0800, Andrii Nakryiko wrote:
> Add few new mount options to BPF FS that allow to specify that a given
> BPF FS instance allows creation of BPF token (added in the next patch),
> and what sort of operations are allowed under BPF token. As such, we get
> 4 new mount options, each is a bit mask
>   - `delegate_cmds` allow to specify which bpf() syscall commands are
>     allowed with BPF token derived from this BPF FS instance;
>   - if BPF_MAP_CREATE command is allowed, `delegate_maps` specifies
>     a set of allowable BPF map types that could be created with BPF token;
>   - if BPF_PROG_LOAD command is allowed, `delegate_progs` specifies
>     a set of allowable BPF program types that could be loaded with BPF token;
>   - if BPF_PROG_LOAD command is allowed, `delegate_attachs` specifies
>     a set of allowable BPF program attach types that could be loaded with
>     BPF token; delegate_progs and delegate_attachs are meant to be used
>     together, as full BPF program type is, in general, determined
>     through both program type and program attach type.
> 
> Currently, these mount options accept the following forms of values:
>   - a special value "any", that enables all possible values of a given
>   bit set;
>   - numeric value (decimal or hexadecimal, determined by kernel
>   automatically) that specifies a bit mask value directly;
>   - all the values for a given mount option are combined, if specified
>   multiple times. E.g., `mount -t bpf nodev /path/to/mount -o
>   delegate_maps=0x1 -o delegate_maps=0x2` will result in a combined 0x3
>   mask.
> 
> Ideally, more convenient (for humans) symbolic form derived from
> corresponding UAPI enums would be accepted (e.g., `-o
> delegate_progs=kprobe|tracepoint`) and I intend to implement this, but
> it requires a bunch of UAPI header churn, so I postponed it until this
> feature lands upstream or at least there is a definite consensus that
> this feature is acceptable and is going to make it, just to minimize
> amount of wasted effort and not increase amount of non-essential code to
> be reviewed.
> 
> Attentive reader will notice that BPF FS is now marked as
> FS_USERNS_MOUNT, which theoretically makes it mountable inside non-init
> user namespace as long as the process has sufficient *namespaced*
> capabilities within that user namespace. But in reality we still
> restrict BPF FS to be mountable only by processes with CAP_SYS_ADMIN *in
> init userns* (extra check in bpf_fill_super()). FS_USERNS_MOUNT is added
> to allow creating BPF FS context object (i.e., fsopen("bpf")) from
> inside unprivileged process inside non-init userns, to capture that
> userns as the owning userns. It will still be required to pass this
> context object back to privileged process to instantiate and mount it.
> 
> This manipulation is important, because capturing non-init userns as the
> owning userns of BPF FS instance (super block) allows to use that userns
> to constraint BPF token to that userns later on (see next patch). So
> creating BPF FS with delegation inside unprivileged userns will restrict
> derived BPF token objects to only "work" inside that intended userns,
> making it scoped to a intended "container". Also, setting these
> delegation options requires capable(CAP_SYS_ADMIN), so unprivileged
> process cannot set this up without involvement of a privileged process.
> 
> There is a set of selftests at the end of the patch set that simulates
> this sequence of steps and validates that everything works as intended.
> But careful review is requested to make sure there are no missed gaps in
> the implementation and testing.
> 
> This somewhat subtle set of aspects is the result of previous
> discussions ([0]) about various user namespace implications and
> interactions with BPF token functionality and is necessary to contain
> BPF token inside intended user namespace.
> 
>   [0] https://lore.kernel.org/bpf/20230704-hochverdient-lehne-eeb9eeef785e@brauner/
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

I still think this is a little weird because this isn't really
unprivileged bpf and it isn't really safe bpf as well.

All this does is allow an administrator to punch a big fat hole into an
unprivileged container so workloads get to play with their favorite toy.

I think that having a way to have signed bpf programs in addition to
this would be much more interesting to generic workloads that don't know
who or what they can trust.

And there's a few things to remember:

* This absolutely isn't a safety mechanism.
* This absolutely isn't safe to enable generically in containers.
* This is a workaround and not a solution to unprivileged bpf.

And this is an ACK solely on the code of this patch, not the concept.
Acked-by: Christian Brauner <brauner@kernel.org> (reluctantly)

