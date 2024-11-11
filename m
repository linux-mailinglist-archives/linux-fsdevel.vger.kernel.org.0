Return-Path: <linux-fsdevel+bounces-34213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DDB9C3C6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 11:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C044281584
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 10:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB36616F85E;
	Mon, 11 Nov 2024 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="V0bE5FtE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65275158848
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322196; cv=none; b=UzVuXUXgRhbZuX6kyAX81BdxbGvQsgFz55U/EeEda/9QkLPiBLhELQI5utL7m5OOpqzHalbOJNAHNMjwJOItUMh0/mudi+0e7iuCSeboErvzJ/qWSYI6aOj+6jT5KAQuItjZkItXdKp7vv6FCy9/88xm6jT85xbVc4Yuk9awP7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322196; c=relaxed/simple;
	bh=PaRLH8uPQK1MXk6HcuVk24LMz8AsMK0vCWsZhKwPVCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bX+Q7EgLIMf3g8cA7+59QHmvw/Q7+cpfNFI5IbnR4Amq0njXulyOfZy0VcTUcvAd9VQPqThuHWlSDgfs3YFFT5mxIeRcWtfYoGphDYSo5uG1CedX7/7RN6zq0oPL21fkcQs9sd8gifDV66m9xwyZ2jgvlH0uSlrirZq2LX1mZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=V0bE5FtE; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e28fd8cdfb8so4064158276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 02:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731322193; x=1731926993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3kwuzcMlaOY77zVC5V+o32P2Py31dCZW2YdTPwgCdiY=;
        b=V0bE5FtEcHomMp+v/Oy2jdm8aO1tyDU4VSK/v2BjH1uNmQIpEXpJpT/E/kcWkmGHn1
         m4dEyXugZscIcUP3y86dbZAt2t1kGV2mEMbsDKqOxTDzlE5UL7dcPzV8Bv1XALQNHhu+
         UdjP4RKtEx1cuXgsysCBBVqG6wPTInLzJzs6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731322193; x=1731926993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kwuzcMlaOY77zVC5V+o32P2Py31dCZW2YdTPwgCdiY=;
        b=Yz8TIHz0fADQCbqD7RVDXowoMCOPWUtRghoc7r2uP7ZFHo30yQa98lIg3AZ2BkXZVH
         rT4ivnb4m5cjxjZnLC+gxtTomQ40eLDJkOeEzlz2fUOTbP9In1V8weN2Gb0yyRw5PYlM
         2qN4Z66s91EMer7wJgupaIqCaiGLQ/9qoXqKsrjIASFdsCWqM5NLCGTwMI+T7OkG182u
         deAZbUJNy4BdW8L5sHtvaS9wuvlxRGGRwVFDnxozOrysY3I6XeZpCvaNS+SdOwQXbLzk
         hzdapUDq/JD2aleABeaAtpvmF0elyj7NxF/bX7BRqHHJI2vegvZkU+rqogXt6xJBcFef
         Bouw==
X-Forwarded-Encrypted: i=1; AJvYcCXdynHXtNMp1EBJBZ0qiaFnMrdtlEi4nZzicNC1GvjKOTISwoL+0cJ4fEeieTjhj6AbtSeykv3u40iA8Une@vger.kernel.org
X-Gm-Message-State: AOJu0YwYW/iQ/Zy//2TuOlIt3kp8+0oRX4O3/AybRYnBMTVnuimN0aI9
	3uz240qDmSfNc0OLNOn1kS63qVFownz2CrP1zuOOeTJOtuNgOBw+t3mt4jKa3vlb9awIxB+2Biy
	bQY896PF+dGbFFyp7z4kE6TB4gjhFN840hTOJvQ==
X-Google-Smtp-Source: AGHT+IFcWDGFlyzuXcdDBtQBlsRyrxy0kv6wAbUjD4WWe/Ob5ewjgR8GKVWOK0mwsazDOliP2zoXZ7J6AZrpyuHVuF0=
X-Received: by 2002:a05:6902:982:b0:e30:d468:743b with SMTP id
 3f1490d57ef6-e337f881a72mr11128509276.27.1731322193272; Mon, 11 Nov 2024
 02:49:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107-statmount-v3-0-da5b9744c121@kernel.org> <20241107-statmount-v3-1-da5b9744c121@kernel.org>
In-Reply-To: <20241107-statmount-v3-1-da5b9744c121@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Nov 2024 11:49:42 +0100
Message-ID: <CAJfpegsdyZzqj52RS=T-tCyfKM9za2ViFkni5cwy1cVhNBO7JA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fs: add the ability for statmount() to report the fs_subtype
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Ian Kent <raven@themaw.net>, Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Nov 2024 at 22:00, Jeff Layton <jlayton@kernel.org> wrote:

> +       /*
> +        * If nothing was emitted, return to avoid setting the flag
> +        * and terminating the buffer.
> +        */
> +       if (seq->count == start)
> +               return ret;

First of all, I don't think it's okay to subtly change behavior of
other string attributes in this patch.   If that is what we want, it
should be separated into a separate prep or followup patch.

Clearing the returned mask if there's no subtype does sound like the
right thing to do.  But it makes it impossible to detect whether the
running kernel supports returning subtype or not.  Missing the
STATMOUNT_FS_SUBTYPE in statmount.mask may mean two different things:

 - kernel supports returning subtype and filesystem does not have a subtype

 - kernel does not support returning a subtype and the filesystem may
or may not have a subtype

I think we can live with  that, but it would be really good if there
was a universal way to detect whether a particular feature is
supported on the running kernel or not, and not have to rely on
syscall specific ways.

Thanks,
Miklos

