Return-Path: <linux-fsdevel+bounces-19253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA548C20A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CCCB1C20DA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 09:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15857161333;
	Fri, 10 May 2024 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bD4Sg2m1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578A315F3F4
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 09:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332616; cv=none; b=doTPs5V89YS2uTiWezkArdcI7Lb57ZZz3R96A75+kB4W4zmEfsedbIFMn0aEcencFZk+Wcv/iZM4iZ1GGxlyDHjIaFO5FJ5R8iACOnGcHy9CnZRJkwCGBRwLa9+BQmFZRTeLILWS/uRc1KKP30ub+e6HchyqgQlZhwzIuaz/kvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332616; c=relaxed/simple;
	bh=PzEAvfubVdzbr1Rad2HFxtO4tJenQDkig1qLCknoPWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wm+0+alHmGqQyI04gASYR+A7TzSt0jTpihVDpuyCda9y5cgwhU9jjLljTrGVUVtK5eBalMPTNlWuFqi+TxWBu79PlBA8Dv4peaTcw5fnEFCeADRA69G9SyMcG1ggIhCb2sKeWQOeWAuPMGDhQIj6cWNwkxHRmk2/GhVG0Nak+7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=bD4Sg2m1; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59cc765c29so400021366b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 02:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715332611; x=1715937411; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PzEAvfubVdzbr1Rad2HFxtO4tJenQDkig1qLCknoPWc=;
        b=bD4Sg2m1RLi6TOkF1O/lKZ5jEm9XL1TkRr0NRhH6fAZ32FRZ8FfldUJrCDJcd9SuJq
         vFSwIalQSk1h0yztBNxCGVOgu9+4YPe2t03xV6ppCpwpwPqH13jS+jrnFmgstfEDK9DB
         0b3CamPPu4vyMoHbunE64lihXFHlQp98uktQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715332611; x=1715937411;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzEAvfubVdzbr1Rad2HFxtO4tJenQDkig1qLCknoPWc=;
        b=bFKZ/hbXMp3rNz4YK3C7ejIX7amEXXSChzcaEh8cxVcTkraCxaXiOy5mrYj9E+lz9d
         q9rFsD8Fu2tExDXMgf+tUwfv2NCb8zL1Hq7z9A/6vBap6C2cPIsLANJdMiDxTP1sf0a2
         29ku6Rr69kiBwa7YKUK+/kT7NsdRx3WZOeEbqU0TRlheEHUarh1vkgPTEfRc1msLmCm+
         uJvkI4zUqO+CsKSD5THzBPL3rd1YGGDR+eT/XMLsS/vfL31wNFYeqdE+gjozx70g7Z0Q
         AOqBv8hV/+NBDv8SXcqcDF5fCoxzq+wPNDoeGTTi9PiN7Atitpn9ITgIFN8aXpextexQ
         a1UA==
X-Gm-Message-State: AOJu0Yy91DjaV8Cx60EpUCIPKM0+i0PnLDN/5fXuaAR27QKHvohfQytC
	JDCh+LkLkKp788sbtXkreWKj1/oCPMXjH4WH4OASwv3EKTqMEcOhSgRYypMGAcKgLyMLoZfyGC0
	Kp0it3evrLYLvti5K7eJKq67JW6qFSQ9WOromgw==
X-Google-Smtp-Source: AGHT+IEBQo/Qbfl2WC+0rK4SGXKb1MtU+UuvKOJs0bGdaUK/2EFugpwAD8QMjqigbM55196R57Wz0hxTuWlnljjn/MU=
X-Received: by 2002:a17:907:6d01:b0:a59:9f3e:b1ca with SMTP id
 a640c23a62f3a-a5a2d6657camr156437666b.55.1715332611232; Fri, 10 May 2024
 02:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509122154.782930-1-houtao@huaweicloud.com>
In-Reply-To: <20240509122154.782930-1-houtao@huaweicloud.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 10 May 2024 11:16:40 +0200
Message-ID: <CAJfpegvJgFfJmDZXw7NBGZ5WASdxTy+EVjQxBSydAq1oARCntw@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: two tiny fixes for fuse_resend()
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Zhao Chen <winters.zc@antgroup.com>, 
	linux-kernel@vger.kernel.org, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 May 2024 at 14:21, Hou Tao <houtao@huaweicloud.com> wrote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Hi,
>
> The patch set just includes two tiny fixes for fuse_resend(). Patch #1
> replaces __set_bit() by set_bit() to set FR_PENDING atomically. Patch #2
> clears FR_SENT when moving requests from processing lists to pending
> list.
>
> Please check the individual patches for more details. And comments are
> always welcome.

Applied, thanks.

Miklos

