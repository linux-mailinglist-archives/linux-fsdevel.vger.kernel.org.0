Return-Path: <linux-fsdevel+bounces-13106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE3386B415
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 17:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31FE1F2A1E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 16:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1711C15DBBC;
	Wed, 28 Feb 2024 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OQcW0l8k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A980C15D5B3
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136232; cv=none; b=HA1WM6ZlliU6/XD+666fqq19fhEGBWKvAaTZhv7Vl5prhU73zHRfz+g0ViKSCL537Fgko6M2XBOgeAMyGq/gCgl8zkFjOIIaFjf91+nZG6ApsEIExlFRibpqG1OoW0UcD5U5PD1yQjc+ZxgPcF6IT4EYx7L41SuWmhakW6mShp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136232; c=relaxed/simple;
	bh=kjSgkfVsEWsBTq1aQskWGHQt31mNcHdmrQcjf40LDPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RevurzPKCv77piZlLhELrNHJ9+oh+5bNzxvvTkGAq+VpHMvFBFNtmGCQ4hs1zMdeB0bNVSvYkhfdW2dqMqvucAfqQKuW4ZiXNqFtu4dhHhY9j1QRZ4b0CZMh34S865aULI9uUIg7RfNfArcU6GE1u5eSUEJ98E3rmnrJ4chKieQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=OQcW0l8k; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3e7f7b3d95so673870966b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 08:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709136228; x=1709741028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GL8+xVgPGmzIodjYQfeewCkNTMU6fCy247tVp82Lbbg=;
        b=OQcW0l8k4riNcN1A7z/DRJHmcS8ia6xrJjvP+5juyQLfdYx8l7BGi0Lihu1JCJwf27
         j0/zy5aYI9AmdIlR9baHfm9tFCI87C5v1yacSYeMHUBF6sZmAm8lQ1JkPHTOBTJZZtZj
         4yK9QdbgmbA1iTV1tx2CXVSOx5kcUQr5RNRVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709136228; x=1709741028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GL8+xVgPGmzIodjYQfeewCkNTMU6fCy247tVp82Lbbg=;
        b=ICvnubv1JXS/onWcpW3LBognH/2edjzJWZOoaMItnet/aQa0Qt17OtDsQ1QfQptjqz
         XGdAtH5+CwIdXHVNTCZkzRDKj4o3YiLVwRllIx2u2Qxwvxcb0mKR29EDThgQ4myjt6Tl
         wEV0jf+dusAgBAh9DUySrGFA3QI/XGPbKQDrdKde/dW6f7v96viIKPrKPW6WpOhoQL5X
         3XBNPEnZLP6JV3cDQOggO8lE0qxr0rK0pbh6OHULqxUsiJ/6U7KECB3SATZlggb45wlS
         6lslioZ2G+obYVzIi3b9jVIGujGXXfU3sFQFkgXYLN1RqaI0lg+7REUtl5u+wuowg/bF
         vd7g==
X-Forwarded-Encrypted: i=1; AJvYcCXix995fO2+L8+fMnm6mzAyb2I392H85keldt5bU26EMXsQYmyHSUA1akf/JStCPb3kho3xDkGRnLmoVpdLZ0Ofp54Z+ZgyYZdc3eFBqQ==
X-Gm-Message-State: AOJu0YxRPBLqqT0rKDZzslt26YRprT3tpRr6ZW+iJnGYi2M5DAClyers
	OHlt3rrSzlTQr8fSOqLd769/pioCOzpQc7eA8cbgt5FvLiMvShlB8Z6/0lpvwogJi3eiic1v+Xj
	KDA0HL0xE1MJWeBQi6eiAP79SemOW+fTWWDPHyWe24FPWwUJ3
X-Google-Smtp-Source: AGHT+IFpkR/AA0G4z3hkeJmNxQEf9oKoYkccbluGcC8u9c4DTOR+lLMKvxJEGFFSk+PiPdCnr/nJkCRCW835gNARz+E=
X-Received: by 2002:a17:906:d0d4:b0:a44:2134:cba9 with SMTP id
 bq20-20020a170906d0d400b00a442134cba9mr61445ejb.69.1709136228082; Wed, 28 Feb
 2024 08:03:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d997c02b-d5ef-41f8-92b6-8c6775899388@spawn.link>
 <93b170b4-9892-4a32-b4f1-6a18b67eb359@fastmail.fm> <BAQ4wsbXlrpVWedBrk1ij49tru5E6jxB11oY2VoWH5C7scO9FgmKRkQIsVekwRNgfxxxwWwWapZlBGSGQFSjSVhMs01urB1nLE4-_o5OOiU=@spawn.link>
 <CAJfpegvSuYPm-oZz8D3Vn-ovA6GXesXEiwvHTPeG5CzXQPQWDg@mail.gmail.com>
 <5b7139d5-52fd-4fd0-8fa0-df0a38d96a33@spawn.link> <CAJfpeguvX1W2M9kY-4Tx9oJhSYE2+nHQuGXDNPw+1_9jtMO7zA@mail.gmail.com>
 <CAJfpegssrySj4Yssu4roFHZn1jSPZ-FLfb=HX4VDsTP2jY5BLA@mail.gmail.com>
 <6fb38202-4017-4acd-8fb8-673eee7182b9@spawn.link> <CAJfpegscxYn9drVRkbVhRztL-+V0+oge8ZqPhgt4BAnvzaPzwQ@mail.gmail.com>
 <f70732f8-4d67-474a-a4b8-320f78c3394d@spawn.link> <9b9aab6f-ee29-441b-960d-a95d99ba90d8@spawn.link>
 <CAJfpegsz_R9ELzXnWaFrdNqy5oU8phwAtg0shJhKuJCBhvku9Q@mail.gmail.com>
 <f246e9ce-32bd-40df-a407-7a01c7d8939b@fastmail.fm> <CAJfpegu-6WP2nDOh18NMY1Cg3QJ19+tWXfHUax7qp5EUxAe76A@mail.gmail.com>
In-Reply-To: <CAJfpegu-6WP2nDOh18NMY1Cg3QJ19+tWXfHUax7qp5EUxAe76A@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 28 Feb 2024 17:03:36 +0100
Message-ID: <CAJfpegudssVUa+KkhfnZPrpziGz85sNiSntLxKAjQzMd8Ky9dw@mail.gmail.com>
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Antonio SJ Musumeci <trapexit@spawn.link>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 15:14, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, 28 Feb 2024 at 14:16, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
> > Could you still apply your previous patch? I think that definitely makes
> > sense as well.
>
> Half of it is trivial (s/make_bad_inode/fuse_make_bad/).
>
> The other half is probably broken in that form (see 775c5033a0d1
> ("fuse: fix live lock in fuse_iget()")).
>
> Things get complicated, though, because the root of submounts can have
> nodeid != FUSE_ROOT_ID, yet they should have the same rules as the
> original root.   Needs more thought...

Sent out a series that I think correctly handles all cases.

Thanks,
Miklos

