Return-Path: <linux-fsdevel+bounces-34875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 131C29CDA58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 09:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EE01B24413
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 08:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53BD18C011;
	Fri, 15 Nov 2024 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFPtO1LW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673B12B9B7;
	Fri, 15 Nov 2024 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731658584; cv=none; b=s7bacWIPb3/Dt1iGLUJERBphDSwbLXtsMtLpswuMkvzbe8i+YaMiUb38SZ2w23HuJdD18LTUXTiljfOy+zkeciUgsGOOkeEjKir+flr+GX9S59jJPRioyTrTWT+sH1YKzLbRR2FJWxyOkrvbzIXbj9INgPwTuY/WjAOEaI6tv9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731658584; c=relaxed/simple;
	bh=YvFcs3TbU1UzCIaoPY3w3H31wzDsKn8m4eJLMmpUyw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3IgIaDw77qkF6ozaduVGz9WvhbXxhseahAf3maRzTAUbX3ZDPT3KdMI8JWKuKb+9UuzJVUDjTgcSxIqS93AbNi2fws6qv4rsn3YA/6wA7xSWUfTfT2CoSh1Gv+Rtapr6WfkuWJWnHGjMfFyIT1feWPt7hk7IvHY01nQFZob89E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFPtO1LW; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9ec86a67feso278991066b.1;
        Fri, 15 Nov 2024 00:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731658581; x=1732263381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/ZTTN08/fIOGKdrgWzCu5aUQzVCGtVcF13+BBqm2Qc=;
        b=FFPtO1LWnAb+YyrfnKo5D6hSHny2Uk/27udSTzfPUrGqhhtpkO413e4mYB842ufIHk
         N73ZgX1AA6apv+oHp1ChXHZMNUY/eQ+jehHCPEpHj8RnVUkm0vUPntb4qG0whWhpTYSx
         YJBa7Lxi2jDItB1+DSnpsg2WVgYRm3u7bUOZD3yzldRkDpv9O1D40ay/Nvpzfg4edB4X
         uod48iwCrtfMM7tLCA7SKtRVKn5/P3n7j/JZArHFJS5XHk5nTKeYKPiDA9eA8hjFPyjD
         oFsoErdQKzP9VWR2zDJr9IyZ1cQ3KPzuMtIKiX8GSwLzqx5/TlkhVRe+fQrSDMGSQNoH
         bPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731658581; x=1732263381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/ZTTN08/fIOGKdrgWzCu5aUQzVCGtVcF13+BBqm2Qc=;
        b=fK6TaPF0vz0tUw2BS+xSgi8qW5Pb37i03UobSxnVxavVugfPA/RVbkQZQ9wqgvUObL
         oR6OV/rQKwkbDEpiqTfXRVW/WK3q77AEPmw8WArfYNE2B65OR6uUZAulITaZaAz5I1m5
         Y7VYjTu2ZsyrhnvDmAxTClU44p3jwHZx8eXwjsHFh5hNlhGkkwziidBmbw6jqcsEDSsJ
         cSU43Q01Aklxpam1qaS/egKGRRHAikgp9KkVhNi7NdTW6jBFCI1iXGliBRvF6wwmM9xj
         4pD8GHaPsXYMf8F2fkGr0P5aDETnr5jzYd5r7DdSzmljP4zS/rLLW8H5NJ9PRDSet1fD
         3M3A==
X-Forwarded-Encrypted: i=1; AJvYcCUNhMaCAfZs3vCqkSUjtTGEKh/GcSBk8CWlqSkgGLMSk3IXerY482heVhlwG99wKZNDfJ+9+ZYfbxt4vVuK@vger.kernel.org, AJvYcCVJPxa0AFXIBg7XCFL21HdLSAnHpZIAfZtP7c2nZ7IoOlR1Gh52i6exBDmD8a4NXoEG6CXPEGYXOSSTiIEaTA==@vger.kernel.org, AJvYcCXKTR2AhO+qi7YXNHaB+LtR9RWP+QO3mpKpQHaV/f1ktbGIFN4ZMbu+psXNDwi5Qdqs4/z5wowM8Pk+qVU2@vger.kernel.org
X-Gm-Message-State: AOJu0YyeyWEpOCkvYAvFm8eLU6xVC6mhtsLTK/te0sD7dIW4XCHhcjyJ
	Ih2bpG6Bs2pr9B9tDOj4XUY89Y7IQpXkEj5dkqYF1GxBKqVvqYsx+ynGw7clzwyhgU9L9cEhLzv
	ebJjRmbYV4ry0uZ4KHYHDhkhzeVxNAvUw
