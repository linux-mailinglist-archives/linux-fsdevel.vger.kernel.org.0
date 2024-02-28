Return-Path: <linux-fsdevel+bounces-13049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3722D86A95A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 08:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D949C1F284A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 07:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426DA2560F;
	Wed, 28 Feb 2024 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LARv5y9h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8C8241E6
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 07:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106951; cv=none; b=GNlmDkLl2HHVF7UgnmE7dAORfGFTYtG6pnlxVgoxHo5E1OE7sRfdO3zalLqOXj7eLdRIu0AJnkpcG4o1Pg9jt7L9nfamcvKHL9CX4m+n8rxdkTAV2zn5kyGNbyq/RJwZ3AZoyU/uOvXeKdp/Zbpoee90Qdbr5RLTnogHsu45TX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106951; c=relaxed/simple;
	bh=JYSY69f9h2b4GibGes+EAcVyMYs73STamKEhPN21BpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1Ei1wEOZc9eVA6DVRlD1abGu0WZh4p20ZWrhUbuFlvREQ6TOIIFke+EEbE11F+sRBD219TUUYhdu8fLM6ThCRBTreup0N0BhJ0qV4MHYx7aSVeFBQaak+MXtgwAfmGik8ayLlWswgEc5m/IdF3GbzhdS79r3iP8juatLV6i0oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LARv5y9h; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so714105266b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 23:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709106948; x=1709711748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T47BCWAh75xKMs/8o17JkDBWNSecsn9BUIlhcT7aUnw=;
        b=LARv5y9hUaNEVIM/B5Rugx27Uy3XuY6y+ucS2J6QW7EaLHBP5Dam2w8NybuqQce/vC
         NVxHwavSyYN+PaHwZK10InBWbWbI7ZrWSBePyDpMA2Z2nTpn5LskzPe+GuA6rnGNbACK
         LRpumRYIyAABchSBd53ZFUqBdX9kGLchnb+ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709106948; x=1709711748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T47BCWAh75xKMs/8o17JkDBWNSecsn9BUIlhcT7aUnw=;
        b=BwY31j4ISphkfJej+NYqmA5PFxtdl4LvQ9HUGhDeF2p35EYxmWrRCOZcQSEy3ZnQap
         WNBMPYXM9wyQ2zR9sdn3KcLRLOjo6C9rmRKEqsKFAn2K/lMEaO+pU+pE/krRbUCANCP4
         WkFG2I3ZN7rbb+WAgclu7Si6N5xY/gmSUbrs7j0FJ0nfXV1RF2bD5n8/0KfRVn3y3dcY
         s12PQA7ZGrXzYq0Dcq/eOy7NRHJBvsW5Iudujc6T5NAjZz+Ad4Qp0jy3xYOzlBthgPSg
         SxjX5L4pDlQr1VUUzxghjMDY+xl7MBH6E2olh1aObqO5YaVEc8e1n2MZiH9eiG/i8Ob6
         wqmA==
X-Forwarded-Encrypted: i=1; AJvYcCUbEvNrf9/Z5eUXOP3+n8LwNvxuqYd68h8Y9eWaCRNmtXcmkQs3Sj2vxGYGcUKZwQQqGcT6DJpu+1iNSSsXzQPrYC/9+zBWkNLsjDvU+Q==
X-Gm-Message-State: AOJu0Yycy9MG9fDfhmvOEZzdJcPYdQMNfNpNy3kyHNNnvuXPNZAG+Egl
	cVe50rTeRAe0Rvfr7gjZ7OZinB9EFUn/OWqN6rj3vdeBYthbx52S7DmTdK9HZOh35kNG6YF7kTM
	CU3Paj6j2L5hA8zNt13QX+oqSeowJk2rUu2SWUw==
X-Google-Smtp-Source: AGHT+IGqdkMT1ABgUuOgg4QKgqM+uG4YfiWSCkNG4gy+yVayOu4OYoZRzIYjapv5ZNTGBrSKiC4H6LxBAMhhslEUFBQ=
X-Received: by 2002:a17:906:71d3:b0:a41:3846:6927 with SMTP id
 i19-20020a17090671d300b00a4138466927mr8665182ejk.56.1709106947794; Tue, 27
 Feb 2024 23:55:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <11068567-a3c4-457a-bc49-7c9480cabb29@moroto.mountain>
In-Reply-To: <11068567-a3c4-457a-bc49-7c9480cabb29@moroto.mountain>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 28 Feb 2024 08:55:36 +0100
Message-ID: <CAJfpeguvhPHdO0+=gCGPqRBak+3zy=Nyy0pN=r5e5ojZLqsqyg@mail.gmail.com>
Subject: Re: [bug report] fuse: implement open in passthrough mode
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: amir73il@gmail.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Feb 2024 at 16:22, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> Hello Amir Goldstein,
>
> The patch 51deab7d21f5: "fuse: implement open in passthrough mode"
> from Feb 9, 2024 (linux-next), leads to the following Smatch static
> checker warning:
>
>         fs/fuse/iomode.c:225 fuse_file_io_open()
>         error: uninitialized symbol 'err'.

This is my fault, original patch was correct.  Force-pushed fixed branch.

Thanks,
Miklos

