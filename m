Return-Path: <linux-fsdevel+bounces-21438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C67903CD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 15:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392B1286404
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 13:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566BA17C7D8;
	Tue, 11 Jun 2024 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eob6bBas"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B0C178CCF;
	Tue, 11 Jun 2024 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718111641; cv=none; b=DOex3/ls2E9GbYSwkepwdbLS/sgFLV+rtXkIuYL7uDNWG9WHtMCtSyNbYKzlIztKEUWB5+kxoQa69Ncs2GQLOQrRjtVHy0obWGQ1AOBpXjtkolHPiH9crHBD2Pyg6l0ta0DA9gYUC+kVzqk+oNNxVx7qLdxPoS0mOHZVujXcupY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718111641; c=relaxed/simple;
	bh=2fuiZBJ4gYF5RN/aMsRqRkOaz/OPJXyzyyNphLyvMQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXjZULPYHrwwH2pW59XQ7hwds2SgqPvK8jLEWm3OdBAdCEEjor8nmxJoDoOTAbZ9j6hgZ0k8I0LrYdTLIs8bFGsB9ZGT7Ye1jh/c7qVzZaBS1h9orvOZCHFKo9O5NOJCddUDPOhfBdBDGbSx2xoR5z2y4F8LtEpnvuQDlIptA2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eob6bBas; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b96a781b63so1994904eaf.1;
        Tue, 11 Jun 2024 06:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718111639; x=1718716439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/6q+EI90ZEHZa34AsXgmeE30lWgmGgFJVCVo7xWZ+4=;
        b=eob6bBassUudvawSQeCMFjbBYtLEBKJVYr2qH+94tTgpF+vkLqOYsDKCs9k5d6YiRF
         7hRnDNicpozyRMpuPyVKtzb5N7+2PdHWpkGd1jF3sUwxqu26RStptChrUydyK2E+B/QU
         /tlueq3Hsw0c1kfVeB2IeV+IEDRXhPqcyXgRIdMElybQZIZw03bg7C4ROm14JMsNZnYt
         SOrJSBRGAStu6f31dFoeCnafBZES2teCf3IlSRxtdR+2SQ/3M/xvw++k7/2i2O+kAFwg
         0xYnDHDVC3EIOGetStbsMSNQhiL1fMYjUAUtLq4xPfX9F6sjkGLUZwvyYIcO/uGI/hlS
         5hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718111639; x=1718716439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/6q+EI90ZEHZa34AsXgmeE30lWgmGgFJVCVo7xWZ+4=;
        b=ScjeoaCzB8tcwpn1yf+6SWVyNEvCKKHaiKOdbXzV5dxJc1r6UM1A7PIKEucIJfd6kK
         YvkLAn2YuUp3yaDwBli7FYIC4bb9Y8zWPsNhK9EAD3q4M5zHxFbiC6YvVYz1MxwExeRL
         iIJkgZqHs+oiEF5fiO0BdRAjlQZlhzDGBNxGMzfcnclxhhBVAJVEcqD140CeeTeuYkV1
         XjuJoSSIIIiMhuyghtUk49lPHLX3J16qTDoSsc3K3sfNH8CnLgZMGruwlAXCJqFFwAqh
         BJs3VI8QlKoI6fvDZxpHWdXIP+fiAAVx0ZaBkezbplFph5jwoUBU4+rBmQmsGXrd3dkA
         sigg==
X-Forwarded-Encrypted: i=1; AJvYcCX+MW7k7uaB50dULh2L+uf6q7OQ4VJc7uhfHcrLIU+T+kmPdskrTvs5mOIHFqOBH28a7W9G0KUasCWZTLoDFEmkG0b4GddLPxAtNZtdAa3L2oIswz6lw4UdFUmn68HQ1HuofioUxn6fQz0J8D7dTUd7o0RfKbUsMIU7/afmuoeTGqTSuwWTgN/q
X-Gm-Message-State: AOJu0YwNs0POWBK6KuDHP0iTADK3q4eIiLFN4wVKKw04jgRAH9h8O02a
	pvCb4ufYznS1hCfcxmoF+6KRacoV7aM+yAbrSyVXULTFPsHf8Cu4kuiyrzKs90vCNQ08MwtRBS9
	lfjE+V2RGCI8y8DdBUHvuH9WDvIE=
