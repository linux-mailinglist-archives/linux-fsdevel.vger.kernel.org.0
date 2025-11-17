Return-Path: <linux-fsdevel+bounces-68707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1A8C6396D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 11:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B5CA335C09A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617DD3093C3;
	Mon, 17 Nov 2025 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YlW0EMnh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EDD272E5A
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763375421; cv=none; b=skQr5maBTLkJFIsHeavXVKK04Fjcketb2fmKcFSn7UcibBbWXzBKekJk6duCGQnaQVLsOxPMjK8Mm0U9hFi7GLU6/Wza4/+7U2wR6mhq5jfJjd9VOseUHkh3iV+J0sFFkrJWqv/pAWCODH4PWH4Rl/BRR1SjopWoQdwTucZByTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763375421; c=relaxed/simple;
	bh=uDCCQXzcWKHDdw6+FUnhEhT/EnEM+9jDsx38khAZyt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqkrcoYT3pokMgP73xU/DkgmYKBlJGhrA6RK0Zmia4M0nvVm+FQ7sxWWk9+vDPuYLmrp2mnHbFLVKmWVxuYuSy+SfB2U8LIL7Z46Q3w/SOfXk0/mRN+mtIZwiGjPfeb6/BvfCkfMwUF9Sc2pHWJXItdP9J2v49qTH3OKQSohyEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YlW0EMnh; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b735b7326e5so567452366b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 02:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1763375416; x=1763980216; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ghXYPE/gMEzITHPum2kYyeM5dHW4Nj/tBMdJSh+GKnc=;
        b=YlW0EMnhOziFpGjQAD97RkWmScG7BMRkkGsGc7YR+cCepvcyxg2A5y+qzBujQwumXU
         zl8Zp9FfImtchdcikNdAFO3bOeX8kbXG3SrA0PyLRAMyqc/XehYwM90MpEJsEMTATnn7
         erY2+h2+GYy8HjcqQEBppGSmOVSWNUJjk5pXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763375416; x=1763980216;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghXYPE/gMEzITHPum2kYyeM5dHW4Nj/tBMdJSh+GKnc=;
        b=BoWOB2YBi3PjvY48Jue0zpp+dYDYHDoGhTLFOQt0dZzko3pkBJQJ6z9eKvNdPBC7Hw
         3gHK6FLB+rKNdRmfslNNDYOn769m+9M34AiFS17ssJn1L34cjfHf8MKhCLZg0aLeGgTZ
         UWxEbcHmNvZ1y9ggd6zCoymmTmUAQLKTVsngGdoFe+qMFwSj09dJL1F+quKFXRw+nRGq
         YTSwSzshuniZKW+TjPj6EZo5pVK2JF8gNhnZZq41/1BB1aq+bK0y561aezeCgHWTq6N+
         CxpretZG+RG+uyJddsH5nkTylkXWG3jP5PIMpS5tEU9WqkvHPKvcNmEXMNWJKbQ6zTRS
         POWg==
X-Forwarded-Encrypted: i=1; AJvYcCUCjbniJD81kYEgvYYtL6qa2LS1SCa30Yei9mDiLviokd0wj4w/4lnq4CYvPTH66DdOzoKTLFIIEnc5c0jI@vger.kernel.org
X-Gm-Message-State: AOJu0YyXA3LJGYGrIQ6VHUXUFyhfZQfk+ZWywVBObo2HjdGsatBmw1CN
	WqusGIf6LIcFeRxIb62Kmpg3Z6frcFYWc8VQw0oqC9KeXST44NeXDu77L35UNihtG5WtmGlLaFf
	sO+A8/C4=
X-Gm-Gg: ASbGncvljgnKoMLYhtcK8vvDr5C9J3WXMYAGjJpJ+47zySH6tSMqD893V+e9i77t1Ll
	7H3bSBYbu6hIf3sgZ4wW68aY23d7GpLRfDiiSsk6nq0zkG0ed7Cj4OL2KeOdRnmeLDIydqsLkdM
	PsZo9UgPHVgwqKirD35qsNlfHgrCVJYcsP0MlsMsV2m5ykDzoSurFuqgc0iM3jXH39AAHfxScJE
	uRY8HwFGe71CJ2NaKlMsto0RlriKdpV9lQn6rHEVqbjWsgK24LqjneSFHr1KwOegR/Xiq082UOl
	YSeYb+LImoG3wIfdIolC1jrmU3BYxF9FWo8sQE+JeVtE/Mq+5KPsxMR/7tlPoymbwMf4BzPxFaR
	MZmlNovpeXVaSmHSJUEpv/eL9j016GfxQyS3m0KBwKFtFzv8IcUjMzK6Cr50tIaNcdZjd619llu
	aZKVaYUd0q39tWxN8njgl/rT5GpkVVi3OXFmdhzzfTBBSURQmWeA==
X-Google-Smtp-Source: AGHT+IG5f7peeXqok2mDMivOBdyLry3We36VkFGw3+3duE3gWPC32d+AR2RdH2iC6mo/5NAdyNc+7w==
X-Received: by 2002:a17:906:1701:b0:b73:8d49:d291 with SMTP id a640c23a62f3a-b738d49d45amr438101466b.0.1763375416322;
        Mon, 17 Nov 2025 02:30:16 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd80a3asm1034190766b.37.2025.11.17.02.30.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 02:30:15 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso2792038a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 02:30:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNfJm7OpNvj9mAN4x9oD84iPUGRj6v2sx09eVbxA7Q6sdP5bmkGMhy3rjjwkiqCMr8YqxA2diREq3QHs4M@vger.kernel.org
X-Received: by 2002:aa7:d8da:0:b0:643:130b:c615 with SMTP id
 4fb4d7f45d1cf-64334c7e125mr10982774a12.6.1763375414716; Mon, 17 Nov 2025
 02:30:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org> <20251117-work-ovl-cred-guard-v4-35-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-35-b31603935724@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 17 Nov 2025 02:29:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=whrCSbimz8jDhh+q8AJH2Ut9V3dgyLxVotn3WLCTyoN4g@mail.gmail.com>
X-Gm-Features: AWmQ_bnwhUgEdQVd21k4V-Ihe66DJElQUz0jrc4qSGDc6kLcbscsjeq-o69GauQ
Message-ID: <CAHk-=whrCSbimz8jDhh+q8AJH2Ut9V3dgyLxVotn3WLCTyoN4g@mail.gmail.com>
Subject: Re: [PATCH v4 35/42] ovl: port ovl_rename() to cred guard
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Does this old "goto out" make any sense any more:

On Mon, 17 Nov 2025 at 01:34, Christian Brauner <brauner@kernel.org> wrote:
>
> @@ -1337,11 +1336,9 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
>         if (err)
>                 goto out;
>
> -       old_cred = ovl_override_creds(old->d_sb);
> -
> +       with_ovl_creds(old->d_sb)
>                 err = ovl_rename_upper(&ovlrd, &list);
>
> -       ovl_revert_creds(old_cred);
>         ovl_rename_end(&ovlrd);
>  out:
>         dput(ovlrd.new_upper);

when it all could just be

        if (!err) {
                with_ovl_creds(old->d_sb)
                        err = ovl_rename_upper(&ovlrd, &list);
                ovl_rename_end(&ovlrd);
        }

and no "goto out" any more?

In fact, I think that "goto out" could possibly have already been done
as part of the previous patch ("refactor ovl_rename"), but after this
one the thing it jumps over is just _really_ trivial.

Hmm?

              Linus

                Linus

