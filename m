Return-Path: <linux-fsdevel+bounces-34759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADBF9C8898
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 12:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B6ADB33DFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 11:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA6E1F9A8D;
	Thu, 14 Nov 2024 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdR9XqA3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390291F708C;
	Thu, 14 Nov 2024 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582115; cv=none; b=R2kFTAcZbrs3WQmNmxtceHuwEwFY6rX4qD9lC1quUJmHDDq7lxxv9XatbT4xBZewc6xCDefbYIpqc99as5gzxCekwgS7Xmva8pGVRsd0kauQWYArG7jBsLv70TcAX5yOknABqSG0Z3zik/YGT/PjvRLI5o68sgwlHmqdaL/NysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582115; c=relaxed/simple;
	bh=yOveOm35kKkQspZjLPov71DNDXoqG1thad41wsW/2Y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fR0doDA6F5KbqVnKNotYVyvDLMnjAG9hTndOVLxJqQtFrAFz5JglqWIQxsqwLzEp/hRY1d1bmnGu3i5VwuKvfZLPbCCdB5XJgB+yGj9BrAC8mJYZ+UCdngMSA1N0GyAKvgITN3clm5tbyvT0wxdgokbDtC7J5CMteLzdBk9mLz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdR9XqA3; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b155da5b0cso30458185a.2;
        Thu, 14 Nov 2024 03:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731582113; x=1732186913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cb7dgVR+ryKmBZe/3qiUq65bGl1Enns12WFs98srOvU=;
        b=OdR9XqA37CF97QU+wz5lHmWAmhiVoSrep3VfmsLYUs1u8M2SQxHIhCuxaUvu4jMU5T
         EP6Yu45T/qHtjUmfC/9osUWIMeoyNdxQVfV/NjjrEgKj7Gc8wW5LyY08fgX3f3BlKQU1
         lNUO1i0XgYmp47+n54YQGvj2ul+Hvos+zNXotNK23FwCUQCBbr0qXuxH8XyblJNZ7nkK
         GA8i0ZOwE2fDhQopKD+t7q0hW0/sEPh2MBrE7wHyBTyFS26OJgNQeKzC9cH6sYoC6nwW
         mvXnAkRYH0EOXgw/W1bYvj2RnFbxW4GHC2KOIptFnA3dQBu4Jf4Jq+CQPBHifIiMJwtY
         GH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731582113; x=1732186913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cb7dgVR+ryKmBZe/3qiUq65bGl1Enns12WFs98srOvU=;
        b=uS+EXxQ/5OY1aKEVRLM88nGqT+7e8MlAV6XKwlsr+QFdkpMpNHmjAT0RqShwaxoBIy
         KoSgxaSKKvU/jSG1IPipuFlCR4PiS89dxYzExV5W43thI2XSDqc6N/y8nasWa9q9A24l
         NeWq1uLdIoC+on2NntdC+Zh9KmByzlN9zYh+K+TOu7nLb8+1EzdSQeIUzQBWKg+J9Lsg
         lRwGJ5nBTySJtju7w7vMZ0KhWb1vLWKCNVn2aDBvaOU4dserzpRs+ZXiu4fMH3iEZvXb
         W2auEcL0bffoVEeuswvBzyWa0AijU+bLVb3nsw/OPrCr/Z7aWm0cxznPPh67HCTIn8RZ
         bYsA==
X-Forwarded-Encrypted: i=1; AJvYcCUEmGKgrglydCLptRDGGbqrYawx2fBUf0LyV2uzdgsm6mool8IdwxXlQTVKywhT7iEiGBrQM7Et4oUkH2iX@vger.kernel.org, AJvYcCUu7Wl+7FMA/uU56zr5ZJpLKnMcqqr/Y8ynknMeHf+0uDG04Trgyx5Q+bPkEDp0TGhUPx2QieeZyJpQc4rq@vger.kernel.org, AJvYcCVDgE/GYoxOawIVw0HFVE1ecLFUUtXSmvSRTJ4vBvvTFY1lNxpVqFoXHEhRA4KmDRj41cnd+fi0ZPQeZVbTIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxamPcS2C/F6meyVjymdqSzeZeocRpRj4yMoL3HIEe27UcUoFS2
	ja4lHaF8O/srY5Xq9n6zdbIU4LXcT04jGrpIYHRk84huDC65r2xVJacO9hfiFLY1XEbstLLq+2f
	z7y5OTMnv8uOL4wGZGgNc+kbl3ds=
