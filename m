Return-Path: <linux-fsdevel+bounces-48206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E555DAABF16
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EFCB189182F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEA8274FF9;
	Tue,  6 May 2025 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9Jti8Ik"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1940926C3A5
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746523130; cv=none; b=fVAojPdoktXjbYEtpoKlEzbMMVZrxSCA+MEE6cnDQCX0cTG848D/+Wpd8kMu/XLw51Z6bQkVVE09ox3heAWfCt7nK347orzgXLF4XQT1WxD3Q5oeSjBujYKQdS1RRFcna5xep1D46GZpgnBoDLxPX/1zzqU3LbUKHJYrxY7rjSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746523130; c=relaxed/simple;
	bh=Mq3nH/drbxKqRxXzeZ/ZTRfURa8po81qX6xnc6hj2oI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMICTrocalAVxGHUkVds1fBqURZ8jX0zeDEmJCp0/lv5gubfoqhCMMtPgmKAz61AnVymmg9AwmMIVSLHECjKhVW8qYhl1Cph8qoW/MN59QtMTjjYgF2ZeHabVqN3OzrjbTgm0JYgkhk+F860ACvtBwgZYu2/S/JTPRLif8Nfsgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9Jti8Ik; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ace94273f0dso254787166b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 May 2025 02:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746523127; x=1747127927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mq3nH/drbxKqRxXzeZ/ZTRfURa8po81qX6xnc6hj2oI=;
        b=M9Jti8Ik+JV1epgd/lbgo6BKnFt/eY7481Cg/ljs4M67zZDzP49Zhv+i3xK8IL7hTF
         a8MsAumSzNngRtKQmlNGmu0Unke+u+ERvM3nCSe7DcPS5MprBguVqTSfsLLO1kk/g410
         cXBL9xtKfd64WJWSJSQW9+eL0Xj2K0oCSk6HyYC3Xu8GQK8UCZpxVvHd8zibvxsuRp5j
         Tr1BSUSQh53EAAJSGxZ7PJfT0Chg/FS47uNpTokv0EOZ1iDy911OdGiPNwvwZjpRdexk
         te+mKH4JNpFTOa0MWwXoTzGZEEwqfs+SHMGAhh/nm9Nmly9EIVGYOwC22hd/KJ90Qh2F
         6ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746523127; x=1747127927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mq3nH/drbxKqRxXzeZ/ZTRfURa8po81qX6xnc6hj2oI=;
        b=jMkWbOWYTfOMF5vLwTHg10eu9i1W8IemY8hsKjk8BdMrVUQNmLNx6d3ngCMRWpNTJ3
         aljqPfkS+sOQAcLNB7FrU+zawQKND8Wutbj4TcDH96uLMdO5r5IfS1sSwl7fdc0aoHG3
         A0wtOPcHl11lNYn7tgCpuAlJtn7WFm2ea0HJLnvns7gH4OZVQclTX2e+2P2qnIWck6Ey
         cdpH4mDuV4urhKOcppEJEbfNC7Bt+ptg56iBkpcy3ogkGov2R9TIKxK7wgPxQTHTHkFv
         CQZDbbXfpbxD1ndmwuFpIf6ELesrOp2c8wEJHf5F5wOK9RkzBrb2vHCKElKeuWWfimuX
         BowA==
X-Forwarded-Encrypted: i=1; AJvYcCXXp0BJfneelsOk7qAhHm5UigQMVRETb66q3tiabbQfX1KkAD+/4aEAjfqxiC+rKZwEfSm44OMrmQgKv3D6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3tKaYGU+EnlchoVz9y4joOaLXBWEi8N8queCHc5b0vmZ8HeRm
	CAJmTBcipbTjTSJyK8S0eCbGOKbwzscRavm1lm00ENIud1J8E14kKwMX8yygp7JOq+bP7lfol/O
	LB8kLdOyqnD4VJr8LHSKFZrsPFWc=
X-Gm-Gg: ASbGncuTOVwcVE/ldF2TjcnpfB95MIEQS1yrx/ilVJOooyV4giOay7BwPoEPNeEBM/C
	bbrK1FK0BuYiFzJp7/1m9yEtnLFBH7txRPL+olRIQjXeD1ZywbqslJpyW2QKfIz9ndZeQZ9MgDx
	UTu6llkM6yuiPQIQHAEVy8kCK4XSu7ZWxj
X-Google-Smtp-Source: AGHT+IHCF26b+zulic5rhSYeqs7QCLAx45yU/AwNqTgx0Fllk4U6rQpYbK4DSmOadRNYYyHeUFYkuRkJA3JNswqsWuY=
X-Received: by 2002:a17:906:ef0e:b0:ace:f07b:1c04 with SMTP id
 a640c23a62f3a-ad1a49750bcmr952524766b.27.1746523126977; Tue, 06 May 2025
 02:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOYeF9V_FM+0iZcsvi22XvHJuXLXP6wUYPwRYfwVFThajww9YA@mail.gmail.com>
 <ec87f7f4-5c12-4e71-952c-861f67dc4603@bsbernd.com> <CAC1kPDM2gm_Lsg-0KqDm9R3b_TV_JDX1RL9iqD_mJzgLdG+Bzw@mail.gmail.com>
 <CAOQ4uxitswS2Fmz3mGzxj27uOP8JvUqpVbwn-dNyOiE-UC5qVg@mail.gmail.com>
In-Reply-To: <CAOQ4uxitswS2Fmz3mGzxj27uOP8JvUqpVbwn-dNyOiE-UC5qVg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 May 2025 11:18:35 +0200
X-Gm-Features: ATxdqUGDsRHGhr6dsT-QpFSG4MTji2XPYd3FT514Z8BYUZRec6zqfKV_od7EXbI
Message-ID: <CAOQ4uxi6-Z1JKFVS_gcM4gNCRSKr+kOymvZOzGVE+zfGU3+Sqg@mail.gmail.com>
Subject: Re: CAP_SYS_ADMIN restriction for passthrough fds (fuse)
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Allison Karlitskaya <lis@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC Miklos

On Tue, May 6, 2025 at 11:18=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, May 6, 2025 at 4:48=E2=80=AFAM Chen Linxuan <chenlinxuan@uniontec=
h.com> wrote:
> >
> > On Fri, May 2, 2025 at 9:22=E2=80=AFPM Bernd Schubert <bernd@bsbernd.co=
m> wrote:
> >
> > > I think it would be good to document all these details somewhere,
> > > really hard to follow all of it.
> >
> > I agree with you but where should we document these details?
>
> Documentation/filesystems/fuse-passthrough.rst would be a good place.
>
> At the time, Miklos had an idea to spawn a kernel thread and install
> those fds in this threads fd table, so that lsof will see them out of the=
 box
> without having to adapt lsof to learn about new fuse connection files.
>
> But IMO, as long as we have a way to expose those files it is fine.
> having old lsof display them is only nice to have.
>
> Thanks,
> Amir.

