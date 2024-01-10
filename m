Return-Path: <linux-fsdevel+bounces-7739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2208482A079
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 19:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A552893BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 18:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AAF4D5A5;
	Wed, 10 Jan 2024 18:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FeHX1Skv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDED74D58B
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-557ad92cabbso3987874a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 10:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704912765; x=1705517565; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m3UJsqaOgk5eE2VQnILkdg8C0bn7x8fx0mLavVcEL4o=;
        b=FeHX1SkvwsxvfzE/eELwaPdgUllP66IgEj3HgO+eOMZi9w4TJY+UcrzX7NFdAAM55g
         Uj/NX+yIls9FrQKTQvgTVWhCMicEbJh6vOLtfPbK92oeG+C/esMYA9jUkdxHqMGKtQE0
         fIsnP9tfKkeBqmMi0zMrMjE8ZeFxcol8g860Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704912765; x=1705517565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3UJsqaOgk5eE2VQnILkdg8C0bn7x8fx0mLavVcEL4o=;
        b=nBt1EwqBEyDtlHSqyBVLHu+f+3g1ROrCfhTEWxrWCLTCjMngcMLjxwdmLGvVjiFjj0
         +claY7Tkd2s5iKyDZ8SqOZ6627qrejm7NAAkhoVHE8uiAoNzRhh073XbDooB0j5AHefr
         vCaUEViuJoa3/hUy0s5+FudnfOYT029SRu99QFVYeOoltFpsSVts2NtRAs6Gkny3cQbw
         dhzDLXUXVh8kvMZqVWEU8o8kmvKnYjAQcoL+oZhvgttMOMgVn1qi+zRQnrXhFxeR1HCK
         AL1qn89suOgcaZKxNvXqpcUN6/DXphn6sUDWro6Ub7PRfErUDHTW7UCABN2MuJcKGqD6
         av9g==
X-Gm-Message-State: AOJu0Yxjw5ioh9MWsHcuNYBZThHpS6C+SaLJ4R7vviPLlBW4j6VyBHMY
	gocGgSnbZFatsOT3bV0NdNH55akE0Oo9nWa1ZAlgR9B+Qj4Mlrv3
X-Google-Smtp-Source: AGHT+IHUJGYFHUtLQtA6yS3XYxTC9nVWzHq8YBhIBjLWnCudvfqlWWAm6GtO5qhKwHUP3sr5Fo2TBQ==
X-Received: by 2002:a50:d64e:0:b0:557:4a8:e122 with SMTP id c14-20020a50d64e000000b0055704a8e122mr395553edj.2.1704912765096;
        Wed, 10 Jan 2024 10:52:45 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a23-20020aa7d757000000b00557075b4499sm2268133eds.58.2024.01.10.10.52.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 10:52:44 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28b1095064so490463366b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 10:52:44 -0800 (PST)
X-Received: by 2002:a7b:cb45:0:b0:40e:4ada:b377 with SMTP id
 v5-20020a7bcb45000000b0040e4adab377mr402184wmj.62.1704912744493; Wed, 10 Jan
 2024 10:52:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ4fyY4r3rqgZL+4@xpf.sh.intel.com> <CAHk-=wgJz36ZE66_8gXjP_TofkkugXBZEpTr_Dtc_JANsH1SEw@mail.gmail.com>
 <1843374.1703172614@warthog.procyon.org.uk> <20231223172858.GI201037@kernel.org>
 <2592945.1703376169@warthog.procyon.org.uk> <1694631.1704881668@warthog.procyon.org.uk>
 <ZZ56MMinZLrmF9Z+@xpf.sh.intel.com> <1784441.1704907412@warthog.procyon.org.uk>
In-Reply-To: <1784441.1704907412@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jan 2024 10:52:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiyG8BKKZmU7CDHC8+rmvBndrqNSgLV6LtuqN8W_gL3hA@mail.gmail.com>
Message-ID: <CAHk-=wiyG8BKKZmU7CDHC8+rmvBndrqNSgLV6LtuqN8W_gL3hA@mail.gmail.com>
Subject: Re: [PATCH] keys, dns: Fix missing size check of V1 server-list header
To: David Howells <dhowells@redhat.com>
Cc: Pengfei Xu <pengfei.xu@intel.com>, eadavis@qq.com, Simon Horman <horms@kernel.org>, 
	Markus Suvanto <markus.suvanto@gmail.com>, Jeffrey E Altman <jaltman@auristor.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Wang Lei <wang840925@gmail.com>, 
	Jeff Layton <jlayton@redhat.com>, Steve French <smfrench@gmail.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-afs@lists.infradead.org, keyrings@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	heng.su@intel.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 09:23, David Howells <dhowells@redhat.com> wrote:
>
> Meh.  Does the attached fix it for you?

Bah. Obvious fix is obvious.

Mind sending it as a proper patch with sign-off etc, and we'll get
this fixed and marked for stable.

           Linus