X-Google-Smtp-Source: AGHT+IFL06nDNgoTwdVpXwiwMhzWInjm3qrgfOipsTe13xs2EZph4MLYv4zuSihCgIcHYW0Ybd4jC9gysiYmGusw7Ig=
X-Received: by 2002:a05:6820:1c9f:b0:5ba:e5c3:4fa6 with SMTP id
 006d021491bc7-5bae5c35072mr8006000eaf.6.1718111639148; Tue, 11 Jun 2024
 06:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611101633.507101-1-mjguzik@gmail.com> <20240611101633.507101-2-mjguzik@gmail.com>
 <20240611105011.ofuqtmtdjddskbrt@quack3> <2aoxtcshqzrrqfvjs2xger5omq2fjkfifhkdjzvscrtybisca7@eoisrrcki2vw>
 <20240611-zwirn-zielbereich-9457b18177de@brauner>
In-Reply-To: <20240611-zwirn-zielbereich-9457b18177de@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 11 Jun 2024 15:13:45 +0200
Message-ID: <CAGudoHHFh1d3AWcGQ-dm=DbwR8o-+a6+pcsvQbW-F_=qxbD0LA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] vfs: add rcu-based find_inode variants for iget ops
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	josef@toxicpanda.com, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 3:04=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Jun 11, 2024 at 01:40:37PM +0200, Mateusz Guzik wrote:
> > On Tue, Jun 11, 2024 at 12:50:11PM +0200, Jan Kara wrote:
> > > On Tue 11-06-24 12:16:31, Mateusz Guzik wrote:
> > > > +/**
> > > > + * ilookup5 - search for an inode in the inode cache
> > >       ^^^ ilookup5_rcu
> > >
> >
> > fixed in my branch
> >
> > > > + * @sb:          super block of file system to search
> > > > + * @hashval:     hash value (usually inode number) to search for
> > > > + * @test:        callback used for comparisons between inodes
> > > > + * @data:        opaque data pointer to pass to @test
> > > > + *
> > > > + * This is equivalent to ilookup5, except the @test callback must
> > > > + * tolerate the inode not being stable, including being mid-teardo=
wn.
> > > > + */
> > > ...
> > > > +struct inode *ilookup5_nowait_rcu(struct super_block *sb, unsigned=
 long hashval,
> > > > +         int (*test)(struct inode *, void *), void *data);
> > >
> > > I'd prefer wrapping the above so that it fits into 80 columns.
> > >
> >
> > the last comma is precisely at 80, but i can wrap it if you insist
> >
> > > Otherwise feel free to add:
> > >
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > >
> >
> > thanks
> >
> > I'm going to wait for more feedback, tweak the commit message to stress
> > that this goes from 2 hash lock acquires to 1, maybe fix some typos and
> > submit a v4.
> >
> > past that if people want something faster they are welcome to implement
> > or carry it over the finish line themselves.
>
> I'm generally fine with this but I would think that we shouldn't add all
> these helpers without any users. I'm not trying to make this a chicken
> and egg problem though. Let's get the blessing from Josef to convert
> btrfs to that *_rcu variant and then we can add that helper. Additional
> helpers can follow as needed? @Jan, thoughts?

That's basically v1 of the patch (modulo other changes like EXPORT_SYMBOL_G=
PL).

It only has iget5_locked_rcu for btrfs and ilookup5_rcu for bcachefs,
which has since turned out to not use it.

Jan wanted iget5_locked_rcu to follow the iget5_locked in style, hence
I ended up with 3 helpers instead of 1.

I am very much in favor of whacking the extra code and making
iget5_locked_rcu internals look like they did in v1. For reference
that's here:
https://lore.kernel.org/linux-fsdevel/20240606140515.216424-1-mjguzik@gmail=
.com/

--=20
Mateusz Guzik <mjguzik gmail.com>

