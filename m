Return-Path: <linux-fsdevel+bounces-51819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC2EADBC4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 23:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21883B2FF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 21:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFE421FF5E;
	Mon, 16 Jun 2025 21:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gbgSMjki"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23EE21D018
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 21:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750110791; cv=none; b=uN4VpPknF5IcBD64WYzJH3Hbv5rMDVs6sP49fMaoGt2X8o1iYQvgWwYTOahS877yU1/VnQR4pq6UH1dxGZX7NJHYaFGC6yqqklXwLew/SjHoQcTozlYXkDl29oIBxXNySOGEOWzNlrnSD+570LUChkbVH0NBAAAgvpey5/OypQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750110791; c=relaxed/simple;
	bh=aTM9OBfANswAW0jJyR+JIklFgc0uaVQz3yzV7C+bxmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fy0/CEoruhrrdttEpg3iI9jI96TkX/UAuVDKJ6Fkd45Z9pIjOiVe27IE29gf2G4ZfOCk/iNMb+yseD8LoV7pcgiQCiGNb86/QfI8R+9WJP+sErkPLbI9eNphlYAuP9mSR5VrUegpbGGlV/tANRI4px3InfLWOI58B6oT8Yjgd/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gbgSMjki; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ade76b8356cso1002365866b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 14:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750110787; x=1750715587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CFXuB2yULaV8RN9JrVlyTbbAvWukkCDzQCKWEEy0kQQ=;
        b=gbgSMjki38xXpNmNwRs2cTCGlBCycPIgY7MwyBD6AY8h69NpNka8V2oI0JK3P3//Vw
         h3Jd/84F0q0h/7HjyrZdw3cxzG1s78YXlWuvV+0OCKSh3eLg9CWpX590DvHlALhzTQXQ
         B83o4toS9UFjT6REcfQbDel3WvE0A6X3ltyf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750110787; x=1750715587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CFXuB2yULaV8RN9JrVlyTbbAvWukkCDzQCKWEEy0kQQ=;
        b=CoWBYFF3yCTSRxIjUkmubfxIddXCJNVVDvKLGAq4MJO6fwurUUzGIQdb8s2z4Jd/x+
         98mT5VExsFslq+eYXFVzHVfFodwBiA83AWoxc3KSzEn2Ad8eAWxH4o3RwULt0khrZHfE
         SRZ5dZviMwYA1xcPEWSVuAAb7f2jiFeJx0wNafE5BtKDG1gZsR8sk9iYFAFDNjN+u932
         AfPSvsX/I7tdKFIsza8X94KFnOa9hoW8Ni/JZLnQ0FJXjSe2yZMDv+xz2DThjxa5dcI8
         6891+DDffCNj/J7+zucuAANWgewFP9XxX0odwo60OPX/BaPw7lNJ7uYCwKGyj+8ax5C9
         4Rnw==
X-Forwarded-Encrypted: i=1; AJvYcCUqynNS8Q3zC80RF4EvD29AoHavh/KBgvgmrTJhYo+HoRhn+fh1j0uElhhuywwLST196f1f1teN8X78TkZf@vger.kernel.org
X-Gm-Message-State: AOJu0YxhCksCT0UfyvqAaFlszHNijOhxA030/tkoWMLdUBVWQ/2+umHB
	R2aK4cHo0jmnon1K/AMTTBfcnUb3TDQkoe3kquP/dPCclWJLWyGsF7WsnRQsigApilGdF/rFUG7
	IP4o5FmE=
X-Gm-Gg: ASbGncvOwjZAooNzrmwcpheAztU91FNLKzUb9Ytvu6y6LDxh+xkYTJF7FTDfL9SR80A
	ZZ6gNGJ+uu5Y6lUerWHADDEC1gRh8xjrq4xRsBvUMdrLinovC+iT+SZ4Yl8/31zq6l5CJRMjKFL
	CEEYk44BzzM8o/vorCkWm9Fo3qMoB68fdusrj7q808+N5yroT4djcXxYU/p8A3OKi3/g+N/jYZ4
	q+T2dOUJDuv0fHU3OML+fulYx6bNM/WflE0itdfl+fzdsneQ8t2GOGMieA+TTXniBxu+DTYGf7S
	RRjR348/Ze4GboDzwTzkOO4ZM5FYsQLPEiQ7sd2JTH29WnLYUTmS7hCU/Qtl/qkUBsd6e5DIt38
	I66JEd2UZNx+Bsy2MSPrVIASFGBl3N05untjwPe1ADvOh4pE=
X-Google-Smtp-Source: AGHT+IGorDYex7EhK047jTBfw+YLVqR4Yfw0EsD0TNPXq1G8e4n3JI4vauzp0qqMRn8NjlOGk51Qaw==
X-Received: by 2002:a17:907:2d0b:b0:ad8:ac7e:eeb4 with SMTP id a640c23a62f3a-adfad5c9130mr923128666b.37.1750110786698;
        Mon, 16 Jun 2025 14:53:06 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adff0e8574fsm138162666b.42.2025.06.16.14.53.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 14:53:05 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso9757654a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 14:53:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUpsVq5Yp/3ZcSKTif4Uq+r1pPL/zNYIYryKW7jEX6gWWmTRqaprp3v6n3E3M2fbpKoEgwg6r+YwBXVeIcE@vger.kernel.org
X-Received: by 2002:a05:6402:38b:b0:609:241:1deb with SMTP id
 4fb4d7f45d1cf-60902412112mr6472596a12.10.1750110785313; Mon, 16 Jun 2025
 14:53:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610081758.GE299672@ZenIV> <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-25-viro@zeniv.linux.org.uk> <20250611-leidwesen-kundschaft-92abc4565458@brauner>
 <20250611184700.GP299672@ZenIV> <20250616203837.GA438417@ZenIV>
In-Reply-To: <20250616203837.GA438417@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Jun 2025 14:52:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjezWRn9cT53c1iP=MzSX1pSSkxpz1Ke7Umxd6hE_nHGg@mail.gmail.com>
X-Gm-Features: AX0GCFtxnLLjb1pX8UCqT3DbeQxQaJfy7qAoFr4y2F9BccwxQL8gKuoOpdNJoYQ
Message-ID: <CAHk-=wjezWRn9cT53c1iP=MzSX1pSSkxpz1Ke7Umxd6hE_nHGg@mail.gmail.com>
Subject: Re: [PATCH 25/26] get rid of mountpoint->m_count
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	ebiederm@xmission.com, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Jun 2025 at 13:38, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Folks, how much would you hate the following trick:
>
> lock_mount(path, &m) returning void, and indicating error by storing
> ERR_PTR(-E...) into m.path; unlock_mount(&m) doing nothing if IS_ERR(m.mp);
> users turned into
>
>         scoped_guard(lock_mount, mp)(path) {
>                 if (IS_ERR(mp.mp))
>                         return ERR_PTR(mp.mp);
>                 ....
>         }

Eww.

It feels like using 'scoped_cond_guard()' is the *much* more
appropriate model, even if that interface is kind of disgusting.

The it would literally become

        scoped_cond_guard(lock_mount, return ERR_PTR(mp.mp), mp, path) {

except I do admit that our "cond" guard syntax is horribly nasty - see
the several threads people have had about trying to make them better.
You've been cc'd on at least some of them.

Maybe using lock_mount() could help figure out what the right syntax
for the conditional guards are.

             Linus

