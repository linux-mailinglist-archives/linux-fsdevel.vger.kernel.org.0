Return-Path: <linux-fsdevel+bounces-57844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDE9B25CB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 09:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06C572622C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 07:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EABC2641EE;
	Thu, 14 Aug 2025 07:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlFZXSxZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3DD76026;
	Thu, 14 Aug 2025 07:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155291; cv=none; b=eNCXyq7Svk68mne9bzfwXh1nSImghN7p4FsSB2s0vG+2XTxAIlQdg12YjtE2e0SXm5+yrIV7QiPTsMPV4RrrmJ5zziuGS3Cs3WhtFoHpm4HkCTVyld7fuoBrUeozR2GdPBrnd9JZkK4JzA9BndOCpO+U71bSgkLIOY4cv/MfYl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155291; c=relaxed/simple;
	bh=iS67YfDTC/Ncbq053qWWDMLTEvwGULYZ49mkMlG5gWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTQgXpolKpLgq4aQJrVXValmsTs2TIZ0L5xTY4iSHBfd6e5I78z+jT2OzNIEcTnM/vUiim5z2plButLmo5uz3+h2Gjr6jaQAhTNy9MxY7xwoCd92IVnAehfBO5htQcYngXNxo6WNcVFH62brmWEQpM/pdx1f7scCaY/LqAwG6vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlFZXSxZ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-323267b7dfcso643334a91.1;
        Thu, 14 Aug 2025 00:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755155290; x=1755760090; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iS67YfDTC/Ncbq053qWWDMLTEvwGULYZ49mkMlG5gWI=;
        b=VlFZXSxZBnaEGFsebI3F63rlKI/IfPYFIjp8nxXDxqmFqGAkR4WT/fxPlnO8nA7Uw+
         Aw80Q3n4lD2Bvxda1p0a07PiCQ+fy+XVzvej142ZNKxSvdY/WAuuKUWx4aP0i2R3uWqh
         mCF4kbdA9SFcL5EH34he9DAZfAbV/3PycCJpefonr/sFaGXTXT34kcZPnC/T6A9T3Ix+
         7SaObS7DpjmRshxssytwI0nNWH4LbIetRegBWLCjRBQxgW1VvBIm0fQalWBVTgXsT/fj
         VzUHEJdCgGssYw76Spwzd5RvmDEFMt4KyQ+/ORbTjPba83bGleTaYQbeWrS2Xsqgsl8q
         I8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755155290; x=1755760090;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iS67YfDTC/Ncbq053qWWDMLTEvwGULYZ49mkMlG5gWI=;
        b=k1mjcREgB5Or6qGNVp4NNRi83rsg+FM6EMfLkNQuSJ7228K5T/uvHx2oETavUFuG22
         m4su8aPqczjaKVuoqjO7NDHcOcJ7AoXGflhIc0bfGGwhjerxQwtPAkhNBRxIE/FPfX2V
         OsZoVo93iIINo5TNQ2//PFLhkFGhmQFmBGXI92DL7iTCiqckQvGkq2VGK+wJ3LmhjMm1
         NkhHBvLHMFhDwaOvVv4VodCnU1lD7CVNu2+5uFObxmUbuEVt+G1Vx16250flHFXPkQWY
         FU46pY+tFJSIoDTwzWJAj8+zY5RCFZgDNNcX6Q/PLUKuOnQzn2egoVilkWP3U4yiHi3J
         0Zyw==
