Return-Path: <linux-fsdevel+bounces-62905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EE7BA4938
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 18:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA9518848E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 16:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DCB23BF9B;
	Fri, 26 Sep 2025 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1YKKgGH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBEE2376F7
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903290; cv=none; b=kL73Vnjaqm9fS4Ghst33thYTc+P3Cj2XTfcJ1Lht4tkUic6J2qCnPqhzTIwbIS/mihKyk7rZ0vYcQiW4bznmOo0gVwlnao7rm8jBGG/nxnY9bJNzdPLKGXX2D38hcXRvbYip1PXHFV/GaifIgBR7McD+2h15uLnuIx+ttCN4vBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903290; c=relaxed/simple;
	bh=ty08G4b6M5Pp4QYW2iJQZxSYsknTux2aJiPak5iH2+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVeHVSSpsQUfMurCqsVzny/axZ4SmeNouo3bZeiAdigk0nh0BWlMR+aEaxM6xIhlOE5O07XD1P7cqSrrGws6r3vFEdWbTWCDJwnadQ1g/8vgpczVPo+q2y2NJxiCPK+3YVlhtiuw9/ilZ08/OSm9TP+gZ6zrIRIIyqYfujNvyyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1YKKgGH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63053019880so5165616a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 09:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758903287; x=1759508087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZHHVzgq6/orpLSrvsPyixEcfWVZzwKhj7cB3xBVn3E=;
        b=G1YKKgGHN/9SeuFF3W1RPObSTAId/9Y9gAo8C6dZk5vV07J858P3GreWrwom7+nmUs
         Sx2IkdoCpQilKOXPIPcL4Nc4UtA0+gNSZVzG9ds3ybEWYeytdweVWNHiTtHviwgm8UOT
         cOD471GvwnLMKeBbVgCRQ4DXjzqgqoveOcQkvfIEYNDm+i450W8fQ34zkNj+A6R+1GIc
         rT5h9QgNuPLLqsGjrzshXpNd4DHFK187Cxj2N3os2I6Qqn4bCUPCPuEpetMrwl+LtXAF
         4r7CiffVFvW0n/borxaCBP+WA5qUCbaMIuJspbR5PMwJozGVvkkP0AgfLtcyMrBZO1Bp
         O+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758903287; x=1759508087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZHHVzgq6/orpLSrvsPyixEcfWVZzwKhj7cB3xBVn3E=;
        b=QCT2WEA3DZA9T5hGu2oNJJU/1jzDePjzpbL571Y/FdvMTXgsYxuHtflEqIIsh1A9/6
         kUa334rejpgXDo1zozEqganViZ/+cmJff6Ew+Om8yuyuapeKxV3ho77eLmfglgZKpQ2d
         bT4vqKPJ+f2bcXAxv9osWsJu/fsQ81ub77f5rgHcrnuo8lcpnUdJe4ZQ3P/GQgRxV4e8
         iyhc8fh/vsyGUBCs8crbTZyKEpfTGE0cKOghNY7n/XoL/FVp1JQK55sL23e2puxG1jRL
         HnkW2XVoS7N88zuynrb3WapPtNMploh9k9Y3Gj8BOC6P7OF07wDESzZFjfl13vO2RpcS
         m5Rw==
X-Forwarded-Encrypted: i=1; AJvYcCW9Rg608YwV53ajPlJ52zLQ8K9tqM8HYGBNz9m9qu100uAMUXvaTMHDlLpy+0cKQ6xCEG1iOGZp8RuTvbh2@vger.kernel.org
X-Gm-Message-State: AOJu0YwFVo/rheSTt9gYk4MegRRuxmCCb2wMdjUOZykwqSEgBqC+nga4
	hEjbsa5T12BCAS3a8U9xEKITsIHIOkFP++SY2pr2aEhoml2BG2fBbEty9qL4RKRn1o0EpfiXvIy
	R3VfQiaNC75pmQk5FgzVQkMUCCnSEAJA=
