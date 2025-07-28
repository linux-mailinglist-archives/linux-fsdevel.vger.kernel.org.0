Return-Path: <linux-fsdevel+bounces-56155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC1FB14246
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD46168C80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 18:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC86F276038;
	Mon, 28 Jul 2025 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mt/MsJzi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490801482E7
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729100; cv=none; b=kyjiAT3CJcL+EeYlqA1CzOcF/ju/GM8yMXyj3mzKeY0PaVeCgV5m2KgswSI4d+jyebY83FAUfURbKosskYdhpibYE2tfFYt76LuIerYy3dZ1OdnbwmI5I93ZzASW+bWxp0BpSJ6kDZZL9jGT2ivMofIpJk4xwmUVciSeZGpBWoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729100; c=relaxed/simple;
	bh=b69OQ4wKYJyVOZsCUGDVDJDFnEpUIuYLCjyPVGv9y1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXeYkJZMrszZSYDTiYG4FqRxEV3BfrWVdI4SagZRNCeBlW8YCtISS3Er7EYr6ILB2j5aWSr5IpQHoqgwVM5+SYWM9vrALAaQf7YQRi8QLJWJi20EyM/aLQV69k0ptetRtoXKKAn5CVIFq9GHzqLsKYAwqBgyLLRkpuuHUy1Ao8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Mt/MsJzi; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6f6so1374873a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 11:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753729096; x=1754333896; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1B0VGPq5i+53ouXuQcjcdmGDSUZMS/bOyjuy32IMYoc=;
        b=Mt/MsJzicGzmnAyE4PV58CgTjJaMNpfLTVYUjbu5Z4LP+R9e2YiqBlog7uHRH+YlDg
         0BoXwC2rTX3nrdHUOarfBwCo2PhlCi+6xxLhIC0I7hNV+P6vZbEUKQENLkXfhMZYoVGq
         BgmJnn/DdMs/lMWs00hOJyR3z0LKW0JewiE88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753729096; x=1754333896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1B0VGPq5i+53ouXuQcjcdmGDSUZMS/bOyjuy32IMYoc=;
        b=k8d+Ga6OqTBSTsj0eIVA8YQX/zkCv/wtxiBLft/+byIbzTYNgig6+92i+Flz8CeKRz
         mElHBg+6iD7PHbwZXzyFl39/Zd2pfFxoiPeALO8yJ60epU52pqQEyA3r26z7YWzhM013
         VrMrPCXpeNAG8Qn/Yr4Lv3F+tEmfmOAUCC5JFCt/fudFSz8jXGWkY/sjlOrLRPpxdA2Y
         k+UUlqti5b7kKYWmKaZq9Cn5dcR8++igdoDjcEeB0FHCioVR6KxB2emoxJF6SulFwlVu
         KbyeBgKm40dV7ARKLCVoum8hbWXjImgP0KJrTZmpjt6raXWRbUY0i8/ZOeI0KLfRHana
         9FIQ==
X-Gm-Message-State: AOJu0YwG8MLzOOOszSTSEBxJ8J9Xrls94lQ2MJAEimGS98n6xMshPbIS
	BjDc8OQ6w9/qkKAm1KeECj4foFlKRf/QXJpp+IeJyNtQ4ZLgpzy7KwgwoU/q8usC2E2XI7h3/Wg
	rllofapY=
X-Gm-Gg: ASbGncv2Q+ADN6l5PNzgMaTHs4n2C7wSgVxvRn940dJo5csCIJHUKcm201fBEwuUmhf
	rzg/5ETVNiGz6SYxhgu4B7bSIbgV7NOF6Cj5b/+rZC0ltIK2spvHuw3eJTvN9UDeW68ObZ7ViZX
	gTaa1+XfqRFkc7ZoJLRzHrMhD6hk0KWu2/Fch8S59KhnIZK2hFcN9e59HP+CMfYixDDlHHgSu2a
	je9l7IwbpGzbQdsScUou6CWO3eSKi+baf1TLq55bVdqSpqlOXSkoAQLnSg1vyYfnlyzyA9oSrf7
	+RfwhyBcd9GKKlVC6tQQDm0ROzuaY/Bcfp8Qrv9bjjb2c4hAzsNUkhbOHz21slj46/aXsHiUMhL
	7aylarcPIpYOUK2vWEsSGfWIndtBL361UL8UXc3PEawvxYJT6UCEHWFblzuRJOnvBzbxCkPo08z
	aCAtioJ78=
X-Google-Smtp-Source: AGHT+IGto3+P2JwVD2ExB4aJH7I5S0/mekKx3VDF7UsOwTNxICo54jfUcQyS+OwlHtamcYoEmhSj2Q==
X-Received: by 2002:a17:907:7e89:b0:ae0:d7c7:97ee with SMTP id a640c23a62f3a-af61e63692amr1370746366b.41.1753729096259;
        Mon, 28 Jul 2025 11:58:16 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635860003sm466590166b.10.2025.07.28.11.58.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 11:58:15 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6154d14d6f6so1374832a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 11:58:15 -0700 (PDT)
X-Received: by 2002:a05:6402:27ca:b0:615:5563:54aa with SMTP id
 4fb4d7f45d1cf-61555635846mr3198856a12.4.1753729095195; Mon, 28 Jul 2025
 11:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner> <20250725-vfs-coredump-6c7c0c4edd03@brauner>
In-Reply-To: <20250725-vfs-coredump-6c7c0c4edd03@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 28 Jul 2025 11:57:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYAT=9kUrGRCW=kWkF7aPdvcAYUnUj3f-baMy1+DsoOQ@mail.gmail.com>
X-Gm-Features: Ac12FXwhEsA5DQB-XZIHN4Bhc1mc1jqfEZkS-B95UcGNtGZOCJCseOEXBvpnfZ8
Message-ID: <CAHk-=whYAT=9kUrGRCW=kWkF7aPdvcAYUnUj3f-baMy1+DsoOQ@mail.gmail.com>
Subject: Re: [GIT PULL 02/14 for v6.17] vfs coredump
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Jul 2025 at 04:27, Christian Brauner <brauner@kernel.org> wrote:
>
> This will have a merge conflict with mainline that can be resolved as follows:

Bah. Mine looks very different, but the end result should be the same.
I just made that final 'read()' match the same failure pattern as the
other parts of the test.

Holler if I screwed up.

            Linus

