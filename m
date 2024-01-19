Return-Path: <linux-fsdevel+bounces-8338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9C0832F43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 20:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E56A1C2345A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 19:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FD155E73;
	Fri, 19 Jan 2024 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRZK2ZgU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577C33C6BA;
	Fri, 19 Jan 2024 19:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705691202; cv=none; b=Qi1h3JrljugQT8q0+xpL4nlFDmEhTMLKGgH4O09qW7r/l/SymDwP2T9LpZnvAj6XZGzcD6j+49KazttwfDGutfLFG35UTKTr1p+X3Lj8ZIVKGgdQBHFVLrBE7B2myajX7EDNFWkV7o/6YlSG2Ay07h7NLUCaAOjWeEdU0CIzuk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705691202; c=relaxed/simple;
	bh=5yYdo3Q+tSNRcPUuACl0B6aWlTGLR2zXLx2MtVEd+fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4ibWAIb5inmzQfFjzJZ7VVe/npEi8ZBVZQ8nyZg1SUWmn+fMPVN25OhufLXnTLl+5xsyLMz7fDiOkeMTxq7xQFJNOqcBOoKXC8vYjVzeSwzTw2nakvUFNqCycwtr628uOzAI+0j2nVqMFNhKzar69lZwpath/BlMKQ8yMW1UCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRZK2ZgU; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6818aa07d81so5604276d6.0;
        Fri, 19 Jan 2024 11:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705691200; x=1706296000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yYdo3Q+tSNRcPUuACl0B6aWlTGLR2zXLx2MtVEd+fo=;
        b=VRZK2ZgUQPCJGigeVoFmUW9dXq5DCaZnVdvov6U7dqK3swsTVzPbSNH1MBan8s+hOy
         3Xzw+UGB6l22T8W2Y4DfKmSf1kViV3toOAtTg3RqWkn2VyEaWey9j9ob3+BPA9KTCt8m
         pKTZdBpQ9Pq74Mhj1J0b7IH1+9CQ8zegNwD3BwIzKJUSYc1CRY2T6zTW599h5AsePgEz
         KDQD1nAN24cirlrYVgLptW+dexbAFji5TeWpC5Vy+0Gdzxol3RWsgkt1tNQpqtV84WcC
         2KhdSlgfvT/OJMtK8d+3LCutr4IXZTD8MvdyMrP698tv7JrIZWZevEyVbqjZvdvh1uZb
         mU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705691200; x=1706296000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yYdo3Q+tSNRcPUuACl0B6aWlTGLR2zXLx2MtVEd+fo=;
        b=FxR+dHJwadpdMo4af7UIfqI8GruJMxIDpWDDip3So26dnNXkr/EK3GRzHy1AB9UnUq
         oevPOtf86X3m3iO00yx3e0JsPkl6iEGBr689ESC2hkjaB+z+Ut/cUofl5oDHfL31AmEk
         dhwRkbo6fZA4y0rAD/M8DbrGj7rxIdNfr3tVhxbrdSeRYlf8tMJ4ArH0tzbba5bgpY4c
         bQSSYTuDnXiL+m/AEimhRTSHlFW8nrZMxrs3Onvd+sD9/SMRRVMAcML+T9VULIFH731w
         Z+W6P9OAqro6QzMVmWKG7Y7m6Ph1p3crJScOOdJtSdKpHw8LIHa/VCpwlKGMAxBk53xX
         DRIw==
X-Gm-Message-State: AOJu0Yy3Dy/iPsE5MkB7loh0Gim5CLDmnZGlUoORtn0ByRLAQhQvH2sA
	ZHSuMYqPbd3Uo/asduEGbeiktd2Z064r55I4tme3kQEXMRgaYAqYlM5gePo19cXkq7F940eAiLK
	b6FP8Xy5qK2jrC/9B9W7r888JYsIiGrU3w3ZcFQ==
X-Google-Smtp-Source: AGHT+IFIXlIsLRXaPo/Q7hGR90FQw6qnTHeNDRwBJiSI+P6DZ+yY84Ln/2tOcBv492wGXA9gPn2XVtCD9FO9qF6/Etc=
X-Received: by 2002:a0c:db11:0:b0:680:ffed:c1bf with SMTP id
 d17-20020a0cdb11000000b00680ffedc1bfmr328407qvk.54.1705691200182; Fri, 19 Jan
 2024 11:06:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119101454.532809-1-mszeredi@redhat.com> <CAOQ4uxiWtdgCQ+kBJemAYbwNR46ogP7DhjD29cqAw0qqLvQn4A@mail.gmail.com>
 <5ee3a210f8f4fc89cb750b3d1a378a0ff0187c9f.camel@redhat.com>
In-Reply-To: <5ee3a210f8f4fc89cb750b3d1a378a0ff0187c9f.camel@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 19 Jan 2024 21:06:28 +0200
Message-ID: <CAOQ4uxiob0t4YDpEZ4urfro=NrXF+FH_Bvt9DbD1cHbJAWf88A@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: require xwhiteout feature flag on layer roots
To: Alexander Larsson <alexl@redhat.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 6:35=E2=80=AFPM Alexander Larsson <alexl@redhat.com=
> wrote:
>
> On Fri, 2024-01-19 at 13:08 +0200, Amir Goldstein wrote:
> > On Fri, Jan 19, 2024 at 12:14=E2=80=AFPM Miklos Szeredi <mszeredi@redha=
t.com>
> > wrote:
> >
> >
> > Do you want me to fix/test and send this to Linus?
> >
> > Alex, can we add your RVB to v2?
>
> I ran into an issue converting composefs to use this.
>
> Suppose we have a chroot of files containing some upper dirs and we
> want to make a composefs of this. For example, say
> /foo/lower/dir/whiteout is a traditional whiteout.
>
> Previously, what happened is that I marked the whiteout file with
> trusted.overlay.overlay.whiteout, and the /foo/lower/dir with
> trusted.overlay.overlay.whiteouts.
>
> Them when I mounted then entire chroot with overlayfs these xattrs
> would get unescaped and I would get a $mnt/foo/lower/dir/whiteout with
> a trusted.overlay.whiteout xattr, and a $mnt/foo/lower/dir with a
> trusted.overlay.whiteout. When I then mounted another overlayfs with a
> lowerdir of $mnt/foo/lower it would treat the whiteout as a xwhiteout.
>
> However, now I need the lowerdir toplevel dir to also have a
> trusted.overlay.whiteouts xattr. But when I'm converting the entire
> chroot I do not know which of the directories is going to be used as
> the toplevel lower dir, so I don't know where to put this marker.
>
> The only solution I see is to put it on *all* parent directories. Is
> there a better approach here?

How about checking xwhiteouts xattrs along with impure and
origin xattrs in ovl_get_inode()?

Then there will be no overhead in readdir and no need for
marking the layer root?

Miklos, would that be acceptable?

Thanks,
Amir.

