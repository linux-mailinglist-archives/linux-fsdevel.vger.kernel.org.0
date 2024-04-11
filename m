Return-Path: <linux-fsdevel+bounces-16649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9B18A0807
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 08:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609931C230EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 06:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC8813CA8A;
	Thu, 11 Apr 2024 06:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="MrwO3uOl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F66313C9DD
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 06:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712815613; cv=none; b=GqFspmgFRFtW22CTAhZEWYA88zAR+5W28dJrC4E/Lp9q84jXR2Is+CsRuVXM/4j3/v2y1sJ2m7NT8TJi5yIO/9OUDRwQUBRprZrIbB3RGH3rS0rroji2k5mSj2lUNymCEpHC1BBLn1i5d3u8T353EA354uXYV7njXGO8f6pqNjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712815613; c=relaxed/simple;
	bh=etwAmNFsbXUdww48y7BC8erdJj2lz+EKgfLJrt1mtXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ldr6l1zC9vuuHwdUNrZ3rfglyRurTaEJdmchzkCZwjP5NR5ZL2MxkvddqyMS8CBEtm2A7BVfbzWZWc5hs1On1093d8TBjeB/Ybd77uNe9CzouUgP11zGaAOZG1TKhk8pOyK3kjG88xlprXDN3IbpjKhELXzqp2MIcbxGykFjyjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=MrwO3uOl; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a51d3193e54so478490766b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 23:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1712815609; x=1713420409; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TqfSt8w/wpB2B9Py9iSBwVpeof6kTkVrZ0umEsasQxQ=;
        b=MrwO3uOlkPuECuglT59pZSR0KoPfw8rh5kLHlzh/AbfwgLnWC3baYhrhga6GCQBCmr
         +qJgswQXrZ1hVgqDeoP4qRvzeG17w7DebkNZQqC1NUmbHTtD4qRNSzgcKEMe+HQ4bqFC
         ZUhJQKiKnAq03kUysgLqghkGXNOciMIFNVFHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712815609; x=1713420409;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TqfSt8w/wpB2B9Py9iSBwVpeof6kTkVrZ0umEsasQxQ=;
        b=TfODqVDgiUlZaXKTN3mRyB3dS7DtIDb0FcjAgGeQZhzRsQ54xsLI9lDoVaHaoxI+3x
         t+DtGeFR8EUxzTcXehOsZgjHL7XVTVUCIjSRhiG1ONrpdFFtcPVzsRVobr6mw1rn++iy
         LJmi8MPzGc1RU365LRALeoragBMqgZXS84SNHpD0lJXzIFe3Vo/CvPq2ehvN8g5x4s7J
         jQZe6P6+qIVPJENgmcaU4YDt9D0IPObOCPw4OaSNZigSoDnMFgD4d6hckw26nDouTeSw
         67OMRqXRBFwjcOAlG9pNGoTZA2MQKMjLHnS6EIwN2PaSZlozjCOC0WQHe/2eTH23x0J6
         sxQA==
X-Forwarded-Encrypted: i=1; AJvYcCXncSlE+W46++6/CvBjaDs3auO8zD29VQK07PlE9zQQV60eQ46DWZubmk452xP8Zaw9O4f/8lsT0S7fH0PqqACz6GebQiJHnKFd5GNr4w==
X-Gm-Message-State: AOJu0YzF8xgxtOga+NVxtvOJWaB+TGsPk7YT4V1WkxKTel9CFM8L0ne1
	gX9DRVfV/PLVJIoTqZRgtCBHMheDXQB2xt6birzbaXcIKmbdE+2DDfje5kozfVlycDyThFbHWGI
	iQ0c89TxTFUheo4lx1ePd59OCeJB8d/gYuWlcDA==
X-Google-Smtp-Source: AGHT+IGry/tdGf5pMhfHh2d583hk5cG64ou7lZWKS/zaTKtvxUTJx1tmwBEjU+sskUEc1/51fPcviZps69p8CVraRIY=
X-Received: by 2002:a17:906:6812:b0:a4d:fc83:70e1 with SMTP id
 k18-20020a170906681200b00a4dfc8370e1mr2167447ejr.56.1712815609200; Wed, 10
 Apr 2024 23:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328205822.1007338-1-richardfung@google.com>
 <20240328205822.1007338-2-richardfung@google.com> <CAJfpegvtUywhs8vse1rZ6E=hnxUS6uo_eii-oHDmWd0hb35jjA@mail.gmail.com>
 <20240409235018.GC1609@quark.localdomain>
In-Reply-To: <20240409235018.GC1609@quark.localdomain>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 11 Apr 2024 08:06:37 +0200
Message-ID: <CAJfpegt9hBADfGEAdsBjNShYHB68o7c=gHN29SZHqekdnYzkNA@mail.gmail.com>
Subject: Re: [PATCH 1/1] fuse: Add initial support for fs-verity
To: Eric Biggers <ebiggers@kernel.org>
Cc: Richard Fung <richardfung@google.com>, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 01:50, Eric Biggers <ebiggers@kernel.org> wrote:

> I am fine with having FUSE support passing through FS_IOC_MEASURE_VERITY and
> FS_IOC_ENABLE_VERITY.
>
> As you may have noticed, these ioctls are a bit more complex than the simple
> ones that FUSE allows already.  The argument to FS_IOC_MEASURE_VERITY has a
> variable-length trailing array, and the argument to FS_IOC_ENABLE_VERITY has up
> to two pointers to other buffers.
>
> I am hoping the FUSE folks have thoughts on what is the best way to support
> ioctls like these.  I suspect that this patch (with the special handling in
> FUSE) may be the only feasible approach, but I haven't properly investigated it.

Ideally I'd imagine something something similar to how we handle
FS_IOC_GETFLAGS/SETFLAGS.

Exceptions for those were also added in commit 31070f6ccec0 ("fuse:
Fix parameter for FS_IOC_{GET,SET}FLAGS").  But then infrastructure
was added to the vfs (commit 4c5b47997521 ("vfs: add fileattr ops"))
so that filesystems can handle these as normal callbacks instead of
dealing with ioctls directly.

In the fsverity case this is not such a clear cut case, since only
fuse (and possible network fs?) would actually implement the vfs
callback, others would just set the default handler from fsverity.  So
I don't insist on doing this, just saying that it would be the
cleanest outcome.

If we do add exceptions, the requirement from me is that it's split
out into a separate function from fuse_do_ioctl().

Thanks,
Miklos

