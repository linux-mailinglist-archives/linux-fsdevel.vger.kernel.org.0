Return-Path: <linux-fsdevel+bounces-50327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1623ACAEFC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 15:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E89E1BA1753
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 13:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11659220F51;
	Mon,  2 Jun 2025 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTGsplkt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C72520C031;
	Mon,  2 Jun 2025 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748870864; cv=none; b=ofHvXsyFQ3+3ZCVbIxzGqd6GECxu+u0Z164R7qbTt8IHmjnvNGICyz3WTBfoZMQLOgZS5k0RFShtg69vlvZgjy+w53ejWuNcyHoY0RSCTQDoHNZUKWMgOtsfoT4DGYorNqIhBjzKf9goTisUTaBWR5IfHu1i1YgnlHVn81JeDk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748870864; c=relaxed/simple;
	bh=MWnaFm0fY7wNgxp6V57uPFFzewM6NZbpUyh6VIJyeIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dnd2oS/2+j8j8W4X+LxNUqJOk0yO2jWBTLLIC/lQTZM4svcVYiWfq7OyByh/tcFy9Mux/xgAlnBQ/cf3JK2DhtnCxhUHWMd1QXx8h8bFJi6rg8adRVca/ofJN2VYIE8EuJhQ06DYEr6nWKh6AbgFhcahpSwrfSArx49KYxP1dUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTGsplkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB26C4CEEB;
	Mon,  2 Jun 2025 13:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748870863;
	bh=MWnaFm0fY7wNgxp6V57uPFFzewM6NZbpUyh6VIJyeIY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GTGsplktGqg46KrRxSG9dRHAgPn6zYxPpeUk/lnsjx8RZcOyXvye7yWGkppzYvlWl
	 oT1PFOlOWf7r6a3ztWBM4DpsbnnBuItwsqZg8lavXXkepa2LJUgHTDNRMU7dyz7MvG
	 eMs7KOC6P08IjabJcxmbl1vi6NwqQWSLvk1zPlx79Ifdwfi0lCB2U2dsh0cAq7qMfQ
	 M/E5XDZDvdjXT29mpzwLcLtgqrng/Y5Nr7+iGbx0ci+4Om91vvS6f5i62hnYUzZq2y
	 7475Z40MJ9b3Xk5sPKvzbjaZHBlsq9g32g5Zt3k6s7lqf5rFG0pn8kE80sRbPt/Asr
	 4Wi/HyUseJ4Tg==
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fadb9a0325so17978466d6.2;
        Mon, 02 Jun 2025 06:27:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4aGptmYO+BsdZxe6Vx23M4xzssngPnY+6Xd55TxA1k01m1XU/VndyVkOD2MmM3w6RG6pW1FwF70oOsXwLEmwn2wJyOMpf@vger.kernel.org, AJvYcCVQBqsWZMN6nm7PHysA5r2RLnk8sq4qgGL6HPu+43HT9znB8gBpNAfrPbhP8aj3n7nD8P9x7y96pfuN6SqIMw==@vger.kernel.org, AJvYcCWhYXcfELrfbaO6bgFvs3fIU+a86pV3AH2pqz3g6/+tMOqn7V7BATM8WPgmPYvQL3Nukk8=@vger.kernel.org, AJvYcCXCxnYZVMnCTeXqvlHHIkMfbirsQlx9zEERq5c6l7jp0bzb+vxOtVCRlcRhpv3zchk5lqr8+EqMJLK8q/dV@vger.kernel.org
X-Gm-Message-State: AOJu0YyNy0p/ElTiZn3iZIn5zvshK+KR1cprkldFOoGRoFhnw96Piz8Z
	rIqMgAGw3UcqnMfNXH0d6sQTRPJDPW3lhQGLYiIvcdZzgKRoM7jGKU0MbxvdB1HFuJqeJBvQq8N
	CmOxPIphMXNhzDdJGIPb5O/scn+i0HwM=
X-Google-Smtp-Source: AGHT+IFhY1OAUdXnhV9TDyfD4od4kgsfWVZ9DSzY5wOUCfTeloAckm3mtPnaNhiF9n1KxtcPrqpA2C2xxaCGMsik8yQ=
X-Received: by 2002:a05:6214:3115:b0:6fa:d976:197e with SMTP id
 6a1803df08f44-6fad9761a27mr159411406d6.33.1748870862882; Mon, 02 Jun 2025
 06:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528222623.1373000-1-song@kernel.org> <20250528222623.1373000-4-song@kernel.org>
 <20250528223724.GE2023217@ZenIV> <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
 <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
 <20250529173810.GJ2023217@ZenIV> <CAPhsuW5pAvH3E1dVa85Kx2QsUSheSLobEMg-b0mOdtyfm7s4ug@mail.gmail.com>
 <20250602-lustig-erkennbar-7ef28fa97e20@brauner>
In-Reply-To: <20250602-lustig-erkennbar-7ef28fa97e20@brauner>
From: Song Liu <song@kernel.org>
Date: Mon, 2 Jun 2025 06:27:31 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7ogestn8Cc2jac2O0fnWcH_w=HuZQiSOx0umM4uT6Whg@mail.gmail.com>
X-Gm-Features: AX0GCFv7exgfZHaSo_HrFli6RvFn8kD3E2x-G4ZgMt74ykULlK91j3RGb1-OW18
Message-ID: <CAPhsuW7ogestn8Cc2jac2O0fnWcH_w=HuZQiSOx0umM4uT6Whg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, kpsingh@kernel.org, mattbobrowski@google.com, 
	amir73il@gmail.com, repnop@google.com, jlayton@kernel.org, 
	josef@toxicpanda.com, mic@digikod.net, gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 2:27=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Thu, May 29, 2025 at 11:00:51AM -0700, Song Liu wrote:
> > On Thu, May 29, 2025 at 10:38=E2=80=AFAM Al Viro <viro@zeniv.linux.org.=
uk> wrote:
> > >
> > > On Thu, May 29, 2025 at 09:53:21AM -0700, Song Liu wrote:
> > >
> > > > Current version of path iterator only supports walking towards the =
root,
> > > > with helper path_parent. But the path iterator API can be extended
> > > > to cover other use cases.
> > >
> > > Clarify the last part, please - call me paranoid, but that sounds lik=
e
> > > a beginning of something that really should be discussed upfront.
> >
> > We don't have any plan with future use cases yet. The only example
> > I mentioned in the original version of the commit log is "walk the
> > mount tree". IOW, it is similar to the current iterator, but skips non
> > mount point iterations.
> >
> > Since we call it "path iterator", it might make sense to add ways to
> > iterate the VFS tree in different patterns. For example, we may
>
> No, we're not adding a swiss-army knife for consumption by out-of-tree
> code. I'm not opposed to adding a sane iterator for targeted use-cases
> with a clear scope and internal API behavior as I've said multiple times
> already on-list and in-person.
>
> I will not merge anything that will endup exploding into some fancy
> "walk subtrees in any order you want".

We are not proposing (and AFAICT never proposed) to have a
swiss-army knife that "walk subtrees in any order you want". Instead,
we are proposing a sane iterator that serves exactly one use case
now. I guess the concern is that it looks extensible. However, I made
the API like this so that it can be extended, with thorough reviews, to
cover another sane use case. If there is still concern with this. We
sure can make current code not extensible. In case there is a
different sane use case, we will introduce another iterator after
thorough reviews.

Thanks,
Song

