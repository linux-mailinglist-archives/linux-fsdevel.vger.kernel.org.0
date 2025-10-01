Return-Path: <linux-fsdevel+bounces-63189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E57BB0B27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 16:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B761C5578
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 14:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791742BEFF9;
	Wed,  1 Oct 2025 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnWtCV45"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7942253EB
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759328911; cv=none; b=TRW+vOqah11mu4/VunwfRxjoG7j8DVpTCCFLLMYSj3U7SwWXuXZDXf+9IInXMwXrEbriZhzHARrvwKCOr2YT2rieIjj1EKCROFx/l41iUF0yYUIOyAJVlPCjNDgqNCfP5M0lL/BHAgKj3Vhp4OX206KG/wVjeYXKZ4wfcjSVdAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759328911; c=relaxed/simple;
	bh=GbvR03dxXETujTTMYAeyEO4LzE9c9HuXvowi1p4nKyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O50KR+/y+DoI8h0fzYRP6NHBbCnsAgnOvIK50nTwXuUOHd5X4tnjxrT9KWsWfT9KFzd4RI2guTZu2QNKkOMY0SgNDMBPeZvU6yxVuO+9wpooE8etxFRm8ssiQhP7O4w39s+3/jpnfXrr0en88d83hhZmxieHhCnWufVuLRDmTgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnWtCV45; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63163a6556bso2226220a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Oct 2025 07:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759328908; x=1759933708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/WXZxUw7oHyyOQg8NfrAdp+ICRxshn3JIQTTWtfAqg=;
        b=NnWtCV4564GxHSD4bhNeBPC893cn03b8hx2eeftoYFxu79KsK6vMf260Vrd9iaKzzJ
         /Rc491TZDNl+7q1/kT+boqCfwtFRSFOmm5s7HRcS/yT7CNR6iJ/Bd8Aqh0kHahJ90Whp
         Cpz6RD0irfC2jVvc1dXXBxKoUshQHa/mj4GobAGe9NRH1ftT+fUaTKzvAhgfeHAQJfxA
         h0blax623loSsUACIlm8z88KYiarZZmKmZt0WKZNADJ2vLW02BKXKXOMsfr0v+MZGfgO
         hSyKcUH7vf5lYMUhFWKKpISSMG82C33JJFDPkUVopwN1LyqAn73VK2SSUOdXxWjcKTpC
         UWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759328908; x=1759933708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/WXZxUw7oHyyOQg8NfrAdp+ICRxshn3JIQTTWtfAqg=;
        b=p2OkcJdufScG8sYWbfmZmYA6yTBti/RLiJCha1MbaycOh9Obs3zQUQ6WuJuy5ZoMhP
         1qQXya4sa3+lDu3IsZInX1yyfZq8Sd3qP+yJ/uV8vblsuAWQOPUxElCCga6DiZXf5S9S
         7t96UV+KpYIqG0mr3sAD11FFLLOgAkmeLky7iyCz66OcndkNLA1bt30iHysE5W111ejX
         iLCEnvT0wFHqruiY292M5t4o5Y9L9U0T0+ipvoWUPpgEouUEMJJOgX2EK1ColtnqIHPs
         aCqk3ArHM0o78csW02uinPoKDKgyTnfSQ87ADsN3KfAXkdnt/huCEwgQ0CxBEgDgCbdn
         Lm2A==
X-Forwarded-Encrypted: i=1; AJvYcCV5dO3wk/IgBApdqzYpSIEC3UmKXXc87C1DNL6RrHCHsZDFDmt7WiCBGV7nFmbgxogwA7JESUGDnOvE3eTy@vger.kernel.org
X-Gm-Message-State: AOJu0YxvraRbFgjDhUmmu5hj696RBv5n6iUxGush+ANCCDEoUHo0NKOo
	Zci0CuJhA2rf00QLW7fq/T1Ky/UKfbEwkg3MAldf19Y5DYI/VxrsLDCYO1lv26GptZIcYp7EWSx
	CgJvIJ5Lr2mUxLQTCjWu1P3IIlvAmleY=
