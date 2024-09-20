Return-Path: <linux-fsdevel+bounces-29764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 707C297D80C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 18:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36836283098
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3757617DE06;
	Fri, 20 Sep 2024 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3pylaOe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C51B11CA9;
	Fri, 20 Sep 2024 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726848624; cv=none; b=Qd4PMtQ06md1L/x+85++7tITufffGZHN4LeETgScYCI4k9cDJo24RL8+epxGqvaTHaF5qAs9/6GU0apStvopJ5f6/VXmreiQ8rWPBKntE176YzDfpPHlDhkxDVo5LUtDkGn5gVn0Yd6NzlAZZ4JbRLgWBxCv7OsJaeM+VsC5NII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726848624; c=relaxed/simple;
	bh=RWEMaJGaXsfxEE0C0lo9T9ZyPmvAAJNaokH0TQxxmw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDvvdFIzlrMnnPqqY5A6as1jFV8rCONSGrbqy7jjadnoOa2Jawo+ftPOFsdHVl/HUkjqweNoLqxP7yfNj0F8cdOqVxdqGGxoQ6c1+t4bNsvMSxmD6qDn1piz7J4X62lJdQBAo/hhLnUoIhsSMUp6lkl1xGrnPW43kjcZ5nPMb0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3pylaOe; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c25f01879fso2690900a12.1;
        Fri, 20 Sep 2024 09:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726848621; x=1727453421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cr7XGOcXUziTvyQlX8y4MaSV3P+QXr0/0cPRJVwRwZw=;
        b=R3pylaOeye/T9XNN9JS7dUvXb/NhqFgdGBSTGZ+GJaNxw/Q1wr1d+TYiZY3Huoft/F
         x64731mQjWt5cAcLb2U5INz4KHwQzZ/C2LOz/0ZxeeSwpWI9InFEg4a8BZ0u41ejVdkJ
         NshTb85y4rNfooePpz/V0Z406PPArN2ma5WooRuwTV1ZOfTE2iDNZTS8q89dMQImAFFu
         xs5oBBFQjYc2mM9leAIjUFyn9YkPGVK3RO0KTpRK7p3FMJMlAszKqeJzM/HR5MrxVC9K
         1Q7MkMzMw2V4kcBNArUsQRtLS0lhaEYgORS2GiO+0CzKSluVcYE0gYbUt3FrAJ4cbR0S
         Ddcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726848621; x=1727453421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cr7XGOcXUziTvyQlX8y4MaSV3P+QXr0/0cPRJVwRwZw=;
        b=NituikGtLZnrSDVUzvcKtp/ZlJv3iPqbv54uirG7qAFKbyGd7oCckQClJRBM2PunDO
         cSZEmQaxbvBGOGdre953GxEZlgQxj/WDL6CEvYfnmO3uv+cS97Z/e6WcrGWMesQ0yFrW
         TCnmjJtgOfR/5icfEkTzhWP60D1KC1YSIeOwvrWweQ5Nf1XVakhQOUM0M4TVgzo20B+7
         HOu6W1XXa/xhdkhtpPuC5lUFyHaEU+BAaYoP/Z9EReTtQPHL3qrwKuxuCu1vJtJgFPXG
         ggbRCFyyiM+6GEPmLDaaYEgoDJVQC4v540i1NVTjmkt9+P1vv5fDZVhgy1v3IgSB+KFR
         aptg==
X-Forwarded-Encrypted: i=1; AJvYcCU7QSmX0YvKch4vwkWxTIwQ07AQ2kzO8zLnOVYtphSto3w9ovmsat2uJVTJm/+vJPOF9+T455asUeeU@vger.kernel.org, AJvYcCUCJd1ozGQ1UhAkGhfGyuZfepK4auhdBbANKo3mw5Jvjf7Gkipt1S50o3JXABirUc8WoHIwOVqH@vger.kernel.org, AJvYcCVVYgUDf3SlgZ1hZ2Fc1BM44y5nQWg634mv6iEsBEs6XPQut3VePqEgsE/+TcEQYH4dI+pKkkErlkz91rEn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9H5geGu69a5JRF5g/07BqsNllXUVNmoAjtxm7YED7JRk0Qigu
	x2vSXpQQNvHdzJhN2jVs4jPP+oz0rVtCk7nQb6XY9m5OJCOhVxt65vplK0Tskvy7siCLx/oyc+B
	C2cYWKWIaJ+bpJtLv3iusa1lPe0o=
X-Google-Smtp-Source: AGHT+IGB1VoPgmOEpq+79L6y06ORo5qnfiSPcOleFXvXlBXrfzDDPKj98YPlqM00JgvUC/DGeu1v7WP7Lhtg0Vobn2o=
X-Received: by 2002:a05:6402:3588:b0:5c3:cc6d:19eb with SMTP id
 4fb4d7f45d1cf-5c464a384b5mr2119053a12.2.1726848621078; Fri, 20 Sep 2024
 09:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920123022.215863-1-sunjunchao2870@gmail.com>
 <Zu2EcEnlW1KJfzzR@infradead.org> <20240920143727.GB21853@frogsfrogsfrogs>
 <Zu2NeawWugiaWxKA@infradead.org> <20240920150213.GD21853@frogsfrogsfrogs> <Zu2PsafDRpsu3Ryu@infradead.org>
In-Reply-To: <Zu2PsafDRpsu3Ryu@infradead.org>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Sat, 21 Sep 2024 00:10:10 +0800
Message-ID: <CAHB1NagfhamaCnV_spH_uSU4u0sDWrESVy3uU=TfGN51tSBm6A@mail.gmail.com>
Subject: Re: [PATCH 3/3] vfs: return -EOVERFLOW in generic_remap_checks() when
 overflow check fails
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2024=E5=B9=B49=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=BA=94 23:07=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Sep 20, 2024 at 08:02:13AM -0700, Darrick J. Wong wrote:
> > > Which isn't exactly the integer overflow case described here :)
> >
> > Hm?  This patch is touching the error code you get for failing alignmen=
t
> > checks, not the one you get for failing check_add_overflow.  EOVERFLOW
> > seems like an odd return code for unaligned arguments.  Though you're
> > right that EINVAL is verrry vague.
>
> I misread the patch (or rather mostly read the description).  Yes,
> -EOVERFLOW is rather odd here.  And generic_copy_file_checks doesn't
> even have alignment checks, so the message is wrong as well.  I'll
> wait for Jun what the intention was here - maybe the diff got
> misapplied and this was supposed to be applied to an  overflow
> check that returns -EINVAL?

Yeah... The patch was originally intended for overflow check and
sourced from [1], differs from its description. After applying it to
the latest kernel version, there were no warnings or errors, but I
suspect there may be an issue with the git apply process. I'll fix it
in the patch v2, thanks.

[1]: https://lore.kernel.org/linux-fsdevel/20240906033202.1252195-1-sunjunc=
hao2870@gmail.com/
>

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

