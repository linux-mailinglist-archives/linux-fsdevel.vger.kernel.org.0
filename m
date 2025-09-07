Return-Path: <linux-fsdevel+bounces-60458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096A0B47899
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Sep 2025 03:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF256203CE3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Sep 2025 01:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614C219258E;
	Sun,  7 Sep 2025 01:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9J0Zdcg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09821078F
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Sep 2025 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757209477; cv=none; b=ouQbK/4yAACBMGxkS3cVbzToCAMQTpJkM1c7CLIM9HnFevATvaMeiAehRIikkU+99LodbOroKGVO19IXQHj0Oz7e70q9Evt4xwvub9XEmaNya90qPW17+MMcc83kL4kKvLjVdnlwxpZL99Q7vL5clnZWHaZyQA0zBN9lPn/GTtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757209477; c=relaxed/simple;
	bh=slsA3AoFQ8MJDsBCWbRmEEWJ1tU8e7v2VNnoFU+tPMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9kJSOUKroESvqQbFfF+9A0fNOtlJjz0aabGBdNXSuAOdlfYYiTYEntCItHqRrGUHtX8ybQioXY11qSsVyUo+jAJFbte/NR5PG+hS9//wX7rvgQu/mp8XaOJR6bSi7SiRC0VwsMBjrM0tsRGybweYEN1Tcd7mPg9F/uH9++NV0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9J0Zdcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D75C4AF0D
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Sep 2025 01:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757209477;
	bh=slsA3AoFQ8MJDsBCWbRmEEWJ1tU8e7v2VNnoFU+tPMk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o9J0ZdcgKSNjneGV8iFVNXr/o7TIxRhqMTR6MtY4HJ9BKFYk44pwdqTzNEOpz1KnY
	 12jWvvZUg8pdUn7ScD0ihKf79rCdIAMKsAfqE0SbmIQOxQZs/eDzyRirrwEbxoXL9W
	 /GHbtZCWx7rHalhMSC+5KNEjnCdSvUszxcy127yYjf7d1BRzrHZ84cc6RF6uc/Go0H
	 OjDfh6s0R6yYbHrA65fwRizXv5b9aQpdU9tlQkhADw+/4r46/OVh/nWibnkzLUwM9z
	 TQ6Ku/UmLu0T/N+cV41javAvPTCAtUMkRvNIbT8Qi6IrQKrK8ZFM4i5e/9AAdvByNs
	 CWjA2skLXBR1A==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so4266514a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Sep 2025 18:44:37 -0700 (PDT)
X-Gm-Message-State: AOJu0YwAWpl+wdVDpFTJTjjuGUEVvfdhLW6HW6Jy5mdx32iDYZPy2Pj6
	Ti5yMQKVfw+6gYWjqRQSVSGbs8Tc/Fvfi/EhcT4kauBJI1BozeI97bjbBRZqRBBx4t72GaFRxSC
	8/4/LLvsZuFSpNBugf62Nja2us8gQ/lw=
X-Google-Smtp-Source: AGHT+IGhBRERHM7Mxk9bNMxhEgba15oJPvn8javZD3wylSJ7NlMYtgGvmBNst4Bw/DIuW2wv0kfkZ5j72xg+GqGiVgc=
X-Received: by 2002:a05:6402:35c2:b0:622:a79:dc29 with SMTP id
 4fb4d7f45d1cf-62374a74938mr3535406a12.16.1757209476235; Sat, 06 Sep 2025
 18:44:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906090738.GA31600@ZenIV> <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-11-viro@zeniv.linux.org.uk>
In-Reply-To: <20250906091137.95554-11-viro@zeniv.linux.org.uk>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 7 Sep 2025 10:44:23 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_GZiweMh64Brf+nyK9Rr7ugfjvA+8DjmnD-Rg4OfZgGw@mail.gmail.com>
X-Gm-Features: AS18NWALObT4dnN9jFdrx4cHTgyyyzvrnqbJXfWViDNQYqRz0d4lA8FWeE-Bf6s
Message-ID: <CAKYAXd_GZiweMh64Brf+nyK9Rr7ugfjvA+8DjmnD-Rg4OfZgGw@mail.gmail.com>
Subject: Re: [PATCH 11/21] ksmbd_vfs_kern_path_unlock(): constify path argument
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

