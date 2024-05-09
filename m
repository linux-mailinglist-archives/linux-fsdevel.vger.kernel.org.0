Return-Path: <linux-fsdevel+bounces-19166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B1B8C0EB2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 13:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE06C1C2161D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 11:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C60F13119F;
	Thu,  9 May 2024 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="EawHTqKo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC3414A8C
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715253030; cv=none; b=eE4iZn4R1JA9rPr0ozhDcyZVoDhrkU28yGJOIF+8F0RC4/Y9G78YdNXLThRoDAi6ECiYJX0z1a+hyVhcY+ow8uD4MlKrxy8PweJ+/dtBIi5bYy8s04A5s+a9IcDu51OHMi/CYqipJPgo/XGfis3bILv8MU5BrdtddpeMIjo68rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715253030; c=relaxed/simple;
	bh=03PX6NemMM9qw7jWLF9NwK60Th+ZBBbE3KpqpjC6/Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ch+jYGrqWBBVtvb6h6+EO5+G5Y42zmyDqScF3qFDNpFDm5bHAyMyjJZ08JDi3q2/aORvRg5njkCD6a547SabPQZqBMmzMc9nNsLtFjDTs5wOwznu9hUUr5ITy+94SODBL2ccdyNqyOW6Jq7TF14b2/s2qp1z8VLIKy1yHYCua0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=EawHTqKo; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59b58fe083so170304366b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2024 04:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715253025; x=1715857825; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=03PX6NemMM9qw7jWLF9NwK60Th+ZBBbE3KpqpjC6/Xo=;
        b=EawHTqKoQU1J5AdLc5bmrF56FE6n7c9rZBbkhRy1TX0OumrHcHr+0R1ND+W4wpfvjf
         OltsEY0uyXx01svJB8oPwGVixFD0SPtZzbdNcEQfhrYk6OiKiGVVt6lEKfkiWsmORQMn
         KI08aCQrWlQvKN62gAunrPKEU1PCcWuEEL5Tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715253025; x=1715857825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03PX6NemMM9qw7jWLF9NwK60Th+ZBBbE3KpqpjC6/Xo=;
        b=RVjTTp2JQFB7SxyG19g59rK1evQO1FolSfWIBV4f6E2ZjWMD1em4M+1TQRZDWredVr
         b8F0pAN3jVjv/K/61m4DwUyT5UVCV1SaJQt/byPx1nkM+vxAkmGjrfCsXs3M24aGQ1Ll
         UmZIE6cg2Z3+EczbQvqt6aNP/EfoJ4dxVHfe7mRuRUBlUo5TOvI8yr/JORiUGtyzeHQ3
         f0P/qdzjNJD26RD23CucgFvJ5JGB/8UyUmnNpnxAspMwqhEKwOiQbMGsOY/VNs5xcQTG
         k9tpOchnkTemMNd1z+oW6qf1Lc7QupfK+g+XsseB9zdOs/s7DEKsNzTxeAC5flDFX/1x
         PIuw==
X-Gm-Message-State: AOJu0YwdMzCXvvgbuyY3/MQljgGUevRaJDevc0D96lledFulXRRKojZW
	bX2tN7Jbuw63pl247Y3bY6wSvNpsGxFeQn3vWxw8BMl/Npgnun4h/tFXMoTxlsypTaN4JUG1XwX
	GSQ6FG9VjHD/g4zBU3JtX6UojO/UwIWgM0hOiKQ==
X-Google-Smtp-Source: AGHT+IF9U8vDbQi7flO+ddKAFOTpHGh5MFE0MlfX4MRGCXmJng729t5gJvO9bS+9NwxSXqiy6zpEH8qU81fiKqyd2j8=
X-Received: by 2002:a17:906:b291:b0:a59:aa3a:e6b6 with SMTP id
 a640c23a62f3a-a59fb95a264mr314987266b.18.1715253024772; Thu, 09 May 2024
 04:10:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZivTjbq+bLypnkPc@gmail.com> <CAJfpeguNAEH88aKTSFbEdaa4neUbpXVkbr5-XiAkOEH6ZNUoHQ@mail.gmail.com>
 <Zi/aIkYRU5N03xEC@gmail.com>
In-Reply-To: <Zi/aIkYRU5N03xEC@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 9 May 2024 13:10:13 +0200
Message-ID: <CAJfpeguxFAtyY+2r04JPraw2ELvs2FEqAnCODvCQQZ4qJtn40Q@mail.gmail.com>
Subject: Re: KCSAN in fuse (fuse_request_end <-> fuse_request_end)
To: Breno Leitao <leitao@debian.org>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Apr 2024 at 19:34, Breno Leitao <leitao@debian.org> wrote:

> Yes, reading ->num_background using READ_ONCE() in the fuse_readahead()
> path fix KCSAN complaint.
>
> Should I sent it for review?

Yes please.

Thanks,
Miklos