X-Gm-Gg: ASbGncuBxCiRVgl899GLcuYjSW+m9fLH+pC2FJqjSFFCeOGTkPpJWAtch9c2cPVGNgr
	YJVKYucQTkK9XSK35iWvQdxHnslOMicR+a4JstgtDLA/UedPwIUE7PxSjjXXvY2wXXlNVQ3Hlus
	BBtjOIW0Ovs5nx++1VKNwHM6zE9fh792ef6RYg044U4NmLsl5TWDttt/vYJ7+xOSxdznyLUYebv
	ChPO0Gfwj4yi3EbaFINNSIvHdkC7bXuOPm4SRlsyA==
X-Google-Smtp-Source: AGHT+IFNKkYJzlxCASglyO7G6X57vMMNGKNmq/zMuooKUGnQ/eY9wVqCF2gxokIm7WuBqxwYQni9hLZo7sdEXeCfILw=
X-Received: by 2002:a17:906:6a19:b0:b04:9acf:46cd with SMTP id
 a640c23a62f3a-b34bd4410fbmr799463566b.42.1758903286487; Fri, 26 Sep 2025
 09:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925132239.2145036-1-sunjunchao@bytedance.com>
 <fylfqtj5wob72574qjkm7zizc7y4ieb2tanzqdexy4wcgtgov4@h25bh2fsklfn>
 <5622443b-b5b4-4b19-8a7b-f3923f822dda@bytedance.com> <CAGudoHGigCyz60ec6Mv3NL2-x7tfLWYdK1M=Rj2OHRAgqHKOdg@mail.gmail.com>
 <14ee6648-1878-4b46-9e46-d275cc50bf0a@bytedance.com> <CAGudoHEkJfenk7ePETr3PCCqb9AYo7F4Ha754EjV4rT+U6_qoQ@mail.gmail.com>
 <xetmahjj5tlxksfxfkronyam6ppdeiobpdz2zuvigichqkqcos@6hembfwhlayn>
 <CAGudoHETCiATjWYcHbO_SBkE-X0fWWi0YCkn51+VLcjw7620oA@mail.gmail.com> <dvfobm24dgl4hhvirwabai47toypkvrimv7rthevrcvig6xmjf@scpmbv7qucme>
In-Reply-To: <dvfobm24dgl4hhvirwabai47toypkvrimv7rthevrcvig6xmjf@scpmbv7qucme>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 26 Sep 2025 18:14:33 +0200
X-Gm-Features: AS18NWDk0LITglwP_F8j4OL6ptqdSKO8Mvc6KHiNh2uU6lJi8XnmuwuEacBNIVo
Message-ID: <CAGudoHEpCYaA9omAXoJWraDTL5hMSfrj3Cufe_W5sEcSuonX_g@mail.gmail.com>
Subject: Re: [PATCH] write-back: Wake up waiting tasks when finishing the
 writeback of a chunk.
To: Jan Kara <jack@suse.cz>
Cc: Julian Sun <sunjunchao@bytedance.com>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, peterz@infradead.org, 
	akpm@linux-foundation.org, Lance Yang <lance.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 5:55=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 26-09-25 17:50:43, Mateusz Guzik wrote:
> > On Fri, Sep 26, 2025 at 5:48=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Fri 26-09-25 14:05:59, Mateusz Guzik wrote:
> > > > On Fri, Sep 26, 2025 at 1:43=E2=80=AFPM Julian Sun <sunjunchao@byte=
dance.com> wrote:
> > > > >
> > > > > On 9/26/25 7:17 PM, Mateusz Guzik wrote:
> > > > > > On Fri, Sep 26, 2025 at 4:26=E2=80=AFAM Julian Sun <sunjunchao@=
bytedance.com> wrote:
> > > > > >>
> > > > > >> On 9/26/25 1:25 AM, Mateusz Guzik wrote:
> > > > > >>> On Thu, Sep 25, 2025 at 09:22:39PM +0800, Julian Sun wrote:
> > > > > >>>> Writing back a large number of pages can take a lots of time=
.
> > > > > >>>> This issue is exacerbated when the underlying device is slow=
 or
