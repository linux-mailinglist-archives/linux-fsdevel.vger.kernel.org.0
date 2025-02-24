Return-Path: <linux-fsdevel+bounces-42405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6329EA41E98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 13:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7B6189654E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 12:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1809221930D;
	Mon, 24 Feb 2025 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="K2AoVVtm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165282571B8
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398922; cv=none; b=dPZMR6FCWkiK40UkVmkdxtfJfhPwejnvkX/LUOfCJiDhTBFJiJtQJn6CVlMWpt93r5MT+6yuq+BYJmIW+9EELlrHuSkMnPkzadDZJG9RTSGfSAOT4OsxbOTbheryAnSNW1e9L1MUE6qyw4LQl+y9bphCxLrnwcKt2w1/KZnoAvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398922; c=relaxed/simple;
	bh=kzXecNHRbFh50ri05wtHLEf3nbWyqUbonTy9wYBKhgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjjZupd7Q9hkqsEkaKmyKmMaEOnXWRvX1x/noD2JrL1Ce7ZRG5ZDZoFy4VrikBbkT5gGN9YELvBc/aB69+B3NiNw/U6uaTKHz8lmVLEr2RJ6j0bK+87vB+WPJ6ZBrf6dG7cnLblyWnA0Px72dqqYGB6QFQ/UV0eXUXJIBHBpvJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=K2AoVVtm; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e68943a295so37991836d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 04:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1740398919; x=1741003719; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bVv11kkNbpnH7NXv2lzx1aD/s83nOcC8I/9VECVC3NI=;
        b=K2AoVVtmhAL4ocNQQD2juN/G/ZsqtcHjBUUjt89X4mgdV2Fy3nW/BGgLCyZOwVqqNk
         TAQ+J3uvFH+2PxgYIgmtX375FL39wD2GYcdarSrtURFodNOINtijcn3QtRNq+qio4KdZ
         aOuix9jr+rx1/AUyzFPHSQO186gLFra/YXhTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740398919; x=1741003719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVv11kkNbpnH7NXv2lzx1aD/s83nOcC8I/9VECVC3NI=;
        b=X2X1eVpNLHHQsVDgcWMVvLLPT/Bln/IJYnXUYejPLdABGW6ukqRzCQBvgSbXaDvenD
         kQqlSMCpPwbaKny/gvh6Kh3yKkHAGVPMkcabSBmNob2eIfanlasX0txhKBzqmPyI47i3
         gUc1BNJrPlF1QlGHHjdd2SYW/p98uk8KBsIDwAxfMIdHVWndu9H4XOVb6nNgwU7o1MCy
         ZL+NkecZj9i3qcTtb3oUZXdAutd+6oDRMqdcHL/cb61R+CvOnCxCL78ElX9pqRWcGfaP
         Hu6Gsohmlk2DIiq3d2UQQQl1lfsRfbDIStDuA1CepmugWAweqWYCzCl/J4IvOb95R9RD
         CNrA==
X-Forwarded-Encrypted: i=1; AJvYcCVWZEhVcQRTu/94avaOXtHn9n9gghKglQF+la0GqAIubMZAfY8HhjeWJA0bnVS5/jP/CB8LYzodsgy/7/lu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+KZWF++Ko4Ay+J8xPT8SpD0CqvrN/IMVX0fQpBuTjmVg8z941
	Lap7OdjYeqYttJhocUA+UIrOFBxspbaKh7o+txgy9PqTJ/xDg7B6Lo20LVhI/JrAPRHbTyWi9TP
	8eI1BSA+24CWiQrN0ZQNwjGyz0vn1/iA/vml8Bl7RTzrs04tH
X-Gm-Gg: ASbGncvQvcS/Dbs+RNR+08JWRowZ2XS5nubGe1lYN/7hRICdlZA9wUJ/fsyYe9GnsOz
	e5+0m+hvplabDGjPySPWJijmy4Ia1fS0Tj6bQf673Sfq5txEUE/wguJbVMgG7xW2iep2I1ubfhw
	7/BD9PYEPn
X-Google-Smtp-Source: AGHT+IF2r0y7EbNOX9gJRfKsXHY/LXgLrKwzLJKXRKjlFly9zjR0pj5HmRk0WrXZFUAysvnGfunzFL4WBXbCOUHaJ14=
X-Received: by 2002:ad4:5bcf:0:b0:6cb:d1ae:27a6 with SMTP id
 6a1803df08f44-6e6b010e18bmr147394186d6.24.1740398918714; Mon, 24 Feb 2025
 04:08:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKXrOwbkMUo9KJd7wHjcFzJieTFj6NPWPp0vD_SgdS3h33Wdsg@mail.gmail.com>
 <db432e5b-fc90-487e-b261-7771766c56cb@bsbernd.com> <e0019be0-1167-4024-8268-e320fee4bc50@gmail.com>
 <CAOQ4uxiVvc6i+5bV1PDMcvS8bALFdp86i==+ZQAAfxKY6AjGiQ@mail.gmail.com>
 <a8af0bfc-d739-49aa-ac3f-4f928741fb7a@bsbernd.com> <CAOQ4uxiSkLwPL3YLqmYHMqBStGFm7xxVLjD2+NwyyyzFpj3hFQ@mail.gmail.com>
 <2d9f56ae-7344-4f82-b5da-61522543ef4f@bsbernd.com> <CAOQ4uxjhi_0f4y5DgrQr+H01j4N7d4VRv3vNidfNYy-cP8TS4g@mail.gmail.com>
In-Reply-To: <CAOQ4uxjhi_0f4y5DgrQr+H01j4N7d4VRv3vNidfNYy-cP8TS4g@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Feb 2025 13:08:27 +0100
X-Gm-Features: AWEUYZk15tnAHQ1Hkw5t18U-SlRj-CYMpL4j2TOzMzjG64Wee9bdrcLfCeK8_WY
Message-ID: <CAJfpegv=3=rfxPDTP3HhWDcVJZrb_+ti7zyMrABYvX1w668XqQ@mail.gmail.com>
Subject: Re: [PATCH] Fuse: Add backing file support for uring_cmd
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Moinak Bhattacharyya <moinakb001@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 19:31, Amir Goldstein <amir73il@gmail.com> wrote:

> BTW, I am now trying to work out the API for setting up a backing file
> for an inode at LOOKUP time for passthrough of inode operations.
> For this mode of operation, I was considering to support OPEN
> response with FOPEN_PASSTHROUGH and zero backing_id to mean
> "the backing file that is associated with the inode".
> I've actually reserved backing_id 0 for this purpose.
> In this mode of operations the problem at hand will become moot.
>
> One way to deal with the API of FOPEN_PASSTHROUGH in
> io_uring is to only use this mode of operation.
> IOW, LOOKUP response could have a backing fd and not
> a backing id and then the backing ids are not even exposed to
> server because the server does not care - for all practical purposes
> the nodeid is the backing id.

Yeah, the backing-id thing should not be needed for io-uring.

One complaint about the current passthrough API is that it adds extra
syscalls, which is expensive nowadays.

> I personally don't mind if inode operations passthrough
> that are setup via LOOKUP response, will require io_uring.
> Both features are about metadata operations performance,
> so it kind of makes sense to bundle them together, does it not?

Right, this would be the least complex solution.   We could also add
an ioctl(FUSE_DEV_IOC_LOOKUP_REPLY), which would work with the
non-uring API.

Thanks,
Miklos

