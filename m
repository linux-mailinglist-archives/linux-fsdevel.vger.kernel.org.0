Return-Path: <linux-fsdevel+bounces-51785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89A4ADB59F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 17:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7D517188B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 15:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7794A25A2A1;
	Mon, 16 Jun 2025 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nzoh8IYa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C7D21D3F6
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088226; cv=none; b=lM90Bk+AqKtfMJcKtkDa8odg+uurNBPexyBqfnmW3eVMItLQwwYB8aTUNlLKjlmnVuu0uzuHevS/FPGSelk26XhX5SnzQellC8QqXSNL+G62e2mQNeZ1HT2jdBrxac4bMv0mKQkrGCWTz/Yy1xKWmsPwSbd2ov6dvx95ep+YmDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088226; c=relaxed/simple;
	bh=180+fvQmghlJ4dELQpA9Q9GzoY6ozYQlhMfrL81At4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukw19TaqwYi5AXsY8GvLTfPa7Ir3g6FYIaWknXiK0viYrN7tvOYaGBZAEueVXiFPAtsBUKMWue3tC8XuGsjLKiEnt0t13w7sRvdxGMpSt4WBvFLoD2fkCgh1YRhk7NRiieMj7zBh/EYLNtBAgrjLVQX65EQy/6p1XTwNIsTo5II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nzoh8IYa; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4B4913FB5C
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 15:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1750088216;
	bh=180+fvQmghlJ4dELQpA9Q9GzoY6ozYQlhMfrL81At4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=nzoh8IYaizjaXlwtNf6VSxH0O3bKqwGARsQnt2RhrZLPxHI3k6qwDTDv49X+JCE2b
	 ZMt3/DYoy2QShs0zX+weQ7CKotmyTs6ZwGJzqozvFNd4rO52LGG5uC47l4I106rqEH
	 CiiD2HFdQlE3xMwYvKNgngSgGcKuJ4O0FEfMUPupoio5j9MA+6tQlj+uzFQI2339VQ
	 QOozOIKul9gd0axkbl1sFPBov8xtsTcv89izcc9iKKwFk4xv7Fk+CG8mtzB2OQwsCT
	 ihVOk6MJEKf+AVkqbBc3GCs5Iwb42laFQgUMe8HCmKUqZv4axlmWOz2i4OKTdLl4AU
	 gJiMQL+27SEuQ==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-addd0146baeso384306966b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 08:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750088216; x=1750693016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=180+fvQmghlJ4dELQpA9Q9GzoY6ozYQlhMfrL81At4g=;
        b=mPUfGm6dUGn62ka/RkZ12GuXzfIctY9YANzxz/080nlppmeXPGMbn1BNZmz5wyezCU
         f58t10ibFfZIhnFftHnaR3OlYIshor2M+UD1aiXCR+vdSsAt7eXTLuA5cxyxf8PTBSG7
         +zuuprLQnTc9TInEaFWBgomR/F8p6XvHZHEP9JoAe2KeCLio6olD+mZIk/GvdygJetIZ
         S4sXmKQO/eypHOOA2z7tYGLPYcaxj3J0J9n6hdAvFAWiOiGFXlxzO2vsk1sw/a7tdq28
         7JLcOyFMwzE3YupvSDsS+uZSH7e4kNir9yjrzfymmiTW5JSTTktD4J7a+QeChdqC97BV
         xiRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBMVLpZH6lPyMY+jbeVAruXFUd/Ga0+IfYK11JzyMhHgDwSZ2uLP/vA+cFSIE+aq1ruwyMyzWmQor4C/+M@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3yGsB3qQSYcGmQOtOICOKd01OUUB/iYmknvMKOAWHQ8uFo6gT
	ciYE18zhPbwLBHEnAFZLmU7DFYfovbum4EmHGJiH97dQiscetUAOmoFqdAKxRZlOsgkniLit2ce
	RgAfl5AiSxO+RKWV0cKCtW8MPXtOz960J0BWNw30KyWfo6Alm+t3zmqKGRmLCIg2LKjjHVjbpPX
	UDupv7sEtJfP1A0g3fZhoKm/9a52uLepC/MasFEKWkZlJ6btyWI1PJk15E3B3oaArYvEMG
X-Gm-Gg: ASbGncv/vXxgZld83Y8bYxXvbZjkUl5gliugTi1DumD4wI634mj3lezhHO4nU1c0s8l
	G37jxm1hsvrQkpb0MOA5nPKSgHA3RG/wOfCTkBfEGwmIBaI/CbfAzeQzax8pbCVvCwbDgQAutDc
	CBuvw=
X-Received: by 2002:a17:906:f597:b0:ad1:e7f0:d8e5 with SMTP id a640c23a62f3a-adfad31a6b6mr999250366b.16.1750088215719;
        Mon, 16 Jun 2025 08:36:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQJQ/hxkf9NwqjXLunZ2BtPoIP+ffyUhg6RAkOlGAz65yqlO6T/4AupYPgi3j+vAgE7ysMiMcbZuj7k5Zd7QU=
X-Received: by 2002:a17:906:f597:b0:ad1:e7f0:d8e5 with SMTP id
 a640c23a62f3a-adfad31a6b6mr999247466b.16.1750088215333; Mon, 16 Jun 2025
 08:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615003011.GD1880847@ZenIV> <20250615003110.GA3011112@ZenIV> <20250616-holzlatten-biografie-94d47ed640ea@brauner>
In-Reply-To: <20250616-holzlatten-biografie-94d47ed640ea@brauner>
From: Ryan Lee <ryan.lee@canonical.com>
Date: Mon, 16 Jun 2025 08:36:43 -0700
X-Gm-Features: AX0GCFuA0E_AeS4fXVbbXeQ-QJYneMvLTC9afYzBWHzkjGBvUYmdb71wV7nw2uQ
Message-ID: <CAKCV-6sD3tq3GQhq4YuSV_xPi4pA9Vv0zqxxZ=KTOzQutaR4kQ@mail.gmail.com>
Subject: Re: [PATCH] apparmor: file never has NULL f_path.mnt
To: apparmor <apparmor@lists.ubuntu.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Forwarding message thread to the AppArmor mailing list so that it also
has a record of this patch.

---------- Forwarded message ---------
From: Christian Brauner <brauner@kernel.org>
Date: Mon, Jun 16, 2025 at 7:23=E2=80=AFAM
Subject: Re: [PATCH] apparmor: file never has NULL f_path.mnt
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org=
>


On Sun, Jun 15, 2025 at 01:31:10AM +0100, Al Viro wrote:
> [don't really care which tree that goes through; right now it's
> in viro/vfs.git #work.misc, but if somebody prefers to grab it
> through a different tree, just say so]
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

