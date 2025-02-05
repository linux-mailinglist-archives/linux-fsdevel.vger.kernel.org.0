Return-Path: <linux-fsdevel+bounces-40966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE5BA299B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 20:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68DED18893C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1C61FF5FF;
	Wed,  5 Feb 2025 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9rq1awu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E565944F;
	Wed,  5 Feb 2025 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782335; cv=none; b=H/jL4g8sMHQGDN+7Vuu5hptCNhtQ78u80XhECJVbFfbC3um3zeXtlDPg3ckxIaXF4bwPa/fA3tSUqAuoZdv6RAH0VSyfKvx3DSdYBSme5mHX4g8tOHbCv7BJGy5xybueFOSjujBsJJiMKAFbRcs37n1M8igVA1oJ2+GidRAsdnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782335; c=relaxed/simple;
	bh=t7CLcELsQh973O7p17cqjk2r4r5zWT8nJXohkTPsaZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J71RZY41hQWzMH9kXEZb6mpjgIFtLckVqsGOv1ExbnaBYx4VWy/K+C4pyHMEkQ9gkm3sQtvJsnXxv+uNxL+KaIxPKbuKdcdMvYzcDU4iw3x0fq2esPeNSbe/D3ZNFkyI53SB21UQBD3AL4dETKvFfjLweYVbxW67lNUnK4qVvBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9rq1awu; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so338381a12.1;
        Wed, 05 Feb 2025 11:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738782332; x=1739387132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7CLcELsQh973O7p17cqjk2r4r5zWT8nJXohkTPsaZA=;
        b=E9rq1awukbOiLLJ1hdAPSsU8TVQpYAl2jRwEdqCG1mOKyDFcohUj/JOhNnsYBSqbYK
         RO1/vUQP58VyR+JK2hGsiE2d8BasHxEgL1TPsMikqHiXPaJ/LAhBxZE1Vra7whk1JIpk
         3K4JVbKxJe0CjkY1lL7FamNeRiWPSPL4NY6agLAP/xHDt1bDD9HINZsreW+x8tqeqlC6
         Vo2+/PHdETFxHQCODMNgDpBFuSu60nluHxCxKveAVVlgFCp1TUyF/mMPSC3NZFD1awOv
         xpD2LOJmyfKx1ZQNKAlmlC15n/a8upE3+eIgnQuDR0MqH29t3YVcG1vW5jNTBmAny7g3
         eOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738782332; x=1739387132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7CLcELsQh973O7p17cqjk2r4r5zWT8nJXohkTPsaZA=;
        b=eb3xi3YhXtRvg3jWVPexBc2O4Dl9Lj1N5QPRh/97W2TFfJAhAZk2p4Q/tSlg1lK4g1
         rtKZWHbph/K9SsaXqty5oJhNfmfy2Rtz1FkATtLAN53X6yIl7QGKyOlUDfUzhJGpJpRu
         H5LPa6KSqm+RBmAprbpSAN6VNIzv9rgc1oBuUvoaAVHTyXlHSUxvOYb70cXoVDtM7eB5
         5nQx9c0cjWwT+eUh/rgfW9NgjkVyvjYdTba5q2m0RzY8ooFKRixgh8c5ksOfeiddo0tY
         FmlejFrE26gCKPRwlYEbxKbU6HwhajbzruBNkT9ZN/bn9qQ93VaDcijKNHFmf1QAoU1j
         vC4g==
X-Forwarded-Encrypted: i=1; AJvYcCUu4PBvaYMAlJVd1WkqHEYWMjD4/i4MyZcJUkb7cBontTPvTM9x7VSoqfwmhBjtMsDhvP+toyLZlDst@vger.kernel.org, AJvYcCXtsl8CuR0xqoEDivD0DWO2HTZXH5b8XIcOoDiDqw/+TCg+/mqvmaxGrEJRFtxXCHoazF8rRPrp3rCuvWKQ2A==@vger.kernel.org, AJvYcCXucnZkDT5qAF0h1BfIQMgoWD791MnWXHAsI0p7DUx8j13gMwDCNYzYVeMY6M+mk4ddvOAXrkFYE/mMe0aY@vger.kernel.org
X-Gm-Message-State: AOJu0YyDorLfaJtQMOskquIlXDOpzhCdxP5hFWRfZWAFPMKZZFQnns48
	eJI7L3ME8O2QT3M9l7eGNpU3OCswzwD/xz7FH8CXKDeG4HiUqs3eV/iV6KCtYW7toDjayoldmFG
	lT5/0Iof2/r6KLpnTXywKM5kvKZCPEockf/4=
X-Gm-Gg: ASbGnctSgLTpRfNjE9/KzFYhSKt6X7ef2pvIr7iglyAlivW0SGwnlboIYiV7/CwNoPm
	xa0P0T0c/xnFofD/Dm2dbae6jcqeNTfIs0B8h55qCIF0ZEhhSeNbbuTgKtUKMUHuimnRGEqg=
X-Google-Smtp-Source: AGHT+IG3mFXOSETMuRLYoBorSgJDSpYyNUtn5qdCuV7P8c/VZ9qYcepSmEhPEERHaWTVcONUV1ur0S+LuU0YsZiDq0E=
X-Received: by 2002:a05:6402:321e:b0:5dc:88dd:38aa with SMTP id
 4fb4d7f45d1cf-5dcdb7329d1mr3930229a12.8.1738782332358; Wed, 05 Feb 2025
 11:05:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205162819.380864-1-mjguzik@gmail.com> <20250205172946.GD21791@frogsfrogsfrogs>
 <CAGudoHENg_G7KaJT15bE0wVOT_yXw0yiPPqTf40zm9YzuaUPkw@mail.gmail.com> <vci2ejpu7eirvku6eg5ajrbsdlpztu2wgvm2n75lkiaenuxw7p@7ag5gflkjhus>
In-Reply-To: <vci2ejpu7eirvku6eg5ajrbsdlpztu2wgvm2n75lkiaenuxw7p@7ag5gflkjhus>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 5 Feb 2025 20:05:20 +0100
X-Gm-Features: AWEUYZlEukpyDH6KkkJOMLlhg_MSebSSFDdpkMUnF0LkYkWDJQOFg-fGvZBow5c
Message-ID: <CAGudoHGjrS30FZAM=Qwqi1vxpdkPQyXGsW7-xONeSE9aw8H3gg@mail.gmail.com>
Subject: Re: [PATCH] ext4: pass strlen() of the symlink instead of i_size to inode_set_cached_link()
To: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, tytso@mit.edu, kees@kernel.org, 
	viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, 
	syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com, 
	linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 7:10=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 05-02-25 18:33:23, Mateusz Guzik wrote:
> > If the ext4 folk do the right fix, I will be delighted to have this
> > patch dropped. :)
>
> Yeah, let me cook up proper ext4 fix for this (currently under testing).
>

I see it got posted and tested:
https://lore.kernel.org/linux-hardening/67a3b38f.050a0220.19061f.05ea.GAE@g=
oogle.com/T/#mb782935cc6926dd5642984189d922135f023ec43

So I consider my patch self-NAKed.

Thanks for sorting it out.
--=20
Mateusz Guzik <mjguzik gmail.com>

