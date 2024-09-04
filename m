Return-Path: <linux-fsdevel+bounces-28593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA48096C454
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE90C1C22B71
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 16:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F681E0B9B;
	Wed,  4 Sep 2024 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR1369uG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67411E0B79;
	Wed,  4 Sep 2024 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468309; cv=none; b=M9unZloHLuHy24u+9+JUECtqWI7i6yXc1/lY/JdzYv4p8Y5RzRObq5J6LcU05WQ6+hZ5oO1LRh/7Hh3Oiy2mdYC4JI2C07gXdb+AAvMJKA2TaaX4MzUHcS475RnYhwMLw0bAriEtfQqAZ4XVBPgmpa/8TeuyFIVpI41ACWz+IB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468309; c=relaxed/simple;
	bh=sZq5Sl4k2Ja4Iix3tKV1PrlAHf29Z7WsTqEoXj5tVQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+HwOzlYGRh3C9q3M4d0jkXo+5HlqrtAEHl5rJptspQD7GUetJf+4cy/9IC0eBjgHHUGJwKY8UeiWs7TjE19sOprUeMKoOaUNAE2PN/9XTy+LkNhwNqKOSi8XzpUmgarQGT9SfVd2VAnn3B+j9jEihAyDo0GIKL5t4u7UjgqNXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IR1369uG; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a966f0a985so229488385a.3;
        Wed, 04 Sep 2024 09:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725468307; x=1726073107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+97pJzC0UZCf1ZhPCVqbpyHvcwl1EJo2MBdOEN/H1ic=;
        b=IR1369uGtBbt9dKcMhpmWAUuZp+guqPjlL51piSQ8AZLwTFStz0om/XwsW05chB1lq
         RCnqHkIjX84iiZKirnNBb442JSheoxuXk8fHTwXTMwcVFd3tAAzl9oZ4Xn+Ha5MrsEL6
         UneKlC4UOICUccxSeBqe8W6FdeNP4hwN0n0b2fWY+DEo7wGSXFRY8MMu2JMCfi4b8uc6
         /KY8/DcrbJxDou0f7QMbU6H/hMF8G3Vdge90l2RxFc38v+j2vQhMHG1lbXrHsB9uOb8E
         b9NsMMYiCan/c5fPaRbNae1X356AK7Qwip2WSmHdGmXfNCgKz1CA/QyRM0qXdTiFN4Pd
         YLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725468307; x=1726073107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+97pJzC0UZCf1ZhPCVqbpyHvcwl1EJo2MBdOEN/H1ic=;
        b=rUrYoq7lY0FOjcMXa6ws/yxw/+Iu8IAPXDEFjw6+XFfqXJl/DFYrFVhN/Ll3S1FYxl
         u9M6yxe9GN8ch/tLyIn699ZX4rdLREijSfY1ofxl5IEDSBKN7eSCa/Lgp1q/15e/e5Gk
         nTc7aEWSaU6cRqob4nrs7aQujWVw7L4BUsUlZyhsVVESp1tDOG2Svmf21fHFM1Y4sXaG
         RLCJ1vxXLP1XNyh5qoWMWrcPfi1sC7RAZmxFUqdu4Hu2uO3uh1yxrrZ6i1UYBhru/h2z
         zVVZhRiH9fwG/bLoSjOpoxayDhdn4GZO6uNhMzNkmerUpsVoReUs6WCgW/lWCiu1I09h
         fqEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnMuKbbzHp9S8VxqXCWj68JvMYIIlBsS7a5nB993bK4qwk5To5jEskcCJ/Xdvw3U8itCl1tliEw0aSvV9Q@vger.kernel.org, AJvYcCWEZujhdhuaz7/2fco5Kgv9miHfTE5QJuYkh5rEvpAywqDDHCBw3FeA6YX1zubhhQb+3tM12A7F/xwnsEZ0QQ==@vger.kernel.org, AJvYcCWT6LSKJkYzdbatc8CSbgHOhyXUKYKuZ3+rwHE9BU/vYm751vHIMeevFBB95K5nWB5Ei9a1qunkU53oBjEym9hz/w==@vger.kernel.org, AJvYcCXg2sHBzf3AtNT5la8Qk5kF/BXJteJqqjaPJXAbCcOEZIFKQGAA5HVzJLPVP6oN002Hri/Q1z4c2UTj@vger.kernel.org, AJvYcCXobRTOdMhT1l3AhY96W6st+wGMvJKLiXkap8Ci+RxlPi0Rqtpq0L4mNw9XgP0qjCUEL+FtVlHzJMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3aIP2hDpu5pAwOYV4odlpGEMgxgWx7/r1RDDoxEYoIQiLRAg5
	3XNonhUxezmhRBZYEFvrXNfFjILYbbYk18EXyY/IB4LIE/O6kluy5lrN+cCmtvrX+LdN5aCF57R
	IfCdOb3RJQoW2FeaqYFz9BcvSkYQ=
