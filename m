Return-Path: <linux-fsdevel+bounces-29908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8278A983985
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 00:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15EC1C2147B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 22:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0003E86131;
	Mon, 23 Sep 2024 22:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ab4smDkZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C958F84A21;
	Mon, 23 Sep 2024 22:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130050; cv=none; b=hJulqT6DsGT4JfsV+X6ac92NNv7N7C6gefrwz836x3fOASDQsTDVJuvuaF1MxbWWI8McHpZ2PrAVxTpH+5PUpWz/WHuFhW6urU6zfYkFPdjnPfWusI2pJfN/qZYSvNFrmNQgd5lMRyyD5ON/9SRVcajqznsKNDbwrFTIosYaOWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130050; c=relaxed/simple;
	bh=I39zkW/kbT3Ufd9pmx9Uzp6ZFsPoalu4/LQvA0A1FO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMgBij/E1W6SzQ7XilNLC01ywn5ghUpg0S6JozoS2djRaGhHUVfyvzM0k1vEt97XGFkgPZr847juhn0StmHvBauDdHa61r0R36auMSOoqaSXYOaZzL15xZ5viZlRWhGw0d+vTM2n7TUUkf/EoGce4YJCRMYa/EEItCI9Crjzd7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ab4smDkZ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-537a2a2c74fso1198966e87.0;
        Mon, 23 Sep 2024 15:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727130047; x=1727734847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNMtJL71ZDx/2MpgXo8xbuzvbC5cBg0WyIL0f1AlPoU=;
        b=ab4smDkZe9ff69bIzZ/6tiu+wP/i3lvxg2IXI0jH7hXR9+Kq0w9RZjq6GAJyiMnNKO
         DnsoevgkvzA+TpdsFNz0s17QAq1S2CMslTie7LI1twuXnj2nBwX/LLtmgZW+ieMdIUpq
         /dwVeEPDqQRTysaZ1xNz1vqatj2ChaWMN9iEvUoo3+j6eEA3nKJ81roUM9aQeDd0ISBo
         jlKu3qwCLCps9KDWqFevCduOec+5RcU58NWxH1ggjQYsgG5S3P8BUyGoO8nSjNY+O40X
         qYgQaHFRAQSlIq4TrNLmxgmLgYclqyIy6Ln+tJOYX4cPXEqJdBm70Z8UEkzDh3Y3ynGm
         Ad3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727130047; x=1727734847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNMtJL71ZDx/2MpgXo8xbuzvbC5cBg0WyIL0f1AlPoU=;
        b=HBGhL5eJNg+6snW41o/zUBXf/94GPza43R+6wnTR3uWW+Sk4aiJtAH/g28zHWJZ013
         suOybTzThlQYr+7eKbhK7R2JQvGPNEbkaX1eoUdW14xgNhZri7ukI+iimR14hVFV49Oh
         mADWG9gm9H5vap/58xeHKK1qMWR0jjSbZ4RCAkASO+jYvB32U/r/Cr0cAv+uez8KFjT9
         g6IT7MlFu0YF9zRdMXt5ZTJtY1nqNa+4HT4mjZv/fX9/uGpfvqETYejZl1vM4ftAmoFL
         uBm3xCzAVOuz5KuYGZGU+aFuJjnthYO1Wjdj37XTBBIzGMMg5omUM6jNuM1fqdNeEmqu
         REsg==
X-Forwarded-Encrypted: i=1; AJvYcCUOOmVPWKWrvioSOYoUScaGGWIDk5w8anueXQxsYeBm836SfYIEdl5TX6r5eICRVu22PTXAcnz5IzdB@vger.kernel.org, AJvYcCWartzUh1bd/EEn+9m0Fk7JVofXeiyZ1pz9YsSveP7rjBP8LI14Pu2adjbB3rh6eQRZN8ZsZ6eV7lGNM0ERNQ==@vger.kernel.org, AJvYcCXp9KqOszT9lmVs76s2JvA7QdLJ5v4gZlwG45lIEMW0FqfPE3XZUv5g1Scm5oL3pu/qGbCzRtA2EoX7iA1g@vger.kernel.org
X-Gm-Message-State: AOJu0YxxQm/H3zrPttryPjyYA6yr/yab7stls6RAyyD9K7Kl5oTdE1va
	X3+B7RlH6jWG6zD9GOMOY5cksDyMZegcqLzVxNkHOb5FOS5TJCVMuIurbscJp6KjK1Ud+8yQZAX
	QVUSprsjqA3BTtLo214ypnHqPrcE=
X-Google-Smtp-Source: AGHT+IFSbGoovaCTItwXPKaGxT+vP85QVsKRZkmCJA5rZZuojl9Rce9M7PI4TZVkGutC62+PVBjxG313v9PS8/TSX14=
X-Received: by 2002:a05:6512:3510:b0:537:a82c:42ec with SMTP id
 2adb3069b0e04-537a82c44d1mr81547e87.4.1727130046730; Mon, 23 Sep 2024
 15:20:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2390624.1726687464@warthog.procyon.org.uk> <31d3465bbb306b7390dd7be15e174671@manguebit.com>
In-Reply-To: <31d3465bbb306b7390dd7be15e174671@manguebit.com>
From: Steve French <smfrench@gmail.com>
Date: Mon, 23 Sep 2024 17:20:35 -0500
Message-ID: <CAH2r5muENv0sQ0+Q6xtDA-ThVu8B1W9=3-Yy0nOhX3onVVUXFA@mail.gmail.com>
Subject: Re: [PATCH] cifs: Make the write_{enter,done,err} tracepoints display
 netfs info
To: Paulo Alcantara <pc@manguebit.com>
Cc: David Howells <dhowells@redhat.com>, Steve French <stfrench@microsoft.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

added to cifs-2.6.git for-next since it is important as it fixes a
regression affecting cifs.ko

On Thu, Sep 19, 2024 at 11:01=E2=80=AFAM Paulo Alcantara <pc@manguebit.com>=
 wrote:
>
> David Howells <dhowells@redhat.com> writes:
>
> > Make the write RPC tracepoints use the same trace macro complexes as th=
e
> > read tracepoints and display the netfs request and subrequest IDs where
> > available (see commit 519be989717c "cifs: Add a tracepoint to track cre=
dits
> > involved in R/W requests").
> >
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Steve French <stfrench@microsoft.com>
> > cc: Paulo Alcantara (Red Hat) <pc@manguebit.com>
> > cc: Jeff Layton <jlayton@kernel.org>
> > cc: linux-cifs@vger.kernel.org
> > cc: netfs@lists.linux.dev
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> >  fs/smb/client/smb2pdu.c |   22 +++++++++++++++-------
> >  fs/smb/client/trace.h   |    6 +++---
> >  2 files changed, 18 insertions(+), 10 deletions(-)
>
> Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
>


--=20
Thanks,

Steve