X-Google-Smtp-Source: AGHT+IHrt37be3sYp9wTxVqeSYfR8jrYiZ8jv2z+pAhhp29ZLz7Od2thkOQtttaRvT8qsBLwGyvMA5s+7HKksyZ77+c=
X-Received: by 2002:a05:6214:570b:b0:6d1:992e:4c5a with SMTP id
 6a1803df08f44-6d3d03a9ac0mr138999846d6.45.1731582113059; Thu, 14 Nov 2024
 03:01:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107005720.901335-1-vinicius.gomes@intel.com>
 <20241107005720.901335-5-vinicius.gomes@intel.com> <CAOQ4uxgHwmAa4K3ca7i1G2gFQ1WBge855R19hgEk7BNy+EBqfg@mail.gmail.com>
 <87ldxnrkxw.fsf@intel.com> <CAOQ4uxguV9SkFihaCcyk1tADNJs4gb8wrA7J3SVYaNnzGhLusw@mail.gmail.com>
In-Reply-To: <CAOQ4uxguV9SkFihaCcyk1tADNJs4gb8wrA7J3SVYaNnzGhLusw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Nov 2024 12:01:42 +0100
Message-ID: <CAOQ4uxiXt4Y=fP+nUfbKkf46of4em633Dmd+iUCFyB=5ijvHdw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] ovl: Optimize override/revert creds
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hu1.chen@intel.com, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 9:56=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Wed, Nov 13, 2024 at 8:30=E2=80=AFPM Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
> >
> > Amir Goldstein <amir73il@gmail.com> writes:
> >
> > > On Thu, Nov 7, 2024 at 1:57=E2=80=AFAM Vinicius Costa Gomes
> > > <vinicius.gomes@intel.com> wrote:
> >
> > [...]
> >
> > >
> > > Vinicius,
> > >
> > > While testing fanotify with LTP tests (some are using overlayfs),
> > > kmemleak consistently reports the problems below.
> > >
> > > Can you see the bug, because I don't see it.
> > > Maybe it is a false positive...
> >
> > Hm, if the leak wasn't there before and we didn't touch anything relate=
d to
> > prepare_creds(), I think that points to the leak being real.
> >
> > But I see your point, still not seeing it.
> >
> > This code should be equivalent to the code we have now (just boot
> > tested):
> >
> > ----
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index 136a2c7fb9e5..7ebc2fd3097a 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -576,8 +576,7 @@ static int ovl_setup_cred_for_create(struct dentry =
*dentry, struct inode *inode,
> >          * We must be called with creator creds already, otherwise we r=
isk
> >          * leaking creds.
> >          */
> > -       WARN_ON_ONCE(override_creds(override_cred) !=3D ovl_creds(dentr=
y->d_sb));
> > -       put_cred(override_cred);
> > +       WARN_ON_ONCE(override_creds_light(override_cred) !=3D ovl_creds=
(dentry->d_sb));
> >
> >         return 0;
> >  }
> > ----
> >
> > Does it change anything? (I wouldn't think so, just to try something)
>
> No, but I think this does:
>

Vinicius,

Sorry, your fix is correct. I did not apply it properly when I tested.

I edited the comment as follows and applied on top of the patch
that I just sent [1]:


-       put_cred(override_creds(override_cred));
+
+       /*
+        * Caller is going to match this with revert_creds_light() and drop
+        * reference on the returned creds.
+        * We must be called with creator creds already, otherwise we risk
+        * leaking creds.
+        */
+       old_cred =3D override_creds_light(override_cred);
+       WARN_ON_ONCE(old_cred !=3D ovl_creds(dentry->d_sb));

        return override_cred;

Thanks,
Amir.

[1] https://lore.kernel.org/linux-unionfs/20241114100536.628162-1-amir73il@=
gmail.com/

