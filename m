Return-Path: <linux-fsdevel+bounces-48259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C669AAC866
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 16:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B41D1C43374
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 14:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0702820B4;
	Tue,  6 May 2025 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcQmmg8c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22EE270EA1;
	Tue,  6 May 2025 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746542647; cv=none; b=ELzPa1jvbhk43czkTOLoagZuA7LKIFS6PApVY4QIOEtqT35+tz7MajJVZfgD8NFVnDkZrpwNvFkeVByH9nhgSeWaShTqxxyu5dHzwmVTj6w9Ot/MEB5ZxqJ/CX0J79sLws3AZffHmih5ks9MuC5bULp/ZupsEe3ktqzuSj0zTbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746542647; c=relaxed/simple;
	bh=3QfXSnc5w8R7jrH8OugG82kWJ+PxgyWUlsLE3oZD9XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWqMeb1Y9IKuw7vQMsW8FHXoB+JdZUKiTYRT2WUTJmB1vdy9apBVUdrj3x3AVwha+PrFxEY8Y8YqySvvSaZxiqKKWjEJE9rM+iCIk+PIiTSW79vgusjLAi1QPZFzv91JAGKxWGP/OmceV+Ckv+68MEruRlj8wBFS653Se8A9jZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcQmmg8c; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a0adcc3e54so472700f8f.1;
        Tue, 06 May 2025 07:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746542644; x=1747147444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kgv2Oz6iPtMbJz2CTRkx8b47IVM/KLpXEmF8ocTs9kc=;
        b=GcQmmg8c3imgKQKYsW0Vk5g/NoxyzB95h1HJR9sleHqgGJA+2mDR4+hNYV4tsm1+UK
         fqamAjHcUa7YtZh2z1ssMATUaYa+LDp9Zzex+6FTR08RinZ0VJrBttkZ/2z3lWgeX5Ed
         DzR9t/BjZqbXyUIftzE6kCdVn2f/1DL37pcT9nHXKl/bcV1oUauOFGoPaLU51wvNnxwo
         yMeKIBTzoUXfN5mg1TlSYtlbAiKDY3dUnDqL47j7r9SdLFfjcJOspP4GWfKvIYuhE9wd
         +23yF1eKqAdaL4nBHhxK4zBzBltgwRLX16Be+VOoxS3CcAMY5Njhu4jvUhbK4Q6X4zwc
         +QeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746542644; x=1747147444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kgv2Oz6iPtMbJz2CTRkx8b47IVM/KLpXEmF8ocTs9kc=;
        b=dRaI4mjJ/gSiM8CGdH/CIT/YXCG/18jy5g9ZFhhwn169XD31n4Y+Kle90rX4lfKHTj
         JGrUGlTlM3bUSVm1CoGXpGp15ZnHgS4u7jiDq/UTnposRa9ZE8LUpx8yWi1/RwOo1yRC
         saVGL1B6dBdk6m9wNcYssz/hQewbBZAsHOMW2Rer6Vv7MhZV3DncKH25ggoCJFAO7G2B
         Ykvup5+tLbEQoHS+l7lDiRftseQpqMZVNONMPvz+FbAF89FIAqp8cJpDhzvdq4C5LDJY
         pAZxL8h5TLH1l1pmWgF34MrLawOqa474sp9p+rfUMFPrm4hGcYUIv8PgV3/ai5JdgdFQ
         nbrA==
X-Forwarded-Encrypted: i=1; AJvYcCU0DcMcgLsqIhkuIqvHh8yDy8rZ5O5tePbnOIOR6cMxMh4wp9IpD0tTXVv9tOUUvMcmjZUbrMitK/cJGeXA@vger.kernel.org, AJvYcCWb4HCiZLmZz0TELzjM51KoQWOEw+dYTCaSaflQkabT1zD3jJ8u6BUbSAOHBN5xm6ZFVVlPe60YPDCymfDX@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcqh33TR35+BhIULW9uWcXWNv6nEYTrBPgIJjXGCTXBVGnxq7r
	Rb99xdJU2AeyswVx5TcOyeCt4pD6o+MeCnmViMlmIyACmUz+CsceQej/yw==
X-Gm-Gg: ASbGncuYy721Hy1+5avY8Ni0VqGD1LXbVzPm9AbBBuWDWz1aeZ4wfz+EMP3mDR+Tzv1
	eYm2gEd/Fl4RvEJT3znH+OKlCK6uIuKLLxmRZ31zNL+M1d0iTiYE3tz8CURQhWkVRDanBtcLDjA
	VxNr4jNCwvJqiJGKcmwSltbsioIPXVfuUzSOda637fjn+qFVCzeYnfVwsyV3Vjl2ERPRmAUUZeF
	4cPeGrRmkWTPJn3KP3j32xXFhk+63oOvOBFSVxjGTjddlSbJzyCK+NDYDi2OAY/y4/vjFq8hEEy
	ceqbSfJae2nWn5YE9B/E0ZMMSmrboctrJN4/cYUWIyCh2rBix8M=
X-Google-Smtp-Source: AGHT+IHbMZ5DozORsI2hRq+KWiNqDXAo9wLcIv2syQJ6WB+ScvWPPTo+aWIn/YhouYmVnEXqo73U8Q==
X-Received: by 2002:a05:6000:1785:b0:39c:1f11:ead with SMTP id ffacd0b85a97d-3a09fd87a2cmr7930671f8f.26.1746542643823;
        Tue, 06 May 2025 07:44:03 -0700 (PDT)
Received: from f (cst-prg-3-11.cust.vodafone.cz. [46.135.3.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b178absm14124554f8f.97.2025.05.06.07.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 07:44:03 -0700 (PDT)
Date: Tue, 6 May 2025 16:43:56 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfs: detect refcount bugs
Message-ID: <bsap2vh4o7h3c5kwmtbgrcjuzldic2m33tlierxx6eqxz7uuqy@p3v3ipakqv3y>
References: <20250506-uferbereich-guttun-7c8b1a0a431f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250506-uferbereich-guttun-7c8b1a0a431f@brauner>

On Tue, May 06, 2025 at 01:55:54PM +0200, Christian Brauner wrote:
> Now that we have pidfs_{get,register}_pid() that needs to be paired with
> pidfs_put_pid() it's possible that someone pairs them with put_pid().
> Thus freeing struct pid while it's still used by pidfs. Notice when that
> happens. I'll also add a scheme to detect invalid uses of
> pidfs_get_pid() and pidfs_put_pid() later.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  kernel/pid.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 26f1e136f017..8317bcbc7cf7 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -100,6 +100,7 @@ void put_pid(struct pid *pid)
>  
>  	ns = pid->numbers[pid->level].ns;
>  	if (refcount_dec_and_test(&pid->count)) {
> +		WARN_ON_ONCE(pid->stashed);
>  		kmem_cache_free(ns->pid_cachep, pid);
>  		put_pid_ns(ns);
>  	}
> -- 
> 2.47.2
> 

With the patch as proposed you are only catching the misuse if this is
the last ref though.

iow, the check should be hoisted above unrefing?

