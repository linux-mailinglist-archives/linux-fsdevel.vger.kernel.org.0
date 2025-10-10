Return-Path: <linux-fsdevel+bounces-63791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAFEBCDE1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 17:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E34ED500035
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 15:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EC9286439;
	Fri, 10 Oct 2025 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCdjm0MC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1091F26463B
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111482; cv=none; b=eb6ew5TgMt0jdTgKrDcgK9ElDZIqkJQ9PwrqRdMYTyLwsHHuSyPvhV9YoyM+JNWIdsowiIctnXV1A4htoSCoXXn7/Kp3nnqJ8qTZLHcHuCuG1cozsq8vx65OycMZKvAUuED9VTjwmLkVEkLHw0oh+LiRa9tCoEtECgDtLfvh3w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111482; c=relaxed/simple;
	bh=TfNKgAwty2Qn00bV61R/qulEyPoJyzCS7e1xQ1v/Tp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBWigS3vOlwSv9maQ0MFi7jpMavRQO17vcZVaQIqOKcb9Y3r1L1ZdKOgFhfwOoQeKIYulEuDe9UBywgjEb9rs/i7K30BQ7lfIdRv1zaT6rwvd7YWpXJ9HaBOlxe7mrTL2Mi+mgdI1LUXuUrkWyd3AlhomWSRTE5DiDMpiM6FSxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCdjm0MC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63994113841so3916165a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760111479; x=1760716279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhH9vWsw8gK9Ns25kQJ5DC4FK/KR5dBSJxG+yxQ1Djk=;
        b=lCdjm0MCSicT5ohXLnU+1eU4uosnNbe3+T930M/f4sRMs2RHwMBqyjq3JzzRNMWFR1
         YHE3JeLz3P9jHjdJDIFZLsiScLvsce9q/63KnWKHkCfk7q5TIcB+/L0eJj3rk/gImSbx
         pKFVSaAyaCSCADkovW4YdjlSMjy22Tt0ZL2XfXyVSOY4PrbXsWupmRfq2Eoqvwnm5AEq
         AVEISQm1IMYjazjS3gaooCgRRgSqUcG5PV3Ou2x4Y4oDa6jJz6vjRyY22WGBLbUnZpvO
         4SH17Y/s+f7LQ9a066xc0BoGU/eYBsxJGnRWscpcBKcpH/kLcPftsFMSZ2trN3dHjKzi
         oPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760111479; x=1760716279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhH9vWsw8gK9Ns25kQJ5DC4FK/KR5dBSJxG+yxQ1Djk=;
        b=TrR5+d6Vv3xklZpL3pAwwfq6A7xoLPy4KtcT6qw28YcwfawIzV7BPax6zVQUSSyBOo
         udb0y4a+koxaQlWrUCpfNMZ1O6tVx7TRWcNRUhW/fQ+dzHit9ovXDviwQGHYJYZfXM/S
         FIj76duBDBWS9VsEQ7+wUYPF9IZoX79yHFy6lmIZm3tWq+yWEN3fsznmEbObG4T3XCtr
         dI5jAzQaoKffipRnXP5xf2cZtCDM9iZHRMpCgV7hRr+lPHyY/TRcetDLyyzXImnrX+kA
         18nQvc4fmxlOJbbAEXGPyUfPDW0Q9yWGWo5oaobcl0rJa5t8vUIJeCwqngd0WLHfwRT9
         hUSA==
X-Forwarded-Encrypted: i=1; AJvYcCXChusGlvnoFT2GfUk1I8ovElNlpByrtatXwhMy9a/qusvs19jXTr0j0CRsvOTeHDGFCYrRY3c6ypWlG7H3@vger.kernel.org
X-Gm-Message-State: AOJu0YxDE6GFhJ0tVzMrRrwf0AVWrzR08JsuYI7sGRMVXzF0RULFT7AJ
	SKCJhEwEuVt+cbt0Dbi2ZlHzllsivbKwYakQu/kUxgexlo3dGD33eQEWa5HcCqVKE08STeTWCbv
	cDywT9g39Jg2qTl5g4I+1VoeDFpwBs/s=
X-Gm-Gg: ASbGncuMHHgzjySocY7o0DV14mCHoJEFrOd7x4A2/nZT1SBvp6mmwDcuB93nDYZDIhd
	tzP2cdfjHY7Y8bSLEYo3jQpdqArokPW2mJgicSHxEhhPyLn83imzdLFoZkGAfqOQfk0/gdzAzSs
	1cLvVr5m3IuN+/5za9SY6uPWhT+HKPM4JT7NhlLdQxdb1n0q5U7XDa/bkAGbgczq8Ha6zB9c4bV
	NrN/rNBPgXlJUs0bmaYuQ6BYL1oa61PHA9HKlwhw+UE9xga22c8nqYv8UAJox5N7Esf
