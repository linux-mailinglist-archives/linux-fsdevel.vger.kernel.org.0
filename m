Return-Path: <linux-fsdevel+bounces-45143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5BFA7359E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 16:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81873BEDFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 15:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6F118D649;
	Thu, 27 Mar 2025 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="l9OwKeaf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0347C1917F1
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Mar 2025 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743089334; cv=none; b=XbKJSaoRGlZ5yvSxheBCSVi7mLKCZ8lJ8E7ozCQ3PCMtJv8htIe1N3s9c51Ascac9xn+QDYbyqrql+fBRTjEdEQDIt1d5TFvCFZ/kTekCxYk1s3Y2rGZa0XVTV0Yr6ItEssNQzgAL/pbVoPTNEX94mWb5ZTM2M+Qp9buPBQ7dqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743089334; c=relaxed/simple;
	bh=XOs0XD8grZZQi2az2ZYhhxKJelYDc40QnSGdkccUUhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6lGms0VKVWOzqkACecBehAoBdsIJwGLvu1DhvmnqKsEvZiza/IBp8FIEQDZJVA50rAGjzHPI41TJ0qK5xyugwCn4dmc+b7uwHP2NTFSt9U/FLf2XH+eoa6833hyiqzeav5PZGhoYoexVSJNp3gLLywYG2S1+Xg1LUOXk2W1tBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=l9OwKeaf; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4767e969b94so20932141cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Mar 2025 08:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1743089330; x=1743694130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAwEfBnftZTbsrwmLsgztdIXMKeGRigNbWTP9ROr8m8=;
        b=l9OwKeafIOKcVApWc73nmKrMP5Z0QF2SZy1CFzUQhXo+/hc9vnZTWPjbj3T0Ge8XRh
         /++mJZ1lLjgiCdj3vHUxDhharQev1AFw7BfEvKAMOKBn5JkpnA1FSSm9xtntcwqEspad
         DiQSLzSBE+PO09cFXAyBSOEMO1yvw8aoi78L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743089330; x=1743694130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAwEfBnftZTbsrwmLsgztdIXMKeGRigNbWTP9ROr8m8=;
        b=g7ghabl4wjqhliRKjkQCRbE7UIcfIjZ38poA2UKPsiCt9UjqlllTsuT9NmH1jTIT9b
         gy1M7krrscSChe8zROkpLdYU2Cj1Ot26z2dlBC67suI/eBbiu1uzbZew3B0zAwb6Ovst
         ivZyDj0HA9JLPl01tm6JSCpVzdXreNO5UDlvK3lt6p8xlHP7hZvRqfXaYdBkmj731Ft2
         EgUkN4i+fofzkKYk8oJqVvTh3ewknwlhIfi9QkJL05sqFIRKCt3N7/IV3mDR6lBzvQaA
         gSxqCC5aTgBmYLubyrQqHzN9qq/igaUhQaj1T8wUXAEJCuBSNF4jWTMn6CVw+3JGfKmm
         oUjg==
X-Forwarded-Encrypted: i=1; AJvYcCVceLFcj0pEU0URGSwmNCfpsjb6TKsSMarjACLU6Yyir67Jti7CRl4jN7q3pJgkRD2rwjizTvE/MC34+UE/@vger.kernel.org
X-Gm-Message-State: AOJu0YwaxAMensGwDWSvsGVrRddX3q8bHMJb9WfzMgIAQGLjVH1+mywj
	BO/jtYNckflLwwvNqB7dTyumTYxJPo9VrDKbMjaHGGVBrSXVguOjGeS5Nw4EQ/soUj20yV+LwnI
	fZ427yVaFKqFJtOY8HcWPUCT3hMa9HRRVJyZkxQ==
X-Gm-Gg: ASbGncupkf2b9LSebdngIu6Dkhc5zAxPgv8c4CQAUMDx+GSaG1G2kw6ETEHhHnIsu2X
	c/jrmq/MS+gX5eyfAUJMFyEZHCUTJgYUDzHikVG+qVcwRaETWot7e0HiGHXUojvyoyMcMnz5Rf+
	q7kot5zkU59rRsmzi4oR6vvlTT
