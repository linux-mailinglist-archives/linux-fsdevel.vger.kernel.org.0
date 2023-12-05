Return-Path: <linux-fsdevel+bounces-4912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A344F806384
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 01:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A1C1F214A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 00:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89F21108
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 00:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzUuzTyX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2822B3FE49;
	Tue,  5 Dec 2023 22:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AF0C433C7;
	Tue,  5 Dec 2023 22:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701816615;
	bh=5x+DUlQVMX4rI7C/lbZIjEUnEMm9TF3RtDPL84aa0IY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qzUuzTyXqMMGkKhJrn0avRKUlTtuVRfv/LG3aS+yYIyilDbFJlKiPBV4QT/OhAyvB
	 REmuJ97m0Ki7HhmIxYX3L0D26m+YeruHvP8BYlXfZ/dLY8ucBjEP9+vKTPwP2J16xT
	 KJpUroGmXr/ssEPipGeyjd5M1TGe8ld645GkOxgYCpbF+igL01H3sKvrGZ1aUpweC0
	 AiGMUlNIrvmDafNTG/4O/n/dCNabro47BUi6/sMduEXxnnqyGfbIK98p9vzNHWBSiE
	 4p+AHuLGe3tttS3KUX7Uhu+5fAh1zA6Af0RHboehlcZ6Ei3k14EB1vKs92lYRSGUX+
	 vHBVzdrjsfZ8w==
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40b2ddab817so64358935e9.3;
        Tue, 05 Dec 2023 14:50:15 -0800 (PST)
X-Gm-Message-State: AOJu0YyrjV7ARNHYi6uLmFHCb+25xQIkJBRIdgTKuUF3uH0lwyuGqtEO
	jNTQYL7/YdDrM+YyW4T225zRVA9f1OANIaZIJJs=
X-Google-Smtp-Source: AGHT+IGYT2ppXKePS26ax/2UBvv5gM94PgtHGfQeEYRZVI9vMWhldLMI2tj8QziTQ3Nn5fTMlBxU2W7RMAXv7ppzCbE=
X-Received: by 2002:a05:600c:3093:b0:40b:5e59:da99 with SMTP id
 g19-20020a05600c309300b0040b5e59da99mr21446wmn.172.1701816614079; Tue, 05 Dec
 2023 14:50:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231204-const-sysctl-v2-13-7a5060b11447@weissschuh.net> <ZW+lQqOSYFfeh8z2@bombadil.infradead.org>
 <4a93cdb4-031c-4f77-8697-ce7fb42afa4a@t-8ch.de>
In-Reply-To: <4a93cdb4-031c-4f77-8697-ce7fb42afa4a@t-8ch.de>
From: Luis Chamberlain <mcgrof@kernel.org>
Date: Tue, 5 Dec 2023 14:50:01 -0800
X-Gmail-Original-Message-ID: <CAB=NE6UCP05MgHF85TK+t2yvbOoaW_8Yu6QEyaYMdJcGayVjFQ@mail.gmail.com>
Message-ID: <CAB=NE6UCP05MgHF85TK+t2yvbOoaW_8Yu6QEyaYMdJcGayVjFQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] sysctl: move sysctl type to ctl_table_header
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Iurii Zaikin <yzaikin@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Joel Granados <j.granados@samsung.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 2:41=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisssc=
huh.net> wrote:
>
> On 2023-12-05 14:33:38-0800, Luis Chamberlain wrote:
> > On Mon, Dec 04, 2023 at 08:52:26AM +0100, Thomas Wei=C3=9Fschuh wrote:
> > > @@ -231,7 +231,8 @@ static int insert_header(struct ctl_dir *dir, str=
uct ctl_table_header *header)
> > >             return -EROFS;
> > >
> > >     /* Am I creating a permanently empty directory? */
> > > -   if (sysctl_is_perm_empty_ctl_header(header)) {
> > > +   if (header->ctl_table =3D=3D sysctl_mount_point ||
> > > +       sysctl_is_perm_empty_ctl_header(header)) {
> > >             if (!RB_EMPTY_ROOT(&dir->root))
> > >                     return -EINVAL;
> > >             sysctl_set_perm_empty_ctl_header(dir_h);
> >
> > While you're at it.
>
> This hunk is completely gone in v3/the code that you merged.

It is worse in that it is not obvious:

+       if (table =3D=3D sysctl_mount_point)
+               sysctl_set_perm_empty_ctl_header(head);

> Which kind of unsafety do you envision here?

Making the code obvious during patch review hy this is needed /
special, and if we special case this, why not remove enum, and make it
specific to only that one table. The catch is that it is not
immediately obvious that we actually call
sysctl_set_perm_empty_ctl_header() in other places, and it begs the
question if this can be cleaned up somehow.

  Luis

