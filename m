Return-Path: <linux-fsdevel+bounces-39971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B361DA1A82A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 17:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6C03AD654
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA7D14659D;
	Thu, 23 Jan 2025 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J23XE9/L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F4113EFF3
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651108; cv=none; b=A1IGdN53aZL+QQYq6fQ2enxUtqyyCtvJlgvYAGhI8WgBYTknViBAqflqzXC+IQoDs9daWLFbLCiySJWlhZKkYZxRKGi5aC6jsEfWnSJtTW0D9HnI7GVRuqIlA86HZEchxqjTHWlVEfUBqU/VvNuY14TJNqeefLq4xDFdkGZATZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651108; c=relaxed/simple;
	bh=ohxZApkhVStfPeITmFuBz2i9oU8pH5Nny2S/UtP7M+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LOK0TncRUx2SlcUrSDXr8/coVyJMIPKERXDYRKIG5JMrTRg1+RQ+cgYdnodvLvcaNPO/cTcG+6MHS8sh2NzuqwfgQ9YvPkX4PkaSqA7EVKbqhFUuIZ3L7Kf4jstb0u9EhQJRam094N8dZq6E9VKsbSzqTbefUM/vZilj2lr1r7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J23XE9/L; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4678664e22fso9777891cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 08:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737651105; x=1738255905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohxZApkhVStfPeITmFuBz2i9oU8pH5Nny2S/UtP7M+k=;
        b=J23XE9/Lx1z5Yq2Uvh8TZ8Znj2mLfEDMd5j81eaDFAoPbfPZMUbXBbkfZfbsqUSdD+
         buBS3nhX3PLh5O13qC8ufcBePjyTTeFNtMoM6W3C4ElobpFxabFov3I93wjDd+GSY1yl
         tywd3SIMrtZOmP+dkg4iguQIa06hMNobC1gkLeD966NGfwM6E4OpTlB1ouhsprHTQz7F
         ADent3ZE6cPLJCOKA85uPQtFVrpqaPerMuOsmG0OnrVrQN9OqQYbPqXIXs/beDIIvyx1
         blHMoWm+MgSBza3+ntGxQgqOkSyDLxOa3/uqUg9WUckSlGidtWBvOI/zUAL65Jvd8tgu
         iA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737651105; x=1738255905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohxZApkhVStfPeITmFuBz2i9oU8pH5Nny2S/UtP7M+k=;
        b=I1oO3fHb02iwKFJXjquBL6yzo4RjqZc8cICWjGCiY8da0kx9kJRXgvztIA1SID4+gH
         KTxigFgcvZ5gf3ml1dGpacBn9LvqCypRcbCpjyJzIMSQgO0iZ18afQsoQPG+tDoj0hdT
         zUIF8AXUE+cg5QtvZz6u6w6k5G/9RDGD+aaM5zTdoPt5X66TXhOXp3AOJzaScM1bvq47
         m6Dyt9+DPP4MPGVjvBOBBqg32EFO0gF5TMtQ/tS9yXHz+eaZYiFoR7qpHvr+mHMOXMTe
         rJeLI8JJskYbRecB1LvUbayNuThUq6WfrB6vkyStBT/Osi62AUQs3M84eQKK6QBk6Ggp
         ICRA==
X-Forwarded-Encrypted: i=1; AJvYcCVtAMWcgt89tn+5nbNP2szv//HrK2vevvVYTUWqZkaaQpnetss6e6CH9fcvpzA0es6+dAHgLoYcYrwJ0WDn@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn4riKl3eXN8IbVH+0vxguv37xtEKaQqaba1JUjYaIOCsYVg6j
	rTCEaN6O3weRlEP9DiTNnIWXhqynH6MKkUalq9PgcUqAB9x9QHZwLSSrRwv3zZ5GtxQwpeFPkGC
	GHE/bcdQEGVf+9dFlr2z2InV0Qrk=
X-Gm-Gg: ASbGncsJAeviFNNIiPRMTZGHjZ3Yemaq9f/czbmI0XopMqGsBaoo8Low0nImPR0EGyd
	k1tPNKzRpDFZuFJUUIW8j23xY8w9NU8HQQk54pEdOIeo7vyR2w2SXAruoN3PjU7JhzQiZ1iAzqi
	/RFw==