X-Google-Smtp-Source: AGHT+IEoOYwqtCG3h2qkToGCIg9YQUfyCOYQmQWCMjtxt39LY2sCiHfXOEHgbjNUVsw+T83K4b91MOtcR807u9Ci5AY=
X-Received: by 2002:a05:622a:480f:b0:476:9e30:a8aa with SMTP id
 d75a77b69052e-4776e1c6258mr79571461cf.38.1743089330540; Thu, 27 Mar 2025
 08:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210194512.417339-1-mszeredi@redhat.com> <20250210194512.417339-3-mszeredi@redhat.com>
 <CAOQ4uxiqis6kawuv4pa6jxHYgpQPc18izFP8e0TORfA_mVu_-w@mail.gmail.com>
 <CAJfpegt=PWs8ZDF11p3nOCWHbWescE5nwVtUt82f=B6B+S0Miw@mail.gmail.com>
 <CAOQ4uxiQQV_O1MJgTksKycBjJ6Bneqc=CQbUoghvXc=8KEEsMg@mail.gmail.com>
 <CAJfpegsuN+C4YiA9PAuY3+-BJ959aSAaXTYBwKNCjEnhXVw0pg@mail.gmail.com>
 <CAOQ4uxjkBQP=x6+2YPYw4pCfaNy0=x48McLCMPJdEJYEb85f-A@mail.gmail.com>
 <CAJfpegvUdaCeBcPPc_Qe6vK4ELz7NXWCxuDcVHLpbzZJazXsqA@mail.gmail.com>
 <87a5ahdjrd.fsf@redhat.com> <CAJfpeguv2+bRiatynX2wzJTjWpUYY5AS897-Tc4EBZZXq976qQ@mail.gmail.com>
 <875xl4etgk.fsf@redhat.com> <CAJfpeguhVYAp5aKeKDXDwip-Z0hc=3W4t=TMLr+-cbEUODf2vA@mail.gmail.com>
 <CAOQ4uxgenjB-TQ4rT9JH3wk+q6Qb8b4TgoPxA0P3G8R-gVm+WA@mail.gmail.com>
In-Reply-To: <CAOQ4uxgenjB-TQ4rT9JH3wk+q6Qb8b4TgoPxA0P3G8R-gVm+WA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 27 Mar 2025 16:28:39 +0100
X-Gm-Features: AQ5f1Jq1ECXl4-EuDIkwRhiylPwwWOgwa5JyV-klDjgVPMmUAmwVfDLYyRaE36Q
Message-ID: <CAJfpegu6mJ2NZr2rkCVexrayUt=wwNSyYv5AE694D04EH2vx2w@mail.gmail.com>
Subject: Re: [PATCH 3/5] ovl: make redirect/metacopy rejection consistent
To: Amir Goldstein <amir73il@gmail.com>
Cc: Giuseppe Scrivano <gscrivan@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Larsson <alexl@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Mar 2025 at 13:16, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Feb 20, 2025 at 12:48=E2=80=AFPM Miklos Szeredi <miklos@szeredi.h=
u> wrote:
> >
> > On Thu, 20 Feb 2025 at 12:39, Giuseppe Scrivano <gscrivan@redhat.com> w=
rote:
> > >
> > > Miklos Szeredi <miklos@szeredi.hu> writes:
> > >
> > > > On Thu, 20 Feb 2025 at 10:54, Giuseppe Scrivano <gscrivan@redhat.co=
m> wrote:
> > > >>
> > > >> Miklos Szeredi <miklos@szeredi.hu> writes:
> > > >>
> > > >> > On Tue, 11 Feb 2025 at 16:52, Amir Goldstein <amir73il@gmail.com=
> wrote:
> > > >
> > > >> >> The short version - for lazy data lookup we store the lowerdata
> > > >> >> redirect absolute path in the ovl entry stack, but we do not st=
ore
> > > >> >> the verity digest, we just store OVL_HAS_DIGEST inode flag if t=
here
> > > >> >> is a digest in metacopy xattr.
> > > >> >>
> > > >> >> If we store the digest from lookup time in ovl entry stack, you=
r changes
> > > >> >> may be easier.
> > > >> >
> > > >> > Sorry, I can't wrap my head around this issue.  Cc-ing Giuseppe.
> > > >
> > > > Giuseppe, can you describe what should happen when verity is enable=
d
> > > > and a file on a composefs setup is copied up?
> > >
> > > we don't care much about this case since the composefs metadata is in
> > > the EROFS file system.  Once copied up it is fine to discard this
> > > information.  Adding Alex to the discussion as he might have a differ=
ent
> > > opinion/use case in mind.
> >
> > Okay.
> >
> > Amir, do I understand correctly that your worry is that after copy-up
> > verity digest is still being used?  If that's the case, we just need
> > to make sure that OVL_HAS_DIGEST is cleared on copy-up?
> >
> > Or am I still misunderstanding this completely?
>
> Sorry, I have somehow missed this email.
>
> TBH, I am not sure what is expected to happen in the use case in question
> on copy up - that is if a full copy up on any metadata change is acceptab=
le.
>
> Technically, we could allow a metacopy upper as long as we take the md5di=
gest
> from the middle layer but that complicates things and I am not sure if we=
 need
> to care - can't wrap my head around this case either.

I've been thinking.  If a lower file has verity enabled, and it is
meta-copied up on ovl with verity=3Don (or verity=3Drequire), then it will
have the digest stored in the .overlay.metacopy xattr. What this
ensures is that the lower file cannot be swapped out without ovl
noticing.  However the .overlay.origin xattr ensures the same thing,
so as long as the user is unable to change the origin integrity should
be guaranteed.  IOW, what we need is just to always check origin on
metacopy regardless of the index option.

But I'm not even sure this is used at all, since the verity code was
added for the composefs use case, which does not use this path AFAICS.
Alex, can you clarify?

(BTW, that origin check could be simplified for non-dir, since we only
need to compare origin_path->dentry->d_inode to this->d_inode.)

Thanks,
Miklos

