Return-Path: <linux-fsdevel+bounces-68467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 937B3C5C993
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 11:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB20F35EDC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17123101C2;
	Fri, 14 Nov 2025 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSvW3jSC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8A730F53B
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763115979; cv=none; b=G+EfquHr6xcBcf101nY708vWXPgFSWv9XYqyCBULPgQSxwcIPPjGF5jGjG2WrtxNYmdqHAWVjwkavFXcPj32/lGZer6pS3bewpJjKpgaL1RSrU7EXF+v/Ve0bp8LfvxDcRgXGu5Euf+VE4+nb3HM55041lLlpYfYUHDkW7ILdt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763115979; c=relaxed/simple;
	bh=Fe4+q7Knka7qKfvvXEjqGoG4VtSNdAANJNsKClnoq1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEkT6q8csMAmiqo7A8wy2AJBG0dTmsRNEncLd6VsRTUyEWYVc442Xf5VUhTTdURoJDbP7hoLk6f1sGjgtgSmCjICXFKGaWuRoQf4aHlF0BB/HfWBQOfvc5t2kWPw0chA0jBfubsVTmGYduvRxD3gHywOfiXLK3ZkIhR2DNLgS7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSvW3jSC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso2903889a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 02:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763115975; x=1763720775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M919p6rjN1bXEXYx263WtyltECG5QWhuVC76Ko6AMW0=;
        b=iSvW3jSCX5EB/zx2pgMldifzWl2HIuFlO3c8l3EplHqabysO7w/PXjA3KEqJI0B84X
         Cj8I3waPl6GPF501G5UujWWpIed0izNN+Z/aAOoJaMvk6PxiOEbuQHPqReHaiNLd5Fxz
         +hoxYm+U4+0bxnW3wReMvnh/HjEF19OLGy7tvEH51TMML3vmXwMS8z0UqDShHUoj3eSu
         NX/Jdg+rOmIrhpBkAebWtv9NteFjFfYupuRzK2Z9cYkvRjYAYAc72qicEUiRh4XTWhju
         C/gPPgR0AQNf98ilmCmtUmzvuqLu8sqAl+uQj7HnwxD5SIFX+m13mLXY6rDLFRCstIIX
         zolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763115975; x=1763720775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M919p6rjN1bXEXYx263WtyltECG5QWhuVC76Ko6AMW0=;
        b=xTRS5bAQTq51hOsVr4iq64P9GpeRZZA1tfbdZfF2mjjG6wWWRzUB2NA4+9e5RUIUAp
         3hM7lMzvsxAtbTpEKlt+FH6eltTx+pgzx53OZgmxsxvfDyjfv9QpfAOTv+uoYDe2c05a
         01uqJChE6POCTpCMPMlxghFtQWbAVzbLNTcik0+Hg1cquFjYvlYBqLzd04j8FA5wru5Y
         SHx5OxJyfchtB35JPNtBKd2/6AxrRAYn4UDWPJ2rlqS7b+uT86ukPglzf8qDEfiBQnzS
         XvbF633JDZaQd6d6RBeQ2e781bmrQhFKNSYGhVQAuTI5m2GDHnlIjJQsbw95VL+XscNj
         +ESw==
X-Forwarded-Encrypted: i=1; AJvYcCW43rVJaANw9jtXlFFGWBBk0xnjOh+FbEoaLk0BknLnu9+LmtvzEzLh1qwW2BIHLilnUEIvOtl9NGe7sNE0@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ5moANTb2SgmXy2TfCPTJ47wvlynrJ1D9OnovMFF1cEN8hxST
	+DzKaTvIAg6yjcz884wsRElYA2zVB1YBZ/67A20xkMWIfnTJP0wKYnd7A9cDjJp0201EilsCgAH
	EC7Ab8DcptT20j1cgYcfmGkymkW8aMF0=
X-Gm-Gg: ASbGncvflZhPNGWhkxmsvOdeJB8xpLfISw8ugTxcEgxZ5A5ijFviu5O5maiTXzYBib2
	AOWrUlrdlYd3LZDzJVwNQ6iARNJpEl1GcCyCw0j+/pdIprJ58nGoMWqFdQuEPtBUdw2+zoLu71u
	jValW5iXOpCEZs4IVyG85veeIOR3MbhuWTHMcU5ryfrHUJ8q+ZunBIbxHeae3fiFaW0au6Q7Ybr
	cv8CGRmFq2WoOunsM4ONoc+FdUpXuY9KuVdmi5R3zABk+0ugeybCBpEHpoG130WMgZpWRPVC2Ef
	qDHO3Fidi7E2w504p3rvF/q5fOCJSQ==
X-Google-Smtp-Source: AGHT+IGKzjAO62p4FpClkQVUrTJgfe9FWmS9MtXp+ACmaG/NRCZxmD36YniOU7rsJoBBK8HqMG4KYCjTGn02zOC8Mpo=
X-Received: by 2002:a05:6402:268f:b0:641:1f22:fc68 with SMTP id
 4fb4d7f45d1cf-64350e8d3b5mr2096910a12.24.1763115974563; Fri, 14 Nov 2025
 02:26:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
 <20251113-work-ovl-cred-guard-v3-33-b35ec983efc1@kernel.org> <CAOQ4uxjeZC0V_jWA=8u+vTw0FDWehdu8Owz8qzO8bTqYVb6A_w@mail.gmail.com>
In-Reply-To: <CAOQ4uxjeZC0V_jWA=8u+vTw0FDWehdu8Owz8qzO8bTqYVb6A_w@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 14 Nov 2025 11:26:02 +0100
X-Gm-Features: AWmQ_bl4vISBLfcA735JdkvKtTxS1m2H3GC_9ANj87Q-c70ejASkdAO3pAawhQ0
Message-ID: <CAOQ4uxi05JPptYgXXzLN_C4LAOWyriZGvJdrWydzjBv-q_aGFg@mail.gmail.com>
Subject: Re: [PATCH v3 33/42] ovl: introduce struct ovl_renamedata
To: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 10:04=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Thu, Nov 13, 2025 at 10:33=E2=80=AFPM Christian Brauner <brauner@kerne=
l.org> wrote:
> >
> > Add a struct ovl_renamedata to group rename-related state that was
> > previously stored in local variables. Embedd struct renamedata directly
> > aligning with the vfs.
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/overlayfs/dir.c | 123 +++++++++++++++++++++++++++++----------------=
--------
> >  1 file changed, 68 insertions(+), 55 deletions(-)
> >
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 86b72bf87833..052929b9b99d 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -1090,6 +1090,15 @@ static int ovl_set_redirect(struct dentry *dentr=
y, bool samedir)
> >         return err;
> >  }
> >
> > +struct ovl_renamedata {
> > +       struct renamedata;
> > +       struct dentry *opaquedir;
> > +       struct dentry *olddentry;
> > +       struct dentry *newdentry;
> > +       bool cleanup_whiteout;
> > +       bool overwrite;
> > +};
> > +
>
> It's very clever to use fms extensions here
> However, considering the fact that Neil's patch
> https://lore.kernel.org/linux-fsdevel/20251113002050.676694-11-neilb@ownm=
ail.net/
> creates and uses ovl_do_rename_rd(), it might be better to use separate
> struct renamedata *rd, ovl_rename_ctx *ctx
> unless fms extensions have a way to refer to the embedded struct?
>

Doh, I really got confused.
The dentries in ovl_renamedata are ovl dentries and the entries in
renamedata passed to ovl_do_rename_rd() are real dentries.
So forget what I said.

Thanks,
Amir.

