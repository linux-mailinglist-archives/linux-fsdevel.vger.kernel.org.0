Return-Path: <linux-fsdevel+bounces-68709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27537C63970
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 11:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4FA7C28B80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286BB328619;
	Mon, 17 Nov 2025 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqEtcWN2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1A0328B51
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 10:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763375932; cv=none; b=LEmJcj+PL/YZAbVvvApsmIeWU8iQOdRT/UkVG+9QomQXwfWJ8wL7OW3JlcrMhdaWHXA5JpI8pWRKqRc3q4DHDasaKSYMXAh3QV+u7kpZiULIkPuQq4d02743aQd33tu+Ln/3S+Ne51eA2F7ohy2ix+qfHaTKxdGrKf5QPHF75KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763375932; c=relaxed/simple;
	bh=A4OuYHNoNbmpT2j/hxsR/HSLdirQTZhZsI015gZWf1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKOSZ3jK+NLtTo21A3JpIiuzZGT+B+tBd7aLZnknzgzTam0TNwOVgRIdbw243tSAj7JP+GVkSRsw9gRnvifMc1VjbWHlWZm3aQonE1Xfxt3HpJUKVoFkxNfDZGFjQgmc2bPAVCUcjF6qydCQkcsoLsaIsesLYRnjLEP7xjN4ex0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqEtcWN2; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso2376495a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 02:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763375928; x=1763980728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qap2iRcMcJlDJP5mFPyDz+ljNy7HqlA5ophrRA9mpfE=;
        b=PqEtcWN2gMiSx7W1knC6NZG3sMg3hckJ8B9+HhTVq+jFG4T1E3iZhElpqfvnlvxXpE
         O3Qb6fkq9IJMPmKRAWKcd+ps/ZRtjk+NgjrPrPSbOHe9lmimCJw9WzH1CiolY0k4Io4V
         8lnoJih/Czr6EyY8ALekPSiIgK1f+zQyQZf6ByCadc/Lh2nWEmmUwJ34+vCCD27CIe6P
         ze6QsQJ1V6anvJNulD9dqN35e7x4Vqnk31R2YtSVrq7I/cgKyGoOAqkYJRTNcjQevXLD
         2UwCY1MonQbBZUaidEffPhNAmFmPE0Uu1ex+9HnGdAFmOzLTht/qzSuL9SIDXYX6M0te
         vCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763375928; x=1763980728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qap2iRcMcJlDJP5mFPyDz+ljNy7HqlA5ophrRA9mpfE=;
        b=CSFafezFHr5y6MxS9Vj3nc+L4kOGu9m2/qcqUtjDGcQaezgJGRTrLmIMcYv3UDTBvZ
         ZEayWY6L884v89bOh1An1GiIfTM5I4QjKQypMMx2BnZckDspbcUCTec3fgEQknSdq1ge
         ybrEht7YNjZAVRZj0LMjizfcNm3w6lDN/P4+B+SJKIYJxM9M+G90TCV8GUGoFeRAlb4S
         rIT1f9+3wOJKb41+mpW6IRK03tjh5+/7KIVznDLP3mGXj1yBbovn/97d3fYPX5ut0ACb
         t5AQgq+z/sgncnGkZh6ozWy5saU7SMZU+f5MTezllhl7yGOQQKPgXA3SMS4NCBxKlQoJ
         9lIg==
X-Forwarded-Encrypted: i=1; AJvYcCXKAq4n2jVqD2JzjDxiIwND5nzdot/jOMKpVRJjUhlyW5ZBQ9EXlU046tKiRcsJW4PnQZSBMUiZLVqMeSYu@vger.kernel.org
X-Gm-Message-State: AOJu0YwJWYCu5H3gLnLdaEGe3Jw55zMbE2R3O73nwQ7PFXQwEGpMxQzv
	Nq0OaIzcOvuakndZ/viHXbbJssEq1Iq2sfoBDvmVYBAMR/71n1WF68wgt0gQsQY++AzjiLDhJNF
	qrXSGWXpof3IxN+Chca4N0wgxsccPrxg1tajCUM0=
X-Gm-Gg: ASbGncs96yrZRJ1n1jSQuBQwnbQ3zX/Y5L5xPcVqUIMETLyEX9ZBfJThtErPmayvAgl
	4oiXOeA1TkIs7r4afvaTN6II9/RUxWnt3l2h28eY+ELityuttV4bfBwzSUp2ndO5RcJYwFNxdjX
	9mPH5xfI9Df7aMKx0j6z26MDTLyMH7tnKvsWYAJtQNMhSMojH1J4dAJkrfU6cb4dZ8B66hp70J9
	q0wiDawRLu8WxkulIcqFHSxoEOYxoLo/Jph0MSxoCTXmRHvVmzDpIjDToJ9Rz21zxWy9wrKMzAq
	A9wdmkmn10tnKTzBWA==
X-Google-Smtp-Source: AGHT+IFQBrieEzXt0BFp3NtQPrxoZm9Uol4G2t8bK38gMdj4cbpLL4aBaSCTVB54vvBgjrXba3gJvKXjhNbhaUad9hA=
X-Received: by 2002:a05:6402:4404:b0:643:4e9c:d165 with SMTP id
 4fb4d7f45d1cf-6434f81d559mr13217935a12.5.1763375928285; Mon, 17 Nov 2025
 02:38:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
 <20251117-work-ovl-cred-guard-v4-35-b31603935724@kernel.org> <CAHk-=whrCSbimz8jDhh+q8AJH2Ut9V3dgyLxVotn3WLCTyoN4g@mail.gmail.com>
In-Reply-To: <CAHk-=whrCSbimz8jDhh+q8AJH2Ut9V3dgyLxVotn3WLCTyoN4g@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 17 Nov 2025 11:38:36 +0100
X-Gm-Features: AWmQ_bmPS6llwzEBn2g7ry1ARvOA718wT0t_asNxjxv1iSyU-WgosyxIeDa1kRE
Message-ID: <CAOQ4uxhTUZWUjUakUGzWh57iBKriAXqizBCPem3-7+Ng_Urgkg@mail.gmail.com>
Subject: Re: [PATCH v4 35/42] ovl: port ovl_rename() to cred guard
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 11:30=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Does this old "goto out" make any sense any more:
>
> On Mon, 17 Nov 2025 at 01:34, Christian Brauner <brauner@kernel.org> wrot=
e:
> >
> > @@ -1337,11 +1336,9 @@ static int ovl_rename(struct mnt_idmap *idmap, s=
truct inode *olddir,
> >         if (err)
> >                 goto out;
> >
> > -       old_cred =3D ovl_override_creds(old->d_sb);
> > -
> > +       with_ovl_creds(old->d_sb)
> >                 err =3D ovl_rename_upper(&ovlrd, &list);
> >
> > -       ovl_revert_creds(old_cred);
> >         ovl_rename_end(&ovlrd);
> >  out:
> >         dput(ovlrd.new_upper);
>
> when it all could just be
>
>         if (!err) {
>                 with_ovl_creds(old->d_sb)
>                         err =3D ovl_rename_upper(&ovlrd, &list);
>                 ovl_rename_end(&ovlrd);
>         }
>
> and no "goto out" any more?
>
> In fact, I think that "goto out" could possibly have already been done
> as part of the previous patch ("refactor ovl_rename"), but after this
> one the thing it jumps over is just _really_ trivial.
>
> Hmm?

I agree. We just did not notice how trivial the end result became...

Thanks,
Amir.
>
>               Linus
>
>                 Linus

