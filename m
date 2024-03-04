Return-Path: <linux-fsdevel+bounces-13430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B4F86FBBD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 09:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B35C1C21BDA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 08:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9616E17C60;
	Mon,  4 Mar 2024 08:21:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EB418E10;
	Mon,  4 Mar 2024 08:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.150.191.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540496; cv=none; b=snx1le37KHFfuKCwZ7twvCsQxvDt+mm98w+7r/o8EBSpk5W4Ggh1+vTsWC+9TaQJyCn6+iDQ8Az6fa0B1+g87x24+Nd4xz8+vMb+yP9AxmLBWPhPnHb73JgFfKHLo0pptjARU7jR77m8lTRJ4ll3FbK+HdN1uTA28ZkR7zLfIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540496; c=relaxed/simple;
	bh=rQistqTUrGOlKZBaVskLCJfYvitC30s8IkMeYcZYZWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M62l2gbpe1+rFxChRdoJiqeJseU32iOBs/ep5ytWoWV/RnZEcC4pXGQtntEaxqf0EuoT7uVpO5zCG46umfl+ZOQYO2tE+LQ3lBwD1eO0ba2YK7Mm/p5XhxQVn29yJ3sIwtJBO+sgQBYbyJrQ+af5o/dKVKoZSJP5tmmxnUvb658=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=194.150.191.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 830728B1959;
	Mon,  4 Mar 2024 09:16:19 +0100 (CET)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: John Stoffel <john@stoffel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [WIP] bcachefs fs usage update
Date: Mon, 04 Mar 2024 09:16:18 +0100
Message-ID: <2199336.irdbgypaU6@lichtvoll.de>
In-Reply-To: <apot5wnom6wqdvjb6hfforcooxuqonmjl7z6morjyhdbgi6isq@5fcb3hld62xu>
References:
 <gajhq3iyluwmr44ee2fzacfpgpxmr2jurwqg6aeiab4lfila3p@b3l7bywr3yed>
 <26085.7607.331602.673876@quad.stoffel.home>
 <apot5wnom6wqdvjb6hfforcooxuqonmjl7z6morjyhdbgi6isq@5fcb3hld62xu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Kent Overstreet - 04.03.24, 02:08:44 CET:
> > This is not the same level of detail needed by a filesystem developer,
> > and I _never_ said it was.  I'm looking for the inforation
> > needed/wanted by a SysAdmin when an end user comes whining about
> > needing more space.  And then being able to examine the system
> > holistically to give them an answer.  Which usually means "delete
> > something!"  *grin*
>=20
> 'bcachefs fs usage' needs to show _all_ disk accounting information
> bcachefs has, because we need there to be one single tool that shows all
> the information we have - that's this tool.
>=20
> If we're collecting information, it needs to be available.
>=20
> There will no doubt be switches and options for providing reduced forms,
> but for now I'm mainly concerned with making sure all the information
> that we have is there in a reasonably understandable way.

=46rom a sysadmin view I totally get what John is writing.

I know "btrfs filesystem usage" also shows a lot of information, but still=
=20
with some learning it is quite understandable. At least I can explain it=20
nicely enough in one of my Linux Performance Analysis & Tuning courses.

Commands like "lspci" do not show all the information by default. You need=
=20
to add "-v" even several times to show it all.

So I am with you that it is good to have a tool that shows *all* the=20
information. I am just not so sure whether showing *all* the information=20
by default is wise.

No one was asking for the lowest common denominator. But there is a=20
balance between information that is useful in daily usage of BCacheFS and=20
information that is more aimed at debugging purposes and filesystem=20
developers. That "df -hT" is not really enough to understand what is going=
=20
on in a filesystem like BCacheFS and BTRFS is clear.

So what I'd argue for is a middle ground by default and adding more with=20
"-v" or "--detail" or an option like that. In the end if I consider who=20
will be wanting to use the information, my bet would be it would be over=20
95% sysadmins and Linux users at home. It would be less, I bet way less=20
than 5% Linux filesystem developers. And that's generous. So "what target=20
audience are you aiming at?" is an important question as well.

What also improves the utility of the displayed information is explaining=20
it. In a man page preferably.

If there then is also a way to retrieve the information as JSON for=20
something like that=E2=80=A6 it makes monitoring the usage state by 3rd par=
ty=20
tools easier.

Another approach would be something like "free -m" versus "cat /proc/
meminfo" and "cat /proc/vmstat". I.e. provide all the details via SysFS=20
and a part of it by "bcachefs filesystem usage".

You indeed asked for feedback about "bcachefs fs usage". So there you have=
=20
it. As usual do with it what you want. You can even outright dismiss it=20
without even considering it. But then I wonder why you asked for feedback=20
to begin with. See, John just did what you asked for: John gave feedback.

I planned to go into detail of your example output and tell you what I=20
think about each part of what you propose and ask questions for deeper=20
understanding. If you are open to at least consider the feedback, only=20
consider, of course you can still decline everything and all of it after=20
consideration, then I'd be willing to spend the time to do it.

Best,
=2D-=20
Martin



