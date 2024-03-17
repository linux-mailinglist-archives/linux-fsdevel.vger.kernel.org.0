Return-Path: <linux-fsdevel+bounces-14654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F98087DFE3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 21:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFCBF281A73
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 20:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5E61F605;
	Sun, 17 Mar 2024 20:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxPU97hX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE45F1EEFC
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710705619; cv=none; b=MiI3YHyEo2t9vYSORLcFNYMuD7w7O9+tP/MwIpRSAc5aRffN0qA9fnkSFNfpCEpHoaPjTg3FDcjR2hctryKSLqRrNd615EhesIFAIqODrTcsmNWdxui2lWZREzsOAicbYnsxMiMsAPJx3LBa6iaF8ASe52KXR7nMG8rDdqj2xYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710705619; c=relaxed/simple;
	bh=suMg0LM2sx9IwR4Ac0jgxB7D3CCV3ClZ+/1jh43KBic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVnN/pWMb+j6h7uHxrA9zaKAKP+SaOYBr9amg+Iusx+1etHqItY2M2/89BLbSf3mmcyEV+rzJ51VSFEkfPBUUniNQNmG6/vpBk4Ug0/auq0yCnFKpjOYAOt+AUZBBoSslZyT8iYilrUZBHTuZeCkjj+VcnDxW5YYJdbm8FRPsqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxPU97hX; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-690c821e088so25470346d6.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 13:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710705616; x=1711310416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMX+ribHo+y2w0HTooM6si8l69ZWxK8PUy8NnkOxeFg=;
        b=SxPU97hXXiC1er/W1dX+o442Rx52lawKVakVE6bYLQpGWy52WIBPIXtfRpajxmKBIm
         K5dib1T50XZ28TL23vQjNVRBk8kTtGW3Vefs11dVPo761kbrQhMBhdEiHT3XBOb/yakI
         A2tuNBG+KCXGkoI1bJAoa5P45soMgAaME8+rCZiGyJ7dlLj9IDUStWU9Iu38ddFdMU+x
         wdrKdK/nOII4MKP8pkd8muKCpizwWKdkW2jQmlBG7SY73lToVYYKt8d7uFk8/Lar3T8K
         ri7jkTSz8BNWTI8FgtNPhR3a8Dv8pDZNgNEVuK3BqQK0fcYPtO5JPkVnIU7lhRgKFdN6
         1jDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710705616; x=1711310416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMX+ribHo+y2w0HTooM6si8l69ZWxK8PUy8NnkOxeFg=;
        b=UXe972tuVzAgAF5S4cI5kFa1xxDDSg9JkT4BAoPRVMb64pmotRsR//PKx/R/b1akpU
         JbfgEfluoKPADIb1TiZk77tdvXpI7SHn41LRUXj+4FKLK/IaDzKaRrww/BCL50FzGBzG
         ZQv0twtJPQikX99eStKsuCtKY0PGB0R7ctFaP3hpf1IXQ+uIptXcj1q929BElZsRRiLs
         0dlxHBfjhuYA8DboexpzYOV9eMP18gqmCOmQrpiSx5KYybqvoxYEPHoODNuFxWJHJslz
         3wmK6fKcF/F8T1fbxBF0QH5LrpyktWhr43lFqCY6iqnaSD5LP86f7PTsauKAfLow+pSA
         2H0g==
X-Forwarded-Encrypted: i=1; AJvYcCXNCPA4Dj6nXGvh2JMeyR2SgnYp8LdTx+LgE6mqjtVB9YuIlbBA7cmBvqLdNYOy+G8uQzN57O2CjHw0UewZpwuWh7ks7tUD4iQhy+BcuA==
X-Gm-Message-State: AOJu0YxZH3ccRhtJiU8NrtEJG45pbB5v+8x5FvRSG8UcUQ1spGGQVrUS
	1UM74Zl1FLide6gbZGPaSCs1XM5d3g+f/rg+w2wk8JzL5jR57FkZUYuW2oTxcjWD09C5JoeFHqR
	wrKuMYzLefPMm4dyfUMxwkosV0ow=
X-Google-Smtp-Source: AGHT+IFn2PCgnutFll498icV0aKu/XFyzwZMxZ56uodr9ARdtiQjzR4MTnQ+P+FwIHBeQsv3O2hgwchctER1wfjAn6M=
X-Received: by 2002:a0c:ab17:0:b0:690:8842:820d with SMTP id
 h23-20020a0cab17000000b006908842820dmr10658968qvb.40.1710705616634; Sun, 17
 Mar 2024 13:00:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208170603.2078871-1-amir73il@gmail.com> <20240208170603.2078871-10-amir73il@gmail.com>
 <CAJfpegtcqPgb6zwHtg7q7vfC4wgo7YPP48O213jzfF+UDqZraw@mail.gmail.com>
 <1be6f498-2d56-4c19-9f93-0678ad76e775@fastmail.fm> <f44c0101-0016-4f82-a02d-0dcfefbf4e96@fastmail.fm>
 <CAOQ4uxi9X=a6mvmXXdrSYX-r5EUdVfRiGW0nwFj2ZZTzHQJ5jw@mail.gmail.com>
 <CAJfpeguKM5MHEyukHv2OE=6hce5Go2ydPMqzTiJ-MjxS0YH=DQ@mail.gmail.com>
 <CAOQ4uxh8+4cwfNj4Mh+=9bkFqAaJXWUpGa-3MP7vwQCo6M_EGw@mail.gmail.com>
 <CAOQ4uxj8Az6VEZ-Ky5gs33gc0N9hjv4XqL6XC_kc+vsVpaBCOg@mail.gmail.com> <CAJfpegv9ze_Kk0ZE-EmppfaQWc_U7Sgqg7a0PH2szgRWFBpHig@mail.gmail.com>
In-Reply-To: <CAJfpegv9ze_Kk0ZE-EmppfaQWc_U7Sgqg7a0PH2szgRWFBpHig@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 17 Mar 2024 22:00:05 +0200
Message-ID: <CAOQ4uxjrw58f=8-xepx4s9sReAR0WtWQ+Q=B0oKbMZkJPfRftA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] fuse: allow parallel dio writes with FUSE_DIRECT_IO_ALLOW_MMAP
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 9:31=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Sun, 17 Mar 2024 at 14:54, Amir Goldstein <amir73il@gmail.com> wrote:>
>
> > I see that you decided to drop the waiting for parallel dio logic
> > in the final version. Decided to simply or found a problem?
>
> I don't think I dropped this.  Which one are you thinking?

My bad. just looked at the wrong diff.

>
> > Also, FUSE passthrough patch 9/9 ("fuse: auto-invalidate inode
> > attributes in passthrough mode") was not included in the final version,
> > so these fstests are failing on non uptodate size/mtime/ctime after
> > mapped write:
> >
> > Failures: generic/080 generic/120 generic/207 generic/215
> >
> > Was it left out by mistake or for a reason?
>
> Yes, this was deliberate.  For plain read/write it's simply
> unnecessary, since it should get 100% hit rate on the c/mtime tests.
>
> For mmap we do need something, and that something might be best done
> by looking at backing inode times.  But even in that case I'd just
> compare the times from a previous version of the backing inode to the
> current version, instead of comparing with the cached values.
>

Well, looking ahead to implementing more passthrough ops, I have
a use case for passthrough of getattr(), so if that will be a possible
configuration in the future, maybe we won't need to worry about
the cached values at all?

Thanks,
Amir.

