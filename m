Return-Path: <linux-fsdevel+bounces-45041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8F8A70920
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 19:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CA53188F8A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 18:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816EE1ACEC8;
	Tue, 25 Mar 2025 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUPm3Es2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD021190679;
	Tue, 25 Mar 2025 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928019; cv=none; b=oExew6mWOKMv9GApukcV8M6A3A+F32yT38XgoubpOy74ZPX7t0E19TcspXrj9oq9P7W4x3rgr9fp28S+alZZs0arguy9rkXld1p5X1Mlw5857QoRtnqc6XAIoimiI9HVciTyZlQs1Q/Th+T2u1JkoMTjaIzeobnNGRD0UU707os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928019; c=relaxed/simple;
	bh=46bS5zblPi4Cgi/GNAZgCaWw2aUsl90BI6FA+un2euk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qJYracd/y+GhHBZh9LsYBE+ni1lf5tbWb8fUNGXyn8rR0O8fHG46S8J36P1gXPhCXSXKTvn5LDKWF1+VyFtema5YXbSwjkskrJPO1PUoqKRoVuZMW0SXqceuVtId8qgN0IwzzKxtuju35tIXZ24FhyMe1E36oFUo82BPD7TMvCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUPm3Es2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F7FC4CEE4;
	Tue, 25 Mar 2025 18:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742928017;
	bh=46bS5zblPi4Cgi/GNAZgCaWw2aUsl90BI6FA+un2euk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=nUPm3Es2dRzj3FRgaG8tA42h7dX9GKnc4DWwth7T3WvuzXc906Khs8/oiG+pElZL1
	 NBj6FKVCaG7M3fZ6xEGWVVOFCiXlRuMNeht3jfPQXN7lvwo2MtMmHY78ggOa65t4jm
	 X7vV2dV8pwjTa+prQTkQaZkcgazfzXHO9jDyMXibvYFFYsuoinn4vszAwj5BSt3/Ad
	 ukHZb4Q5yi9eKwjWd+9DqWVQ82lADzEtqIrvU0yaSOkngD1cCaAgaB/uNnU1RGu2DH
	 gF6kh1+j2oZfHZABDa83+4bbQ7xzC4QxSmfox0s0BsJaFUyUsFjEXr6AAzfQkysc/e
	 00oRHgNpTDBAA==
Date: Tue, 25 Mar 2025 11:40:15 -0700
From: Kees Cook <kees@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
CC: Oleg Nesterov <oleg@redhat.com>,
 syzbot <syzbot+1c486d0b62032c82a968@syzkaller.appspotmail.com>,
 viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] exec: fix the racy usage of fs_struct->in_exec
User-Agent: K-9 Mail for Android
In-Reply-To: <20250325-stilbruch-deeskalation-f212bb2499de@brauner>
References: <67dc67f0.050a0220.25ae54.001f.GAE@google.com> <20250324160003.GA8878@redhat.com> <CAGudoHHuZEc4AbxXUyBQ3n28+fzF9VPjMv8W=gmmbu+Yx5ixkg@mail.gmail.com> <20250324182722.GA29185@redhat.com> <CAGudoHE8AKKxvtw+e4KpOV5DuVcVdtTwO0XjaYSaFir+09gWhQ@mail.gmail.com> <20250325100936.GC29185@redhat.com> <CAGudoHFSzw7KJ-E9qZzfgHs3uoye08po0KJ_cGN_Kumu7ajaBw@mail.gmail.com> <20250325132136.GB7904@redhat.com> <20250325-bretter-anfahren-39ee9eedf048@brauner> <CAGudoHFGcTergsO2Pg_v9J4aj94dWnCn_KrE1wpGd+x=g8_f1Q@mail.gmail.com> <20250325-stilbruch-deeskalation-f212bb2499de@brauner>
Message-ID: <AA35714D-AB8B-4CC5-B298-2F1E00C4B3ED@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 25, 2025 7:46:15 AM PDT, Christian Brauner <brauner@kernel=2Eorg>=
 wrote:
>On Tue, Mar 25, 2025 at 03:15:06PM +0100, Mateusz Guzik wrote:
>> On Tue, Mar 25, 2025 at 2:30=E2=80=AFPM Christian Brauner <brauner@kern=
el=2Eorg> wrote:
>> >
>> > On Tue, Mar 25, 2025 at 02:21:36PM +0100, Oleg Nesterov wrote:
>> > > On 03/25, Mateusz Guzik wrote:
>> > > >
>> > > > On Tue, Mar 25, 2025 at 11:10=E2=80=AFAM Oleg Nesterov <oleg@redh=
at=2Ecom> wrote:
>> > > > >
>> > > > > On 03/24, Mateusz Guzik wrote:
>> > > > > >
>> > > > > > On Mon, Mar 24, 2025 at 7:28=E2=80=AFPM Oleg Nesterov <oleg@r=
edhat=2Ecom> wrote:
>> > > > > > >
>> > > > > > > So to me it would be better to have the trivial fix for sta=
ble,
>> > > > > > > exactly because it is trivially backportable=2E Then cleanu=
p/simplify
>> > > > > > > this logic on top of it=2E
>> > > > > >
>> > > > > > So I got myself a crap testcase with a CLONE_FS'ed task which=
 can
>> > > > > > execve and sanity-checked that suid is indeed not honored as =
expected=2E
>> > > > >
>> > > > > So you mean my patch can't fix the problem?
>> > > >
>> > > > No, I think the patch works=2E
>> > > >
>> > > > I am saying the current scheme is avoidably hard to reason about=
=2E
>> > >
>> > > Ah, OK, thanks=2E Then I still think it makes more sense to do the
>> > > cleanups you propose on top of this fix=2E
>> >
>> > I agree=2E We should go with Oleg's fix that in the old scheme and us=
e
>> > that=2E And then @Mateusz your cleanup should please go on top!
>>=20
>> Ok, in that case I'm gonna ship when I'm gonna ship(tm), maybe later th=
is week=2E
>
>Ok, I've taken the patch as I've got a first round of fixes to send
>already=2E

Thanks!=20

Acked-by: Kees Cook <kees@kernel=2Eorg>


--=20
Kees Cook