X-Google-Smtp-Source: AGHT+IE+fpwB+bY36jZhuFvtAiR+1ExrpMDWYUETjZUPwkwAWYTKotWAPrtOsHK68GTsCIaCtcLyUWD8+YiMIbEIYPI=
X-Received: by 2002:a17:907:3daa:b0:b4a:d0cf:8748 with SMTP id
 a640c23a62f3a-b50a9a6d769mr1349543366b.13.1760111478957; Fri, 10 Oct 2025
 08:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009075929.1203950-1-mjguzik@gmail.com> <20251009075929.1203950-4-mjguzik@gmail.com>
 <h2etb4acmmlmcvvfyh2zbwgy7bd4xeuqqyciqjw6k5zd3thmzq@vwhxpsoauli7>
In-Reply-To: <h2etb4acmmlmcvvfyh2zbwgy7bd4xeuqqyciqjw6k5zd3thmzq@vwhxpsoauli7>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 10 Oct 2025 17:51:06 +0200
X-Gm-Features: AS18NWAdR8mn7h75Ldgul-s1iHW_YrjMNEOV1VnI-B-ScP1aM5_q24GjzqXvcko
Message-ID: <CAGudoHFJxFOj=cbxcjmMtkzXCagg4vgfmexTG1e_Fo1M=QXt-g@mail.gmail.com>
Subject: Re: [PATCH v7 03/14] fs: provide accessors for ->i_state
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, 
	amir73il@gmail.com, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 4:44=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 09-10-25 09:59:17, Mateusz Guzik wrote:
> > +static inline void inode_state_set_raw(struct inode *inode,
> > +                                    enum inode_state_flags_enum flags)
> > +{
> > +     WRITE_ONCE(inode->i_state, inode->i_state | flags);
> > +}
>
> I think this shouldn't really exist as it is dangerous to use and if we
> deal with XFS, nobody will actually need this function.
>

That's not strictly true, unless you mean code outside of fs/inode.c

First, something is still needed to clear out the state in
inode_init_always_gfp().

Afterwards there are few spots which further modify it without the
spinlock held (for example see insert_inode_locked4()).

My take on the situation is that the current I_NEW et al handling is
crap and the inode hash api is also crap.

For starters freshly allocated inodes should not be starting with 0,
but with I_NEW.

I can agree after the dust settles there should be no _raw thing for
filesystems to use, but getting there is beyond the scope of this
patchset.

> > +static inline void inode_state_set(struct inode *inode,
> > +                                enum inode_state_flags_enum flags)
> > +{
> > +     lockdep_assert_held(&inode->i_lock);
> > +     inode_state_set_raw(inode, flags);
> > +}
> > +
> > +static inline void inode_state_clear_raw(struct inode *inode,
> > +                                      enum inode_state_flags_enum flag=
s)
> > +{
> > +     WRITE_ONCE(inode->i_state, inode->i_state & ~flags);
> > +}
>
> Ditto here.
>
> > +static inline void inode_state_clear(struct inode *inode,
> > +                                  enum inode_state_flags_enum flags)
> > +{
> > +     lockdep_assert_held(&inode->i_lock);
> > +     inode_state_clear_raw(inode, flags);
> > +}
> > +
> > +static inline void inode_state_assign_raw(struct inode *inode,
> > +                                       enum inode_state_flags_enum fla=
gs)
> > +{
> > +     WRITE_ONCE(inode->i_state, flags);
> > +}
> > +
> > +static inline void inode_state_assign(struct inode *inode,
> > +                                   enum inode_state_flags_enum flags)
> > +{
> > +     lockdep_assert_held(&inode->i_lock);
> > +     inode_state_assign_raw(inode, flags);
> > +}
> > +
> > +static inline void inode_state_replace_raw(struct inode *inode,
> > +                                        enum inode_state_flags_enum cl=
earflags,
> > +                                        enum inode_state_flags_enum se=
tflags)
> > +{
> > +     enum inode_state_flags_enum flags;
> > +     flags =3D inode->i_state;
> > +     flags &=3D ~clearflags;
> > +     flags |=3D setflags;
> > +     inode_state_assign_raw(inode, flags);
> > +}
>
> Nobody needs this so I'd just provide inode_state_replace().
>

The unused _raw variants are provided for consistency for the time
being. I do expect some of them to die later.

