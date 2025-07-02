Return-Path: <linux-fsdevel+bounces-53589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6318BAF0A31
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 07:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0AA485587
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 05:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3421F30A9;
	Wed,  2 Jul 2025 05:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jwton1pZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C38A1EF38E
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 05:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433079; cv=none; b=u3VfV977CoZpIN4MgjGvYWzwxBsHKfYPKvcWizh854ttWtMmkhevIu/W/qNYRLq5ffu0mknhucxUhZ4Px1cBWXsd1U/BeNi38c/iFHOxxChyS2BW+p5LFudn8VecwqTqIaULhjJlxr1HX0QRPJZkbVVuicrv3eSv6LvuUGr+Idg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433079; c=relaxed/simple;
	bh=Z9dQdXAKnf0aXMqacPVheeFOi8sC5KKmZmgMx4NYYTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euQBhBlvfbAb9EEAjiaq2YDGUfyPzqqtPOdWOKqqmFi7fDyYFBN9qB+xedGtVc4cVVyquvPMPsCWutiEvVwb6UpHzMbZS3VCypUOKJoFPX2bTZPxSkNcXAdXisUAdk7/B+/efW4vhJuouS21bbjx8JiqjoPj+hx/SFLrUM4V3wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jwton1pZ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a58d95ea53so70493721cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 22:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1751433075; x=1752037875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39A7riltgC/pMTMvbUJBbwdnMFL2POw3/zh411n1MtM=;
        b=jwton1pZ1vQrfCKQVzH4jCk+koAb2WmU2XoTDA6i0jltAOTfEirtF5hkgR4BsjLDeg
         DjtUxei+2lhj0trMDd2Juy5CiYLBUINC3HChbbenQyi3xjlaasWTGOjihdcyrurevyXF
         3IY6GpFi2mSwLm0jQU6Pa8Eva04EF+pcupJYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433075; x=1752037875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39A7riltgC/pMTMvbUJBbwdnMFL2POw3/zh411n1MtM=;
        b=xPi2TyIvG6N4Gc8r7s888D3Va1+8PKZBvqlj+HVu7gKdFMSd+WNo5jhJk7tHM67Cj7
         Gn4SqOIl3466ykVMIuiKgiw1CBaqH8OAepUBhNGLRiss7mLqbVFRX3SA9Ia3zzkaU8Rr
         6E7SahQsN8plFfxOF2rjsm2+/aSxfFxj+TEG1airAp9feL1cTqnlJ6pG2wKncnrVCAbm
         6uQ9uqLooF4x442F7w9G7QHXbc3MJBref7nh+NczY/RcHKqNE5IZ0Oi1JmDpj8vFOUAE
         X7d9pBoy4ptP3XyJoPEToHYZMXjH7SKU6hu5hFYtTAkndzjs3TkOEy2uflkvXTH3On6h
         CbUA==
X-Forwarded-Encrypted: i=1; AJvYcCUqPAXh5S179Ikfy/1peuBpSgK/t4wEFQyml/OvrRBAclny2o+KlieKx+20+pGz24hyqbRdpBL5nHiOnx5f@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrx7i2eOZXmnOymmUz4NuBwW9hyU48kRikBRrtlQlcExrdLzdc
	zWp/Fs4xOPsNs7ISpKHJyP2gXOfwtpZcWVIO2FCxKib1VexVcJCcJ8Jx5kg1TzSQwWiLyrZxppZ
	URj1xa5HXha6dCGOQ5Piw5YXl8CiQXqGYdjwGkj4E7Q==
X-Gm-Gg: ASbGncsb3F5z0VaV23grA1HUqh4DKLpX4rVMQHEJMM58ExW0ukthE+3GE4nDoxgidDG
	0jiK/pDAk8d2PAaIiALlJrLPJXj/bdG9sdS/b+hec6pN16oa0ml+e+s7nMDP/kUHkii6zgUvjZW
	7p0oQrilN4A2EM87MSRb0mqKz5Bi+K20eO3z9rfqRuYR3vF8UcbC046POG3JEvfvbf0HUZSoI3A
	0vqieOfym0r/8A=
X-Google-Smtp-Source: AGHT+IFAZ2Ggt7L6FwNS6Sb0whPR01gwHwY7a3pdJQip0QYzrqFWmzBH2hoAm+Nnxnd0g7xLU5LUQ/ax/H6vCjPCsek=
X-Received: by 2002:a05:622a:4d0f:b0:4a7:23a3:c562 with SMTP id
 d75a77b69052e-4a9781f9fb4mr22045271cf.22.1751433075344; Tue, 01 Jul 2025
 22:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com>
 <CAJfpegvhZ8Pts5EJDU0efcdHRZk39mcHxmVCNGvKXTZBG63k6g@mail.gmail.com>
 <CAC1kPDPeQbvnZnsqeYc5igT3cX=CjLGFCda1VJE2DYPaTULMFg@mail.gmail.com>
 <CAJfpegsTfUQ53hmnm7192-4ywLmXDLLwjV01tjCK7PVEqtE=yw@mail.gmail.com>
 <CAC1kPDPWag5oaZH62YbF8c=g7dK2_AbFfYMK7EzgcegDHL829Q@mail.gmail.com>
 <CAJfpegu59imrvXSbkPYOSkn0k_FrE6nAK1JYWO2Gg==Ozk9KSg@mail.gmail.com>
 <CAOQ4uxgM+oJxp0Od=i=Twj9EN2v2+rFByEKabZybic=6gA0QgA@mail.gmail.com>
 <CAJfpegs-SbCUA-nGnnoHr=UUwzzNKuZ9fOB86+jgxM6RH4twAA@mail.gmail.com>
 <20250513-etage-dankbar-0d4e76980043@brauner> <CAJfpegsmvhsSGVGih=44tE6Ro7x3RzvOHuaREu+Abd2eZMR6Rw@mail.gmail.com>
 <CAC1kPDPZ5nw8qmvb5+b30BodNh+id=mHb8cTfJyomtL0nsVK=w@mail.gmail.com>
In-Reply-To: <CAC1kPDPZ5nw8qmvb5+b30BodNh+id=mHb8cTfJyomtL0nsVK=w@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 2 Jul 2025 07:11:04 +0200
X-Gm-Features: Ac12FXxTBrVwpktrx3T9XvaGWoNpyxuO-t08Krlo0OOu04fSsoekxJo_XlJEBZo
Message-ID: <CAJfpegudqYye8=m=ZOMFnQ8u5tp0vsLPutV9ikM5_NLVOxMoUQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fs: fuse: add backing_files control file
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Jun 2025 at 08:12, Chen Linxuan <chenlinxuan@uniontech.com> wrot=
e:

> In my opinion, adding relevant directories and nodes under procfs does no=
t seem
> to be much different from what I did in this patch by adding nodes
> under /sys/fs/fuse.
> This kind of solution would still be a somewhat =E2=80=9Cnon-generic=E2=
=80=9D approach.
> For io_uring, scm_rights, and fuse backing files,
> these newly added files or directories will eventually have their own
> specific names.

Why?  Name the attribute "hidden_files" and then it's generic.

The underlying problem is the overgrowth of fdinfo files.  It was
never meant to contain arrays, let alone hierarchies.

Thanks,
Miklos

