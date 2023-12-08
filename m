Return-Path: <linux-fsdevel+bounces-5325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4253180A58D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 15:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2EB0281AEC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 14:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1501E50B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYftDdRO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3D41CA81;
	Fri,  8 Dec 2023 13:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08B5C433C8;
	Fri,  8 Dec 2023 13:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702042886;
	bh=iw7AZIJ/HJKYatG6312tRTjIKLjBbSHjSe1T5NGECQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYftDdROJXoaI/Jn/GPYBGoyH3/829Gl5qFur6JUJ6zdo7RBLZMSUj/cMVWFEnj7H
	 7IbDdS0VB7rHXQbYOgM4QI9jkA8l/6jBuS2HQbMUr2WmnCW8nKRkfoO4stnhJBe9j4
	 6mlrkQ3ANYZPzqmTqc51l08PUKVxzzmGoVS3Y+NdCkb9t/CZcfcnGy5tZfv5+K0z4O
	 rvY2YHR94O9KbAJFRPi1IsVV+3G742E29qDf1bzZYy1ZI1DBusScIUddmgmEa0tWsc
	 oo529eVoDA3yWzE8AyALmhgtisod0H3BCsmZgU1fK0Kzju3giOUt8hn0IToE0ZYXMS
	 zE9oj2/YDZ9pA==
Date: Fri, 8 Dec 2023 14:41:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, keescook@chromium.org,
	kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH v12 bpf-next 03/17] bpf: introduce BPF token object
Message-ID: <20231208-besessen-vibrieren-4e963e3ca3ba@brauner>
References: <20231130185229.2688956-1-andrii@kernel.org>
 <20231130185229.2688956-4-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231130185229.2688956-4-andrii@kernel.org>

On Thu, Nov 30, 2023 at 10:52:15AM -0800, Andrii Nakryiko wrote:
> Add new kind of BPF kernel object, BPF token. BPF token is meant to
> allow delegating privileged BPF functionality, like loading a BPF
> program or creating a BPF map, from privileged process to a *trusted*
> unprivileged process, all while having a good amount of control over which
> privileged operations could be performed using provided BPF token.
> 
> This is achieved through mounting BPF FS instance with extra delegation
> mount options, which determine what operations are delegatable, and also
> constraining it to the owning user namespace (as mentioned in the
> previous patch).
> 
> BPF token itself is just a derivative from BPF FS and can be created
> through a new bpf() syscall command, BPF_TOKEN_CREATE, which accepts BPF
> FS FD, which can be attained through open() API by opening BPF FS mount
> point. Currently, BPF token "inherits" delegated command, map types,
> prog type, and attach type bit sets from BPF FS as is. In the future,
> having an BPF token as a separate object with its own FD, we can allow
> to further restrict BPF token's allowable set of things either at the
> creation time or after the fact, allowing the process to guard itself
> further from unintentionally trying to load undesired kind of BPF
> programs. But for now we keep things simple and just copy bit sets as is.
> 
> When BPF token is created from BPF FS mount, we take reference to the
> BPF super block's owning user namespace, and then use that namespace for
> checking all the {CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN}
> capabilities that are normally only checked against init userns (using
> capable()), but now we check them using ns_capable() instead (if BPF
> token is provided). See bpf_token_capable() for details.
> 
> Such setup means that BPF token in itself is not sufficient to grant BPF
> functionality. User namespaced process has to *also* have necessary
> combination of capabilities inside that user namespace. So while
> previously CAP_BPF was useless when granted within user namespace, now
> it gains a meaning and allows container managers and sys admins to have
> a flexible control over which processes can and need to use BPF
> functionality within the user namespace (i.e., container in practice).
> And BPF FS delegation mount options and derived BPF tokens serve as
> a per-container "flag" to grant overall ability to use bpf() (plus further
> restrict on which parts of bpf() syscalls are treated as namespaced).
> 
> Note also, BPF_TOKEN_CREATE command itself requires ns_capable(CAP_BPF)
> within the BPF FS owning user namespace, rounding up the ns_capable()
> story of BPF token.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Same concerns as in the other mail. For the bpf_token_create() code,
Acked-by: Christian Brauner <brauner@kernel.org>

