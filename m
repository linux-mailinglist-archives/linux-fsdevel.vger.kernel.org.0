Return-Path: <linux-fsdevel+bounces-68488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDC7C5D396
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 14:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0ED324E1145
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 13:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6892EB874;
	Fri, 14 Nov 2025 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1uJIFYg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D692472A2
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763125309; cv=none; b=egG1Bui9T+reIzc1OXlsVd8YJowAeFKx+mVE/CARW/QUBsnmYY3CN28SIGnIqAFHcPsEmG26tUtS087Ha+d6dwN54lSoF1EYxE+3ipTuJNWrukf7lLkj69ksPtZ4bNCxeDxJBvxc3EeNrK2Ne2u5hybJME97JO1AdAAaaFP/KpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763125309; c=relaxed/simple;
	bh=HpAgGgaEFn90GAP+61OaPTHjskGHvMWPVJKnFRe5/SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujeMcDjoMtDKtMY8uquHMrZSWpVGORl266rCrMkUx/qQxRKJ3afNvnnVmx6YH2LMYllXXtwBwjstohNXgP7U5Y7o4H70uq3IV4jk6BHTZOFkRMCYkcwhx/esrESt0dPHKTuuJDOyaUGQUrw58/Q8VhCHgDNWuTSG0TuNI+wsQmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1uJIFYg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4775ae77516so21755285e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 05:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763125306; x=1763730106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrJ7wpuffsUOhxttMGNEH1UpdA6aqm646ujYOAqkR8Q=;
        b=O1uJIFYgf/y6lfrRpBXdOjWUq4jTOxTW6QXaNsDmSPJzPUxgLDB8DGdqYTYHg2plzw
         6TbrvO8NNOa2OizD6zFMDXdM9ieZKmf5Dum9EwDrUDc1+JGfZ7snMwKv2TDjN6WhTEox
         nS34KcYkEUEKYUZ4DAh1WCQEwxFwBcVfH0xzvd3OmRBjS0GMi1Uc+0aFXMiBkvLdBahR
         pNATAh/aacX2tacq2MYxUW63yy92vkSYNhkWMvxfg3BDueig0orDMqPJp//Pmyg35RP3
         tDBZP/cUfUhYWsB1rY/7wGYukUKk5iSn8MG53Uyc9n+d9dH732Ow/KuI7TDDPfTAsFb+
         VuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763125306; x=1763730106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WrJ7wpuffsUOhxttMGNEH1UpdA6aqm646ujYOAqkR8Q=;
        b=rM3bjEchmNuFjqa0FAunBjZG+O/fr0PMn2rX6HoO7FhElTbEPjyAUQ5Ke6z/b7Q5C2
         nx7WuLxLtpBzurNjO4KG3lTECiJu+PE5KQ+ZsSOOjLhn1AJrGPZMq31P0dK1qAE1DM3J
         TI5eOsQLT4MjBxj5rKo4bLW2xTZtdt8/mZYnVnkqx0q6eY0xzUrNR0RapgPlyaObVOXN
         JbIb1IA/mCEGI6MkcwDdaLSK6PRJnqyPJeZTxbM9V0brC9GTgROH1zUiqpdnn0n+Jdx+
         NATy6bwSENLbrd+mGzZL5PB0s0GVe3wNQ1eZo649g52fVIBLjGNKocyIjtQiY7o2HiV2
         FD4A==
X-Forwarded-Encrypted: i=1; AJvYcCVE00iSGtmqCeAEdWg33+C4g/05/y+hneEZ4rUa6IcPA3ACExayPRx20eWNTrr5Km/yV/vOlTpw7ENmJmMI@vger.kernel.org
X-Gm-Message-State: AOJu0YyoqWemVkkS49iKZc73+amXeMenDjZYyVtUXtjcvNUSNpgY68cu
	HJdWfFHTLM13VIJE6fRFcRwtEPT9OBfVHZrbol9m2YIM4jG7KKFZQUze3RAnQkFNzo+yZ/r2rq+
	RtUFFR8OBdIKxAhW9kpVbaLMJ0dcjhy8=
