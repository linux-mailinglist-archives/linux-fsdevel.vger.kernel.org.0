Return-Path: <linux-fsdevel+bounces-16384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59D789CD79
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 23:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 677FF1F24A24
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 21:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7A01487CE;
	Mon,  8 Apr 2024 21:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="goJN4DAf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330EA1474AF
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Apr 2024 21:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712611285; cv=none; b=Yze8vOzJzmtMyhsevfRe48x4yPH34xcvUjyPXQEV9VwemuxDA1CE3Qy8hJns0OlQn71gCRB3mgHCSX04Hb23LlK9SbpIRu0tatT1rxLORM0eRZoeznqLJjRKqjXdtKFIjNk/daCjVftiz+EEhogfbXVGToqjHZ6SsKqkPV8WABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712611285; c=relaxed/simple;
	bh=Sw4+k5a6MJWGjZVqHzvPeVGvtNP/9bYUYa4c2zZvwvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSO1ecLJrLtjznLQH8G/7vTcqfT18mE94aw52izt4FC2sv3q01Qp5+CNvBekhddYkOE1bN5h67+9PjQl1RDksrLmUffJf0kMlNFY41fWanY11R12IEkHEBPXdraA7qTw1TtH25GaMoViq0QNj++D1Zkk0rvkgcDKbi36312MbJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=goJN4DAf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-343cfe8cae1so3032756f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Apr 2024 14:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712611282; x=1713216082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWv/i5xh3+rBeyFNDgtM4EpK2GAFLELYYUjgkTjhu9Y=;
        b=goJN4DAfu4nuy9oNi0tIq9m4unEqcS2FHw6AbEuckPeT3gUmGTwwInWHBhFmbsQyN3
         xrOrD8YEybmhysAc2pRCX0SJD8+yn/1olxJsWzrTgo2Th9lfXeB+mVNHm2wYjHz6boID
         povWQ+RvmuVHvcAj6xX5d8Fq7TLmVQui5KAD/E3w9EU/58uepC7ztsEVlTz4M20Vyrpd
         Xbr4oRAvlA41huhc6Uvov6Ec7T0JpYCDyI+dS64N5J+qnx4FYXc6Tc9SJ9ZlCOTYKQqD
         V586TMqDxe+S8ODFMvGitaQmqFljBcxVu6j41LCRIm4RwpnwNgMCpLgzJUPJZ4DWJLXT
         09mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712611282; x=1713216082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWv/i5xh3+rBeyFNDgtM4EpK2GAFLELYYUjgkTjhu9Y=;
        b=l4LFcUVHkM6fdAg+encFRiZrqQIFw5b/LKJaqLD4D5zXD6Z6yiyh8c5DeBmsbcu51x
         u1PlO8l385+T084yg61eCOrcN08EPj5iGd2ptrxn+Y69UhgfibR+BWkRDbUbiBiCqTGj
         wo0LHbPCuPV3e+lEPji90j3dgAv3cMg/bB/jQwu13rbHzMVBRdsV0Fgh7TSBI/9jnt5e
         9NITQ5W/V14ykMtPc1ekvnH877J0R+frwiaT8/JUFLt3/aKKc6rKXtQlQ4JEaR6hCqJF
         BZVUUpOpxRnQ7q8ZKMml4oOG/RB29YDHokdd0M+yAxFog2sonVTKiHi+fEVYbRixx2mN
         JTIA==
X-Forwarded-Encrypted: i=1; AJvYcCWjJZMGsTMyK77RZqApHugEzQ+guYU0k5w//0e6fchuNVqFyGxADXotdQLitYR3HjDiTofAxon39AulKT7E68oqryIsD2KBhdpwK7f4+g==
X-Gm-Message-State: AOJu0Yy+Z/6J9bzd7XYSFQrR1xoebI1KFeCpPi/9+d5D/FRLmHrArSd8
	U9pAMhk63Izr9vxmQ2oQ0U6J7Rn+mgSiq3hKOwHSYkcPCm0dnh5cg5JFZE9dNWI/U47a11GZRLb
	Vof4g8+tw7xir6vd5U3U+IdvIvjhm/UZKh00L
X-Google-Smtp-Source: AGHT+IHeGJ6F4ll9rt0b252ElUO5EB31Rl2KzoLT24tHgP5ExIXWB82Osysw+y7ff6hsi+9LQqecR2QLrmDACtdEET0=
X-Received: by 2002:adf:fa8e:0:b0:343:b619:dd52 with SMTP id
 h14-20020adffa8e000000b00343b619dd52mr7230109wrr.0.1712611282291; Mon, 08 Apr
 2024 14:21:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408075052.3304511-1-arnd@kernel.org> <20240408143623.t4uj4dbewl4hyoar@quack3>
In-Reply-To: <20240408143623.t4uj4dbewl4hyoar@quack3>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 8 Apr 2024 14:21:10 -0700
Message-ID: <CAFhGd8ohK=tQ+_qBQF5iW10qoySWi6MsGNoL3diBGHsgsP+n_A@mail.gmail.com>
Subject: Re: [PATCH] [RESEND] orangefs: fix out-of-bounds fsid access
To: Jan Kara <jack@suse.cz>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Mike Marshall <hubcap@omnibond.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org, 
	Vlastimil Babka <vbabka@suse.cz>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 7:36=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> Frankly, this initializer is hard to understand for me. Why not simple:
>
>         buf->f_fsid[0] =3D ORANGEFS_SB(sb)->fs_id;
>         buf->f_fsid[1] =3D ORANGEFS_SB(sb)->id;
>

+1 for this idea, seems easier to read for me.

>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

