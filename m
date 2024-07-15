Return-Path: <linux-fsdevel+bounces-23658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0780930F4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 10:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F2612815BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 08:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CDA184131;
	Mon, 15 Jul 2024 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CciST/50"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91672837F;
	Mon, 15 Jul 2024 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721030769; cv=none; b=g2qEavDgxvo05OairTI1K8t19K8b+s93zL2F1p2wU9BCDT6zPxIkSeP31Yxcllpuab6pCIYSA8WBnpKVU3TEONypGMzy+Zaj0jcxqTofVs/h5GLznyxePbSS3bHr2nopvkp8BJWJWxGVNQEm6Bc3KyXIO9raI1jwrAqbg5AXL4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721030769; c=relaxed/simple;
	bh=G1eFIX6OESTMDT+YLCC2lCf5/XhYggip1JajzNYg8m0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3G7rNMl43rBy80bVRDmQMPVuO5wUfAcE7o5PWMPqSYsvXnemg8wk91p/rj1woI+jAajAgWST8F7ZmFy/42N5ynlYPZnbhAgDhle4x2s8UV/jVU2gyIO3FH3HCM5CIZxkMBggZRCr0M54HKN+G6JWbdEac5irkasKDeZRYmOWRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CciST/50; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77e5929033so487954666b.0;
        Mon, 15 Jul 2024 01:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721030766; x=1721635566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1eFIX6OESTMDT+YLCC2lCf5/XhYggip1JajzNYg8m0=;
        b=CciST/50nEWUieXmCn6BcVCOeKCplu51s98pbn/P/bVj8wOFjkYXwIB7qIq372xqGH
         SXofO3lqwz/k22eQdx+DgyHJJeOevWflmYu6wGBYvXrnY+VlltKQLIyA23ALHLRVrQ9v
         VswmWATBkSb5zpZ76XEZuDM/6cNmX0V33krgwnPjzFhf2nPfyKPnSvZ6y2N3zcF1v/7y
         nwNgOpiOpjgUPe1dtl80CF8NOgdnGM2tAvrr4iCnEMtkqG/9kSZV8rHmTktgVA1aClye
         m35TSmLN89pnvd6+FTFWccfNNloqNTBfu+MIs/2LTZuviyWRPbCxND3hAZOEQxxm3xLZ
         HHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721030766; x=1721635566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1eFIX6OESTMDT+YLCC2lCf5/XhYggip1JajzNYg8m0=;
        b=UHvXgWoA/NF269P+zJdx++UQ6NgGeIMK5sV4TNSkFOVl3TeqIsR0rYdtH8hsVBJzm+
         FrqG0fBXazEwHybTFhWGwZrbXnBT+43HejlcXWooc39uVj8X3JfKdOkPFyk+Sj9x4uZP
         v5pvq+OAA2TLxjKFuzJ4+Yg8Ki04PakPpDQZeiNMgKoujpvdbDEMuj6PF4hJwAYEL6lK
         OJo8gMzkh8n80xMa2+HKgA3ANgy74U6e7lmLe6KZFNIQG0LdX2bVW+NG7e9Pc4aagAT5
         VbXkkNsWsTaopi8cu53V4jlNv9s+/d2AQWGesYREqg6s7oaMwUnI+evFH6/UFgnYU/lo
         ef5g==
X-Forwarded-Encrypted: i=1; AJvYcCWqV+x5Z2dujT5YnMIJb3gm/uhCHUmGuQiK1zFiVn6dF+7DqWd526A29tZXaB2EmE7WJ4kR3RYfyHEmtpNyDbvcD9Sjj2/rgbe3KMdySlfkiGDyDG/l8ABsvvWSj+IT2dXfDfUJ3BQwgpTkog==
X-Gm-Message-State: AOJu0YyZ7oBPdumywQqvJ7/aDu5RnMFsVKLVcNZ4ojfnIjyM+nn101lP
	EPTBwdD/UX66llObdDK4JZiOS5RuFCARcqWqFpp3poE1TovdaoE4ceusMx7N4DlFL3NQJEU/Ll/
	5DFqsJ3FF6+aawFpIX1AAxSv4515vwgS8
X-Google-Smtp-Source: AGHT+IE4Gu5kAOXSNy/6E78Eo8myT0M+rYxfZnWeiSdNLIQZH/k5PtYqs2dhgx4czZjoLW2e1Z6+VsIy5NOoUY2j7wU=
X-Received: by 2002:a17:906:c258:b0:a75:3627:fccc with SMTP id
 a640c23a62f3a-a780b8802c4mr1145031966b.51.1721030765980; Mon, 15 Jul 2024
 01:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715071324.265879-1-mjguzik@gmail.com> <f6ba51c5-e2e0-4287-b995-8a7dff59d5b9@amd.com>
In-Reply-To: <f6ba51c5-e2e0-4287-b995-8a7dff59d5b9@amd.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 15 Jul 2024 10:05:54 +0200
Message-ID: <CAGudoHFBjfSkan10A-9Lx5koUs2rNsV5bWvprJTzxEaOjkETCA@mail.gmail.com>
Subject: Re: [PATCH] vfs: use RCU in ilookup
To: Bharata B Rao <bharata@amd.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 10:02=E2=80=AFAM Bharata B Rao <bharata@amd.com> wr=
ote:
>
> On 15-Jul-24 12:43 PM, Mateusz Guzik wrote:
> > A soft lockup in ilookup was reported when stress-testing a 512-way
> > system [1] (see [2] for full context) and it was verified that not
> > taking the lock shifts issues back to mm.
> >
> > [1] https://lore.kernel.org/linux-mm/56865e57-c250-44da-9713-cf1404595b=
cc@amd.com/
>
> Mateusz,
>
> Just want to mention explicitly that in addition to the lockless lookup
> changes that you suggested in [1], the test run also included your other
> commit
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=3Dv=
fs.inode.rcu&id=3D7180f8d91fcbf252de572d9ffacc945effed0060
> as you had suggested.
>

That commit is needed to have this compile to begin with, so it was
kind of implied. :)

--=20
Mateusz Guzik <mjguzik gmail.com>

