Return-Path: <linux-fsdevel+bounces-8806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C559383B26A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 20:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D21CB22A0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 19:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E12D132C10;
	Wed, 24 Jan 2024 19:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V5ub+sov"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40E7132C20
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125316; cv=none; b=Xz0sX5TF1RgVrqfLsJZycLQQXJBCJVt6hJValefsZf72NcreSrwLiz40gu1Kb8N8azK/P4NM/y/4Lk+zvA9gEoEmuImJADeCkJgQLrrffxf26vpCiA+elRz85QkT87xbAP6JECmKINYJ14xYI7OAinuWobZzzEZ0yci1YDXO6oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125316; c=relaxed/simple;
	bh=ouJwYHRa4mmcxxGDuONLqBrc9eGAB9TSx7zyDOPpuZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLLhnPORrhQ9o56MLm+VZIfZGWWxmwyuMozrfYzSAOACRqIWKHDEWe79nk+dOgr/cJ9cDlt2p8ul2X1dCv0x5ivXVG305+aVf18eYqZU/r21aAzLkqcLP3LvABcGuS75CAlbcLxYi/wQ66LUY2TdwGXE5APZRSGxCplNwt7rnhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V5ub+sov; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a271a28aeb4so637785166b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 11:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706125313; x=1706730113; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uH4xyu20AZv2y9FxRkejBz/ztRhAIrUHK2zRol0B+1g=;
        b=V5ub+sovq3NZYBptrCECOob6x6h6EcgEA1e6g5WOaLPBI9iqsrCgVgofP4D2t6yM6R
         kPfHxOdo+oVd5T73X0pRpKil1nrBTLgZYlCuwDRo3ZMM0mnec+Fk8yFvqaFTE/VJ41Mw
         riBfoWBgIayi0koYFdAt8Z8MffXbA8AAp7qEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706125313; x=1706730113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uH4xyu20AZv2y9FxRkejBz/ztRhAIrUHK2zRol0B+1g=;
        b=JhMXhAjWhRj5jDriPn8/MEMlQc9DO0OD4yUYa7EPQZadLPee6ydd//D4QGa6qS9/FR
         UyXHu1+hxazia2Q98uTGsVp6IO17oiIdGRtLIMEDi8EdaWzGyhBRnn2J6ZvKxODUNIvt
         S+CGtllRFaY+Dpy2i2cJq1OS2JfkATNesh+Mzixz8sQmdKnSzDDL4DE87Wxt4ZeZtpht
         HKHMIwrMTaf5dvLi6LhmrbyTn0fmfg9ioiK4jP8AG8Aoep19mmPOMCOFZ0llsvAx9Iev
         KVGlFScwrEzIiE12pATn1m4e13U/DjxQx6Rhv8rMXQG69FvpYrxo9PJHRRiFi1pSuhQ1
         zXLQ==
X-Gm-Message-State: AOJu0YyU4KO9y2rdSLUoQh2Px406/bSLCOllF1DCqmPl8wZZ9uhKmfe7
	+dfqNX4imTtLamOFRBBKzflfJbaDgv2pii5MaMSi8dyruelAmqjutiknuWEdR9+EJA6UwVA1S7E
	xmcpXSw==
X-Google-Smtp-Source: AGHT+IGB+woRhVhlN3xS8WqWbIYgvBu4UaIq2QL9W0aZk84qBru94ifavRiTkwPvgEh7ATGo2urysw==
X-Received: by 2002:a17:906:1d0c:b0:a2e:7b28:1f03 with SMTP id n12-20020a1709061d0c00b00a2e7b281f03mr1058549ejh.90.1706125312822;
        Wed, 24 Jan 2024 11:41:52 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id w15-20020a17090633cf00b00a2ca9d38654sm201065eja.85.2024.01.24.11.41.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 11:41:52 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so6699639a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 11:41:52 -0800 (PST)
X-Received: by 2002:aa7:c853:0:b0:55a:6f4b:27cc with SMTP id
 g19-20020aa7c853000000b0055a6f4b27ccmr1999900edt.44.1706125311944; Wed, 24
 Jan 2024 11:41:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbE4qn9_h14OqADK@kevinlocke.name> <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
 <202401240916.044E6A6A7A@keescook> <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
 <CAHk-=whDAUMSPhDhMUeHNKGd-ZX8ixNeEz7FLfQasAGvi_knDg@mail.gmail.com> <202401241058.16E3140@keescook>
In-Reply-To: <202401241058.16E3140@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 11:41:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgEXx0m_eaeN5-DoZQxStF0pOLU9s3GkFbhBt-2ro3Ofg@mail.gmail.com>
Message-ID: <CAHk-=wgEXx0m_eaeN5-DoZQxStF0pOLU9s3GkFbhBt-2ro3Ofg@mail.gmail.com>
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from virt-aa-helper
To: Kees Cook <keescook@chromium.org>
Cc: Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	Kevin Locke <kevin@kevinlocke.name>, Josh Triplett <josh@joshtriplett.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 11:02, Kees Cook <keescook@chromium.org> wrote:
>
> Yup. Should I post a formal patch, or do you want to commit what you've
> got (with the "file" -> "f" fix)?

I took your formal patch. Thanks,

               Linus