X-Google-Smtp-Source: AGHT+IE6qHlbORpNlDCBHillBLKnEHgRD20tiWEighgurgUcNMQipOwjOE5nvsvnQnG7CBJaAt9luIoZ6sacEii7DcM=
X-Received: by 2002:a17:907:a0e:b0:a9a:4d1:c628 with SMTP id
 a640c23a62f3a-aa48352c0f5mr139000466b.45.1731658580101; Fri, 15 Nov 2024
 00:16:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107005720.901335-1-vinicius.gomes@intel.com>
 <20241107005720.901335-5-vinicius.gomes@intel.com> <CAOQ4uxgHwmAa4K3ca7i1G2gFQ1WBge855R19hgEk7BNy+EBqfg@mail.gmail.com>
 <87ldxnrkxw.fsf@intel.com> <CAOQ4uxguV9SkFihaCcyk1tADNJs4gb8wrA7J3SVYaNnzGhLusw@mail.gmail.com>
 <CAOQ4uxiXt4Y=fP+nUfbKkf46of4em633Dmd+iUCFyB=5ijvHdw@mail.gmail.com> <87h689sf6p.fsf@intel.com>
In-Reply-To: <87h689sf6p.fsf@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 15 Nov 2024 09:16:09 +0100
Message-ID: <CAOQ4uxh01iN5QPWtSDJPAR0Z0mhAj691PXYJeroSO8WvzxgfAg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] ovl: Optimize override/revert creds
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hu1.chen@intel.com, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 10:01=E2=80=AFPM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Thu, Nov 14, 2024 at 9:56=E2=80=AFAM Amir Goldstein <amir73il@gmail.=
com> wrote:
> >>
> >> On Wed, Nov 13, 2024 at 8:30=E2=80=AFPM Vinicius Costa Gomes
> >> <vinicius.gomes@intel.com> wrote:
> >> >
> >> > Amir Goldstein <amir73il@gmail.com> writes:
> >> >
> >> > > On Thu, Nov 7, 2024 at 1:57=E2=80=AFAM Vinicius Costa Gomes
> >> > > <vinicius.gomes@intel.com> wrote:
> >> >
> >> > [...]
> >> >
> >> > >
> >> > > Vinicius,
> >> > >
> >> > > While testing fanotify with LTP tests (some are using overlayfs),
> >> > > kmemleak consistently reports the problems below.
> >> > >
> >> > > Can you see the bug, because I don't see it.
> >> > > Maybe it is a false positive...
> >> >
> >> > Hm, if the leak wasn't there before and we didn't touch anything rel=
ated to
> >> > prepare_creds(), I think that points to the leak being real.
> >> >
> >> > But I see your point, still not seeing it.
> >> >
> >> > This code should be equivalent to the code we have now (just boot
> >> > tested):
> >> >
> >> > ----
> >> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> >> > index 136a2c7fb9e5..7ebc2fd3097a 100644
> >> > --- a/fs/overlayfs/dir.c
> >> > +++ b/fs/overlayfs/dir.c
> >> > @@ -576,8 +576,7 @@ static int ovl_setup_cred_for_create(struct dent=
ry *dentry, struct inode *inode,
> >> >          * We must be called with creator creds already, otherwise w=
e risk
> >> >          * leaking creds.
> >> >          */
> >> > -       WARN_ON_ONCE(override_creds(override_cred) !=3D ovl_creds(de=
ntry->d_sb));
> >> > -       put_cred(override_cred);
> >> > +       WARN_ON_ONCE(override_creds_light(override_cred) !=3D ovl_cr=
eds(dentry->d_sb));
> >> >
> >> >         return 0;
> >> >  }
> >> > ----
> >> >
> >> > Does it change anything? (I wouldn't think so, just to try something=
)
> >>
> >> No, but I think this does:
> >>
> >
> > Vinicius,
> >
> > Sorry, your fix is correct. I did not apply it properly when I tested.
> >
> > I edited the comment as follows and applied on top of the patch
> > that I just sent [1]:
> >
>
> I just noticed there's a typo in the first sentence of the commit
> message, the function name that we are using revert_creds_light() is
> ovl_revert_creds(). Could you fix that while you are at it?
>

fixed.

Thanks,
Amir.

