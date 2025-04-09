Return-Path: <linux-fsdevel+bounces-46070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A53D9A82340
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 13:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431801B865A9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 11:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1323B25DD01;
	Wed,  9 Apr 2025 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DafZc5pQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A460A25DCE6
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197160; cv=none; b=bjSiurqbGpikYe76hnmwfk0AIMBVM5fNgQQbfIi31/B3zpubPvgRO8tI/5nwaGD/ht6mdxmzWsdTxpVRJCsdfCKhyu0MX/Q2zC/Po6okx7/8SGYiy/EqaNl8PywFSG0oetaKUptk+FtsfVjaGpzX3J4BUCher6BpZ5hzBk7xsgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197160; c=relaxed/simple;
	bh=jReOz4zTlDC+vp4+1C79SPrvtefHrjCMTGFO5ZFNR1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNgYBqJtg8e+DAIA3TMMjHE3QCrDFCezkaXviUWOue4PMGKbbyyf0/nZET4XJXS1RXxVgrm32CCxTRBJ31jb+J+VDg7q4XaIOG35aNutzhskk3YbqPZugJE5AkWeYzlaB9Px0nernl0U7jC5RkJ6ibHHCzPkiTrgC93ukRM2ypk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=DafZc5pQ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c6a59a515aso408278885a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Apr 2025 04:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1744197156; x=1744801956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L8zsW3p1jBNAHNun3l5be4SanrUasHqeykfYH6FqnEU=;
        b=DafZc5pQnPXbnyykZqw3YlHMpSJmkxHUc8AoMnPnKMB0RL5O6lD85gQkJSnhLGASyc
         Iaeo4hhxrSZ4cIMMxNlK+MRYft1a1zth8dC60oZZbgH0xg9WJqWpbNYkqmXpe/fOCWf/
         bKxl3KZpAx1KMNFo2mufzxXmJE/ezQWUNEcow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744197156; x=1744801956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8zsW3p1jBNAHNun3l5be4SanrUasHqeykfYH6FqnEU=;
        b=Ry15Uo1QRbBfMGtQMNJWDTKt7LQojiQCYHXmE61Nd2fJUH3iMyQ3fILOqRKBk03/Pa
         QYvozkJN1M2abqc0iEkyqJUBHl1VSMaj1ILg4RxjKYp7Lc3tr6EQdqrd4YV4javg8ptR
         DjwOSYUP/umizcQbraJ2+4rdo5/+Klj9K6As/pCq1zKprwffanMNAoElXOJIPTzeDUNV
         zPHbnxrYVIzzbE0b/fc+hAqZ0r0RTLJyv4cW6/sFR/ihD+tpPU6xbP//lw8leqhO/njO
         6HGb15gAFlv/CQY4+0bEjqoms8SPhsiKnjRzD6rabfkLtdANmicFOOsc94Svgb8bhaVj
         o6Xg==
X-Forwarded-Encrypted: i=1; AJvYcCV3J8John+FMA2lV+4Cp2XyjfidS8lIb8PRlQwq0fMblWOmb+29sLDo/qepBFg46RLrFI3jqNXpzj3wO+tF@vger.kernel.org
X-Gm-Message-State: AOJu0YzMLu40Lim9vZ+SCJw5w7X6JKkvF620fahOaUBpiFx4vx56VZvf
	II6XuXDHGWaagOSIIW+Iwgjqxv68C7VVzXQqx8Ays/R8GroTjiC+Ht41JfVT7H6kmHzvbCz03aR
	XkffAu/hf+NvzXNwvOBO1LxM8ucWchUwAZI634w==
X-Gm-Gg: ASbGncvS/E7Mgcs7G3nyPlVngwOy0avvYRMiDGD7V13L3BZgVTp909lPsEEn3xzm5jj
	YOdWeeqUfB/w4oOq6z8kEx5bnxkmudYqKK3vlU1QqcbQ74EiU/BCxN1lYwWUWm2Hx0MXP2t82RH
	UTF4UcUDNrVdpZgSTP7YuQfRo=
X-Google-Smtp-Source: AGHT+IFCBgrParqX0ZG9CNIMWiic4Ir0oxdyqswfZdFAmyVwVuOSJkQOYeEm1stvtQWP8T1Vue7LLE8yCoz+pDLEfU4=
X-Received: by 2002:a05:620a:8396:b0:7c0:9f12:2b7e with SMTP id
 af79cd13be357-7c79cbc982dmr390955985a.11.1744197156157; Wed, 09 Apr 2025
 04:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408154011.673891-1-mszeredi@redhat.com> <20250408154011.673891-2-mszeredi@redhat.com>
 <CAOQ4uxjOT=m7ZsdLod3KEYe+69K--fGTUegSNwQg0fU7TeVbsQ@mail.gmail.com> <CAOQ4uxhXAxRBxRh9FT0prURdbRTGmmb4FWSs9zz2Rnk6U+0ZTA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhXAxRBxRh9FT0prURdbRTGmmb4FWSs9zz2Rnk6U+0ZTA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 9 Apr 2025 13:12:25 +0200
X-Gm-Features: ATxdqUEAcTzVg4sJVoHeL5Fk3obPSpX5b0DIQNje9s51kPl6cVWASYAguFsEsd8
Message-ID: <CAJfpegsKAsNFgJMK4oS+gjD_XmhscjdTtmx0uW2GkCPC+kf6ug@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ovl: make redirect/metacopy rejection consistent
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>, 
	Alexander Larsson <alexl@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Apr 2025 at 10:25, Amir Goldstein <amir73il@gmail.com> wrote:

> On second thought, if unpriv user suppresses ovl_set_redirect()
> by setting some mock redirect value on index maybe that lead to some
> risk. Not worth overthinking about it.
>
> Attached patch removed next* variables without this compromise.
>
> Tested it squashed to patch 1 and minor rebase conflicts fixes in patch 2.
> It passed your tests.

Thanks.

One more change:  in this patch we just want the consistency fix, not
the behavior change introduced in 2/3.  So move the
ovl_check_follow_redirect() to before the lazy-data check here and
restore the order in the next patch.

Pushed to overlayfs/vfs.git#overlayfs-next

Thanks,
Miklos

