Return-Path: <linux-fsdevel+bounces-40907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2FEA288EC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 12:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D165C3AE98E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 11:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216AC233131;
	Wed,  5 Feb 2025 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJHXsBSB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C0022DFB7
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738753123; cv=none; b=Jtam35gU0Jcjx618ujdO4QVOBcdGjtP8pzznJMREUSkc1O+PDZocKCw/ADGyWfe8dxMMsuqUmG1f0utTUxW7Z7jGsJ6MIgiFQpPhrhJ4KCaSGDuQJsmKLJQz9CInYZn/6k6j0RkrMkXVN5L3+Pw1rSMS3jIzCmgh9NAFWID0YUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738753123; c=relaxed/simple;
	bh=6yeBD0+hlm7MTwocjbGxPMGDYbzl4VnyB6S/1uuTzH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7G0vCReo1UG97U0j8lP14tFXup6aC+rLU/MiZeKsN1/17gYydejNXFHk//mRONL81+YrS4kvSd8H8jsX3c4C+8GheSNfuVS2K6bq+hjBfQUekKYwsfvAOQfiqn0ff0AkOiwjNLsdHepAYwWOrBSA+DJYlMx3gLtS4q2qesZUCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJHXsBSB; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e460717039fso5371551276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2025 02:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738753121; x=1739357921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6BSS/FmDqXFb+/ZrcjOXlvPA0SHOQddiUkQ/IxJFFLs=;
        b=TJHXsBSBofo3+c5DcAOlnyyU+et+Tgqe0jg4rMWnfUexRp8kWWgjPjWE10AKOG8nzW
         GiweNK7jtbpc3i9sk4HvSJRW8nReKm8VDeVaHsw0tkzXwaHcESQJXiOTFttUFe30px0p
         uQPGjAip+6DN3fcddWvJg2GNMMs+21BEqfjLyvAE+NYj55uPAUClRwWb3VksWKOmA27D
         vzpEWpK4h0q1WW7EaH4zEOwG2AJojLvK1BRKkQSD9B3tS3XzkoPG9DBArBbps/KLKy9a
         RFSkuhZGygpvLmg4Sl67J4ZhX3kRNYlFLKKwiU4iKkIhuwGA8OTh5K8hAI+1VZ65yQF9
         JyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738753121; x=1739357921;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BSS/FmDqXFb+/ZrcjOXlvPA0SHOQddiUkQ/IxJFFLs=;
        b=Ct/Kt4kKkg8IZrjZCLugUt/PR+M8Z+yhEfew08rLmLJAm11OZigQPrE4QXLsiKgSRe
         fn4SywAJxJ2qq988fb5z9jLyqyMOOXlJs4tbgUUR0nek+a37hH98IXn4/bqnKul259KW
         5FOKsnud8n3dlpFljhK9TKhZXLqgx0E9zUiknElOtyewYX4kcw7n4MA0F2NgzMen0rhp
         YwDL/uU+qYB5xpFmWYEJD2k1ND/3XhBNNWNZO0jAEnMksA0erAo1Kn2+UIJqRpSYzqfA
         Fu7Q2sVU/vRqEZ8H+yxioLSgveJUX5Y3TbzXtTmi3dZEshL59dyI53zbqLaCE1dGgob1
         AXgA==
X-Gm-Message-State: AOJu0Yyz2Cp6vB1CPO8thkoKEVL860zNac0nkWFPcD9MnNm4lhn/MqLa
	i3SZU537J14bLE+4KYby1NZGYHozYn2UoGqhPbv5tloF9DLYRXY3845648EudJnHeQ8hAgzOY+e
	U8YfjcJbnAMsraND2vy5GtSckrbKvM3YjPdMUVw==
X-Gm-Gg: ASbGncvHtjFunnrGEXmi5tNkuzifrV+leZHQgW0o8/wRJRKLSpJxXx96p1BTBCUSzTK
	ObNPbLJoScqZkIqJ4m8p9FQlXDDfFFSZyr4Kkzw6F0Z6iK7dQd0+DtKxneTNWqDilR/B8yXq3g1
	qb11dqFLPTjSH0f6UkPKXyV4lt8o+LrPo=
X-Google-Smtp-Source: AGHT+IHslzbkywaXqhybA93Y0uTx9Dgpz4BNBCGPq23vv+sQVidaiP3Slj2pB7xxvMJm1JGEZadgZKjpo7K03qhcVvc=
X-Received: by 2002:a05:6902:1b88:b0:e57:6644:ea3f with SMTP id
 3f1490d57ef6-e5b25a04346mr1716664276.15.1738753120789; Wed, 05 Feb 2025
 02:58:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-work-pidfs-ioctl-v1-1-04987d239575@kernel.org>
In-Reply-To: <20250204-work-pidfs-ioctl-v1-1-04987d239575@kernel.org>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Wed, 5 Feb 2025 10:58:35 +0000
X-Gm-Features: AWEUYZm5817u36zRa37_41FuJwXcGs-mhStMWTZLq-q2sfF0bWwy8GmFJGYd49I
Message-ID: <CAMw=ZnQ-hAnThFM1bCBT9k+SUWSos3EcZjdVUT8Fq9r+Dfje-Q@mail.gmail.com>
Subject: Re: [PATCH] pidfs: improve ioctl handling
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Feb 2025 at 13:51, Christian Brauner <brauner@kernel.org> wrote:
>
> Pidfs supports extensible and non-extensible ioctls. The extensible
> ioctls need to check for the ioctl number itself not just the ioctl
> command otherwise both backward- and forward compatibility are broken.
>
> The pidfs ioctl handler also needs to look at the type of the ioctl
> command to guard against cases where "[...] a daemon receives some
> random file descriptor from a (potentially less privileged) client and
> expects the FD to be of some specific type, it might call ioctl() on
> this FD with some type-specific command and expect the call to fail if
> the FD is of the wrong type; but due to the missing type check, the
> kernel instead performs some action that userspace didn't expect."
> (cf. [1]]
>
> Reported-by: Jann Horn <jannh@google.com>
> Cc: stable@vger.kernel.org # v6.13
> Fixes: https://lore.kernel.org/r/CAG48ez2K9A5GwtgqO31u9ZL292we8ZwAA=TJwwEv7wRuJ3j4Lw@mail.gmail.com [1]
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Hey,
>
> Jann reported that the pidfs extensible ioctl checking has two issues:
>
> (1) We check for the ioctl command, not the number breaking forward and
>     backward compatibility.
>
> (2) We don't verify the type encoded in the ioctl to guard against
>     ioctl number collisions.
>
> This adresses both.
>
> Greg, when this patch (or a version thereof) lands upstream then it
> needs to please be backported to v6.13 together with the already
> upstream commit 8ce352818820 ("pidfs: check for valid ioctl commands").
>
> Christian

Thanks for the fixes, LGTM

Acked-by: Luca Boccassi <luca.boccassi@gmail.com>