X-Gm-Gg: ASbGnctyoQaBp+YkvLaFDIDJYPF5+PXMNn/Cur7AcIzks7Lbh0tvP/8fhS1MuPODX7F
	qaCfClSeEc4FcTDzsnIMy03AHctc2RvOA+Se3EbURaqNPVd2C0ymfMdNORx0aA2BqsCqP1z/G5t
	9GxCblMaabnNvnggJmElvEw48BwWqyFvkWP+tXMnoteQsKBb4no8cLgifvGAJY/GYpUnILnVE9c
	vBzozsk2MwgGGCkK/w+qsv6GigprfTpMDWwcftytaCsFBApMkNsOxR2IS22gyKGahiL5bmF5gch
	At9+rpsu1tQiZ5QYVWI=
X-Google-Smtp-Source: AGHT+IHDM8QKUyFSrd+0zQEKPdCoF3WxF1zjcOTRuW4aKiXzh3MUt7l88tj/0/w7OQqiDd1Hj2Wm7NhMaFNyqPhLxJ4=
X-Received: by 2002:a05:600c:1f12:b0:45d:5c71:769a with SMTP id
 5b1f17b1804b1-4778fe9aedcmr26119325e9.26.1763125305993; Fri, 14 Nov 2025
 05:01:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
 <20251113-work-ovl-cred-guard-v3-33-b35ec983efc1@kernel.org>
 <CAOQ4uxjeZC0V_jWA=8u+vTw0FDWehdu8Owz8qzO8bTqYVb6A_w@mail.gmail.com> <CAOQ4uxi05JPptYgXXzLN_C4LAOWyriZGvJdrWydzjBv-q_aGFg@mail.gmail.com>
In-Reply-To: <CAOQ4uxi05JPptYgXXzLN_C4LAOWyriZGvJdrWydzjBv-q_aGFg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 14 Nov 2025 14:01:34 +0100
X-Gm-Features: AWmQ_bknCoTAmCyGwxVzXTxM2Q2Ddou5vVmeK1m50HLLQqaH7FXQMQ0KGc9mHeM
Message-ID: <CAOQ4uxhcVRQvT7pbtmEVBpjYSBwr8zCo5Rao5p2hwS=OFHHttQ@mail.gmail.com>
Subject: Re: [PATCH v3 33/42] ovl: introduce struct ovl_renamedata
To: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 11:26=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Fri, Nov 14, 2025 at 10:04=E2=80=AFAM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> >
> > On Thu, Nov 13, 2025 at 10:33=E2=80=AFPM Christian Brauner <brauner@ker=
nel.org> wrote:
> > >
> > > Add a struct ovl_renamedata to group rename-related state that was
> > > previously stored in local variables. Embedd struct renamedata direct=
ly
> > > aligning with the vfs.
> > >
> > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > >  fs/overlayfs/dir.c | 123 +++++++++++++++++++++++++++++--------------=
----------
> > >  1 file changed, 68 insertions(+), 55 deletions(-)
> > >
> > > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > > index 86b72bf87833..052929b9b99d 100644
> > > --- a/fs/overlayfs/dir.c
> > > +++ b/fs/overlayfs/dir.c
> > > @@ -1090,6 +1090,15 @@ static int ovl_set_redirect(struct dentry *den=
try, bool samedir)
> > >         return err;
> > >  }
> > >
> > > +struct ovl_renamedata {
> > > +       struct renamedata;
> > > +       struct dentry *opaquedir;
> > > +       struct dentry *olddentry;
> > > +       struct dentry *newdentry;
> > > +       bool cleanup_whiteout;
> > > +       bool overwrite;
> > > +};
> > > +
> >
> > It's very clever to use fms extensions here
> > However, considering the fact that Neil's patch
> > https://lore.kernel.org/linux-fsdevel/20251113002050.676694-11-neilb@ow=
nmail.net/
> > creates and uses ovl_do_rename_rd(), it might be better to use separate
> > struct renamedata *rd, ovl_rename_ctx *ctx
> > unless fms extensions have a way to refer to the embedded struct?
> >
>
> Doh, I really got confused.
> The dentries in ovl_renamedata are ovl dentries and the entries in
> renamedata passed to ovl_do_rename_rd() are real dentries.
> So forget what I said.

To help with mine (and others) confusion I think it would be better to
be explicit about upper vs. plain dentry in ovl functions where
both types exist. It's one of the easiest things to get wrong in ovl code:

struct ovl_renamedata {
       struct renamedata;
       struct dentry *opaquedir;
       struct dentry *old_upper;
       struct dentry *new_upper;
       bool cleanup_whiteout;
       bool overwrite;
};

IMO ovl_rename() was not doing a good job with 'old' vs. 'olddentry',
so for the conversion to ovl_renamedata, we should fix this misnomer.

Thanks,
Amir.