> > > > > >>>> subject to block layer rate limiting, which in turn triggers
> > > > > >>>> unexpected hung task warnings.
> > > > > >>>>
> > > > > >>>> We can trigger a wake-up once a chunk has been written back =
and the
> > > > > >>>> waiting time for writeback exceeds half of
> > > > > >>>> sysctl_hung_task_timeout_secs.
> > > > > >>>> This action allows the hung task detector to be aware of the=
 writeback
> > > > > >>>> progress, thereby eliminating these unexpected hung task war=
nings.
> > > > > >>>>
> > > > > >>>
> > > > > >>> If I'm reading correctly this is also messing with stats how =
long the
> > > > > >>> thread was stuck to begin with.
> > > > > >>
> > > > > >> IMO, it will not mess up the time. Since it only updates the t=
ime when
> > > > > >> we can see progress (which is not a hang). If the task really =
hangs for
> > > > > >> a long time, then we can't perform the time update=E2=80=94so =
it will not mess
> > > > > >> up the time.
> > > > > >>
> > > > > >
> > > > > > My point is that if you are stuck in the kernel for so long for=
 the
> > > > > > hung task detector to take notice, that's still something worth
> > > > > > reporting in some way, even if you are making progress. I presu=
me with
> > > > > > the patch at hand this information is lost.
> > > > > >
> > > > > > For example the detector could be extended to drop a one-liner =
about
> > > > > > encountering a thread which was unable to leave the kernel for =
a long
> > > > > > time, even though it is making progress. Bonus points if the me=
ssage
> > > > > > contained info this is i/o and for which device.
> > > > >
> > > > > Let me understand: you want to print logs when writeback is makin=
g
> > > > > progress but is so slow that the task can't exit, correct?
> > > > > I see this as a new requirement different from the existing hung =
task
> > > > > detector: needing to print info when writeback is slow.
> > > > > Indeed, the existing detector prints warnings in two cases: 1) no
> > > > > writeback progress; 2) progress is made but writeback is so slow =
it will
> > > > > take too long.
> > > >
> > > > I am saying it would be a nice improvement to extend the htd like t=
hat.
> > > >
> > > > And that your patch as proposed would avoidably make it harder -- y=
ou
> > > > can still get what you are aiming for without the wakeups.
> > > >
> > > > Also note that when looking at a kernel crashdump it may be benefic=
ial
> > > > to know when a particular thread got first stuck in the kernel, whi=
ch
> > > > is again gone with your patch.
> > >
> > > I understand your concerns but I think it's stretching the goals for =
this
> > > patch a bit too much.  I'm fine with the patch going in as is and if =
Julian
> > > is willing to work on this additional debug features, then great!
> > >
> >
> > I am not asking the patch does all that work, merely that it gets
> > implemented in a way which wont require a rewrite should the above
> > work get done. Which boils down to storing the timestamp somewhere in
> > task_struct.
>
> Well, but that doesn't really make much sense without the debug patch
> itself, does it? And it could be a potential discussion point. So I think
> the debug patch should just move the timestamp from the wb completion to
> task_struct if that's needed...
>

I don't follow your e-mail, so I'm going to restate how I see this.

There is a timestamp stored somewhere indicating when was the last
time the thread went off CPU.

There are cases where it went off CPU for a long time, despite the
thing it is waiting for making progress.

This can trigger false-positives in hung task detector.

The proposed patch forces wake ups before this happens. This works
around the problem, but also perturbs a datum which would be useful in
debugging. It also seems weirdly disruptive for what it is aiming for.

When looking at a kernel crashdump it may be useful to know how long
the particular thread was off CPU. This will no longer be accessible.

Even for cases where progress is being made, but takes a long time, it
may still be useful to report it as this does not look like the
expected condition. With the change at hand there is no way to do it.

The reported issue can be worked around by adding a timestamp of 'last
known progress' to one of the holes in task_struct. Then hung task
detector can be trivially patched to bugger off based on it.

Later an interested party can extend the current functionality with
the thing I mentioned.

>                                                                 Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

