Return-Path: <linux-fsdevel+bounces-50815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCF6ACFCEB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 08:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0783B164781
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 06:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC9E2673BA;
	Fri,  6 Jun 2025 06:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="m5l66cIe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80793258CF5
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 06:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749191795; cv=none; b=s8aco5HOaGxIVzdI9yImpUhNKt772XdNODmoXl9LCSV+jZzKbvRTRI6nF4EuxeksT0qvN9L4nCNMNu+FZxVUJeURqVNexTXix2Xeb+uI3yhLg9R+rAXYhMZMPsrhQBM6CvKemGYnfVi7OmIpkeIXTFNd9CAhxGuKXZktt5Te0ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749191795; c=relaxed/simple;
	bh=toV9IQaPqvqASnNJNFj5X1N4rgKmvC/sEVmE6pwDqZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUkNzHMknXO9/tDL2ZZ8zzrdaxEXac/HmrFz8nMc2jkWuE3xKl+CzpnqgR85Qvz/kNxR91KpeszKBS68Pkqt4vPdpgL087zIxsD9tpn2k43ii5lOKo8lATwy5etzHJKfTJuiUfv0Uybh6nfdK5KUgOITOrEypUQ5mZWH1uTWP+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=m5l66cIe; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a58d95ea53so20551771cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Jun 2025 23:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1749191791; x=1749796591; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=toV9IQaPqvqASnNJNFj5X1N4rgKmvC/sEVmE6pwDqZM=;
        b=m5l66cIe9Ks66bsumCP3uFTyW71mGCI1gMLaSqBbgW/qPxRDwTCLnzvcfTHk81mzJm
         lMIOxN2M6B6J5E39IJF2ui6dK8T8pxUdpTPQZ9gqjJZO7RPpwCWvmcKMpipdDp8gr+j3
         9hokVjeTs4s+lXPh+fdHeXK0/qfL0c4fPjL1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749191791; x=1749796591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=toV9IQaPqvqASnNJNFj5X1N4rgKmvC/sEVmE6pwDqZM=;
        b=X1Nqod3ZEtjpZyB3ugqCP95YYd5U+9/1stC3D2pRQWbF9CV46+OPWO1NkyM5eBL/0F
         7a05uB+ARj9dg3vJ6zsr3G8oWk9V6tdKZ5EMKeq2cJXO2AxTGjj5YuM9eIRgm2R0s44R
         XG6EMxUhfMGSYQrBjhCw+C5N365mm2tetEWs1LrxiyZ0QVrHQVI9fOhAal9zlpN1qZJF
         CaD2xtCOKz/fbipMDMLMaAAJ5V0NgXxNH78Egj2FlG9elpjEaGkseTJoAtwS5LOdFriW
         iEZDLZkpNTraCoY1SH9HaBmXZIzuyRwwtkwEe6XAM9QPf986pCaJxZKcSigCSNC42JqA
         WO9A==
X-Forwarded-Encrypted: i=1; AJvYcCXkGp9BjdhNPaODpKciTJu0hgO562I88dBwDvUnV0E2FIQw7dEipWiqRKVbRx9pWc86TIZ1mA1PixCiD3lt@vger.kernel.org
X-Gm-Message-State: AOJu0YywCD9o13fBiL2fPdXYEnc56U4rKg3LxdPqecrbez1Di+VmhKWj
	+G2dL4q+dad+bFkL8K+d0hOVE1TltNO/2h+Deb70vsG6Owe3iTXylnt9LjglFe3GvyYoaxlfRVP
	HL8j5DixKpz2XHzVqcaEcjRL7rb755FJuoDe8YGI8S5WM7x34NGlC
X-Gm-Gg: ASbGncsZXcp6c+eNestuG+OLiiPOi6T4ssLy4ABI1+Eej6l6prcOeWp3oI+gEFgzCW5
	FXdeokr9JANeJwCdoMYPGElkxBZFNraLj/9hb6Yiq9PWi1nEUDjWT79V4kilPsfadSrFIusalv7
	kh68oMJpB9reuKER75n+Raz+9HgnjgnSw=
X-Google-Smtp-Source: AGHT+IHZrb8oAUUqWQq5BNm3Ul6xtj6V0TOzDYLhpLP/ffaA9kQ6VFwAI96cX+m2oJJdGnfs/tFQhr6ii63ncKo6CfE=
X-Received: by 2002:a05:622a:5148:b0:4a4:2d6d:80a0 with SMTP id
 d75a77b69052e-4a64b6511admr22914341cf.10.1749191780124; Thu, 05 Jun 2025
 23:36:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegvB3At5Mm54eDuNVspuNtkhoJwPH+HcOCWm7j-CSQ1jbw@mail.gmail.com>
 <CAHk-=wgH174aR4HnpmV7yVYVjS7VmSRC31md5di7_Cr_v0Afqg@mail.gmail.com> <CAOQ4uxjXvcj8Vf3y81KJCbn6W5CSm9fFofV8P5ihtcZ=zYSREA@mail.gmail.com>
In-Reply-To: <CAOQ4uxjXvcj8Vf3y81KJCbn6W5CSm9fFofV8P5ihtcZ=zYSREA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 6 Jun 2025 08:36:09 +0200
X-Gm-Features: AX0GCFs7rakD2EWiToYlZOoJVn9Hy1NZM9uDDVwqBk67n4xvc5_i2D2NHsaiR_k
Message-ID: <CAJfpegutprdJ8LPsKGG-yNi9neC65Phhf67nLuL+5a4xGhpkZA@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs update for 6.16
To: Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	overlayfs <linux-unionfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Jun 2025 at 08:17, Amir Goldstein <amir73il@gmail.com> wrote:

> IMO, it would be nicer to use backing_file_set_user_path()
> (patch attached).

Looks nice, thanks.

> Would you consider pulling ovl-update-6.16^
> and applying the attached patch [*]?
>
> Thanks,
> Amir.
>
> [*] I did not include the removal of non-const casting to keep this
> patch independent of the ovl PR.
> Feel free to add it to my patch or I can send the patch post merge
> or cleanup of casting post merge.

I'll redo the PR with your patch.

Thanks,
Miklos

