Return-Path: <linux-fsdevel+bounces-5457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2507780C584
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 11:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5665281819
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 10:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCD622095;
	Mon, 11 Dec 2023 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXHIOlGf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE96A1D6AE;
	Mon, 11 Dec 2023 10:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A977DC433CA;
	Mon, 11 Dec 2023 10:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702289041;
	bh=r68d1duxP7xVgr46w0Z1vpdCRfKjkuAvt5GXFsR/z7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MXHIOlGf4lSZ5mNEGbLKruvFEoWXfev6kp70IJ8A50CBg2/uFwlVM54P2u24CC/4t
	 zsS1WNETrapEIZi6N9I+3eFv9yMl7QJxo5YH0l09GHpIfYRyrTVnhgZh8WvJPcMj7u
	 f8Mfw5jYavhVKx3zCf6gRr60WQvRXH3eEWQV8UeFbelkKP/GMfc04atjd7uSdQ1j/Y
	 r69o1IHF82uCwzNY7qV2FrFWov1LYnQPLX5HpJTJlDNELxBxv8+Ei8QGGa5eMyrbGF
	 RzgoNJAfoX2FAhlbINZ2BVDYwuUhE456a7wSH0FUpwB/3ZQ2wW6d3chMn3ycfnCrzq
	 5RY7x/2a89xpw==
Date: Mon, 11 Dec 2023 11:03:55 +0100
From: Christian Brauner <brauner@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, paul@paul-moore.com,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, keescook@chromium.org,
	kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH v12 bpf-next 03/17] bpf: introduce BPF token object
Message-ID: <20231211-wahnwitzig-entzogen-2b720296349c@brauner>
References: <20231130185229.2688956-1-andrii@kernel.org>
 <20231130185229.2688956-4-andrii@kernel.org>
 <20231208-besessen-vibrieren-4e963e3ca3ba@brauner>
 <CAEf4BzbRKxBCzKbOWg0sWMzWurF5RvF5OwizXi7tSC2vM4Zi_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbRKxBCzKbOWg0sWMzWurF5RvF5OwizXi7tSC2vM4Zi_w@mail.gmail.com>

On Fri, Dec 08, 2023 at 02:39:56PM -0800, Andrii Nakryiko wrote:
> On Fri, Dec 8, 2023 at 5:41 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Thu, Nov 30, 2023 at 10:52:15AM -0800, Andrii Nakryiko wrote:
> > > Add new kind of BPF kernel object, BPF token. BPF token is meant to
> > > allow delegating privileged BPF functionality, like loading a BPF
> > > program or creating a BPF map, from privileged process to a *trusted*
> > > unprivileged process, all while having a good amount of control over which
> > > privileged operations could be performed using provided BPF token.
> > >
> > > This is achieved through mounting BPF FS instance with extra delegation
> > > mount options, which determine what operations are delegatable, and also
> > > constraining it to the owning user namespace (as mentioned in the
> > > previous patch).
> > >
> > > BPF token itself is just a derivative from BPF FS and can be created
> > > through a new bpf() syscall command, BPF_TOKEN_CREATE, which accepts BPF
> > > FS FD, which can be attained through open() API by opening BPF FS mount
> > > point. Currently, BPF token "inherits" delegated command, map types,
> > > prog type, and attach type bit sets from BPF FS as is. In the future,
> > > having an BPF token as a separate object with its own FD, we can allow
> > > to further restrict BPF token's allowable set of things either at the
> > > creation time or after the fact, allowing the process to guard itself
> > > further from unintentionally trying to load undesired kind of BPF
> > > programs. But for now we keep things simple and just copy bit sets as is.
> > >
> > > When BPF token is created from BPF FS mount, we take reference to the
> > > BPF super block's owning user namespace, and then use that namespace for
> > > checking all the {CAP_BPF, CAP_PERFMON, CAP_NET_ADMIN, CAP_SYS_ADMIN}
> > > capabilities that are normally only checked against init userns (using
> > > capable()), but now we check them using ns_capable() instead (if BPF
> > > token is provided). See bpf_token_capable() for details.
> > >
> > > Such setup means that BPF token in itself is not sufficient to grant BPF
> > > functionality. User namespaced process has to *also* have necessary
> > > combination of capabilities inside that user namespace. So while
> > > previously CAP_BPF was useless when granted within user namespace, now
> > > it gains a meaning and allows container managers and sys admins to have
> > > a flexible control over which processes can and need to use BPF
> > > functionality within the user namespace (i.e., container in practice).
> > > And BPF FS delegation mount options and derived BPF tokens serve as
> > > a per-container "flag" to grant overall ability to use bpf() (plus further
> > > restrict on which parts of bpf() syscalls are treated as namespaced).
> > >
> > > Note also, BPF_TOKEN_CREATE command itself requires ns_capable(CAP_BPF)
> > > within the BPF FS owning user namespace, rounding up the ns_capable()
> > > story of BPF token.
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> >
> > Same concerns as in the other mail. For the bpf_token_create() code,
> > Acked-by: Christian Brauner <brauner@kernel.org>
> 
> This patch set has landed in bpf-next and there are a bunch of other
> patches after it, so I presume it will be a bit problematic to add ack
> after the fact. But thanks for taking another look and acking!

Yeah, I don't mind. :)

