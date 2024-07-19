Return-Path: <linux-fsdevel+bounces-24014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFB793795F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 16:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBEEC2830FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 14:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F5913A87A;
	Fri, 19 Jul 2024 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="rQapTK0B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409BF142E79
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721400840; cv=none; b=salwD2z3RPwEYA+MJc2SWuaTjPJTWpNC+yLO7HFD9WrNdMTWRCL+ckW7irQe/nh0sCePgv3cG5fn1Wy9N0Q1k9qS38F+ojr2zZCfLjEFyAfl932yLxxpGqnF9n8GQgDWaRfJcoc4TOVyaAhl5rcmzuJ4Rz1WKKbuLGHfYfm73Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721400840; c=relaxed/simple;
	bh=qqx67RQaAKOzjdqwogiMENHn0SKZj4GBvtvNTJMMZvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwCRz6WAQlfoWloFO7p4x07TgT5cs/KZBM3tEptFeW/EXM+uOMoU7N7wbiKus7zPGQgtsnzHtYZBiwNQivppzkemceEsz3Z3XI1NAe5AWW7U9lyEN9MEDoTpaUf6ivsa64IjPYb9aAfSF8NJs8M2/uLUbWOijUXKSqJQ744zo60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=rQapTK0B; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-708adad61f8so1034342a34.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721400838; x=1722005638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jw6Rg+dO9brjW1rPqY+ybsuqp7Pkeu5EfE2ah6q8chE=;
        b=rQapTK0BAGaLpsTAa6jXmy3NvjkHZ956//mcl0ijTPaejGvjWLKA4fNcxY3d1ZbSq2
         8rYnSvPeD3/uo7SX6LsFAvkMtnjM9Vv210GMQn77OXhbrTZ/ejdvtQ0tVcVQkuNUCexG
         RD6wHPNB5NDYXpIYtRDSOeO4P2ASFB4KFl5Ucn/21HJ+3VdjhbEPCPnInX1LAiZFLoiu
         AilRJWOc7DrLj1XqJqlMrCIGWRPP8RLkIK999Vv2DlwGmECuXAd8VUThWtaW5v4HP+Rk
         b2dJcSROuAIZQxfiQqCYsaJQIrePvKVeqitxchKjy2hLCI9E26lU2czBq19OohgON/Hj
         jn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721400838; x=1722005638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jw6Rg+dO9brjW1rPqY+ybsuqp7Pkeu5EfE2ah6q8chE=;
        b=Npigo1Di7yBB0tKz32X4SD7qiMK9a3rJlG4n9E4hwUtvsRV24lA+6QDk9N06QFQVWl
         nwMQH2YEUAai7HbHZ89IUYO5DxDeazIxXnBBpejHb088xO+XH28avfhjv7wMttzf84aP
         srW/BUtnzXqvL/Rc5mpp1W/tW0x4z6h8ZJjYIEhICGSI7zPLeie0CEaeEUPp0LwVTQNf
         VxFVgHrvcIIk9X1nQVq7USvt5CeZGneRvauqRck3Fvzzj7lu/2TVu2mhN6Itw1+ZDP5B
         3X0CCxkKB6Y+dXJ6JMhvvJN7jgReJ2o33d/EjcNefCBDd9bZXcbu3mDZufRjmvvs+Qs3
         hf4w==
X-Gm-Message-State: AOJu0YwBrA1364ysAbs2Et+ctGdAFjTJNiYatxAPKDhi1bj+id04dtWJ
	9KEcAWZ5295LSgsg+nvmhMHZ+0CKgbYbs2bQml3BIPUz10NAAOh725BSMmPXxeme2TEROhXe5zU
	M
X-Google-Smtp-Source: AGHT+IHMvrQSyQiob1ZDyd4CherJN3neIrj5vHB+KaO3RZONN79P8xVZXLET27RgqTNYUzNUlVwOWw==
X-Received: by 2002:a05:6830:448a:b0:703:6c79:4d65 with SMTP id 46e09a7af769-708e7830134mr7938428a34.9.1721400838178;
        Fri, 19 Jul 2024 07:53:58 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a199074501sm88973685a.113.2024.07.19.07.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 07:53:57 -0700 (PDT)
Date: Fri, 19 Jul 2024 10:53:56 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Karel Zak <kzak@redhat.com>,
	Stephane Graber <stgraber@stgraber.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH RFC 0/5] nsfs: iterate through mount namespaces
Message-ID: <20240719145356.GA2303061@perftesting>
References: <20240719-work-mount-namespace-v1-0-834113cab0d2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719-work-mount-namespace-v1-0-834113cab0d2@kernel.org>

On Fri, Jul 19, 2024 at 01:41:47PM +0200, Christian Brauner wrote:
> Hey,
> 
> Recently, we added the ability to list mounts in other mount namespaces
> and the ability to retrieve namespace file descriptors without having to
> go through procfs by deriving them from pidfds.
> 
> This extends nsfs in two ways:
> 
> (1) Add the ability to retrieve information about a mount namespace via
>     NS_MNT_GET_INFO. This will return the mount namespace id and the
>     number of mounts currently in the mount namespace. The number of
>     mounts can be used to size the buffer that needs to be used for
>     listmount() and is in general useful without having to actually
>     iterate through all the mounts.
> 
>     The structure is extensible.
> 
> (2) Add the ability to iterate through all mount namespaces over which
>     the caller holds privilege returning the file descriptor for the
>     next or previous mount namespace.
> 
>     To retrieve a mount namespace the caller must be privileged wrt to
>     it's owning user namespace. This means that PID 1 on the host can
>     list all mounts in all mount namespaces or that a container can list
>     all mounts of its nested containers.
> 
>     Optionally pass a structure for NS_MNT_GET_INFO with
>     NS_MNT_GET_{PREV,NEXT} to retrieve information about the mount
>     namespace in one go.
> 
> (1) and (2) can be implemented for other namespace types easily.
> 

Love this, I think the only thing is a comment in include/uapi/linux/mount.h to
indicate what spare is used for with the new stuff.  I'll update the man page
when this stuff lands but it would be good to document it somewhere.  Other than
that you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

