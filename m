Return-Path: <linux-fsdevel+bounces-36785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258099E9548
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA31A281E86
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 12:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7771ACEDE;
	Mon,  9 Dec 2024 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="Kfoh5wVP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C72922F3A5;
	Mon,  9 Dec 2024 12:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733748889; cv=none; b=qpsHrz2jIdGMH3eR6iPVaWN7nOU5Q/v0KyB3XLtNk2x7bIQuUTSDI257Wo6wZ/AFg9uZZcEXmlh0+EHAQ6w7adbMrjFmelCTgEs3PLJVmbwKi4YSfmlfOrSL7Z4fyXyV2mLWduKgr5dK7cHKTXF3Ei8CJJC/GJzzm7rX9PtSQeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733748889; c=relaxed/simple;
	bh=mmp+z6vZClvYN4IUfa9MoRA7iDd0lamwTH4vyhOCrWo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hV5LYMl3ojPUuCX3U703vaSs/bSDpWTD7yAQ7ZDw+McZQYR8FIunLrLTGBy/En258EOWMsJA4Ak12QW/BFQfWBJF5+xiXQZ86gjfV/JZZnn7ISXKJDs6rZGwnRkdWsu2ZeM7rc2Zh6QJmrzWCRYCY5bk2DfM1+H65jOsSnTWd3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=Kfoh5wVP; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733748839; x=1734353639; i=spasswolf@web.de;
	bh=EAY4q6z526O4TaeuoHU1dkNEk9o9mZuPKG7V1nAVNJ4=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Kfoh5wVPf2HaxSlR0zhNthgA+cnzi1FjvP6BIcRsvPWwGJj7bc+Ph941RUlpzWpz
	 6VEdjAfZfGz/DW8K5nKy5prdnr0lXl67RUKmRvJ8Iq42zaaU/dfhvD8995JJ4tI0I
	 GK6SEmpqL3U4R11XTanzSZZinupMTyE5jOERiUkUL4er/hQDFUWN2L6+lm29NZ9K/
	 rfmLxRgqRztr1cvDVH6xFKN/TL6JsQGtMPezT62AqT/l/40nEbnYTN+BZYsLCLSdb
	 uex60sWhoO1XbqLOCetgQFab4fKAVEALNpEWwkCuQ8nz4QGFXPuZt/dMbN3AdczdN
	 XfoC+DGotGRiL+6itQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4N9I-1tj9A91Y5m-011Z1G; Mon, 09
 Dec 2024 13:53:59 +0100
Message-ID: <63df45984a1a7fe5998861abd3210b781662d7f9.camel@web.de>
Subject: Re: commit 0790303ec869 leads to cpu stall without
 CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
From: Bert Karwatzki <spasswolf@web.de>
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org, 
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org, amir73il@gmail.com, 
	brauner@kernel.org, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
 	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-mm@kvack.org, 	linux-ext4@vger.kernel.org, spasswolf@web.de