X-Google-Smtp-Source: AGHT+IHD6Iid1+jIY94q827mn0wAxNIGb4Ddfn+R1FjJ3Lmqs8Ms1ALLX6rxYcRkKbf8M3uW4zlsaVK9UmneTxAURK0=
X-Received: by 2002:a05:620a:4708:b0:79f:4f3:88f5 with SMTP id
 af79cd13be357-7a97bc78e88mr707414585a.15.1725468306494; Wed, 04 Sep 2024
 09:45:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828-exportfs-u64-mount-id-v3-0-10c2c4c16708@cyphar.com>
 <20240902164554.928371-1-cyphar@cyphar.com> <20240902164554.928371-2-cyphar@cyphar.com>
 <CAOQ4uxgS6DvsbUsEoM1Vr2wcd_7Bj=xFXMAy4z9PphTu+G6RaQ@mail.gmail.com>
 <20240903.044647-some.sprint.silent.snacks-jdKnAVp7XuBZ@cyphar.com>
 <CAOQ4uxhXa-1Xjd58p8oGd9Q4hgfDtGnae1YrmDWwQp3t5uGHeg@mail.gmail.com> <20240904.162424-novel.fangs.vital.nursery-BQvjXGlIi7vb@cyphar.com>
In-Reply-To: <20240904.162424-novel.fangs.vital.nursery-BQvjXGlIi7vb@cyphar.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 4 Sep 2024 18:44:54 +0200
Message-ID: <CAOQ4uxg7EgOH5s_RZz27XpVSwgWu9bROT9JRzTycxi8D2_3d3A@mail.gmail.com>
Subject: Re: [PATCH xfstests v2 2/2] open_by_handle: add tests for u64 mount ID
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: fstests@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Alexander Aring <alex.aring@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Christoph Hellwig <hch@infradead.org>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 6:31=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> wro=
te:
>
> On 2024-09-03, Amir Goldstein <amir73il@gmail.com> wrote:
> > On Tue, Sep 3, 2024 at 8:41=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com>=
 wrote:
> > >
> > > On 2024-09-02, Amir Goldstein <amir73il@gmail.com> wrote:
> > > > On Mon, Sep 2, 2024 at 6:46=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.=
com> wrote:
> > > > >
> > > > > Now that open_by_handle_at(2) can return u64 mount IDs, do some t=
ests to
> > > > > make sure they match properly as part of the regular open_by_hand=
le
> > > > > tests.
> > > > >
> > > > > Link: https://lore.kernel.org/all/20240828-exportfs-u64-mount-id-=
v3-0-10c2c4c16708@cyphar.com/
> > > > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > > > > ---
> > > > > v2:
> > > > > - Remove -M argument and always do the mount ID tests. [Amir Gold=
stein]
> > > > > - Do not error out if the kernel doesn't support STATX_MNT_ID_UNI=
QUE
> > > > >   or AT_HANDLE_MNT_ID_UNIQUE. [Amir Goldstein]
> > > > > - v1: <https://lore.kernel.org/all/20240828103706.2393267-1-cypha=
r@cyphar.com/>
> > > >
> > > > Looks good.
> > > >
> > > > You may add:
> > > >
> > > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > > >
> > > > It'd be nice to get a verification that this is indeed tested on th=
e latest
> > > > upstream and does not regress the tests that run the open_by_handle=
 program.
> > >
> > > I've tested that the fallback works on mainline and correctly does th=
e
> > > test on patched kernels (by running open_by_handle directly) but I
> > > haven't run the suite yet (still getting my mkosi testing setup worki=
ng
> > > to run fstests...).
> >
> > I am afraid this has to be tested.
> > I started testing myself and found that it breaks existing tests.
> > Even if you make the test completely opt-in as in v1 it need to be
> > tested and _notrun on old kernels.
> >
> > If you have a new version, I can test it until you get your fstests set=
up
> > ready, because anyway I would want to check that your test also
> > works with overlayfs which has some specialized exportfs tests.
> > Test by running ./check -overlay -g exportfs, but I can also do that fo=
r you.
>
> I managed to get fstests running, sorry about that...
>
> For the v3 I have ready (which includes a new test using -M), the
> following runs work in my VM:
>
>  - ./check -g exportfs
>  - ./check -overlay -g exportfs
>
> Should I check anything else before sending it?
>

That should be enough.
So you have one new test that does not run on upstream kernel
and runs and passes on patched kernel?

> Also, when running the tests I think I may have found a bug? Using
> overlayfs+xfs leads to the following error when doing ./check -overlay
> if the scratch device is XFS:
>
>   ./common/rc: line 299: _xfs_has_feature: command not found
>     not run: upper fs needs to support d_type
>
> The fix I applied was simply:
>
> diff --git a/common/rc b/common/rc
> index 0beaf2ff1126..e6af1b16918f 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -296,6 +296,7 @@ _supports_filetype()
>         local fstyp=3D`$DF_PROG $dir | tail -1 | $AWK_PROG '{print $2}'`
>         case "$fstyp" in
>         xfs)
> +               . common/xfs
>                 _xfs_has_feature $dir ftype
>                 ;;
>         ext2|ext3|ext4)
>
> Should I include this patch as well, or did I make a mistake somewhere?
> (I could add the import to the top instead if you'd prefer that.)

This should already be handled by
if [ -n "$OVL_BASE_FSTYP" ];then
        _source_specific_fs $OVL_BASE_FSTYP
fi

in common/overlay

I think what you are missing is to
export FSTYP=3Dxfs
as README.overlay suggests.

It's true that ./check does not *require* defining FSTYP
and can auto detect the test filesystem, but for running -overlay
is it a requirement to define the base FSTYP.

Thanks,
Amir.

