Return-Path: <linux-fsdevel+bounces-35838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 911199D8AAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 17:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512C4284600
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 16:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4D41B6D1D;
	Mon, 25 Nov 2024 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KSBqK4lG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27151B6CEA
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732553634; cv=none; b=cxXnBmqnAA+BQCQUDlCS62mQoedMgS1/Xrv7KoQSEkHhVTsHIARClW+w73VMCEmIUYDdwQg3ufXV21MqPu716TEpQJw4gHdKZ8YM4YJu2z4SAddEne9NQQa3baf8Ic7fPLMjs557ef8T2VVHs3LSigQKhTmUU98u7T0nSEU7BC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732553634; c=relaxed/simple;
	bh=5T71W2ybz4LcFji5huscS1t9JnB8RFZFmApSJDeVH2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nst10PBGroCHm9ovht7caEtv81HrCOs3b6E4TAvW/3Ac9rp7oiwffe1+eoDTah5rdcnvpoWWFiblSD+38OjeRfAZSF5lFs1tmSKiQmEcngPzlnh9a3R+qcbYd7ESPsY4v4k8zg6J3mJjcP+ejLobE2uc3Tl5npszc03XYFolGew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KSBqK4lG; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ff64e5d31bso43654011fa.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 08:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732553630; x=1733158430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Di9miGVwG+zuI8yL5QK3cnRmWwyZdpSGfLeetKple88=;
        b=KSBqK4lGi9YGBLBG/Lsx1ppLExW7ktQ1DjqXwn4eAczmjOxkIuYDNRrvX3jhN97bKl
         pg4E6v5TtY/rRyWWBSd4ntS7eWBzagyBvuIPKeg+TYWDQ022JqntbSfLLkRjei/kCygS
         9WuWrOXknYNYujlTOLH24vX/WCQsMdiE2m4Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732553630; x=1733158430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Di9miGVwG+zuI8yL5QK3cnRmWwyZdpSGfLeetKple88=;
        b=S3qYJvPfb4Ko/Bcq4ATpzMmRrUoyHljtxaBNZUVf8bvcBx4G18cxiOYCRlTXyRUOmx
         8SzGeKj6LPM5tf5lLBuMTgXGimdwbgCPBY0W9LvhiQmjfECeILacsps0B1w/ZKqDEtH/
         BzNCcNqOHRZC6FyToyWWag+bpFxCjdO1EerKrA60bIPFj/Juf1fqEeab1OTP5vRxZn7U
         fZARJx9nPznAXloqztpQcZGED6RJoYuq1M0lmIgdEq0GlLKaeXplOixRA4Wn7P+1/GBX
         oa8u68CyviWeLbWqSbJfHLQkXP5fXiTCWR7eAqyI26AERah7alMDHePXzyMDJQLN+0d6
         lgJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzJVulod2NSZXtZjBOD6brtiGT/7FGWVs+SR/lxhGkuva3fuDuZclbh5CmZgz9Ro+5+1wajdtMiQiHedvj@vger.kernel.org
X-Gm-Message-State: AOJu0YyJh7HgQG8O6TUZSw58iNcz4iKiW9kdISEF8aCiKj1zX8EYBkIY
	w/sdtilqYvYRNI5tchDR/nv5HLzb14E61fcYwc5wQ6O+3HG8Ifvf+OXvrYvCNa8nIZS3YHyBMM9
	p5r/pHw==
X-Gm-Gg: ASbGnctEj+4rdk89KfYDAdEo3N0p9LtkOZyRykpYmqzw77v9+RqYLvP8EdZ9U6duGKW
	yPSPGKjlwY8yOwO4s+memNB9Evf31JOLYpDaH0Ogu8ILUtCZkBlXBVS0SgWIBvMpgXMyUikr5Rw
	iqXRsweeKkCNhMbsq1IsxP60D1pjEvQmB5+HpHfON+0vxeBbnu75KGWtuDYOLIGIRomisT5yA1E
	5/wD72/jW9DwLywD+IsRQxL/1u142FXO8ayUZcmjJdjxcKsZxmAql0fBv007KzorhlshlfERukj
	q8wmXQuz13zZevaYsM1ub7u0xe+L
X-Google-Smtp-Source: AGHT+IEmHkkiDSoffasIQoRJU8UIUy9i6Pxim5gNMYIsZOOfB7wTGX352xZxuenIIJkrhIGNVTgizg==
X-Received: by 2002:a2e:870c:0:b0:2ff:b37b:5c75 with SMTP id 38308e7fff4ca-2ffb37b622dmr31065651fa.40.1732553629816;
        Mon, 25 Nov 2024 08:53:49 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa53769e3sm15904531fa.73.2024.11.25.08.53.47
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 08:53:48 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ff976ab0edso50595281fa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 08:53:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1ue1SGgVXxa6JwU31bao3JjmDbAQ+JWhyahKosQGXiPZTbardJceWpfA8ogOk9IdsxA3ZOdxfkf+t4Cgj@vger.kernel.org
X-Received: by 2002:a05:6512:3103:b0:53d:a93c:649e with SMTP id
 2adb3069b0e04-53dd39b15b6mr5985585e87.35.1732553627351; Mon, 25 Nov 2024
 08:53:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 25 Nov 2024 08:53:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+R8zBeMZ-gZeoKCw7QO4-0PwktQaEPvtEuE_4o3VUdQ@mail.gmail.com>
Message-ID: <CAHk-=wi+R8zBeMZ-gZeoKCw7QO4-0PwktQaEPvtEuE_4o3VUdQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/29] cred: rework {override,revert}_creds()
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 06:10, Christian Brauner <brauner@kernel.org> wrote:
>
> Changes in v2:

Thanks, everything looks really good to me, this is much better than
our old refcount thing.

          Linus

