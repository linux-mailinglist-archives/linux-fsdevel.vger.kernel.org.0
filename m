Return-Path: <linux-fsdevel+bounces-56629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DEDB19E0E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 10:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0976C3A7284
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 08:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5E624467A;
	Mon,  4 Aug 2025 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="e+1Igswe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE8E243370
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297883; cv=none; b=PtP3YxSZpBtTO5TZMhFF/Z+zP4ZUyj+m005q9ZAZT20PPQzmWmakVfBcLitBxabn3fd43TjqV+cvCxYYA/AkvYR+zyXYPEaqR20THvJHuHWcpJVIKEIpwmN00ETz9kdAANAZRK5cyG9t4Dq/zpdrqZ/6OGvzMOGHKpc+/6Zwwa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297883; c=relaxed/simple;
	bh=rMKPsuA/LNZT53mtPZlD04+HXPrvqoubV0uJH3d9YlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syQzfpK7wdZIVJBsCxFCIuipCeAtiFgLf/At+UuF8QiyEUs8I7Ei9pHOf0OpKTPV6Ulc8EmBNiuNlaQn3AX9PNiuRQOffPeIwlKMxSrKfJ0zvXp/sOY+xfunsAoypf+USWhUNow6gm+7+AV4wzdtQT63tjkv+wcmZvAt5ELNwAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=e+1Igswe; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4aeea63110eso46775151cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Aug 2025 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1754297881; x=1754902681; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+moKtI3kFGQMjrA+sm5yIWFvqawtCi2ghq3vx7zop2c=;
        b=e+1IgsweUsXFbEYzXDk9zfnbX3OgEq82EjDkl91Oj+iQBqMch20Xj9Y95SdJTiU8R9
         kPJGHcN6a3bEneIpfFS+HMewhjQlThfdhL5IgtlqPbW3g03uKgYZw8sAaKOQcq2Swyd8
         kKlbRLVmlZHQqMAyKHDdYfbB94DdE4dlLfFPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754297881; x=1754902681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+moKtI3kFGQMjrA+sm5yIWFvqawtCi2ghq3vx7zop2c=;
        b=UzAJfnQR8aUXYBocjd0Afej2tLP9brGwuCa2a8dZKnw8YFRGTupFQSK9ucB94coZ57
         Vj14YQfAhIwrlGobA5SuFq8ksBdugVE25RTlw7ZuDMmcQOBv3rap8/CdFOmEahUqZile
         poA6dN2G5X9aFusotC8KT8eYdshAr48mAJFyZhFKYuOyvVNurNzq9OtKpuo9Q9L0Gayp
         jFdoQtxLkmy4ChD16OLKiK+PnTdhQlMot2ReovFEBNAxa8SWMuSMMRjlJECQRSzBrfai
         sM19HxBDVdE0UsWTSfPv8p+kRNNAZWU6OmNsoPayqxSJ1mZUeETa1vxBQ1g+iCVJoYJb
         V1Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWqBeBE8KtKO7PAfFIGATF0OhDCQLx4Ex7ljk2cPUq7vYnlmqNqA8CaS7VY9bdU6n/fJR44zrfO9PP0JVOf@vger.kernel.org
X-Gm-Message-State: AOJu0YzJrk+zNLXEWIWM4PjOS6UWECs8YIPs4Gdu3NjImLQvcpJ7Mh3c
	j5wUQrzttdiv8dugslryh+cPO6BPlrR0D8JAXRV8qXbzGJp1VjU6w7MjxxE8MstZgZ1MH5LJJ4j
	U/i/Vl99klFAFiWAfcgks94FkGyLmMwHHYOhQawZl6A==
X-Gm-Gg: ASbGncsKCLlU89/bFOX3MChLDoyJYd+OYHmFBuDHyeCvmo3jTKqPiR2aVWCnpp3P8Uy
	YpID8+IQ8lzWJNRyZGf/cQHMT51ODyFMVwmzsLbt3lwO9qA7p2A8qe6wN76I1hd9R77WwsduBms
	7EIPJjgGo+WqwFFyCp4v54pKe2ydzSLKS3ml8ke9ERnGJQCwzXq83dc4QVu2TPZlevW2fjdevhP
	FhaTzk=
X-Google-Smtp-Source: AGHT+IHycRW29eA0nQXsmFMyfTfL4MJXsfzlc1ljAhwo2MgMd8WlEH0JF9AUOTcj7AyVCgwSa4OnHnSiClGw4Pxdv2M=
X-Received: by 2002:a05:622a:5e12:b0:4ae:f4c0:b608 with SMTP id
 d75a77b69052e-4af10ac4dcemr141129441cf.29.1754297880770; Mon, 04 Aug 2025
 01:58:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716004725.1206467-1-neil@brown.name> <20250716004725.1206467-2-neil@brown.name>
In-Reply-To: <20250716004725.1206467-2-neil@brown.name>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 4 Aug 2025 10:57:49 +0200
X-Gm-Features: Ac12FXzho2f3YnfQ7IGpNhTj4KTqbMXLYR9q6wts381BAVHf1PbdHtnZugBcR9w
Message-ID: <CAJfpeguRdP3zLiRNp=_D8PGS1VjZ-n+y1bPw4X6Wvd-W4uS32A@mail.gmail.com>
Subject: Re: [PATCH v3 01/21] ovl: simplify an error path in ovl_copy_up_workdir()
To: NeilBrown <neil@brown.name>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Jul 2025 at 02:47, NeilBrown <neil@brown.name> wrote:

> +int ovl_cleanup_unlocked(struct ovl_fs *ofs, struct dentry *workdir,
> +                        struct dentry *wdentry)
> +{
> +       int err;
> +
> +       err = ovl_parent_lock(workdir, wdentry);
> +       if (err)
> +               return err;

We get a pr_err() if the cleanup failed for some reason.  But in this
case it's just an -EINVAL return, which  most callers of ovl_cleanup()
ignore.

I guess pr_err_ratelimited() in this case wouldn't hurt, since it
either indicates a bug in the code, which we want to know about, or
mischief, in which case the one making the mischief shouldn't be
surprised.

Thanks,
Miklos

