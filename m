Return-Path: <linux-fsdevel+bounces-6484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BC3818545
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 11:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48C11F232A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 10:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBDF14AA1;
	Tue, 19 Dec 2023 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1NCjvsa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403E6171A2;
	Tue, 19 Dec 2023 10:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE00CC433C8;
	Tue, 19 Dec 2023 10:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702981437;
	bh=WrBgqu27/RVdA/FGbviiOxwuP/FNgSi4IzJpX1xZhLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W1NCjvsayWj4Vk7uwSEmsUKaB9msWeiESEp7gqrNrQ9VJ/ktWx3msYMnq4Q6kh3ra
	 VLb+4h1R76ifLGxs2w35TSMnkOETx6OJXNjAGO0BcD37UYdrstLbQ1vbCGsZ/aSmMg
	 cY7+HGENFpxZpuM/V4hwTkuI+ABu20+bQA/OO0dI9s6ZogauXR/8jBJhiz5INc1NpB
	 mxLPrQJ3BYlxPpUb9T9ryfDKgGZSqPdKWcAGvmUxMzWd+oPFExeE7N5C+ay0RWk1iw
	 72Sp8VU3MNDlfEFOBmedvoJYR0ucPmfb8outlbuUSinvIKCz6dAtn4mL9rASrR61Ee
	 Lj5SOYyvCASag==
Date: Tue, 19 Dec 2023 11:23:50 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	andrii@kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, daniel@iogearbox.net, peterz@infradead.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: pull-request: bpf-next 2023-12-18
Message-ID: <20231219-kinofilm-legen-305bd52c15db@brauner>
References: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
 <CAHk-=wg7JuFYwGy=GOMbRCtOL+jwSQsdUaBsRWkDVYbxipbM5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg7JuFYwGy=GOMbRCtOL+jwSQsdUaBsRWkDVYbxipbM5A@mail.gmail.com>

On Mon, Dec 18, 2023 at 05:11:23PM -0800, Linus Torvalds wrote:
> On Mon, 18 Dec 2023 at 16:05, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > 2) Introduce BPF token object, from Andrii Nakryiko.
> 
> I assume this is why I and some other unusual recipients are cc'd,
> because the networking people feel like they can't judge this and
> shouldn't merge non-networking code like this.
> 
> Honestly, I was told - and expected - that this part would come in a
> branch of its own, so that it would be sanely reviewable.
> 
> Now it's mixed in with everything else.
> 
> This is *literally* why we have branches in git, so that people can
> make more independent changes and judgements, and so that we don't
> have to be in a situation where "look, here's ten different things,
> pull it all or nothing".
> 
> Many of the changes *look* like they are in branches, but they've been
> the "fake branches" that are just done as "patch series in a branch,
> with the cover letter as the merge message".
> 
> Which is great for maintaining that cover letter information and a
> certain amount of historical clarity, but not helpful AT ALL for the
> "independent changes" thing when it is all mixed up in history, where
> independent things are mostly serialized and not actually independent
> in history at all.
> 
> So now it appears to be one big mess, and exactly that "all or
> nothing" thing that isn't great, since the whole point was that the
> networking people weren't comfortable with the reviewing filesystem
> side.
> 
> And honestly, the bpf side *still* seems to be absolutely conbfused
> and complkete crap when it comes to file descriptors.
> 
> I took a quick look, and I *still* see new code being introduced there
> that thinks that file descriptor zero is special, and we tols you a
> *year* ago that that wasn't true, and that you need to fix this.
> 
> I literally see complete garbage like tghis:
> 
>         ..
>         __u32 btf_token_fd;
>         ...
>         if (attr->btf_token_fd) {
>                 token = bpf_token_get_from_fd(attr->btf_token_fd);
> 
> and this is all *new* code that makes that same bogus sh*t-for-brains
> mistake that was wrong the first time.
> 
> So now I'm saying NAK. Enough is enough.  No more of this crazy "I
> don't understand even the _basics_ of file descriptors, and yet I'm
> introducing new random interfaces".
> 
> I know you thought fd zero was something invalid. You were told
> otherwise. Apparently you just ignored being wrong, and have decided
> to double down on being wrong.
> 
> We don't take this kind of flat-Earther crap.
> 
> File descriptors don't start at 1. Deal with reality. Stop making the
> same mistake over and over. If you ant to have a "no file descriptor"
> flag, you use a signed type, and a signed value for that, because file
> descriptor zero is perfectly valid, and I don't want to hear any more
> uninformed denialism.
> 
> Stop polluting the kernel with incorrect assumptions.
> 
> So yes, I will keep NAK'ing this until this kind of fundamental
> mistake is fixed. This is not rocket science, and this is not
> something that wasn't discussed before. Your ignorance has now turned
> from "I didn't know" to "I didn 't care", and at that point I really
> don't want to see new code any more.

Alexei, Andrii, this is a massive breach of trust and flatout
disrespectful. I barely reword mails and believe me I've reworded this
mail many times. I'm furious. 

Over the last couple of months since LSFMM in May 2023 until almost last
week I've given you extensive design and review for this whole approach
to get this into even remotely sane shape from a VFS perspective.

The VFS maintainers including Linus have explicitly NAKed this "zero is
not a valid fd nonsense" and told you to stop doing that. We told you
that such fundamental VFS semantics are not yours to decide.

And yet you put a patch into a series that did exactly that and then had
the unbelievable audacity to repeatedly ask me to put my ACK under this
- both in person and on list.

I'm glad I only gave my ACK to the two patches that I extensivly
reviewed and never to the whole series.

@Linus, I'd like to ask you to please not pull any BPF code that touches
fs/ in any way without an explicit ACK/RVB from Al, Jan, or myself. For
now, everything BPF related to fs/ is proactively NAKed by me.

This is disrespectful to the whole fs community and to me personally and
precisely why we will keep resisting meaningful BPF integration in fs/
until we can be sure that we can trust this subsystem.

Pleasant in-person interactions are one thing. But they're meaningless
if they're inconsistent with on-list behavior and matters of trust.
Disgraceful and tasteless is what I keep coming back to.

