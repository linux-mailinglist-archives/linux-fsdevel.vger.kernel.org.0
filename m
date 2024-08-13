Return-Path: <linux-fsdevel+bounces-25784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B07695055B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 14:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1B41F257A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 12:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE1E19ADAC;
	Tue, 13 Aug 2024 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/ZvaCMa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C178619939D
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552948; cv=none; b=CGMBCsUvxXmBmoevzR2bbKuiiNiThLcpVHRQdVpNI3otLsRuG55qfhFVfowwMrWZgBYhehxOFl2QeVGZ2F49RqIvXvJZp3Wgfw28fSNDmiUTE0cWwzY83lwu2gITFO/PDxT1ZWeKabQplvWRMSdX/goUeQf/vNArCJ3RsHWjqNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552948; c=relaxed/simple;
	bh=AIwO96pSJ/25VH6HJmA34Pj8uOFFxT6vpTHLm9i80mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZO78dtB4swx+Iqox6riwawK2BXQfRh/oWMF+uPopSTeXRszhnSrtqMTo84I+I4fw1D7gHFWkt/6VCZpeCPq58B5uiItnqUy7T+zjtfvxwe7v3jeTUqacO14eaTfUJpUqmH7eRTjktNYxgKP8+tQ/JIcB8VR99GyH5J0zWEdb4uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/ZvaCMa; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f15e48f35bso53734361fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 05:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723552944; x=1724157744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShXRfQGaEc9OjMlSRM2SvbWcRzbcKZmlOeX3g4xS8Qk=;
        b=W/ZvaCMaUlr7g7Pxw4gRpc2BHQXTn4FQFQ1Iq2NwyfeA3eIcZEVjCVO/bsmxkm9f2h
         s84mNUMGfto0fe66B4cwg+jN1eZebAnn9LMIv2W+lYMsi2Vi5/yaC9JfPvz/jFZ8UNGk
         Tie70vmgmGqj+fDP7WpEqK/M2mc79XWjK3umD1oqyc8HNoZ/KURXkiEC+9/dNTm6oqn4
         k9oCDjwMGJUQzXhFzdgtG4La29reMAPB1O+Dtszk2bJgU5f3xDfICjN93pHPoj4yY5Er
         gyc5Ipw5gK17OWzptuYyJs6eYobjUVhWACTdOaLARIpnS9yHEwP29mWhQQ4qAaKLPIqV
         1TsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723552944; x=1724157744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShXRfQGaEc9OjMlSRM2SvbWcRzbcKZmlOeX3g4xS8Qk=;
        b=AeIhniXxrP5Md3QuIO6TzKH+6mS20XAlX4QaoPc2Mt0RNDb+Zm2KWCbKWI4SH5YV4Y
         dCVbA0ggeYIWPKtITH0JaOpf9YZLc7D3RSh6wfY+6RpxARqMTzbrvUlZ7eGJ7757I6vj
         7fLaNpl73MuDEGS4FD5uzJ0N3K2X6QRo7ZIuzCLPwA0ye9WP1U6Y4XdZ4ApLO7iuFbPc
         F70SBgTPRpWsbmFx6bk2JHZdjCwQv0ArXuEE7sx01P3PsmOWA3qg43yAFtXd+Sp2Vjbc
         pOpBka+CjJbuAOCBVlvQuWZTC3mhwezhLf5+/6IaBIY0JATfztssApRcgbpEINNLwbhl
         ERhw==
X-Gm-Message-State: AOJu0YwBuYRL6QecAg0zqF+kcWW/+83NFNBReVbJmLeO5qn7LFHyZ4CA
	W5m5WvhfZIIU8TGUlp2T1lJEpdCtqF6ZjuCHMO3mbT8yBd3ZQ217OLfBjaCO4tAEPivPiGQ/dUl
	nWT1SOL0VacWOOG/2AscIB4jONJq9MfFi
X-Google-Smtp-Source: AGHT+IHvnH01bo3hnrjM64nViBYxriV/hhY9Xb5rmroOBPy1SsSwMitADnpfJNe0/GmxtOIgOWsLlQzvsReu2LHN31U=
X-Received: by 2002:a05:6512:1387:b0:52f:c3c9:1691 with SMTP id
 2adb3069b0e04-5321365d182mr2183438e87.32.1723552943418; Tue, 13 Aug 2024
 05:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813-work-f_owner-v2-1-4e9343a79f9f@kernel.org>
In-Reply-To: <20240813-work-f_owner-v2-1-4e9343a79f9f@kernel.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 13 Aug 2024 14:42:11 +0200
Message-ID: <CAGudoHEdUfP8MJFLK6Pt6tnrGqQqKfi1sSa0G05W=7yyJoBPiA@mail.gmail.com>
Subject: Re: [PATCH v2] file: reclaim 24 bytes from f_owner
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 2:31=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> -int send_sigurg(struct fown_struct *fown)
> +int send_sigurg(struct file *file)
>  {
> +       struct fown_struct *fown;
>         struct task_struct *p;
>         enum pid_type type;
>         struct pid *pid;
>         unsigned long flags;
>         int ret =3D 0;
>
> +       fown =3D file_f_owner(file);
> +       if (fown)
> +               return 0;
> +

if (!fown) ?

>         read_lock_irqsave(&fown->lock, flags);
>
>         type =3D fown->pid_type;
> @@ -1027,13 +1109,16 @@ static void kill_fasync_rcu(struct fasync_struct =
*fa, int sig, int band)



--=20
Mateusz Guzik <mjguzik gmail.com>

