Return-Path: <linux-fsdevel+bounces-15294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8C288BE4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 10:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3891B26F2A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 09:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DD1535CF;
	Tue, 26 Mar 2024 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HA8Prd32"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277874C60B
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446479; cv=none; b=A9kLVbcJiPJlLSiPof87LEilTjPBLodq4awyAT8hWZ8op4ZoZqFLcEkdJm9AaKB/ZIPM7BZ8+By/XPdFKK4fvwO/v2cHU4aqJTWzAu4vHm8XVMfLWuvYSRLe1m+xEEtKJAa0O/SLnefCVffhXpub50BdMxN6tLAQiPd96cmqzzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446479; c=relaxed/simple;
	bh=CpC0tItTXxJwFXoirWnjMrNhkYYoWKrypxWqWWoGUzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNpIJb6Wb/viU70HbIqs574eTL3gth1y6GiyS+zla/4bDKo8fGtMFd2k9sWAKf5OD5KZCRBEHM6VGVyGcOtTng3Pq4pKYC6IL5Jn4QHy/D2pFW1GtAAhPVv10gURyvRsKaX+HndaIUXhrsrSY6HZCK2da2B3hb+2N0CIeLZIiS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=HA8Prd32; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4702457ccbso678843266b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 02:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1711446474; x=1712051274; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qsAi2IPIigNJfNFp22vRBFL+67+CvcQhP68RPXSEF6k=;
        b=HA8Prd32dhdLYTuOT1c0EntHfVIoETJmS1KqHt/ohdWfP0G/iFvM6eFoLgXWbkb9v+
         3p8NiheLiHbtk65a8H+9aRtqsvZRFRRnViVhfAnSVahk8Dmf366T+bYXe7hoLkWjxxtA
         /u9SN+BewV/FqTfnmhL8WpJLt2xNdihc6pHVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711446474; x=1712051274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsAi2IPIigNJfNFp22vRBFL+67+CvcQhP68RPXSEF6k=;
        b=ve9750daDVD1LbtRCiyw6LA48DRFtl4nLXiMcCpsuYhgDhvNLKTtyiuS5GJhO46g9j
         ID5CC9ouiIn3QX8Z1l8WrwU9mkj1SSIxQfq6ZxCz9mzaRW1kxt7HL55bVIQy1HFj8JxY
         uIsvAx1lR9cuoZzqnk3PhCZ+7EY3Qkd99yJV87qHR6mVJE8dNDIJ+lxo82gWE1Emp6AJ
         NP0y2a7W49W3ErKyR4FueMmaISaikCUQdA4k5+1Hv4UmdE0hFoZdAVebEmEajsdkJ5rK
         7065yqcaysWmJ0+DJZpQs9ovMcuAa6DQuhT/8WKRD1dvRcgl+tRpjyOp5hEZCA8BUiZp
         1TzQ==
X-Gm-Message-State: AOJu0Yy+JDTvw2KmBG7hXxQ/3bzPR2OnJA0Px/r8lu0DWEW7p3lQWAow
	uDo4xs6Pns0DWX68aIYXj+PNFTONPwJnmKjM3WICLQRTpwEFJ64n14gM1D+vHvCYUYdA1zF3CWs
	BDwBQfdSO+m3o45gVXbrxGkAy4SzrtLdLccfPYA==
X-Google-Smtp-Source: AGHT+IHL0vByAzM5atnsKLsfU2ike8PqAdV9qKL9COk20raKjo3Jm3y/E9lmm0qvAOOpsYZGr83LkH0s6YFNOxgHUcg=
X-Received: by 2002:a17:906:114b:b0:a46:7c9c:10d0 with SMTP id
 i11-20020a170906114b00b00a467c9c10d0mr5800526eja.23.1711446474292; Tue, 26
 Mar 2024 02:47:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319-setlease-v1-1-4ce5a220e85d@kernel.org>
In-Reply-To: <20240319-setlease-v1-1-4ce5a220e85d@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 26 Mar 2024 10:47:42 +0100
Message-ID: <CAJfpegvTOe8GpsdRUcvi6Ctb7SnBQHrbfP9Kr3Xc4PU5ac0jCw@mail.gmail.com>
Subject: Re: [PATCH RFC] fuse: require FUSE drivers to opt-in for local file leases
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 17:54, Jeff Layton <jlayton@kernel.org> wrote:
>
> Traditionally, we've allowed people to set leases on FUSE inodes.  Some
> FUSE drivers are effectively local filesystems and should be fine with
> kernel-internal lease support. But others are backed by a network server
> that may have multiple clients, or may be backed by something non-file
> like entirely.
>
> Have the filesytem driver to set a fuse_conn flag to indicate whether it
> wants support for local, in-kernel leases. If the flag is unset (the
> default), then setlease attempts will fail with -EINVAL, indicating that
> leases aren't supported on that inode.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> This is only tested for compilation, but it's fairly straightforward.
> Having the FUSE drivers opt-out of this support might be more
> backward-compatible, but that is a bit more dangerous. I'd rather driver
> maintainer consciously opt-in.

In the end the lease behavior will need to be reverted if there are
regressions.  I really don't know which is worse, the risk of
regressions or the of risk data corruption...

Also I'd prefer a more general flag indicating that the the kernel
driver can assume no external changes to the filesystem.  E.g.
FUSE_NO_OUTSIDE_CHANGE.

Does this make sense?  Can you imagine a case where FUSE_LOCAL_LEASES
would be set, but caching policy would not assume no external changes?

Thanks,
Miklos