Date: Mon, 09 Dec 2024 13:53:57 +0100
In-Reply-To: <20241209122648.dpptugrol4p6ikmm@quack3>
References: <20241208152520.3559-1-spasswolf@web.de>
	 <20241209121104.j6zttbqod3sh3qhr@quack3>
	 <20241209122648.dpptugrol4p6ikmm@quack3>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.2-1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0PZnYBU0gg6jmMJSy7XFdM1bYFCaWir11pnGSd+0qH1foI/b0t1
 GDeIAizz3oLKWi9wKNQxaEKI2kayoXbER7RErF9XDIK5irM8+Ya2jrAIr+FSHNTBXyjHO85
 0XI5NzerNjKfxkeDZbFkS3Gq4ooOZmbxFvqOyCoNgX8SykBXo3bDINc7zMw5R19vKSw8cI+
 tWItanavbpwWrfHDmz6yA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h6vS82zGca0=;9iPQBgOpwE7+yvBx1nowykpFDhs
 sL3hd/ksImdUynxocZWcMTayMV+gWBm/4Di2lz+QErGwinZtBSN8NZ7RDi4LWmDy/GfJmTtVJ
 539P1Oo2A3Tp+WNTjsZN/a5eE7lVnLOpSpYO6kfPR4V0wNKw3hE7UpDnOe8tVhcNFNw+mTO1g
 2TKSg8eikeuGTeu6Ll4JehOdb0ugnJ8QN0jEE9HUjungrHfR7AaNDdmlLJR7vkmvmycSQZI4G
 nz1hHEJYRhlASziFYxV+g2XaNVlpE7VvvTS6y2XG4IzRyFxVOeKGJCfvQ664eP4bdr+Ppt/7E
 jguPYfsGn1rewvID6F/X2+bJ0lAQAySpa2F+yL/E3f0+LwrSxNPCDy7PKIZjTTvXN9EnQie6p
 OEND5v0C9gYpHGlua25BSK3zATJv+9uHAY/w6JBhS7osoYf6uAyDjKsyevhVJiO3iV9Aehk/c
 wK5uI4dXzhesyQIQyIdX1aaLQupY9NwpJP4K6xNHnNlPzchW1NDaeZDVo0RtRhU1XTg4as8lx
 20MseOhPoDHGKDsxuCWALftJtpBgRLzY2iHS+/QfM0t7CoDhgOW5GT0ImgguQ/MwDgFHCQtEX
 /Z5zYbtDvC3y00wbcrI5uySwwFceiD0yn76grj9/jVSV5v99BtXizARSPaGtdeWXsgdkks40G
 +r9plqbq4ojzNteeOexaI4M1BGPkux3wJObW5nigGk3Q1hnDIumQyL6rSFI1LruB4Ay8/9Yny
 1A7rVbNuVvmg4eM6FqHKC2aPzCel7sdE2duo4GEYlOuI4xZpQgcYPz9qzv6OQ1y7+TDRcdRsB
 QIu5MzKP9xJG/I04DGrIOrjYWlMXUCcY42JvL5eZGOsBpqOVTISJvX+GQH6TgNvs0fCs84DUi
 SzXQR0ArNPU0Jbe8PAh4NvIqXM6JDOMnEUYJjcb9+eMhi6sBfdD3itJGokQWi3LaZY6/eaHNT
 tiK42jl5RgIpajRSdaZoEdwyQeF7AsBfBQPSByzT02Jk2/Ja45qiMe1i11FiNNioJ3wHjlz4m
 +sNXoOK200618nsA8KvvgE0iCJH6/AAf6U6v6an9hzuVZwWA6IV9yOt60TXS6P9HGbxPKjXEE
 5u4TFy2YU=

Am Montag, dem 09.12.2024 um 13:26 +0100 schrieb Jan Kara:
> On Mon 09-12-24 13:11:04, Jan Kara wrote:
> > > Then I took a closer look at the function called in the problematic =
code
> > > and noticed that fsnotify_file_area_perm(), is a NOOP when
> > > CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set (which was the case in=
 my
> > > .config). This also explains why this was not found before, as
> > > distributional .config file have this option enabled.  Setting the o=
ption
> > > to y solves the issue, too
> >
> > Well, I agree with you on all the points but the real question is, how=
 come
> > the test FMODE_FSNOTIFY_HSM(file->f_mode) was true on our kernel when =
you
> > clearly don't run HSM software, even more so with
> > CONFIG_FANOTIFY_ACCESS_PERMISSIONS disabled. That's the real cause of =
this
> > problem. Something fishy is going on here... checking...
> >
> > Ah, because I've botched out file_set_fsnotify_mode() in case
> > CONFIG_FANOTIFY_ACCESS_PERMISSIONS is disabled. This should fix the
> > problem:
> >
> > index 1a9ef8f6784d..778a88fcfddc 100644
> > --- a/include/linux/fsnotify.h
> > +++ b/include/linux/fsnotify.h
> > @@ -215,6 +215,7 @@ static inline int fsnotify_open_perm(struct file *=
file)
> >  #else
> >  static inline void file_set_fsnotify_mode(struct file *file)
> >  {
> > +       file->f_mode |=3D FMODE_NONOTIFY_PERM;
> >  }
> >
> > I'm going to test this with CONFIG_FANOTIFY_ACCESS_PERMISSIONS disable=
d and
> > push out a fixed version. Thanks again for the report and analysis!
>
> So this was not enough, What we need is:
> index 1a9ef8f6784d..778a88fcfddc 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -215,6 +215,10 @@ static inline int fsnotify_open_perm(struct file *f=
ile)
>  #else
>  static inline void file_set_fsnotify_mode(struct file *file)
>  {
> +	/* Is it a file opened by fanotify? */
> +	if (FMODE_FSNOTIFY_NONE(file->f_mode))
> +		return;
> +	file->f_mode |=3D FMODE_NONOTIFY_PERM;
>  }
>
> This passes testing for me so I've pushed it out and the next linux-next
> build should have this fix.
>
> 								Honza

I had "mixed success" with your first fix, out of 4 boots I got 2 hangs, b=
ut the
new version seems to work fine (4 boots, zero hangs).

Bert Karwatzki

