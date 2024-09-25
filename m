Return-Path: <linux-fsdevel+bounces-30097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87600986192
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 16:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01E71C26C60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A8818BBA7;
	Wed, 25 Sep 2024 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jBUAfwVo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903CD18BB8B
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727274368; cv=none; b=b3aQlAoR+BK6ILesVI/cvBZw+U2PZnT2w6v92vcjEtJA3rCxsYvEJpX1vcdCnTwtYwjWVluVp/brcr40wyAK+mGOQGlkBOvYnqZONT63c2X8fCFXOAY5fQIwrAZux+emUL/wqXZ7B/PmL+C/0DZ92HW/dElIO22PKvOUW3/vwdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727274368; c=relaxed/simple;
	bh=2RGPsyy1ICCGYlOXHDt3UJllHsA4J4uevl1E3onwi5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWRv/j5d2wvF/FR86BQok5CgKah1MobV5veDFMxdoJLhsXw0z+ptWkEfq1oLHw1FiUvi1x6H3/i2UDYyS2rk1hiBqsa/BwG2WoTB190EkKPH4ut7yZMB3v7rg4YcjQonoAVKNXYZ5qX9C6pV6v3OqM854Ju7HvPrwt9xdZt6Au4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jBUAfwVo; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so943462066b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 07:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1727274365; x=1727879165; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BNnH51xiuECwK0bhuUqzXJGS+HWi9NNAdO6akCv0XQo=;
        b=jBUAfwVonbyMCSOpYhkjX/h+kEXxBjpILuCRx0iDYR054ggWAHzRP8K0h2pgQ1Tjlh
         OwKfJm4ED+nC76uQohCUexeK3M1Vyee4olL/3RyslKTeXca3CmSQvoxPeTpGAgjaSWrr
         C+qd1E/NaX4bD4cbuu8YTpbgmyuG3ucNeUH20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727274365; x=1727879165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNnH51xiuECwK0bhuUqzXJGS+HWi9NNAdO6akCv0XQo=;
        b=hvkQEnwqQclPauy81/kO6KbtrGOQ8XEWsZ5+xCjO2hu3Dv95z85xMQyl+KEecdtw0E
         TBgd3JQ3eMM7zOsbl+4NOLMxUAgWDmWdQloW/N459E2RK6bloAUJULSv9S2gpfRsIY8S
         xgql67LatRJD5tSLf7lXLfuQRbINDP1/KT9kQXe15PnGgMHyvEwXSOLRhS692dUjJXeS
         Hfc2rGihs+2fNfRL914IQhyJ01ohD58Qbl+MOHRyNRcRmOkAFEGAWwHD6XHvh3Nfo65v
         w5fmG3623jcDxtWGqHbywjunWhAKlIOxG3lHihxNUSImkimbiwGktpByRwKuCKS5i5zq
         ofZA==
X-Forwarded-Encrypted: i=1; AJvYcCWeqehYmc5x8iL1Z8Y3K8nyb93ZvPCBur+lcJRJgq0ZBuVeoVfZhEQIelm6oE5w5KSKUs73tFh+ZsUnntCj@vger.kernel.org
X-Gm-Message-State: AOJu0YwqId5TpCmEyQQHtQ/TECzuW6zsywaJFMMUi9Z5YfL/VML4IPcT
	0nWgu9vjlqyA6c+gXJ8AqAlfIlU+etzcguLnB8ngydkVuLYVga+Uh2qlETSGFu0W/MF2yVlVf4F
	YeljfcdYosMMQL5QlaNtSgysNXOO2OuOvmFagSTPZT5I7rskV
X-Google-Smtp-Source: AGHT+IHQjgXRlzDHiiOcKnWokx+zNbjRzt5JOPcWhy8HOg/cdJjSOHhjsON9t4wU7ACFwIvzlsIv59eWPz3OvswQW8I=
X-Received: by 2002:a17:907:e669:b0:a86:92a5:247a with SMTP id
 a640c23a62f3a-a93a035d805mr277338266b.17.1727274364545; Wed, 25 Sep 2024
 07:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <GV0P278MB07187F9B0E7B576AD0B362B485802@GV0P278MB0718.CHEP278.PROD.OUTLOOK.COM>
 <CAJfpegvVtao9OotO3sZopxxkSTkRV-cizpE1r2VtG7xZExZFOQ@mail.gmail.com> <a48f642d-a129-4a55-8338-d446725dc868@fastmail.fm>
In-Reply-To: <a48f642d-a129-4a55-8338-d446725dc868@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 25 Sep 2024 16:25:52 +0200
Message-ID: <CAJfpegv=7cnS9N7Fb8dMXSNgA1neYuhqavGeBdTAKFHXhL19KQ@mail.gmail.com>
Subject: Re: [fuse-devel] Symlink caching: Updating the target can result in
 corrupted symlinks - kernel issue?
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Laura Promberger <laura.promberger@cern.ch>, 
	"fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Sept 2024 at 16:07, Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> Hi Miklos,
>
> On 9/25/24 14:20, Miklos Szeredi wrote:
> > On Thu, 15 Aug 2024 at 16:45, Laura Promberger <laura.promberger@cern.ch> wrote:
> >
> >> - But for corrupted symlinks `fuse_change_attributes()` exits before `fuse_change_attributes_common()` is called and as such the length stays the old one.
> >
> > The reason is that the attr_version check fails.  The trace logs show
> > a zero attr_version value, which suggests that the check can not fail.
> > But we know that fuse_dentry_revalidate() supplies a non-zero
> > attr_version to fuse_change_attributes() and if there's a racing
> > fuse_reverse_inval_inode() which updates the fuse_inode's
> > attr_version, then it would result in fuse_change_attributes() exiting
> > before updating the cached attributes, which is what you observe.
>
>
> I'm a bit confused by this, especially due to "fuse_reverse_inval_inode()",
> isn't this about FUSE_NOTIFY_INVAL_ENTRY and the additional flag
> FUSE_EXPIRE_ONLY? I.e. the used code path is fuse_reverse_inval_entry()?
> And that path doesn't change the attr_version? Which I'm also confused
> about.

The trace does have several fuse_reverse_inval_inode() calls, which
made me conclude that this was the cause.

> > This is probably okay, as the cached attributes remain invalid and the
> > next call to fuse_change_attributes() will likely update the inode
> > with the correct values.
> >
> > The reason this causes problems is that cached symlinks will be
> > returned through page_get_link(), which truncates the symlink to
> > inode->i_size.  This is correct for filesystems that don't mutate
> > symlinks, but for cvmfs it causes problems.
> >
> > My proposed solution would be to just remove this truncation.  This
> > can cause a regression in a filesystem that relies on supplying a
> > symlink larger than the file size, but this is unlikely.   If that
> > happens we'd need to make this behavior conditional.
>
> I wonder if we can just repeat operations if we detect changes in the
> middle. Hard started to work on a patch, but got distracted and I
> first would like to create a passthrough reproducer.

I think in this case it's much cleaner to just ignore the file size.
Old, non-cached readlink code never did anything with i_size, why
should the cached one care about it?

Thanks,
Miklos

