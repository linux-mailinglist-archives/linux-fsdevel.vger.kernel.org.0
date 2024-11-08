Return-Path: <linux-fsdevel+bounces-34020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7745C9C207B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 16:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A38A285D25
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 15:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0C320C01F;
	Fri,  8 Nov 2024 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEeqontT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035F420B20A;
	Fri,  8 Nov 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731079930; cv=none; b=LK9dILs39dGjfh7fqjTVJY0Ppmn/jEIEsD6ltlhqV5YtQZvUH6zDWtHx+Dk4Mnq99RXnmuOgFbjATXVh+opnpLn0hx5F+5zI5tl7L4tDwvQYEiARvS5RpFNTXmQGUZi4vD/4Cmy7+PKhGMkt3IP+N3TcB5mC0F3D0LnqGC+mB10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731079930; c=relaxed/simple;
	bh=+o6SMNW5ltrwkaUFGnTAvx5ruimZe+vSc0bhjjOji04=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=nEUS0edC7nbHwyXbRExwb6ExJ7901KnGqXPkQlHPfQedKY6ppXdAey0InQpGt0JtcbiFg6Cs/G5P3+P7ElqlthHcy5oWETHpWntb6JDFdrV6kaH9nYZs/o5y9TUj+/j8KlWXvqRMd4zOy3LDtq1HviOkt9RfQ2qgGY5npjxGxKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEeqontT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DFEC4CECD;
	Fri,  8 Nov 2024 15:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731079929;
	bh=+o6SMNW5ltrwkaUFGnTAvx5ruimZe+vSc0bhjjOji04=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=UEeqontTqm1DIKZo67sydAeXTG8uE8k+xExg3SQ8HcuIVj8Pkxet37LDE61TX4Y55
	 ml7mh8upGx70b2e0DnlZnKcknOif47RdpsZjF0BWQ7Dmc6Qnx0LF+CBHff8NsJnk/q
	 vuqQW4yIAnkmzL1xEHxpq7cKDMXS8EOZQxTG9UrujnNtsTvWKXlwk1TEHogaa7F/+t
	 iFCky72XMaQoGgj9f0kMcrNTOERWEK4TPdvwlQBINJCseNE0mIk1uBFZZKyTzPPK/T
	 UY/NJy1oxASqjaoQ6mEpwGvyhCSA2VsfpBp9YbeZ0zFHoQamhPw00Wpp0NCVaoDv/H
	 47R67IEWXzuDQ==
Date: Fri, 08 Nov 2024 07:32:04 -0800
From: Kees Cook <kees@kernel.org>
To: Stas Sergeev <stsp2@yandex.ru>, linux-kernel@vger.kernel.org
CC: Eric Biederman <ebiederm@xmission.com>, Andy Lutomirski <luto@kernel.org>,
 Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Thomas Gleixner <tglx@linutronix.de>, Jeff Layton <jlayton@kernel.org>,
 John Johansen <john.johansen@canonical.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Adrian Ratiu <adrian.ratiu@collabora.com>,
 Felix Moessbauer <felix.moessbauer@siemens.com>,
 Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH v2 1/2] procfs: avoid some usages of seq_file private data
User-Agent: K-9 Mail for Android
In-Reply-To: <20241108101339.1560116-2-stsp2@yandex.ru>
References: <20241108101339.1560116-1-stsp2@yandex.ru> <20241108101339.1560116-2-stsp2@yandex.ru>
Message-ID: <618F0D80-F2E1-49C1-AA25-B2C0CC46F519@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On November 8, 2024 2:13:38 AM PST, Stas Sergeev <stsp2@yandex=2Eru> wrote=
:
>seq_file private data carries the inode pointer here=2E
>Replace
>`struct inode *inode =3D m->private;`
>with:
>`struct inode *inode =3D file_inode(m->file);`
>to avoid the reliance on private data=2E

Conceptually this seems good, though I'd expect to see the removal of _set=
ting_ m->private too in this patch=2E

>This is needed so that `proc_single_show()` can be used by
>custom fops that utilize seq_file private data for other things=2E
>This is used in the next patch=2E

Now that next patch is pretty wild=2E I think using proc is totally wrong =
for managing uid/gid=2E If that's going to happen at all, I think it should=
 be tied to pidfd which will already do the correct process lifetime manage=
ment, etc=2E

-Kees

--=20
Kees Cook