X-Forwarded-Encrypted: i=1; AJvYcCUp9xUB7noj7Vj28O4dzTxKNeRbnyHUVNLZOTfrHO5/+mezhRIV1+dW2MzxmwDq26ro5zZ2GACR/ik=@vger.kernel.org, AJvYcCW4z4mAYCw2VBC20is01caVIl34T0TFdphaxLLx77Dez4B1bQhbmARMJj7NfCru6A36/6SsRNK+YOYckROtXQ==@vger.kernel.org, AJvYcCWRzMUTBDAgVklXQYyCtZ7HHAXoAOB9I+h9kTmLmHFLdoVHrZzXhdVoS4rQUXbpifl/Tjj5ZEOv@vger.kernel.org, AJvYcCXUN/GuD4xxe47pmMM+vXbC0+ZXRh8saQ7lkymIhaNhxzbi7fDpCICb4eXNs34RimnqW8nRZT6mCugl2czx@vger.kernel.org
X-Gm-Message-State: AOJu0YzvD629w9zFe2WmLmvxmuMa1yzY7MeeOv8Q3J+fVeIfOR5QlrTV
	AgJQpDtKXsjawEST3qkWVyWl434mQc5Efpo/n0oAMlD7HR/O2P7b91DKuSyn5HI2EmOz6Njl/eF
	4DpuD9PortmEvLJIT7MlEaOzyGP+f2YCcfMqnUUA=
X-Gm-Gg: ASbGncum382Lk2vEziUiY+3Kvv7MOBYljDXb9WU+dCpLfmo8u3r687qV8AetwmztlTB
	SghueSD6jRggPkGL3L9Xc3cjwpTyJ03CkEzAY1JxtmYFQYIBt5XzOB/vrwB92HCyS89Dr/HhC9/
	XZ+/ocVu6HBPnp5fL6mLGNmtf4UsqZtCYMdva+vnSruNG67DpX2X8BxqKVbBDe9XOpMvNtWUl4k
	iGPYCEH8w==
X-Google-Smtp-Source: AGHT+IH2Zff/q6dgsi4JeGM7S5teBCpWLxN+arzrDUV01xHua6GL8EAVnGgyxeVmkD484kw8TNaV5y7g54oRgT5cpDs=
X-Received: by 2002:a17:90b:5303:b0:312:1c83:58e9 with SMTP id
 98e67ed59e1d1-3232795877emr2969933a91.5.1755155289619; Thu, 14 Aug 2025
 00:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANaxB-xXgW1FEj6ydBT2=cudTbP=fX6x8S53zNkWcw1poL=L2A@mail.gmail.com>
 <20250724230052.GW2580412@ZenIV> <CANaxB-xbsOMkKqfaOJ0Za7-yP2N8axO=E1XS1KufnP78H1YzsA@mail.gmail.com>
 <20250726175310.GB222315@ZenIV> <CAEWA0a6jgj8vQhrijSJXUHBnCTtz0HEV66tmaVKPe83ng=3feQ@mail.gmail.com>
 <20250813185601.GJ222315@ZenIV> <aJzi506tGJb8CzA3@tycho.pizza>
 <20250813194145.GK222315@ZenIV> <CAE1zp77jmFD=rySJVLf6yU+JKZnUpjkBagC3qQHrxPotrccEbQ@mail.gmail.com>
In-Reply-To: <CAE1zp77jmFD=rySJVLf6yU+JKZnUpjkBagC3qQHrxPotrccEbQ@mail.gmail.com>
From: Pavel Tikhomirov <snorcht@gmail.com>
Date: Thu, 14 Aug 2025 15:07:58 +0800
X-Gm-Features: Ac12FXytQI0TTWn7tXeEn4aByngRSULqN5Q7Bfx1aLHhqOiFKI365i_TkokN5Yw
Message-ID: <CAE1zp77udiu5bB7+4G7ca=A+dsm_veZoPBM6ZceEnHAUBtgK3g@mail.gmail.com>
Subject: Re: do_change_type(): refuse to operate on unmounted/not ours mounts
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Tycho Andersen <tycho@tycho.pizza>, Andrei Vagin <avagin@google.com>, 
	Andrei Vagin <avagin@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	criu@lists.linux.dev, Linux API <linux-api@vger.kernel.org>, 
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> It should be enough to run a zdtm test-suit to check that change does
> not break something for CRIU (will do).

jfyi: checked 0cc53520e68 with patch "[PATCH] use uniform permission
checks for all mount propagation changes" (+ s/from/to/), there is no
problem on criu-zdtm mount related tests. I see some problems on
socket related tests on it, but it looks unrelated.