X-Google-Smtp-Source: AGHT+IG5wMzUX0cAclIQ7OPMArKtZHNSGmB9SQ0AXawDXWreWATFUbIDWmazhnka9W82sO/IsK+p75aO6p2k9kJkiQg=
X-Received: by 2002:ac8:7d43:0:b0:467:5c9f:f8ef with SMTP id
 d75a77b69052e-46e12a1e6d9mr409482521cf.6.1737651105177; Thu, 23 Jan 2025
 08:51:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122215528.1270478-1-joannelkoong@gmail.com>
 <20250122215528.1270478-3-joannelkoong@gmail.com> <87ikq5x4ws.fsf@igalia.com>
 <CAJfpegtNrTrGUNrEKrcxEc-ecybetAqQ9fF60bCf7-==9n_1dg@mail.gmail.com> <9248bca5-9b16-4b5c-b1b2-b88325429bbe@ddn.com>
In-Reply-To: <9248bca5-9b16-4b5c-b1b2-b88325429bbe@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 23 Jan 2025 08:51:34 -0800
X-Gm-Features: AbW1kvZ4hwIbDTGwRiWc3WHFylM4JOgHv3PJ7sUzRA3OTq8aCzVl71XqZ2MO5ls
Message-ID: <CAJnrk1bbvfxhYmtxYr58eSQpxR-fsQ0O8BBohskKwCiZSN4XWg@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	jlayton@kernel.org, senozhatsky@chromium.org, tfiga@chromium.org, 
	bgeffon@google.com, etmartin4313@gmail.com, kernel-team@meta.com, 
	Josef Bacik <josef@toxicpanda.com>, Luis Henriques <luis@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 6:42=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
>
>
> On 1/23/25 15:28, Miklos Szeredi wrote:
> > On Thu, 23 Jan 2025 at 10:21, Luis Henriques <luis@igalia.com> wrote:
> >>
> >> Hi Joanne,
> >>
> >> On Wed, Jan 22 2025, Joanne Koong wrote:
> >>
> >>> Introduce two new sysctls, "default_request_timeout" and
> >>> "max_request_timeout". These control how long (in seconds) a server c=
an
> >>> take to reply to a request. If the server does not reply by the timeo=
ut,
> >>> then the connection will be aborted. The upper bound on these sysctl
> >>> values is 65535.
> >>>
> >>> "default_request_timeout" sets the default timeout if no timeout is
> >>> specified by the fuse server on mount. 0 (default) indicates no defau=
lt
> >>> timeout should be enforced. If the server did specify a timeout, then
> >>> default_request_timeout will be ignored.
> >>>
> >>> "max_request_timeout" sets the max amount of time the server may take=
 to
> >>> reply to a request. 0 (default) indicates no maximum timeout. If
> >>> max_request_timeout is set and the fuse server attempts to set a
> >>> timeout greater than max_request_timeout, the system will use
> >>> max_request_timeout as the timeout. Similarly, if default_request_tim=
eout
> >>> is greater than max_request_timeout, the system will use
> >>> max_request_timeout as the timeout. If the server does not request a
> >>> timeout and default_request_timeout is set to 0 but max_request_timeo=
ut
> >>> is set, then the timeout will be max_request_timeout.
> >>>
> >>> Please note that these timeouts are not 100% precise. The request may
> >>> take roughly an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the set =
max
> >>> timeout due to how it's internally implemented.
> >>>
> >>> $ sysctl -a | grep fuse.default_request_timeout
> >>> fs.fuse.default_request_timeout =3D 0
> >>>
> >>> $ echo 65536 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> >>> tee: /proc/sys/fs/fuse/default_request_timeout: Invalid argument
> >>>
> >>> $ echo 65535 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> >>> 65535
> >>>
> >>> $ sysctl -a | grep fuse.default_request_timeout
> >>> fs.fuse.default_request_timeout =3D 65535
> >>>
> >>> $ echo 0 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> >>> 0
> >>>
> >>> $ sysctl -a | grep fuse.default_request_timeout
> >>> fs.fuse.default_request_timeout =3D 0
> >>>
> >>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>> Reviewed-by: Bernd Schubert <bschubert@ddn.com>
> >>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> >>> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> >
> > Thanks, applied and pushed with some cleanups including Luis's clamp id=
ea.
>
> Hi Miklos,
>
> I don't think the timeouts do work with io-uring yet, I'm not sure
> yet if I have time to work on that today or tomorrow (on something
> else right now, I can try, but no promises).

Hi Bernd,

What are your thoughts on what is missing on the io-uring side for
timeouts? If a request times out, it will abort the connection and
AFAICT, the abort logic should already be fine for io-uring, as users
can currently abort the connection through the sysfs interface and
there's no internal difference in aborting through sysfs vs timeouts.

Thanks,
Joanne

>
> How shall we handle it, if I don't manage in time?
>
>
> Thanks,
> Bernd
>