X-Gm-Gg: ASbGncvCDP67vPCJZsvoyUDxpLNJbwc5eK2E/X60rEYrYkjErlVBfGQ4+v3qg+hWm9B
	Otlq4POs7J31XA7t8yhtcINxaZ+s8NhPImJuCp6oF4RsYBg03U8U0tYjaYg6Du+iGEMudIyiFwt
	NqAZk0tpYcjhcxc6La27tVtIjgdhB9Y0Yf4LlBFiPu0RUwI42ZiLJ46vwWiOrDfqgIdA74RWPCC
	pd0nzc12v1j4mT0eKNHRH+sW03oUHqNr2moBUhM1qwfhvf0a2RKVoi4zVSxsXH/Ow==
X-Google-Smtp-Source: AGHT+IFq01GvQ7V/roDstIdITtS1FOfvHlX1CJiRzI+PFE++QOPBlUqdMnJR34IbYO8qBIvS8/YN4fRt9HSq8uVd530=
X-Received: by 2002:a17:907:1c27:b0:b04:6546:345a with SMTP id
 a640c23a62f3a-b46ea414afamr473078766b.52.1759328908103; Wed, 01 Oct 2025
 07:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001010010.9967-1-mjguzik@gmail.com> <zvd5obgxrkbqeifnuvvvhhjeh7t4cveziipwoii3hjaztxytpa@qlcxp4l2r5jg>
 <CAGudoHHZL0g9=eRqjUOS2sez8Mew7r1TRWaR+uX-7YuYomd3WA@mail.gmail.com> <7ck3szsab4zb3uzgh6aub5kmvm2slold5la2oyi264klwjel36@crjlqzwdmrgh>
In-Reply-To: <7ck3szsab4zb3uzgh6aub5kmvm2slold5la2oyi264klwjel36@crjlqzwdmrgh>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 1 Oct 2025 16:28:15 +0200
X-Gm-Features: AS18NWC1p8ZeqS1QFssgX9aALc1_ZmNcgJPJSm6GufAV4Iachp7Xflo0_OGuOhk
Message-ID: <CAGudoHFAar2rHaCDWP4uD2QD_BO42-Fi6b9uxwFvHTmkXTCQfA@mail.gmail.com>
Subject: Re: [PATCH] fs: assert on ->i_count in iput_final()
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 3:08=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 01-10-25 14:12:13, Mateusz Guzik wrote:
> > On Wed, Oct 1, 2025 at 2:07=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > > diff --git a/fs/inode.c b/fs/inode.c
> > > > index ec9339024ac3..fa82cb810af4 100644
> > > > --- a/fs/inode.c
> > > > +++ b/fs/inode.c
> > > > @@ -1879,6 +1879,7 @@ static void iput_final(struct inode *inode)
> > > >       int drop;
> > > >
> > > >       WARN_ON(inode->i_state & I_NEW);
> > > > +     VFS_BUG_ON_INODE(atomic_read(&inode->i_count) !=3D 0, inode);
> > >
> > > This seems pointless given when iput_final() is called...
> > >
> >
> > This and the other check explicitly "wrap" the ->drop_inode call.
>
> I understand but given iput() has just decremented i_count to 0 before
> calling iput_final() this beginning of the "wrap" looks pretty pointless =
to
> me.
>

To my understanding you are not NAKing the patch, are merely not
particularly fond of it. ;)

Given that these asserts don't show up in production kernels, the
layer should be moving towards always spelling out all assumptions at
the entry point. Worst case does not hurt in production anyway, best
case it will catch something.

For iput_final specifically, at the moment there is only one consumer
so this indeed may look overzealous.

But for the sake of argument suppose someone noticed that
dentry_unlink_inode() performs:
        spin_unlock(&inode->i_lock);
        if (!inode->i_nlink)
                fsnotify_inoderemove(inode);
        if (dentry->d_op && dentry->d_op->d_iput)
                dentry->d_op->d_iput(dentry, inode);
        else
                iput(inode);

... and that with some minor rototoiling the inode lock can survive
both fsnotify and custom d_iput in the common case. Should that
happen, iput_locked() could be added to shave off a lock trip in the
common case of whacking the inode. But then there is 2 consumers of
iput_final. etc.

