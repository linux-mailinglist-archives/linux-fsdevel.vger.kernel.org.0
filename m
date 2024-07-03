Return-Path: <linux-fsdevel+bounces-23043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB349263C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 16:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EFAEB29949
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 14:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0700B172BCE;
	Wed,  3 Jul 2024 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="GYAEIEy1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE1D5256
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017982; cv=none; b=Dq83yFBda5q/luxh31YUBLZlH7U+jv1cn1wiJZClOl0Imscu4jO7g486fgBAIh0ceYeu7ImZ8CcO8F54e/GgMJ67aFXWFyPpoEt5Wv01G/ALX4kKjFM7x2r3qtdEktOa77kwMp48JPaFV4TCOi7QaIKl9lgbMw+DDkHtNQRH4gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017982; c=relaxed/simple;
	bh=Kgi4c/lnViYPjHbo3SH2USHnyYKood9urc96NWejx+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMcJYz5gEu69lPb7j9WUjBXZVOtkrNx0j3JwRpJ1Szkb5C5PblI3A9pmnckhK/9qAr9FMHLFXSNPr0QZQukKvl0+JgulSrVMZag+Y2rgftkG4KO6W2ILoeM0iGLc7O6Pgy9TxqYU/XWBEHHd+2IVdft/PcfURiu9VmZlqXY2D8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=GYAEIEy1; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79c0e7ec66dso444262385a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2024 07:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1720017979; x=1720622779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jYOC1HUrylk74aUXXXeF+pAMxvmAfrUIur11BWJR7AM=;
        b=GYAEIEy1O85JShcrOuaMuxcH9i1uTiyiaUnr7r+VmQw3gqj337ViZ65scNbbNoG7EZ
         o+4Z9odou+DguC7UpZKPJTQfbyDsGn98tsEqlekNpHQdbIo7THSP4PSO2dNOPvGX+TF/
         XgewF4fTMsl1D+YCdWAIuHcEkReKDuO7b1G9CdX+pIQAeX8rAn/8rli2mwziu0pPF1kf
         LUMrj9jDYhxafJElPdsEU21Iit3TZZdv11PDQ3aT0hiZUxRk/7b0bi8WoWL1aajE02A9
         EnTYlAi9WyuvIDGNccgt9wcIW1+MlSoq6b97QEJ81t31C6w2mCSSHPPFCjha884PBsG6
         tMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720017979; x=1720622779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYOC1HUrylk74aUXXXeF+pAMxvmAfrUIur11BWJR7AM=;
        b=G4idp7wBgkgrT8nF0Jd7GcdkT2oiMpKl2tEKb3tP7HyiwVuvM5fWRqegPBstELTZp3
         0imAZgiUdCeZhK7UulJwXQeyfmq6pXdTuAID51UwTVt8oWiqnt68l1aVucOlJrrposPC
         0fetq4r6a6fqIVnQ8FcAoNBTP0JOFBx6QSGhz2J15biK50xJ0ePjzIE+mM3FfhtEByjD
         FEcvPsSv9fnJ7RZmdrjl2antcn6z4GAkMLc4Fra6XOHSfQ77JfUPHj0qaE8n2M5fcDKi
         2mejVtYNlo9o4QutEB/bLPXPJ8jf8vy6ArBppeZkASaKCKnU/Fsk63mkmhfpa6cPkbD3
         q5pA==
X-Gm-Message-State: AOJu0Ywr3uy1qolezLlYYkeL0cf15QWet7LLE7dWTYW6fLpnfN4EiyuI
	v9xzkQ+4ydzaSSLwIUV9n4DZ6nbcn5IDhzM7wez7PNdIMknOO61CTVXOKrP5AtE=
X-Google-Smtp-Source: AGHT+IGmezmt33Oxu1Qj02F8afkXj7gx1QKPfR34B+CSSiGnMDjzIDA9nZ7YLeQs3FwggsJ+1E3RLg==
X-Received: by 2002:a05:620a:ecf:b0:79d:769b:a7ef with SMTP id af79cd13be357-79d7bad14b6mr1327418685a.68.1720017979230;
        Wed, 03 Jul 2024 07:46:19 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69299e4esm572354585a.67.2024.07.03.07.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 07:46:18 -0700 (PDT)
Date: Wed, 3 Jul 2024 10:46:18 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 0/2] fuse: fix up uid/gid mount option handling
Message-ID: <20240703144618.GB734942@perftesting>
References: <89e18d62-3b2d-45db-94f3-41edc4232955@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89e18d62-3b2d-45db-94f3-41edc4232955@redhat.com>

On Tue, Jul 02, 2024 at 05:12:18PM -0500, Eric Sandeen wrote:
> This short series fixes up fuse uid/gid mount option handling.
> 
> First, as was done for tmpfs in 
> 0200679fc795 ("tmpfs: verify {g,u}id mount options correctly")
> it validates that the requested uid and/or gid is representable in
> the filesystem's idmapping. I've shamelessly copied commit description
> and code from that commit.
> 
> Second, it is switched to use the uid/gid mount helpers proposed at
> https://lore.kernel.org/linux-fsdevel/8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com/T/#t
> 
> Both of these are compile-tested only.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

