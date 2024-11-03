Return-Path: <linux-fsdevel+bounces-33585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA359BA96B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2024 23:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C90B1C21003
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2024 22:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2353918CBF8;
	Sun,  3 Nov 2024 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="nmMNBHbG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24CB154C08
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Nov 2024 22:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730674395; cv=none; b=jQH0WqVTy+2Iw9hnFZjPJW4oUwvUvOQvXijl4ZfqublaXrTKutwqIYJZRBqnhV42V/IMoeHhc0cawt/83BCqcM9zCtoAjfmd0Wlu/vF2nDUZ88uv1Wskum4JjzkDkVYfOP+WWbYd1FehM+TwtuRXtl1vK6n3iXXd6rP5Kn0XA7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730674395; c=relaxed/simple;
	bh=h0N9JSxmh1chs4NvO7r3yn1fpf7R04K7m4MXQCWx5Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1TEp2AhIsbHG1aSb3c4fgaWbXKdFuaSxHLlfgh9bogQl4h+74Gu0kfQiac1xtLC4aLDSuD9WlwVPoJDT2+lkZmcq7Xi+I+NoJXycDQoUsQvFGU579YX9vJPIT6S4EEBJPaKxT/R9/3a35kos2uYUKqF/5bE21WBj2w9niTCg34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=nmMNBHbG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99e3b3a411so717983666b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Nov 2024 14:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1730674391; x=1731279191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/o07MZV6TjINQ+zDnpBISVrIcwIjg5m7Y/v0tWWBlU=;
        b=nmMNBHbG7YxxK/QqGj6a+dPbafeTNMqt3paykLErXBrPx1TwmU6amIGCa63jzEqHrG
         aMk4TEOfUY9zlDPtBvkHyBv3b6wk6Xt1JqLEQFvwY6AR7IrC9B8i3G2HaEhaTvxVLFCA
         SvJ7GUOwoUJokGB1gAaSuP2L3wLl2F49RNsgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730674391; x=1731279191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/o07MZV6TjINQ+zDnpBISVrIcwIjg5m7Y/v0tWWBlU=;
        b=j8EtBQyF1ZkAyuIYSZLlSeQq4Q4furzvQIOVoRA2yccckPzBsTONiyXndsus8TbUMd
         TYTpOpjSFZCBC+7C8SyYyulREXqgjzff8s6363NuCR244C/vGO7Q2IZ3P02KTVW3GofC
         RVpzC+UgOTc+CDO5QsSNs0fz9WBxsA/t7ChrQTriu6yHonge2xV0qb89B2PdwIAqJ/9I
         eaGt7114mHzZjo4+m2zGcGc7/VJIrdqS2XIZ5MoHkl1111Yx1bHZyEP4T19DY7d8yh32
         9vfxbnEv3b0owLapgehR9tL362DnAk0T2Bk4QN+o2mIlZMz99TMCxFhwGxaznRPpxJZr
         eFPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+LN42MytHANCY96Ehd4Xhd9ei6RN9iDYjuQRwRLURWiAlgMhavGt2v1jFp1nwgDeOTE4wC71DLPOolgCJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzabn2AZlKmq4xaQ1Lql56B14BEXiS6m/U9kmO51EtXJcY2jVrD
	uk0tvvZiwuwtNtjYPRr332ZbgFHU2nLvgzGkeeybFVLaZIRlp2KBCUiyC+CZ/x/F1WNQcfyN3Ts
	kFKygXU5jy3hguWnBFhLFEpz+Wh8GKN9qi4heyQ==
X-Google-Smtp-Source: AGHT+IFy4o46TYKoQTbVYKAMB2on6bfie/1kLl5cIFqDUnN/9UDRY5lszF0hFgsjo2kqN5eCFId2gUMEqsXUF4IgBZM=
X-Received: by 2002:a17:907:3e9f:b0:a9d:e1db:de8b with SMTP id
 a640c23a62f3a-a9e55a80e56mr1303129166b.16.1730674391087; Sun, 03 Nov 2024
 14:53:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <18f60cb9-f0f7-484c-8828-77bd5e6aac59@stanley.mountain>
In-Reply-To: <18f60cb9-f0f7-484c-8828-77bd5e6aac59@stanley.mountain>
From: Tycho Andersen <tandersen@netflix.com>
Date: Sun, 3 Nov 2024 15:52:59 -0700
Message-ID: <CABp92JB9GGbxWO0Q0QhkiQyZoYoAGmz7agaEp8VyH4ciXoELDw@mail.gmail.com>
Subject: Re: [PATCH next] exec: Fix a NULL vs IS_ERR() test in bprm_add_fixup_comm()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 2, 2024 at 3:31=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> The strndup_user() function doesn't return NULL, it returns error
> pointers.  Fix the check to match.
>
> Fixes: 7bdc6fc85c9a ("exec: fix up /proc/pid/comm in the execveat(AT_EMPT=
Y_PATH) case")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Oof, thanks.

Reviewed-by: Tycho Andersen <tandersen@netflix.com>

