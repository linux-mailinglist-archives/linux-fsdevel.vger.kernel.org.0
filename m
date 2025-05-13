Return-Path: <linux-fsdevel+bounces-48917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B11F8AB5E2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 22:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BE8864216
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 20:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80911FE45B;
	Tue, 13 May 2025 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgH/4gl5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D743F19D89B;
	Tue, 13 May 2025 20:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747169853; cv=none; b=dkeDbJiggo9s0/Giik3QMyPF7FiMOQ6QvB133xtPrvm8exFN6Ldzo/u8SBgpEmX/SpILCyg9JkKHQ+zJLjxtLsGxNtTs2U6XA/v//6s4ITLiaqNZIfZVsQoccWv7v2XGJoRmcGz3bgmPzC/gW79xHKfijIr8eDl3SqPcm6tyG60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747169853; c=relaxed/simple;
	bh=akamBwTU3WG++dvibVKWhKy32yGTG7zt7oKLcQaK63E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=QNYNN5SSD2YoqHK3Ir04JxnYVLZ3l6rIn7i6wNB7gnCvXLYiHn7M6lXrZo2pfWPbyCvMcWah0j0pjP2hZr9yH++wBY/zM7FjFEXGRFaNZSN7Po73jWYVtOKMw20AGrja25Uyxi2AkS6b11AafGSITG4mgD42WYSs4cAC21qFUCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgH/4gl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33023C4CEE4;
	Tue, 13 May 2025 20:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747169852;
	bh=akamBwTU3WG++dvibVKWhKy32yGTG7zt7oKLcQaK63E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=SgH/4gl5OHphQmUDNL/pWDatdwfs97NYq4vBGIHYCV1RvttcW6YwgZrwDS/BBJqpv
	 GxxjbhiQf2kzZX6kW5hRqhFp5CZUucN8Y26fopof8yuKNket+02GQZGZr/GyJTFaN9
	 9d0V1ooL84iYvFPn1PYorReXf+64c7nBbcnoqdFuJrJ2d8uNiV6C0NeA5w4Tzb81sa
	 WREaq8S6HvKA69TRynzVoxOUYiIKAjQVsCsENZfv95ieQj8Er4/GqlTsED4dcF55VR
	 E3f3Gw7C4JJLkhY1BQguq7h8y3xZC+QW8gjLygt7qo49KqU17uamGcq9be4XHAKck5
	 FFu/InBeR2S6w==
Date: Tue, 13 May 2025 13:57:27 -0700
From: Kees Cook <kees@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>, Kees Cook <keescook@chromium.org>
CC: Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Jorge Merlino <jorge.merlino@canonical.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Eric Paris <eparis@parisplace.org>,
 Richard Haines <richard_c_haines@btinternet.com>,
 Casey Schaufler <casey@schaufler-ca.com>, Xin Long <lucien.xin@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Todd Kjos <tkjos@google.com>,
 Ondrej Mosnacek <omosnace@redhat.com>,
 Prashanth Prahlad <pprahlad@redhat.com>, Micah Morton <mortonm@chromium.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Andrei Vagin <avagin@gmail.com>,
 linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 linux-hardening@vger.kernel.org, oleg@redhat.com
Subject: Re: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
User-Agent: K-9 Mail for Android
In-Reply-To: <h65sagivix3zbrppthcobnysgnlrnql5shiu65xyg7ust6mc54@cliutza66zve>
References: <20221006082735.1321612-1-keescook@chromium.org> <20221006082735.1321612-2-keescook@chromium.org> <20221006090506.paqjf537cox7lqrq@wittgenstein> <CAG48ez0sEkmaez9tYqgMXrkREmXZgxC9fdQD3mzF9cGo_=Tfyg@mail.gmail.com> <86CE201B-5632-4BB7-BCF6-7CB2C2895409@chromium.org> <h65sagivix3zbrppthcobnysgnlrnql5shiu65xyg7ust6mc54@cliutza66zve>
Message-ID: <D03AE210-6874-43B6-B917-80CD259AE2AC@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On May 13, 2025 6:05:45 AM PDT, Mateusz Guzik <mjguzik@gmail=2Ecom> wrote:
>On Thu, Oct 06, 2022 at 08:25:01AM -0700, Kees Cook wrote:
>> On October 6, 2022 7:13:37 AM PDT, Jann Horn <jannh@google=2Ecom> wrote=
:
>> >On Thu, Oct 6, 2022 at 11:05 AM Christian Brauner <brauner@kernel=2Eor=
g> wrote:
>> >> On Thu, Oct 06, 2022 at 01:27:34AM -0700, Kees Cook wrote:
>> >> > The check_unsafe_exec() counting of n_fs would not add up under a =
heavily
>> >> > threaded process trying to perform a suid exec, causing the suid p=
ortion
>> >> > to fail=2E This counting error appears to be unneeded, but to catc=
h any
>> >> > possible conditions, explicitly unshare fs_struct on exec, if it e=
nds up
>> >>
>> >> Isn't this a potential uapi break? Afaict, before this change a call=
 to
>> >> clone{3}(CLONE_FS) followed by an exec in the child would have the
>> >> parent and child share fs information=2E So if the child e=2Eg=2E, c=
hanges the
>> >> working directory post exec it would also affect the parent=2E But a=
fter
>> >> this change here this would no longer be true=2E So a child changing=
 a
>> >> workding directoro would not affect the parent anymore=2E IOW, an ex=
ec is
>> >> accompanied by an unshare(CLONE_FS)=2E Might still be worth trying o=
fc but
>> >> it seems like a non-trivial uapi change but there might be few users
>> >> that do clone{3}(CLONE_FS) followed by an exec=2E
>> >
>> >I believe the following code in Chromium explicitly relies on this
>> >behavior, but I'm not sure whether this code is in active use anymore:
>> >
>> >https://source=2Echromium=2Eorg/chromium/chromium/src/+/main:sandbox/l=
inux/suid/sandbox=2Ec;l=3D101?q=3DCLONE_FS&sq=3D&ss=3Dchromium
>>=20
>> Oh yes=2E I think I had tried to forget this existed=2E Ugh=2E Okay, so=
 back to the drawing board, I guess=2E The counting will need to be fixed=
=2E=2E=2E
>>=20
>> It's possible we can move the counting after dethread -- it seems the e=
arly count was just to avoid setting flags after the point of no return, bu=
t it's not an error condition=2E=2E=2E
>>=20
>
>I landed here from git blame=2E
>
>I was looking at sanitizing shared fs vs suid handling, but the entire
>ordeal is so convoluted I'm confident the best way forward is to whack
>the problem to begin with=2E
>
>Per the above link, the notion of a shared fs struct across different
>processes is depended on so merely unsharing is a no-go=2E
>
>However, the shared state is only a problem for suid/sgid=2E
>
>Here is my proposal: *deny* exec of suid/sgid binaries if fs_struct is
>shared=2E This will have to be checked for after the execing proc becomes
>single-threaded ofc=2E

Unfortunately the above Chrome helper is setuid and uses CLONE_FS=2E

But to echo what Eric asked: what problem are you trying to solve?

-Kees

--=20
Kees Cook

