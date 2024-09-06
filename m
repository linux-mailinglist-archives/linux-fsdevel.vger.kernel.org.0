Return-Path: <linux-fsdevel+bounces-28842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4BE96F274
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 13:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4DA61F214E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 11:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3022E1CB14A;
	Fri,  6 Sep 2024 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6z7fPUX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C3D158866
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 11:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621136; cv=none; b=WzfIbQIoGxOuDw4XKSZyZm72/Q/bVQAQmP2oDGTNOcPk8O8D7KpVh+nR6CIvVRbPkneYVFSKtKgm4MyWa81+ZgiEes5r+QazsiJxEgDWO/SUbl7Nm8LEiGt83Fm92L5H0ucuepQ0BObe2p/ViyxzqhMPHVrUpj8sgGREE3kmg+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621136; c=relaxed/simple;
	bh=hRnaVYz8xzqMO5nDLoiKpCcHFii7ac1wzji8EZh2C+M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iD22CJgIbzVrIPsn0HaTwFCFJg2L9DgzqDz5afKVH2xbD7RR5tqRu6JZ/FPaoTqY+uZwR7xXjPFNNZO6LEBVE5TWohsvVytumL/VniNfNQ6xJIkun25Emas97NoHRRlPbLpqnVPZRA5rYOuZw/tkLQt4CTgZ/vFegkUOzxPN/+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6z7fPUX; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7178cab62e6so1624490b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2024 04:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725621134; x=1726225934; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hRnaVYz8xzqMO5nDLoiKpCcHFii7ac1wzji8EZh2C+M=;
        b=e6z7fPUXoJyajpjlRC09diTz5qaAXqwp202uKA+4V9qrz/y5de/jPkSEpoS+67/1a1
         oeUx10pEMJl365amQkxuRIhqVoGSiGmqoBZNDBRoe8dybqn6Y3s67Fnt4f2Vz7Foo9Eu
         7wb3Kl024DPzqPJ6skACFahEbeV4sn78OfQ1yJ6sKEFQhKWpnAGZTmo/w897fcJyQ74U
         WLxJ/uOnGqYzH2fmVVA2TaTRR9ndlaiqAHFG9Zu7kTfonqcrU3v0xjcrkLqbmWrDlUkI
         txHt96PyTmNXd4I9mxi31wFXozSxx58wgab+nmIbsd47cs44HJxoiVl0IQ9XHBP/Z4ue
         vfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725621134; x=1726225934;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRnaVYz8xzqMO5nDLoiKpCcHFii7ac1wzji8EZh2C+M=;
        b=RsoTkVnUV4Mcd2OUUYojHlrToQx8KgunzVVcPy86P0325fHDY2IM+8GOa9QW2+0olg
         /yokYDW4IesI2rBY4NE+ijl14gfUl4JNAYbuLXx+9jF83xGmrPRbzD/9qOYNAYEyW3Z5
         oGvKdVeJjBCEWPz4OAk3J4lxi+bLVC1kUCCigFPvPC6BhTTpHwnrY/lpC4qa+3jRWONf
         7gGLXLaEHFrtAOL/kMsjmUAPqQqHkRGse0Dn2OCYts6VYGqz1yDrCNfrl1EPaOBKlbUO
         z5PP+Wi23hPBAEIQwXMv90RHew7QHPcWrCH2Cil+GYMQmgldNhv9cG+/dtW76x6r7zXY
         cs0w==
X-Gm-Message-State: AOJu0YzNaVtaxX0PzHLQz7u9Pz8nSZ7axBrW95miT5b0NX7jPe3nM+fs
	1EQlFACWCY1buEwEVbCfpAOwhHntJVmiIWn0acjwLQzAQEItiw7h
X-Google-Smtp-Source: AGHT+IGp1GBlqeZ5d464UdJgY83R/T8aRw2bGGtGlE9I920UkHkE4T9ZRHOSTHVIc7fdlsA0k1Wg/w==
X-Received: by 2002:a05:6a00:94a7:b0:710:591e:b52f with SMTP id d2e1a72fcca58-718d5ded3a6mr2046996b3a.5.1725621134195;
        Fri, 06 Sep 2024 04:12:14 -0700 (PDT)
Received: from [127.0.0.1] ([203.175.14.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71791fa4889sm2272562b3a.78.2024.09.06.04.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:12:13 -0700 (PDT)
Message-ID: <d6ddc03e3aa86af60b13e9ebb81548b18fe6d74c.camel@gmail.com>
Subject: Re: [PATCH] vfs: return -EOVERFLOW in generic_remap_checks() when
 overflow check fails
From: Julian Sun <sunjunchao2870@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org
Date: Fri, 06 Sep 2024 19:12:08 +0800
In-Reply-To: <20240906102942.egowavntfx6t3z6t@quack3>
References: <20240906033202.1252195-1-sunjunchao2870@gmail.com>
	 <20240906102942.egowavntfx6t3z6t@quack3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-06 at 12:29 +0200, Jan Kara wrote:

Sure, I will include this patch in the patch set for the next version.=C2=
=A0
But I think it maybe deserves a separate patch, rather than being=C2=A0
integrated into the original patch?

> On Fri 06-09-24 11:32:02, Julian Sun wrote:
> > Keep it consistent with the handling of the same check within
> > generic_copy_file_checks().
> > Also, returning -EOVERFLOW in this case is more appropriate.
> >=20
> > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
>=20
> Well, you were already changing this condition here [1] so maybe just
> update the errno in that patch as well? No need to generate unnecessary
> patch conflicts...
>=20
> [1] https://lore.kernel.org/all/20240905121545.ma6zdnswn5s72byb@quack3
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0Honza
>=20
> > ---
> > =C2=A0fs/remap_range.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/remap_range.c b/fs/remap_range.c
> > index 28246dfc8485..97171f2191aa 100644
> > --- a/fs/remap_range.c
> > +++ b/fs/remap_range.c
> > @@ -46,7 +46,7 @@ static int generic_remap_checks(struct file *file_in,=
 loff_t pos_in,
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Ensure offsets don't=
 wrap. */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (pos_in + count < po=
s_in || pos_out + count < pos_out)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -EOVERFLOW;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_in =3D i_size_read=
(inode_in);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_out =3D i_size_rea=
d(inode_out);
> > --=20
> > 2.39.2
> >=20

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

