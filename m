Return-Path: <linux-fsdevel+bounces-21103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7711B8FE5E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 13:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649751C25D8D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 11:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A969C19596C;
	Thu,  6 Jun 2024 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="k58sY1g6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F0313D28C
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675048; cv=none; b=eKnw7fpit60HtPt4sb3Zr4Um51XBvOoNw/Jgabll1RvF7Fp1WLeh2QBRMbZLteB56L6ENIjXRAlg8yxwHxicgpxkETFc71VVQ9cGMa5ZnZ/ve9d7SjydOdRjQHuWVE4fMDoDqaCrpgJNizxfwDvDiS0V+6Bu73ktmSYU+Kh5Tvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675048; c=relaxed/simple;
	bh=yRNz1iBHgX4K/IXUNo+IYCbFZ0ijdce068h0Rdde/LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0lMEDZj6yIClTljM5BpRZYrOErOjR/gRlWjgK02S5J0CcFT0ONMU0TxriqhE6v/nbjFM6CL5Py4Lw4/7goQI/1nIUAc+kkzz+GZfqt8ITsxTAFncbBuQb5pJLiOy3CUbraR3rfYTtVb15zziVRh+klh7QjsFy5S/xkAFC9fLTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=k58sY1g6; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a68ca4d6545so156678666b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2024 04:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717675045; x=1718279845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yRNz1iBHgX4K/IXUNo+IYCbFZ0ijdce068h0Rdde/LQ=;
        b=k58sY1g6Y48uwuTFUMOV97/WhJbfAQjvdJYhPQGnnNyxqZCUNo3h+HaD/2bAPg9oac
         wUNF0m1keY2I7pIWPlnn7sGTSsiAEUghgevruMICBlHMA7z/lcOxqUu4p8h+Cabd77HI
         H8Q6AjjYbFFc834WdWM8ubCmuj07Y5YwTUwpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717675045; x=1718279845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yRNz1iBHgX4K/IXUNo+IYCbFZ0ijdce068h0Rdde/LQ=;
        b=EiAaim2qRbQc/SsxxZFkD1qx4ncgkXBeAYavcuMAemqU2voTyORGm3ilcdnFp2k3lx
         lj1dx1ZmzNrPqKDG5MOpZMaPOyPH3FDuWsDgjNy6/pDPhLPcy1oI8XmzwcexL8xT4T3N
         tK7VxTw9BrjfdR2/FU+RAssPAJiPSqPacS6pMVYdv0afHnade8OA3EJCBtH/AERz10jq
         q//tGGVZnPkaIWDL2lCLe7GEb2abeAr1p3vCfC8tgHYoP5rkeZx9a85lxBc3uBuaKE6w
         XS2DCf/uZqojzcRi8iWcaYgSKECkBgFLk1eCVGAepfj0hdzma3DJRKIPjC92r/XQmLXq
         9OMA==
X-Gm-Message-State: AOJu0YxgFTcyBD0HReuLwHPfldlHqLiuvtByR9p3hMkjivESSyK09qd/
	SaXCyxsaA8yfZ6mwZ3DBKMdWj0WiLU8UeXvZdBECCBuYV2w0gOeH6d4bspr0FPVr8z+Empd/GJT
	NBfKhw1b400pF4MlQFNLinaR00Eq6ydK3cdxLbQ==
X-Google-Smtp-Source: AGHT+IEZChVQXnyGFb0q1z2OcJNfROfWpovcuEmTvT5lcePccPpw6v0YfNA8gLYpgX+VqE3IUrsxwaJs/USfhaB9UN8=
X-Received: by 2002:a17:906:f819:b0:a6c:70f3:de0f with SMTP id
 a640c23a62f3a-a6c763bf45bmr217578366b.28.1717675044718; Thu, 06 Jun 2024
 04:57:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000c27c85061828ca26@google.com>
In-Reply-To: <000000000000c27c85061828ca26@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 6 Jun 2024 13:57:13 +0200
Message-ID: <CAJfpegtbimr3sbe-8aDLcbQ4FHJiuUdOh=AwFsqAWbCvAj5KJw@mail.gmail.com>
Subject: Re: [syzbot] [fuse?] WARNING in fuse_request_end
To: syzbot <syzbot+da4ed53f6a834e1bf57f@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz fix: fuse: clear FR_SENT when re-adding requests into pending list

