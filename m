Return-Path: <linux-fsdevel+bounces-15888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81F189578E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 16:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2506F1C20980
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 14:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7583012BF1B;
	Tue,  2 Apr 2024 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CzgL9RzM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FA6129E78
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069672; cv=none; b=mp363V8iuMfovROmtOnOHxEiOrAZUZ5YlvZcB++vsnzu3QFECc54J8lXHWmDQJl7UFJVF9kPWIon13n39Fo2vqW1Rpi2AVyzeU9WbSMZQpfVvwR/TfyOxBrd8ZlbbHCeU+EGcFiY77oWhFQ7PVup5JnvIbkymMJkqs04qP5LTWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069672; c=relaxed/simple;
	bh=XhHqbYUE6Sx2oXD4UwzUkAidMzUAqX4XcQB43g8/Juk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grWAKoSZM8EnNspmBRONezxF7oHOV5deORvWTnRdWXdCLDxRCWhXDcdWkjL+l1qppeVeUatYGMNkaZdSPw7kGuplQTKPBygIvjgDz//7uXBIjY8UvkCCeBJF77/j1chQPUDaz287vSkL38WpmBjpGCAhtdPLmZkj+WP6xzbEwQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CzgL9RzM; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4e60a64abcso351408466b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 07:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1712069669; x=1712674469; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XhHqbYUE6Sx2oXD4UwzUkAidMzUAqX4XcQB43g8/Juk=;
        b=CzgL9RzMGnY0+BA1XuU0yV6fA2fMLzh14fbb1EUNV8bPAXX9mn9Oo5pgYxhlLWgYm7
         7yR20Jy/Y+uZFal8F4S1gMDg6SebWCirAtoxgobYw1QFwv7EtRF3gQ89OA9cxslhdavd
         +QsuajtlLfo5zGMpPiGls0tkeISAQGGcDU6us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712069669; x=1712674469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XhHqbYUE6Sx2oXD4UwzUkAidMzUAqX4XcQB43g8/Juk=;
        b=mi7aAqy4hEh0iLBolRs7p82EG//jecZ71Rz+IvvGH5M4g9rf6wV4LNeABk09n6LfJM
         vL3+q7YBJQQLZlZGH5ijFo1ExsLDkYuCNlNZdQH1BJfh4/NRyMEBC6H00m2cEMYB2enu
         3MO808VWA1tFFaBoxODEAXJ/h7g7inBlHeJDPdktlYEOWTFkkxU3OYpJeOv3la9x85FK
         jwsIqH8A/9qE0tD1uhqxPhTOfX7hNSIfZYpxIYzDj36fZQA8CffJj8CoZD3eg9EBGH58
         /mjgFOc6TGVMd6E64L56Gntolxx803EWPbXUXKId78/6XAnHvTu/RkP85hTO4XcnUdSy
         m5zA==
X-Forwarded-Encrypted: i=1; AJvYcCUMnQerPbnBLGZJONK7Um9ZMSIoV3juryp/vzSU1rL9ONIbr/VMU/0cC6RGRMAx2sJKywU+j11v5de/ctV51IZCE4lbs/xBIDCKizkQsA==
X-Gm-Message-State: AOJu0Ywpjva0v7BLzhzPoOkTlLr+Mqkn+MuJJWRkaeD2basZa/mh0Jfg
	FlJDzWj4r2VRwq1PHlMMgMpz2/OSrOsRctzH0nT/y1bTmv2ORfgw/qb2HpRj2ISDyrvYfS9T4+A
	t/ZiJaO/bglQNXCrd1ZhaRH6QmtwENVV4u/NZP1btVcUMaUwQ
X-Google-Smtp-Source: AGHT+IEfPsC0av5KNUW2YwqX9Ii2cWfCfOzCgMFH2tQFtuKqbx1k0z9SiaRv2Dtswp06nVXO7FYfzwuU2PtAB+0IZeA=
X-Received: by 2002:a17:906:f591:b0:a4e:1d5f:73ae with SMTP id
 cm17-20020a170906f59100b00a4e1d5f73aemr14164406ejd.12.1712069669482; Tue, 02
 Apr 2024 07:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402-setlease-v2-1-b098a5f9295d@kernel.org>
 <8a8e8c0d-7878-4289-b490-cb9bf17e56b9@fastmail.fm> <f6bbdf158f0ca7a12de9b9f980d4d7fa31399ed9.camel@kernel.org>
 <CAOQ4uxiv7xSUS7RDK3esa1Crp8reYXewxkr5fFbhG623P20PwA@mail.gmail.com>
 <CAJfpegvRDKS1kKrMPyqzmuSs8KXZ2ohpwp0nEzEf7e3vv940xg@mail.gmail.com> <fbd0b9e5fb765eaea98fef23e9e36f266d7926ea.camel@kernel.org>
In-Reply-To: <fbd0b9e5fb765eaea98fef23e9e36f266d7926ea.camel@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 2 Apr 2024 16:54:17 +0200
Message-ID: <CAJfpeguWCNDzAuDndB8pbcai5c+ux3KLtrAaAOuh74+wCtZBXA@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: allow FUSE drivers to declare themselves free
 from outside changes
To: Jeff Layton <jlayton@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 16:51, Jeff Layton <jlayton@kernel.org> wrote:
>
> I'm fine with whatever verbiage you prefer. Let me know if you need me
> to resend.

I'll do this, no need to resend.

> Another thing to consider: what about fsnotify? Should notifications be
> allowed when this flag isn't set?

Aren't local notification done for all network filesystems?

Thanks,
Miklos

