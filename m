Return-Path: <linux-fsdevel+bounces-49776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8F3AC24D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 16:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 646967BBA7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 14:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE90629550E;
	Fri, 23 May 2025 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ire49FH8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CE114286;
	Fri, 23 May 2025 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748010045; cv=none; b=AMBvJ1K4A+uriD0ykyopbuc3HAZYZvisR6ZyiOWAH7L1SFYWfTf8F3TRFAY36jmgTw1qUhf4AAkkm+keyK166B0KQb3ayNT3h0CUD2klWk7FtQzdkaPQ5zGWDuFF/HvbDFqiHJwtCQxCs1NCp+lJDE4kuzZAHBbgBID7oo3ROXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748010045; c=relaxed/simple;
	bh=xxROsMD/OCEeggk9mL1upW2o3jWleAHEZKATtIaBKK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJZp1a2V7bSEJUBbzFtMjFnrpdhwLkTjEiPdGxRbof0FZrHtMZnPMoux9u1fPvcYZ7sV0E71sO65crXrLg6m1CtAQ3F8hcDh/pJ83NJInb1oUwrCrDa5IZy3fFL+zmKo5pAmMdm4h6F8JM13/uUFul2fyXTOTVUk10DzkTQvPbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ire49FH8; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad53a96baf9so1210677866b.3;
        Fri, 23 May 2025 07:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748010042; x=1748614842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MleecG7+ZrOSvVscFl3wga8Daw1b0dP1WpsIlLpync=;
        b=ire49FH8WWYPQBBzxGEbNcv2z1gxVdk08X5LHZRMohL7WPXveq1GMMnuZWvnxQwRHd
         cf9tm9y8Z6GLUF4iJOrnuXO8ieS88NXhhOQvb2++wAHM5dvVTa10lq8A6V0Pih9t9BhD
         fxXUiAXbaoEGdCGR1FNTWIuTeHz61s5h84neyfa88iz9gxg/yBN7m7CeSCUJjNhYZMcx
         /nIfPVw+yEjEAD7u1oWKypcF4b4b/77Z0zoK9UYOF0T84SZ1tLwcgZERr/MhLHJG6Uw7
         xcSMzlP9UsvdOlEh0PLexphxf/TNIEl6Rirp1mc3f1PMwqlViSnkJpJ7qrBjsisKkUbM
         aRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748010042; x=1748614842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MleecG7+ZrOSvVscFl3wga8Daw1b0dP1WpsIlLpync=;
        b=VJfSRDrUKx3F3ByyVFnhucXAQm1oFbv3G+V/t/OOVioNuhXpO/XXBi1tiX351vfh+w
         1C7p1xdZsfGaTD6D3SOrOkvLbTYaS4+mG4F21OgeQwz5+xD2a20wCjJ0M4unyulF9Y1/
         LuieD7Kn3fU65XErxgo14/Rf1ChLWshtbWRVrs9MghW2ubfEdhIOjQ5R8NX8jGBA9Ra6
         gy3uBRSghSfJGj74FvpHOB98RNq0h9XIs/EnAU1w1WyQJ9J/MPL0hZ9ZbJcnCCzIaAdT
         j6BoI+rx7zAAEneG+zshDJS38CfsfW0VbqPrZrfqE5ouo/J+XcMzooIGa8WQzmYFn6cG
         SKzw==
X-Forwarded-Encrypted: i=1; AJvYcCWUfLGCAwgQC/+fBOCMxiuobNxrfH9aI75BoR9qMjLgOIQPVg98HLKx+RT/7DedMbtsWu6OWbnt@vger.kernel.org, AJvYcCXbz8FXI5EtgZat7E8ieNOYEcPq3+F99psuiC18HRRz07IckGsqv25RJPWnzbFzgHRtfnLVPmPtKtCPK+cubA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgdiylwgi/HRpv1tMXqjtlHBj6YSfWikfMtS5tJXtcUwVSsD/O
	Tr/sgGXaQkePtBvQTr+07HQy+0FgaREe+oc772/Zsjg6CLRG4vZxdXEwVX384hlAlAEV2MXuPt/
	wB1wsv+MyhytSqoE6l5mEj6lR6zHC24c=
X-Gm-Gg: ASbGncs8mjvXofyjxzRWj9HHhaakN8H/AM+MVNnvB4TUpUFmIU0ifxD6or304iSWEVW
	GLmmLTYxiY2tPSlmVeIxkgGiPVFlMdHcVgwT+Ux1PahHIRta0bgYog3sfJevE4WzC5KftvaV7zL
	z35IXHIa8w1Vw6efZSilYXncL7vd4hM5Do
X-Google-Smtp-Source: AGHT+IE1kdC/F1I3zxOFa4VkX1VLCRpkjqX3DJ/m7HvNlP7NnZscx/TmEQ5MyEI8Mky1iH0ht2ufqdulYcgILP7RdB4=
X-Received: by 2002:a17:906:8d7:b0:ad5:372d:87e3 with SMTP id
 a640c23a62f3a-ad5372dbbb2mr2072822866b.27.1748010041659; Fri, 23 May 2025
 07:20:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509170033.538130-1-amir73il@gmail.com>
In-Reply-To: <20250509170033.538130-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 23 May 2025 16:20:29 +0200
X-Gm-Features: AX0GCFszVcYUFRF5U8BKODIwx7XvcNltOmSOdy5aGszyMzAqKiqBgvk2Bs33LrQ
Message-ID: <CAOQ4uxht8zPuVn11Xfj4B-t8RF2VuSiK3xDJiXkX8zQs7BuxxA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Tests for AT_HANDLE_CONNECTABLE
To: Zorro Lang <zlang@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zorro.

Ping.

On Fri, May 9, 2025 at 7:00=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> This is a test for new flag AT_HANDLE_CONNECTABLE from v6.13.
> See man page update of this flag here [1].
>
> This v2 fixes the failures that you observed with tmpfs and nfs.
>
> Thanks,
> Amir.
>
> [1] https://lore.kernel.org/linux-fsdevel/20250330163502.1415011-1-amir73=
il@gmail.com/
>
> Changes since v1:
> - Remove unpredictable test case of open fh after move to new parent
> - Add check that open fds are connected
>
> Amir Goldstein (2):
>   open_by_handle: add support for testing connectable file handles
>   open_by_handle: add a test for connectable file handles
>
>  common/rc             | 16 ++++++++--
>  src/open_by_handle.c  | 53 ++++++++++++++++++++++++++------
>  tests/generic/777     | 70 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/777.out |  5 ++++
>  4 files changed, 132 insertions(+), 12 deletions(-)
>  create mode 100755 tests/generic/777
>  create mode 100644 tests/generic/777.out
>
> --
> 2.34.1
>

