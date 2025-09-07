Return-Path: <linux-fsdevel+bounces-60459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B75F3B4789B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Sep 2025 03:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B6E188B179
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Sep 2025 01:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41E819258E;
	Sun,  7 Sep 2025 01:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+1o3xcn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1E48F48
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Sep 2025 01:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757209494; cv=none; b=AhSUpqbZ1C0F72i0Wgrko6c9sD1a6CQwjf7muynV0dNCXgk8rIwYnw9t+UvW6rv7h/OiGrfPAS7DhWPdDI55CSbSTfO1TLDEiqC+GlIehXX04OYsPTq6zSl6uHUUTaz3QS9iopJugb1Vr7N8p+R2QiRqDjuqNW59vKncf97vbpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757209494; c=relaxed/simple;
	bh=slsA3AoFQ8MJDsBCWbRmEEWJ1tU8e7v2VNnoFU+tPMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aai9JCyb4C8RO/AK73/D8FsWKUv9FzoueBny7T7ykpTeYYJkDTCbfqsFDQ+RV1AyG2MJPhgGZhovVBAE6+UM009s0YQO3n3fci07Udch5iXBYGnkF3PemqI8Y4b/Ke4j+C21QRMEAEbQd0xWsy4HE0LkuoXK5SMqrCwmOqEiPRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+1o3xcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF600C4AF0F
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Sep 2025 01:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757209493;
	bh=slsA3AoFQ8MJDsBCWbRmEEWJ1tU8e7v2VNnoFU+tPMk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F+1o3xcn7qmieMkBzCrt701Ztt3F1iji2s4rWtwBw283jzA1qZr9LtmiLx2VRSe1a
	 iDlT86KfPfOhYeXx6trBN5lxxxgHjkqf+snWHfaw0O3nvO4cZSNOCmUZ3J+Jv+FUNr
	 /2Ke+g0OOuWkYz4CkNmbbYw6aXZnfnhWmVSIZwH4m8pbMEcY9hehCnGi/iMta/Hsbg
	 pdQ6KGbhcUGnHQxNVuBXsew4/R7nyojYS7hCzJRLg45jtusry+cWKL3yJiIXTMmk3D
	 rB+Xhx8xw5KlfPzJIbp1N3bIs8RJ/ydAiOJDCFGsOJy39vOUOSYijAI/04ZfGA/iCC
	 kCAlAgTp3eCYg==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-623720201fdso1801720a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Sep 2025 18:44:53 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy73tZMf9PQKSO+dSDF5EKJNynjtN7yq+ojnIrL58Cxo4DL30Wh
	pAlpH55eneV8HtDpwYlJjACBWAlwtOiUuBdmda4/cL4y76i3O1flwliLmM+zV7C4GV8YCURopNf
	Ht/gfkCR9Tr29cQuLR0PuKLR0r2FDSpM=
X-Google-Smtp-Source: AGHT+IEfS3Sfn8XVGYvEsaqgVxX5q+syR0k1ZI+ajEq00g62C1ynJs8jsSn3PGQIEAbiFotVPB5XAjjpjQ/lgntYLwU=
X-Received: by 2002:a17:907:1c9b:b0:b04:84db:c83 with SMTP id
 a640c23a62f3a-b04b14af9bdmr359909466b.27.1757209492333; Sat, 06 Sep 2025
 18:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906090738.GA31600@ZenIV> <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-13-viro@zeniv.linux.org.uk>
In-Reply-To: <20250906091137.95554-13-viro@zeniv.linux.org.uk>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 7 Sep 2025 10:44:40 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9tLGRy=AQYtp2gt_GwjdDK=ZOkvZ9dx_RLz_fA8tMF-A@mail.gmail.com>
X-Gm-Features: AS18NWDU-KRUSFxIX0lwkt-5aUQxx8I6OZ-8aP8Sw5N2noOy3yNtDz7QKnZWNtE
Message-ID: <CAKYAXd9tLGRy=AQYtp2gt_GwjdDK=ZOkvZ9dx_RLz_fA8tMF-A@mail.gmail.com>
Subject: Re: [PATCH 13/21] ksmbd_vfs_set_init_posix_acl(): constify path argument
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	john@apparmor.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 6:11=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!

