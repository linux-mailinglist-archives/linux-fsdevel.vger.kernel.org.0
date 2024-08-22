Return-Path: <linux-fsdevel+bounces-26683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F7195B000
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 10:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F4C1F22EFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 08:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705ED170A16;
	Thu, 22 Aug 2024 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XQzLSx/H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C93B16E87D
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314515; cv=none; b=a20R4oFZFBYPV6/Sw6AeljKJLJAPp4kf254IkcFlYFPCYh4xyEZte07F2bxi+ugW3g+B9NohidgCJ2xIBCLkUjNcmJGBP0MrnWCHDSGs71KumoiWvHhpBQ4lsHP93qfy7wpQHTdM7qAabTOGAe1Sq/SDMYIfRo6mtrublS0ziEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314515; c=relaxed/simple;
	bh=LQg2LikSVh4t6qUG9/JiYVMdVBSK+0WTTilbAKFAUcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PnBbQagjYMujFrFWCB0e89z0u9E774Mo2p00KU40AguRieyTZouSx8afcDUBX9JT25us11pGdPkbdRAlE/FGAXR1HQtl0awjqpj/4Cy8nxFSmSgjx2ga/WMZdd9R5zEPNjOoUqTH/gYYdLeofxfvWG10D8WYFRZ0Zt1ifC1qCuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=XQzLSx/H; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-533462b9428so838273e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 01:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724314511; x=1724919311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uqbG4nW5Y6BHbHkXKVf6nVFJEVL3TwPzeJDq6NPW2qo=;
        b=XQzLSx/HKg+X/ALxTZuew+UMnOIvTcvEafXLyYr6F3tj7P2jigajL/ve5ujEdLQimN
         Ld9+g1C2Kc5tk6F+d4KLKrjybHnRnXiIZJJXOhWVWt8Svq0n64QA6+7+qYF0WtPJNyTr
         e95OtRO2q6fa71+l6fQgp3YnZgM/JqgkI+i00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724314511; x=1724919311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqbG4nW5Y6BHbHkXKVf6nVFJEVL3TwPzeJDq6NPW2qo=;
        b=Fxed1X9SFI4a6olC8IjSpW8P1Y5I7PL7WxLhLtqWOJWeInJ6ZuRO6o25hNhug42s6L
         9M61f7tuufcm2Y5u3paMR05r/ywTHz1ydxwe7qKi6nlTBy9FAhSM+BOBWD7rCPs0G+kl
         iCdF61SW9P7Q/lR+Ia81jYO3APZFGNWrb2zi5d+GsE3yXz8g/uH1W9mrjj7dsV8HMoQB
         zXh8ic3CUu9JYqReLYCTxGSaJInOMkOdSVQN5OcLcoIy/kQ8Ey11ylMVoV5LQ9GtXhF7
         yVBvYX6fhxUYhgLJ5X2URFKVVl99xfoIwiVLWhkmwWGg5JwznaAFos1zcFHQ6KBmO4cw
         +0hA==
X-Forwarded-Encrypted: i=1; AJvYcCUyTP8IaHwAY3TxDolULQYbqrHlMed+EeU8CpPd2/FYmLHrv/iOTTPdDgus0qron8g2Bfj1KWKaZy0GKI4P@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1SbxTIDaWfdRw/qbQWtHCsXboFPE6CHnRWMRgXOq5fdD7YcmN
	ErDevVNPHpqoVZ0hzQWZsGtEFyYvi4isDbFYPz1R9DUgQpVK+TLKgC1W/SxZWcZfORoshGhLZPx
	eQyX1+0MJSec7YPSc0QdxNI86qi5k/UUumVLhWg==
X-Google-Smtp-Source: AGHT+IGeEsWLwDn62Q3uOu1kuIfreyy7/gjPN+p1rXMKUOBZDfj3t2/mNoyV7SIAvs0yR/zP1E2sixQmJRRO8bfS9r8=
X-Received: by 2002:a05:6512:b06:b0:52e:73f5:b7c4 with SMTP id
 2adb3069b0e04-5334fd4cbc5mr917514e87.37.1724314511188; Thu, 22 Aug 2024
 01:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822012523.141846-1-vinicius.gomes@intel.com> <20240822012523.141846-5-vinicius.gomes@intel.com>
In-Reply-To: <20240822012523.141846-5-vinicius.gomes@intel.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 10:14:58 +0200
Message-ID: <CAJfpegvx2nyVpp4kHaxt=VwBb3U4=7GM-pjW_8bu+fm_N8diHQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] overlayfs: Document critical override_creds() operations
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: brauner@kernel.org, amir73il@gmail.com, hu1.chen@intel.com, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	lizhen.you@intel.com, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 03:25, Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> Add a comment to these operations that cannot use the _light version
> of override_creds()/revert_creds(), because during the critical
> section the struct cred .usage counter might be modified.

Why is it a problem if the usage counter is modified?  Why is the
counter modified in each of these cases?

Thanks,
Miklos

