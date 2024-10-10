Return-Path: <linux-fsdevel+bounces-31591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC42998972
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 16:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D6EEB2FA72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 14:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEC81E908F;
	Thu, 10 Oct 2024 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Osxswuo8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121271E9079;
	Thu, 10 Oct 2024 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569546; cv=none; b=D8J+87kSRC8ln5zsJFZeCbcpX1jJ8Y0peySxzdNR3ntWiicgSwXKSV4zTyQhMUFmApiEj0mha67juW/637dgLAz27nu+oBZQ8GuiiiDBdXjQy8Bv5Hhwv6gpMd6BqjbQESsQdji9YU16NHn7tc4f0jgAMSEEzFZKHrMru04mXBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569546; c=relaxed/simple;
	bh=9lqWCc5e28CxhVVerGSiAMS304N/AvgObvIwqRd0J+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TmaHsJGskifJh0isPrTXWjcm4TATeyHF0o4nnFonuKtVGnqN49J4pgL6UzmOdCj8s0WmajdmAs5kKgnFQuMXgMNouwa/ikjhYtWGqojN1LMlnw+xpuSFfhgqhEgIimif6YwJ7h0kJbKHs707clya2KxmyHp6xLCg43II2VELKW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Osxswuo8; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fabd2c4ac0so10638201fa.1;
        Thu, 10 Oct 2024 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728569543; x=1729174343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FO4nLGdOo+Js2COy6eiR9EScXh41Li3PpsXBgGEPkgI=;
        b=Osxswuo8qK6q3kAHiMAd+eiC8O41VS2gW/L+Jjr/6NGTAAL6rWxfgdRQ8pTzRTdbA8
         bIOFZF03GRthzfkR/nPD+qx7zgOAgG4/lFp+k5yO5/WP7oRTHwQEs9RBFKVU6nBXLuEQ
         UCpaCOdaC9Ii+cLEvTJ/JCjv3hupzfVpe7tMQ9qcuFXUzIyyy9xf6LfgFOC8jC67wzmw
         CBId4WPifvtbq3OmjlzDAUBtOJByRPlkZBd3yjbgSpQmm1GCRGtUS2jIQnzGj5CL+6f2
         6FtDG/RS4WzZVVBbH+/VMW68woY/Z0+TXEpTgeDP0yBadneSL8rIOkqbQXOFd+ZkwyQc
         lLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728569543; x=1729174343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FO4nLGdOo+Js2COy6eiR9EScXh41Li3PpsXBgGEPkgI=;
        b=etzKQXbDUj1B7ajYZFmlQLarlUKhmT2AeH++AWHSC7cITsI01MEbQqhsfJzARDvfNT
         XhU5itEQfE+2H9xktL0ttp1mvifPQPtQSMR8xdIH/s641LJXL5gE8onr4fuOY6Bny5uU
         tcKKu2FpJKUOu+tgmRk+65fGhPEvfxdqRFXTyzbWdgQIDLogV4Fcn9IPzDqlIeBKMD9R
         aZZvpOR2UP+jVufW7f4ENke8ofE7ERfdJ0R3Xnh1L7OIAkpIBQnZ02rvfvnBlk77y/6S
         huFkdF4yRCQsdjDZTW0GDioqTDLGmOShn0kSBOBxZHRvABcZPJkY9o3TglpKszHzF8UV
         J8Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUp2qOHt9NB2r3ZCgbRdAwOY76mtrDWDQwaVr0JdPwulwekpcSl8HY2tRoVVnTWg0dVUlQxioTmQ3Yok5Rrow==@vger.kernel.org, AJvYcCX9FEHdG7W+DMf3t5N0BbB8Fi/kKQ+aa3G9Nn3pget1nZR3QUyl/Gq+X7fjDA2XEax9aC/1SOkLtQ0=@vger.kernel.org, AJvYcCXVb3XliIX+gVduEkMwBDn1pLBLXs26Jsj6ikTrXga8woAThdYBhghcJVnkpa+JZGaKd6jk9iPAAjWYzOlR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm+bEdkHEO5hpk7LxVC0mvqbDmKMCDKiwuo4rwhylS+CQbBZj3
	cYPZF5g6eRSl+1H6wYl0DyZG1TispY7qbMyfPgibNrq2bpWrzLBrjj5RkEZ6c3iYvnIwNjnTzRO
	xMt0mCzbhu+JKHTTmYoAfIb5b3iE=
X-Google-Smtp-Source: AGHT+IGINqsR0Zo1g9Z44wlDBu6XRxQkz0Oey8C8eYChSH4HUW8yOyh6s5LeCyzpGfOw2s+KW7kXwYon786TbMuNtI8=
X-Received: by 2002:a2e:742:0:b0:2fb:cc0:2a05 with SMTP id 38308e7fff4ca-2fb187f803emr33690801fa.37.1728569542878;
 Thu, 10 Oct 2024 07:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ-ks9kiAH5MYmMvHxwH9JfBdhLGA_mP+ezmZ8wJOzDY1p7o5w@mail.gmail.com>
 <20241009205237.48881-2-tamird@gmail.com> <b4a4668d-1280-446e-b1a9-a01fd073fd8f@infradead.org>
In-Reply-To: <b4a4668d-1280-446e-b1a9-a01fd073fd8f@infradead.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 10 Oct 2024 10:11:46 -0400
Message-ID: <CAJ-ks9khQo8o_7qUj_wMS+_LRpmhy7OQ62nhWZBwam59wid5hQ@mail.gmail.com>
Subject: Re: [PATCH v2] XArray: minor documentation improvements
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 6:22=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> Is storing %NULL does by making a function call or just by doing
>         *xa1 =3D NULL;
>
> ?

No, you cannot interact with XArray this way.

> > -into any entry will cause the XArray to forget about the range.
> > +entries can be explicitly split into smaller entries. Erasing any entr=
y
> > +will cause the XArray to forget about the range.
>
> Clearing any entry by calling xa_erase() will cause the XArray to forget =
about the range.

Will send v3 in a moment with new phrasing.

