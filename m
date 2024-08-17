Return-Path: <linux-fsdevel+bounces-26183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3335F9556A0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 11:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC1E1F2162F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 09:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D46146581;
	Sat, 17 Aug 2024 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqz6ItTq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96915BA2D
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Aug 2024 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723885800; cv=none; b=dQjipiJtNMAeElrD4gN9LFCrBh0rZODNS05f6OWabxoD3Tm0L1x+ATRrRpoCVnkV/3UF26+F1Zl0YWIQziq+re+Oh2ISP0lvYL+AbZM9wrZOz8IalWUKQpOQa2TPyw/P5/gEp4J+joMsJFEeZ3Mse3F/TrYi7FMVlFyT+gRPdVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723885800; c=relaxed/simple;
	bh=XuwSI82siOubxUPpj+Q1D3g/rmz+zgKJjLqhqhn5wi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhqRl4mPoOnQZfxKPN+PVmBu/dYk3Ke7pBtduPoLYycX9nx0Wdk9cIvmBm6uiZ05dD6SY+ihbN2sXvJyrRN6WLxBOsSAk08+1aeRKR1Zf/4X1QJUkcjJt6lR1vr+34A3j+ftLaS5YA9iphTFGhiLu1FjstzpEFRbVbaS1JxR+JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqz6ItTq; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7de4364ca8so324400166b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Aug 2024 02:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723885797; x=1724490597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EawtvdUFx+oRjmjEk3RT69Lhmy6gPyA00ErVq1TZ+0=;
        b=jqz6ItTqs0Ddd50r8DCUvuqtqhRbOTpFD6aVZHB0d7Q1hxbtSL530tGsfYc5IqJBUa
         TFojenkPYP8MgD++djkDGyuxzY0asUKrS7X5sC2B48TI+50nma5cP0dtxl106v4Sh00n
         IIMqm3MEzTr7mI0E26gpHtKq0t/zahTNNsBSlGlsaE8p4s1oOagfTLf0E78ME94LTFFt
         IxS7rh0Q3FEzdh+3rvcQO0jkhSEH4rPL2tYddBc2EOhUnqmxsQN6NgBheZUOWgHzgnnA
         7eZDheL5JuLX6xdpZoyLD7fBGRgwYDUCQJtwqfcLSbFY4pg902rjwLi5ijyqOt1bS0qV
         om6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723885797; x=1724490597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+EawtvdUFx+oRjmjEk3RT69Lhmy6gPyA00ErVq1TZ+0=;
        b=gD9MrFS/YrXsxAOyUK1CgjzHcqeeQYxHJ4iC4ZSh3vUCnFcL9NtVaUGy370Yr4b6m8
         ZdxFknZjh6Wr3zV17HKUz08oOou+s5QQb4W3YupyEeS/GO/F2v0bv7u/MjJP0Ta4eLrq
         DkqciLwoIMAs0tTBcw+TRPCIy6ycLPJOJ82jxaMNQVOn30fc3EtHzx7g3hRA0yoid6fY
         VgXnbeW/SKf3aZySCgCfKTV54fSPlRQ6HyzjntQeoW4tqF4rQEHYf61SMDjzfDWm0KO+
         15V5UWL0BGtj8ji1S/GBwnQNfIp+Dof6kgfuh3piVIs9PFt20JlszgP+tXVAOcM7+laf
         foPA==
X-Forwarded-Encrypted: i=1; AJvYcCX+U6C6kwP8V5rXGWr8JRhSKjPBgDobRIvF1KUOe5w4VeuB5GMJSks2HxN+yE/w5lmhxY4Ns9cSnV3VoLmX1v/Uq9lS/gu3vDYWw5DhBg==
X-Gm-Message-State: AOJu0YwzvoYVRrHsFUmEfEEbiCnSdx5rKmhjMlLHeMbUq7/D1c37zVoH
	Y+O2X7JTCX/SX3nsM+ZFS2/NPBNTP9BTcF1IDpr19FjsHtETmURjDc2sJGvnJnTRjFneXkylAVB
	HAXwonIZVvOxxZMDq0TY04rwP/f8=
X-Google-Smtp-Source: AGHT+IE/7FxSCaksgelBl3C3VGL8fJYp4q84Ozs0CeXCCtM6uCFM6rSw+M+hCOeBZ0AKpJ6vrzhbcE1Shn2S0lt4avI=
X-Received: by 2002:a17:907:e291:b0:a75:1069:5b94 with SMTP id
 a640c23a62f3a-a83928d7cadmr384801966b.21.1723885796761; Sat, 17 Aug 2024
 02:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816-vfs-misc-dio-v1-1-80fe21a2c710@kernel.org>
 <2834955.1723825625@warthog.procyon.org.uk> <rkjfi4wcv3rzthhc3ytswry3vposdxpm7bzfjz4tozdyaazdle@rg7x23beryre>
 <3095917.1723879488@warthog.procyon.org.uk>
In-Reply-To: <3095917.1723879488@warthog.procyon.org.uk>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 17 Aug 2024 11:09:44 +0200
Message-ID: <CAGudoHHGeVtdaDD7b6d1A-wyndV0M=nEGU8sTaa8_Azn49u7fQ@mail.gmail.com>
Subject: Re: [PATCH] inode: remove __I_DIO_WAKEUP
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 9:25=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> > ... atomic_read and atomic_set -- these merely expand to regular movs, =
...
>
> Ah, no, that's not necessarily true.  See arch/parisc/include/asm/atomic.=
h.
>

In that context I was talking about amd64.

atomic_read/set do happen to provide some fencing on some archs, but
there are no guarantees as far as LKMM is concerned -- for example
atomic_read is explicitly documented to only provide relaxed ordering
(aka no guarantees).

In particular on amd64 the full memory barrier normally coming with
lock-prefixed instructions (and xchg with a memory operand) is not
present here because this merely expands to a regular mov, making the
code bogus if such a fence is indeed required in this code.

--=20
Mateusz Guzik <mjguzik gmail.com>

