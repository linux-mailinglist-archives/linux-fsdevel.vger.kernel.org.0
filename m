Return-Path: <linux-fsdevel+bounces-44438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7C6A68C58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 13:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275FD189BEEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 12:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C56255229;
	Wed, 19 Mar 2025 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSDGpB7I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7932D253B7B;
	Wed, 19 Mar 2025 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385870; cv=none; b=tNUJiwcuNsyWhii6VfE+G6DW4EC65iTA5j7Qx0yZ7Pv+OCPvFCXaO90cDRVWUQyHmq4xYjJv292gg2g2JxNbPTu8MODfMYP57FzgxLo9m97IxDw0LMVAj9A1dYIZos92GA4hyyS3bOjf9d9JaACIVIFCuZurekFRszBHA079uuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385870; c=relaxed/simple;
	bh=WmXx4bS7gYhJjRBKivFDUzEpM9fup72qFUElBjByfJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNkRKqiofmJnaAg89h1Q8jmejUcLJSWzEpHd5HRfxjTcA9uAKoa3d4pJidlpWU9EsgT0vi26G/g+NOHcCVv8nF7G9UcoOSXhblVkoaIyLs+6iqsIvGKlKAMNph1qW8LQDH0jT2YpPoXIFyTNv970eOQadzCd6T4QlxbLU3tGraE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSDGpB7I; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso3116236a12.3;
        Wed, 19 Mar 2025 05:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742385867; x=1742990667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmXx4bS7gYhJjRBKivFDUzEpM9fup72qFUElBjByfJs=;
        b=LSDGpB7IrrekUUShFXCtbweDOlsdVbWZtJ8HLEsl4oxkpjLK5mUWhSTRSV+FJX2Rh9
         Hnh50kQ9stZQldj4Px2s2inWP6lPU4sHKItBJyfasq3LVEpXapwVRwh7janaZLLFRx1e
         iQpuz02mP2aJ5TqqNOacZOxArKWVyCNXkgJiKaZ+4FbJmsJwNERd+3TYAnfntnJREKOk
         ZbeF/Lkfr4Mk5bywItSEUmOFhHi5lcoRoFeYowU/1HDUeWkgOfagiHxGj8MHJDF+blMF
         k5QM6ThE03RG+hKRsT/PJeiP9aEnAsNX5izRTF/D7Ko+e6/XYdM6dywk44oFPygbJ9Gm
         NgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742385867; x=1742990667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmXx4bS7gYhJjRBKivFDUzEpM9fup72qFUElBjByfJs=;
        b=H1t7PxZW4Z36RA1W54cpUYFjrmtnxffpofFbmg69n1z5lGsuu77RlWKMVDxAZtQbLA
         tecExEbAxN/xXRNpoxoVWws3+kf/nzbHVAQMjd/eP4GK02Y9c7FZQ4u3/qN2QsN60I4M
         QUJSpkfVPaC9HaaRaM5SefGTcJb7yjftkpWkeqAhbvGZgWMsRNg/b5AY5bCD2Yods7cc
         KsDdA1CkzgcNh9HgqlJ52wqjsYXocYFnB2KgKD/8pCUFvHcVl3J9XnyANM/EK4bfeo+T
         n5t4rU+FCJ4RiZ/hBaMohD78QLKxxUqeVcaQhk0DAdzsHVkyfNYyyo+wFz0vdmWyPVDW
         IbIA==
X-Forwarded-Encrypted: i=1; AJvYcCUU3jbwnwPRii1hur++/ECn5eoi0i7jSQQukWXp9jXYem1IIn/sZzx6FbqA7vGW59V1ZuTCPvqhIfEYNwXe@vger.kernel.org, AJvYcCX4Bt0xVQbMMjCbj8Ggrm61OGW+7DZgAjYLe9ZgC6L0BVGaJKCXCEE/7N40XkFmR5lbbvAdZTvLFKuIymYF@vger.kernel.org
X-Gm-Message-State: AOJu0YwGuryizAcK7QIxm5jHga5KqcPPVKi+PEgv9zVgao360uwGsh2v
	3ccJZLpglhb7Yj6HEs5QoTkzjhIM+dR5LJILZnIgxJSpiqLaxo61oXkBWB3iaNnBiARG9I5UZoL
	ioVuSkIcGFBuTjrgojz5ZoWInGhs=
X-Gm-Gg: ASbGncvmUBLz1ukc0pF3TrCLx33OHNVRrV3YO6Py5KsjWhlp2tvL8Zkx7RdkrpeYwQ/
	1YttvmMCc/4Xdsy7nMLTSFmhTFXiZ8twRT3qxRdcSXZ7sQG7MrHSSrdhm9n38ogQOeg9SM7fV+U
	3TK9IJGA4UzLDZDQ4UY1kcyoWWTbzWkTHdARpK
X-Google-Smtp-Source: AGHT+IG6PF4ZQtoeh6iicrqQsCPPEvyzdAtYtZscAoUXBB+3C5gG7BWG47ZdqLIy50KcE4Lgbg4+Hv6J9EZax4UGhr4=
X-Received: by 2002:a05:6402:1ed3:b0:5e6:17e6:9510 with SMTP id
 4fb4d7f45d1cf-5eb80d06482mr2849727a12.6.1742385866463; Wed, 19 Mar 2025
 05:04:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115094702.504610-1-hch@lst.de> <20250115094702.504610-4-hch@lst.de>
 <ptwb6urnzbov545jsndxa4d324ezvor5vutbcev64dwauibwaj@kammuj4pbi45>
 <CAGudoHEW=MmNLQSnvZ3MJy0KAnGuKKNGevOccd2LdiuUWcb0Yg@mail.gmail.com> <20250319062923.GA23686@lst.de>
In-Reply-To: <20250319062923.GA23686@lst.de>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 19 Mar 2025 13:04:14 +0100
X-Gm-Features: AQ5f1JqADt1B5Vnfp9K-CCKF_SgF_2UO8WraUUYZPvq8yjlFO1pbUd0LcklvaxU
Message-ID: <CAGudoHHVd8twoP5VsZkkW_V45X+i7rrApZctW=HGakM9tcnyHA@mail.gmail.com>
Subject: Re: [PATCH 3/8] lockref: use bool for false/true returns
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andreas Gruenbacher <agruenba@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 7:29=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Tue, Mar 18, 2025 at 04:51:27PM +0100, Mateusz Guzik wrote:
> > fwiw I confirmed clang does *not* have the problem, I don't know about =
gcc 14.
> >
> > Maybe I'll get around to testing it, but first I'm gonna need to carve
> > out the custom asm into a standalone testcase.
> >
> > Regardless, 13 suffering the problem is imo a good enough reason to
> > whack the change.
>
> Reverting a change because a specific compiler generates sligtly worse
> code without even showing it has any real life impact feels like I'm
> missing something important.
>

The change is cosmetic and has an unintended impact on code gen, which
imo already puts a question mark on it.

Neither the change itself nor the resulting impact are of note and in
that case I would err on just not including it for the time being, but
that's just my $0.03.
--=20
Mateusz Guzik <mjguzik gmail.com>

