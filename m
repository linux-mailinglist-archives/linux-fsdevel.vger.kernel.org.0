Return-Path: <linux-fsdevel+bounces-47950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82415AA7A9D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 22:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF000466DF2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 20:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E4E1F7910;
	Fri,  2 May 2025 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfGK8+5K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5B21DE4E7;
	Fri,  2 May 2025 20:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746216690; cv=none; b=M4p6XWkwf6uK8DrJINmgm5xu57QBkpgZrs7jORQ22iO1je9CKfp4EvIyhUGea3E4s8Tcbr4GiPY0HcobJyphJJDCL1kN1GUpJUQQnzgdyOHdhkh/4f5lqb7vguXlE4/tvJEUxeIuS4QSmwB6hQazMMKmssZ06xY6opDsU92AiUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746216690; c=relaxed/simple;
	bh=fNb/U1Naew7SwzCXUAnbIHev7jMNaHPPTiUJSpadZyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9tlqMrV43/EOFdpYmdUBo7p+7B3SgUdhJbGGzjnzHC70CuDVnrR477XGZP1Hh08dd3Gmu3cJZ6om3nTJmKLqnin7JdfYkEgc0c59hejcMpY0/T8JAMkhB4wYG5YsE08Bn4LmZGfOcJWrXUy2EzWrDgfpPVX3VGQ7izEHSve82A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfGK8+5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC21C4CEE4;
	Fri,  2 May 2025 20:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746216689;
	bh=fNb/U1Naew7SwzCXUAnbIHev7jMNaHPPTiUJSpadZyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HfGK8+5KcuxZO1r/6Egtm1iaDIgfN1LWFqd+4i0JLZNdZC3GAvFLeW3bOcnfaAOL0
	 EEPFHkY4oSuFeGEb6uVu64vsOno982nujxxEgwsZe3m+Byu5BPcge9SGSUwX9VGZYR
	 IzRl0SYW9J6Ac9cYGZyqRwDViYJyWZkLDHT/iFkLWWz+rZrEiKQcFpIuNrLhmAkjH7
	 C3XvCo73OsY7/UueGMX6G0opY1AQVOQrwfiacX1m75+64xwgYEjVziRqy2IR5EIY5N
	 9Vba91YbI8iCk6ROGlBYsp7ckuGEbpP53hOXYxweraFCAKSjouGD2/6iYtJ8jOzEqy
	 oCC5qfh2xd5fg==
Date: Fri, 2 May 2025 22:11:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC v2 4/6] coredump: show supported coredump modes
Message-ID: <20250502-zugrunde-mehrheit-5fc9ef5d6ec8@brauner>
References: <20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org>
 <20250502-work-coredump-socket-v2-4-43259042ffc7@kernel.org>
 <CAG48ez1YjoHnH9Tsh8aO2SNkJUW=7VUPXAdvxqt7d0B4A8evEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1YjoHnH9Tsh8aO2SNkJUW=7VUPXAdvxqt7d0B4A8evEw@mail.gmail.com>

On Fri, May 02, 2025 at 04:07:23PM +0200, Jann Horn wrote:
> On Fri, May 2, 2025 at 2:43 PM Christian Brauner <brauner@kernel.org> wrote:
> > Allow userspace to discover what coredump modes are supported.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/coredump.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/fs/coredump.c b/fs/coredump.c
> > index 9a6cba233db9..1c7428c23878 100644
> > --- a/fs/coredump.c
> > +++ b/fs/coredump.c
> > @@ -1217,6 +1217,13 @@ static int proc_dostring_coredump(const struct ctl_table *table, int write,
> >
> >  static const unsigned int core_file_note_size_min = CORE_FILE_NOTE_SIZE_DEFAULT;
> >  static const unsigned int core_file_note_size_max = CORE_FILE_NOTE_SIZE_MAX;
> > +static char core_modes[] = {
> > +#ifdef CONFIG_UNIX
> > +       "file\npipe\nunix"
> > +#else
> > +       "file\npipe"
> > +#endif
> > +};
> 
> Nit: You could do something like
> 
> static char core_modes[] =
> #ifdef CONFIG_UNIX
>   "unix\n"
> #endif
>   "file\npipe"
> ;

Thanks!

