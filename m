Return-Path: <linux-fsdevel+bounces-60971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BBDB53D4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 22:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636A75855F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 20:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B722D7DE6;
	Thu, 11 Sep 2025 20:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z0TSCxQT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158D22C15A0
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624064; cv=none; b=AfBn0WLy73ihqNKw9EwkCsuONvblIY4VWDlWerGauUY/Y+lKiqoMGzbSWKfvzX6H1j1f+FDlI7/Oq0TV2lzxu3SKuwRW8d9ybDiu1nZ4vWbVlm8b2aL7mtimtSpSilyvBM65Yk+EX7tgmOxUoFsfg+oK/82MQW+im2a8X2Xu588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624064; c=relaxed/simple;
	bh=IAkTZVuMJAlakYbDgr6bPsITWtDg+0Us37CUJpJm1uo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=YTq6dZV0CD7GD0Q5dETOdy4c4dGRA4LJBRohcLrv4O11T8LBePTmK3pVyHkng1+FAgekKXW6aUKuu4nGSyzGG5zfncBuqT8BkyA4UDEJ1Wl3LtzdJ1vyEMBuGGufJGFLD2h06Mt6SWv3aas7MQXLIYybfC+RNd+k2DgZ+iDcdG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z0TSCxQT; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-816ac9f9507so254838485a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 13:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757624062; x=1758228862; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4qvTZ6b1TyKm2nYvC5gMYys0nnyOLAaCMgbalwU4nk=;
        b=Z0TSCxQTANWzfkNYU0Jd00tq7X+YAVQ1XIX2+25ofr/jPjYzDa/GunC5aT59ogxvJx
         eyWRvU5vSHqYUpyhRl4e7QMkfs/5j0OuCEwhJpMjBj326ZzVGQVAmyOxXtrikFLFjygJ
         OvpN9zVK1VjEm66AtirTFkl5bZYm/JawIL/oBNPbGyB/UOmb+z9rjN3MCBqI60hz2iEz
         yJw9NOtfN+tNoN+IKLemGP4EHGVvhhnoNdfW8LuJZM6kT49ZXOV1Bdt3ep/NhFjoh7Pb
         V8d3IIrkD3rFYQsitGNGOJy82KWz44QE9k1yu8sc5ms8QgxWzuRwMuEVc5Ds5yMlDG+M
         uHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757624062; x=1758228862;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y4qvTZ6b1TyKm2nYvC5gMYys0nnyOLAaCMgbalwU4nk=;
        b=TNPu9euPDEITItVlzQBlaT8IZUX9irkszw21i1yYds4X5KKO1GDdYD5u3n7iwTEszt
         Xsr01/bs3yaJRIztuBAbyCan6GptX/TmdynYQHdTAtSJm+T8FtAHEgORgjuyAOucLZ4d
         gRPiU6qiR2xx6XuMEAY0LXilRYeyVm8Z3JMFSvmVH5RIOYAU3u5fLIvWtOECHp8r++uy
         VZq9uby2nZpKW91lcZoYOMrpmYeuyT/tUyBuwnAM+wF7TVNCIpy2V+gjUmzHLvuiNmCf
         AFqZcbugF5+NiZO8PQ00GedtsnlO9JrFqiiQKH4jTKxI1N+fsiLFTDvQ/3JENYXS6dNU
         TLzg==
X-Forwarded-Encrypted: i=1; AJvYcCUgDYrTzdwZraaySg3s3hkz/EkXA+G9jWBISe4E/cbgaVr2OKND4oDolz8CLoLC4pY9wMBuaDsINYcjZmAh@vger.kernel.org
X-Gm-Message-State: AOJu0YxV/vF/x5rCIjLYa4uRaEeqCxcODADS0wpMkAl74l63kuLDK+v9
	/3BNli3axvLkjIrvqAEwtm/axlWoaSTDfXJm/GSNjlrOBZQmYWPs12GXwocUv6vVt9Z5/R9S/1J
	+biw=
X-Gm-Gg: ASbGncvOZFa9D626IDcdsZFF5KqRJxRF26H2IRj7NTqYnv2MLdgWV1IwZhEC3QEfQIb
	Bf3/RdPp9TYaWpQsVGet0cRzExirA4ZTeP/ZJh08WOOIgIVNmbgoJtfqzDxYIxMW7Us+OR7twmS
	Dcikjn37LqTr2EWb1M4PERSJ14UuBpoEfHcUbw1ch4BaVusV110RVAnfPwg9JKxmcod0af5vGiT
	GiaiSliQM2kTULhAfu7L7Re3Fuw5Dk7TPDeCjew8Ppk8Jvtpj4FPGuMLIgqX2MUWUqpxUQ5cS3y
	SSfkxawAgH97hTC0gq3PeUA93FvxPS+XX7Zb0C3QdWl1fhXOmfyy8YxS3GcYSMyg9RD/ZpXTIX8
	q/AdJTEsNET6IbRRdR+PShnMj3ZcI9Y98m7mOZCqMRfj5YVx81JhYtMGHCGvBYs4wIlGmFkO5Mm
	po9Z0=
X-Google-Smtp-Source: AGHT+IEX7rklarTyTs1aa6eZxMFKR2mTMUD+PJmsGRKVSSCqnw5/WIrBlp1fNwjoDz3NBnRjfF2IrA==
X-Received: by 2002:a05:620a:1a87:b0:801:537e:cddc with SMTP id af79cd13be357-823f9967911mr107148485a.13.1757624061834;
        Thu, 11 Sep 2025 13:54:21 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-820cd701cabsm159872385a.41.2025.09.11.13.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 13:54:21 -0700 (PDT)
Date: Thu, 11 Sep 2025 16:54:20 -0400
Message-ID: <b042d4c28324441644cfd8e3d7733477@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250910_1926/pstg-lib:20250910_1926/pstg-pwork:20250910_1926
From: Paul Moore <paul@paul-moore.com>
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz, neil@brown.name, linux-security-module@vger.kernel.org, dhowells@redhat.com, linkinjeon@kernel.org
Subject: Re: [PATCH 1/6] security_dentry_init_security(): constify qstr  argument
References: <20250911050534.3116491-1-viro@zeniv.linux.org.uk>
In-Reply-To: <20250911050534.3116491-1-viro@zeniv.linux.org.uk>

On Sep 11, 2025 Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> Nothing outside of fs/dcache.c has any business modifying
> dentry names; passing &dentry->d_name as an argument should
> have that argument declared as a const pointer.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: David Howells <dhowells@redhat.com>
> ---
>  include/linux/lsm_hook_defs.h | 2 +-
>  include/linux/security.h      | 4 ++--
>  security/security.c           | 2 +-
>  security/selinux/hooks.c      | 2 +-
>  security/smack/smack_lsm.c    | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)

LSM and SELinux bits look fine to me.  Al, I'm guessing you would
prefer to take this patch as part of the larger patchset, but if you
want me to take this single patch for the upcoming merge window let
me know.

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

