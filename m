Return-Path: <linux-fsdevel+bounces-32521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3351A9A91BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 23:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12690B21F21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 21:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2C81E0E15;
	Mon, 21 Oct 2024 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmsnZWM3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C178F433D8
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729544730; cv=none; b=RSnyTVNH/wUpZUvVWivX8p0vGL+3S9DKteAjQDE+1tIOZSStOv4TEHLfMUFxuIILMtK1/XNwiexB1c2BGFo/Tk736VfqAQPWprkvA1TSeFzIGzG2e6/bpBJuMgQfsI/ykfG7jsVCBlBuoLu0DeVp6udEtU165xBTJCF6TM+EDHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729544730; c=relaxed/simple;
	bh=FODWGZhk0w+UDpntk2ABeJm6nv4S7u2/U/l3WO7DugU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOqogpDM0YgosvGcbIAhIjyQkQG5tWQ/NwvGQWPNr2t1NUDObnvMyu5riokOb99Nzrhy2SWoCvPVw1xAzNrJVf5GGgtQRPW6+7TMOvAzcWJpamoaFpWwUQx5yVoa4kAmW7SbWiFWrCT5tvU32dN/Eio+KB+GYFIvi5fxoWTsuX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmsnZWM3; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460e6d331d6so8137521cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 14:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729544725; x=1730149525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3ZA0BEr3sDTt6qlbLanXjDgNX5vwNVdkrw+XZQzJvg=;
        b=fmsnZWM3hb5z0Z9UoVON0BtF8odpgjPCgWeikerIW3sEtHi9if+4x/ODwaS1ppJ24Y
         I1NfVC4n3VkEZtA5EIBzt4spjJnGv6b3bmPfkmw93X0foP62lqHYyRaBYOJDDMGp/U6G
         mLUKGVw7KJu9qntngCDGGCbA8d2yw7Y7nquHW0qC1vuF4+b81thPyBUUT36QAtyUtth0
         yZT8xSEHg+ZU0USCImVmAtWxifWn91k6uaR7qG0t8WmbSLk2Q7CbLweJGdbtQDhuORQe
         hgRy37/SXUI5F3MSmkWWl7X1UvDopbL4LBIkmEOmWX1anxM0o4A8yMxZo6fiM5OxE9F8
         OFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729544725; x=1730149525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3ZA0BEr3sDTt6qlbLanXjDgNX5vwNVdkrw+XZQzJvg=;
        b=ucDPc/BuCDMbdJg1Vhdr+5waWFoMjR1pXYoORgUdAaC3qWClCw/FkJnZ2gveTpSJpp
         4YcZjbjpE36XRqhxIDGv1FX74weULr4B09WqbVdu/P0fpMSLhkykYeJhKo+Abv7HEDuH
         LWiCiFpvf4tr2a6SJQAZYtZM/HfpwZBp5/6yO7vYsuURv1njxN/d0IfkJc4Z52jpQtRm
         AkqNQtKd1oEoy3D9Q41YCQja+rSz+SomhIXkkqyqMCLNcEwC31at8rEjKm4zVHQxdq8a
         oYE8rVhMMdi0a1OKnhkuRKtaL+TW+Jxj9uynki5kM3w8TR1OErLQ6FsAh7JbnLK5Y8d2
         MaEg==
X-Forwarded-Encrypted: i=1; AJvYcCXTtzprAgzQh0lHFn6e/044bGfZazK3iM+iWEiI+FmnU9Q9ARix5a6EK0zwn6yC4UnvfYYC+oUYdO88821C@vger.kernel.org
X-Gm-Message-State: AOJu0YyXD6NnZfVzNOuhh2Tv0S/S66w+hqwJJNdM62I35tQrJk7816KB
	93burO8gR9xjBFAFQ+BWQxLCNkJRuEe+pW9b7JFO23SH0k7J7keenHPVRneN6E95V2uDyXrjMKr
	ttLf2vJnYn4YdwIT5v9PAS9/sCgA=
X-Google-Smtp-Source: AGHT+IF4p9VCXNv3I35LReHx2HHPEOEoN+agJOqpiUVM3c3GMrqt1MqCrq9nelReSiuB50Im83TXrxKkTicpqrN2K1g=
X-Received: by 2002:a05:622a:653:b0:45c:aa3c:6b21 with SMTP id
 d75a77b69052e-460aed54022mr216629251cf.19.1729544725516; Mon, 21 Oct 2024
 14:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com> <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1a5UaVP0qSKcuww2dhLkeUqdkri_FEyVMAuTtvv3NMu9Q@mail.gmail.com>
 <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn>
 <CAJfpeguS-xSjmH2ATTp-BmtTgT0iTk2_4EMtnoxPPcepP=BCpQ@mail.gmail.com>
 <tgjnsph6wck3otk2zss326rj6ko2vftlc3r3phznswygbn3dtg@lxn7u3ojszzk>
 <CAJfpegvd-5h5Fx4=s-UwmbusA9_iLmGkk7+s9buhYQFsN76QNw@mail.gmail.com>
 <g5qhetudluazn6phri4kxxa3dgg6diuffh53dbhkxmjixzpk24@slojbhmjb55d>
 <CAJfpegvUJazUFEa_z_ev7BQGDoam+bFYOmKFPRkuFwaWjUnRJQ@mail.gmail.com>
 <t7vafpbp4onjdmcqb5xu6ypdz72gsbggpupbwgaxhrvzrxb3j5@npmymwp2t5a7> <CAJfpegsqNzk5nft5_4dgJkQ3=z_EG_-D+At+NqkxTpiaS5ML+A@mail.gmail.com>
In-Reply-To: <CAJfpegsqNzk5nft5_4dgJkQ3=z_EG_-D+At+NqkxTpiaS5ML+A@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 21 Oct 2024 14:05:14 -0700
Message-ID: <CAJnrk1aB3MehpTx6OM=J_5jgs_Xo+euAZBRGLGB+1HYX66URHQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 3:15=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Fri, 18 Oct 2024 at 07:31, Shakeel Butt <shakeel.butt@linux.dev> wrote=
:
>
> > I feel like this is too much restrictive and I am still not sure why
> > blocking on fuse folios served by non-privileges fuse server is worse
> > than blocking on folios served from the network.
>
> Might be.  But historically fuse had this behavior and I'd be very
> reluctant to change that unconditionally.
>
> With a systemwide maximal timeout for fuse requests it might make
> sense to allow sync(2), etc. to wait for fuse writeback.
>
> Without a timeout allowing fuse servers to block sync(2) indefinitely
> seems rather risky.

Could we skip waiting on writeback in sync(2) if it's a fuse folio?
That seems in line with the sync(2) documentation Jingbo referenced
earlier where it states "The writing, although scheduled, is not
necessarily complete upon return from sync()."
https://pubs.opengroup.org/onlinepubs/9699919799/functions/sync.html


Thanks,
Joanne
>
> Thanks,
> Miklos

