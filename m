Return-Path: <linux-fsdevel+bounces-25925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDC1951E4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 17:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7197DB286E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 15:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52271B3F30;
	Wed, 14 Aug 2024 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FNrYCG/S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB49D1B3751
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648429; cv=none; b=t2b4sn/WNTuvH94kzUFTeDX4r53pImQy7chnzkYH1fYo1KuTWBz8C38htWzPHhiVPL0+uy9yLJp4J7hAjeUuROaiWPBt6JynwXCDvp/EKpyUBqN3pZ31zpPCTGdzYcTOAbv9P4NKYw89DkbkHdWbfDytg+IYcDhZtP51ZBU2h/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648429; c=relaxed/simple;
	bh=xchCpsjRgDt+1FpeDwE9wT2UIuSmuIQeVcehD9QaCcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9Bvzsp31bSQ9txbRoe+nzuCqa0YW5H4DP1X2+HCkp0ASymMIaQeyUt+UYjdcEFOlq9CZYWIDHbVjCofuVyMVRxqivsu5SI1zyq6JSZJDo2t0DfGpmtn+GG3UV+kKTaGOjbo9OKP5m7lMp9bVyNXqlGTbTrIoYdTF0Eyqkk/PJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FNrYCG/S; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6694b50a937so485977b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 08:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723648427; x=1724253227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AX+IfIKOESuUiIvW3aOFuEwOA14R96wJZLKJZ4T5b4Q=;
        b=FNrYCG/SbHCqEIAMrOXjm4fl3iebzvr+l0CjMTZ0y+OoXSoUTR1d1t2BgoLeqGLc9a
         vS1yrnKXHQQN2970ZFIBkMdoF6QJArBKK8MaJn3gQaOkwFhaCgvLzo0Kv9POVfX6or2e
         AXl6/jYdNpWT8RhZhvI3CuXuaTUB19NUfj6knQ2H7IGjLu+CUE3u2Xba1dNQ+7hDkZy4
         +lTy67pb099nNgGgWrMXA3+R2tCzyjW2WZo43KUQdiAPRMOBLJVT+Yp3lK2+yR6E40Bk
         LDqK+hyObU6nfo8IfPxyVkQNtq14jm4BL/e4CSgvVGEcEsok19OdI5fyU+hXraUWHxXe
         HhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723648427; x=1724253227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AX+IfIKOESuUiIvW3aOFuEwOA14R96wJZLKJZ4T5b4Q=;
        b=i5YwUWrf/3EmliaM862hBZB8bPWkWUfLbGdzUfNafh9sFqE0hJrzNRa37BJLHJYxdd
         FZn6YoMKGxA1IYnAXId2rhwiwAHdJ+Ok8DcR/XUlA4ELgTl8vCAO1yCwec3Y5xWWJwRy
         WNZ+oartqdug3F0mr/6Ah5QlUK/32JV8TaqUuFwshZB5+sKuVyGCJWoUvXRMp2nhWN8b
         nd5+MIWMvmdX6hf91/0TJniraqpgBBRn45Z+HLZUirVxseixTu3xEVAJZ7k7UN77RxP3
         AjUDtgZQeftfJZoZ81rH6CcGVCShDcYf/qiEfdaLIjlb7N9himnY19tE6tgRXCJKRDJg
         Zi4A==
X-Forwarded-Encrypted: i=1; AJvYcCV+qgHgr0gtNDewgEMb5kAmK6kA1Hq1ca78DP5gmZApIbd6TM9p2BpP8LpqAUCuzWIvBnVj6+vxp9p9SDHSFC6zXiJVxECKMo8QfgJihg==
X-Gm-Message-State: AOJu0Yx3UHMghOKaSVPnEsdYQTAAZhw6/6PBHz2jentyy7zXp9IML/Vl
	3hbBDpH7OYYbrMl5o8BU/4jSTamgc9dKXY8GQSRinJ+G0gN4dzY8KQTfvSJ90HMTV/nU4xa1ODt
	x038T+cHnJLz3TQMNDUh7ym7nYfym1HEPZq+e
X-Google-Smtp-Source: AGHT+IFooUxqBZZcqOQKLdlMNlZ2peRqQY9osovnnhB7zHJX8yyywSseq/vOHjb+0XSGyozBIt2AJXkETwlIdZd8LCs=
X-Received: by 2002:a05:690c:2a88:b0:6ad:feb0:d027 with SMTP id
 00721157ae682-6adfeb0defcmr14160067b3.19.1723648426820; Wed, 14 Aug 2024
 08:13:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812174421.1636724-1-mic@digikod.net> <CAHC9VhRp5hMsmZ9jUok+5c20U37XLiXmoEAguorTqRF5MQq2Gg@mail.gmail.com>
 <20240813.la2Aiyico3lo@digikod.net> <CAHC9VhRrcTo4gXrexb=fqEGbNcynKUUoMWR=EseJ+oa0ZM-8qA@mail.gmail.com>
 <20240813.ideiNgoo1oob@digikod.net> <CAHC9VhR-jbQQpb6OZjtDyhmkq3gb5GLkt87tfUBQM84uG-q1bQ@mail.gmail.com>
 <20240814.OiNg5geethah@digikod.net>
In-Reply-To: <20240814.OiNg5geethah@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 14 Aug 2024 11:13:35 -0400
Message-ID: <CAHC9VhSC+Qff9gtQ9ZM7mCUPWFqiO23tb=4Er7eYAQTUFZRs6w@mail.gmail.com>
Subject: Re: [PATCH v2] fs,security: Fix file_set_fowner LSM hook inconsistencies
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Tahera Fahimi <fahimitahera@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 8:35=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Tue, Aug 13, 2024 at 07:39:45PM -0400, Paul Moore wrote:
> > On Tue, Aug 13, 2024 at 2:28=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > On Tue, Aug 13, 2024 at 11:04:13AM -0400, Paul Moore wrote:
> > > > On Tue, Aug 13, 2024 at 6:05=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > > On Mon, Aug 12, 2024 at 06:26:58PM -0400, Paul Moore wrote:
> > > > > > On Mon, Aug 12, 2024 at 1:44=E2=80=AFPM Micka=C3=ABl Sala=C3=BC=
n <mic@digikod.net> wrote:

...

> > > > > it guarantees
> > > > > that the VFS semantic is always visible to each LSMs thanks to th=
e use
> > > > > of the same f_owner.cred
> > > >
> > > > The existing hooks are designed to make sure that the F_SETOWN
> > > > operation is visible to the LSM.
> > >
> > > This should not change the F_SETOWN case.  Am I missing something?
> >
> > I don't know, you were talking about making sure the VFS semantics are
> > visible to the LSM and I was simply suggesting that the existing hooks
> > do that too.  To be honest, whatever point you are trying to make here
> > isn't very clear to me.
>
> The existing hooks does not reflect the VFS semantic because
> of the `if (force || !filp->f_owner.pid)` checks in f_modown().
> When f_modown() is explitly called from user space (F_SETOWN), force is
> true, but that is not the case for all call sites (e.g. TUN, TTY,
> dnotify).

Thanks for the clarification.  I believe moving the hook as discussed
should resolve this too.

--=20
paul-moore.com

