Return-Path: <linux-fsdevel+bounces-48815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B03AB4D73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 09:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259721B4252C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 07:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1381F3B87;
	Tue, 13 May 2025 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NB8rDEo0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5321E2823
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747123070; cv=none; b=nFBJhzA367OQuix2hQ2paRpubL0w2cVG3nom7TEvUgUcdgP4uFFe7mrDEk3doOKc8/wKgukcezGk+0nrXla9mW3rRlI3TDnYziIW+za3xoo9j+918vC8qc8j1FyT73GO3I1A/pocQVyJMcYTemSDxT3UcMXOMaNw/B7OhQx9hQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747123070; c=relaxed/simple;
	bh=QsPvCeXq5hg0Tk+eYDzBTh6QThUKaB6hBRXmouWU5aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ky1Ix0T0jRopGSYIBM16jPM/mbf3b/EmvUqQO6ZF3S7/QJvAzTcm4nTxIE5sdHWdaRjvNhANEGzIgMaYXlbyuY21bbLMYK57cVaKwTwrBC5zlTvJY0poBeHZB2Lt1zI7NMXIKS3LNQsBYjmF6y3TO7ImbIpwUTpqQeOAQ9aRHk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NB8rDEo0; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-476f4e9cf92so44491891cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 May 2025 00:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747123067; x=1747727867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SXJVtZL1or8cMJixWX1yCQl+rGlb0UkQ81qk49TibCA=;
        b=NB8rDEo0PJef0u1NBt3NKuC+S9leWDZwdqNhVEhGHkk4cdgUk8LQfJ8rFiBvt2zxty
         CtYmHph4rfbN1Lk5TOO3pcxBshF5HlG8QL08a+rottWc/lxvlQgyq1xECPid0mYWOe/V
         DNRzCtCQBGX9GGqyskZhygJGLhn98YVY2VUgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747123067; x=1747727867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXJVtZL1or8cMJixWX1yCQl+rGlb0UkQ81qk49TibCA=;
        b=bnEpivSN59AlPj9ECXzT2Bs0j4Db0jiRduFZ5R3s/lfRK+CqJ5efUjfWQWBH6I3Fr0
         9zhWmlr4p32WO9H4RFaIw5GwxO4k+D58alQhVen7UCWgcu6jEikW5mPoZCUtOovYzKzz
         NUbBbBchusj+UCMEdkGBiGJ23p5JlJG8wTtaniWhtngOeK+yen3cP6wjYt93Ma8dqzcQ
         gdB+rCUGerbrZGriY1Cf0ODh1xAH3/lzZ8vTkdemeLHEFaTi9tKvJ2POUGadSZ37R2DI
         n4cwqohHLifjS8E5nuKzgaFsXwq0WpPUBw06fZTe3QuDRpT4K9pJ8o9o/fjND4iBQfHh
         HzCg==
X-Forwarded-Encrypted: i=1; AJvYcCVkGSvW4gLAISp4Cd7s4Wy5UhZ5s2HaNGmr/bFdadr6pkRmiCLi9OIHEzlClGDHoUN342126rUgY/x0vGka@vger.kernel.org
X-Gm-Message-State: AOJu0YyYzW2pam9xevwoFT3jtNDTF26jSmR6gXQQbpq9bKJ4TEkUBCZ9
	kBJTw1BTdngo+e+7RoiKhUR59R4N4cgJnyHgvg/E4HB2mnZyvrN3gA4wBKkufOR405YK8hInikc
	Kx2rMg9Pn4SqfRSwY01QcThMMJS1wWhvK7IRujw==
X-Gm-Gg: ASbGncuztiJT9h4fTTkCAVqZZyVe55e5ossSNttk/FtYDS4w4wRF6JY/gjwyezn8ADm
	I4/R6tUdZ8IIQsBtwf2raFwYe/GobjVllUDYBq7vOv/Q6QRrH37qhnbp0z+CEw0zxnpDsKn+4Iz
	bW1O4c64+vmKJYT5e0YGX7yjnVw8aHTb8=
X-Google-Smtp-Source: AGHT+IHI6dsSKsGZFfoZq4o/Ub5Ri5nv7cGQmV1dJDEinCDieLL/mFotCccaNVUSBg7uUwM57BkT7txrx05cpWkH0Bk=
X-Received: by 2002:a05:622a:1892:b0:476:7d74:dd10 with SMTP id
 d75a77b69052e-4945273a9a7mr288477541cf.19.1747123067580; Tue, 13 May 2025
 00:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com>
 <CAJfpegvhZ8Pts5EJDU0efcdHRZk39mcHxmVCNGvKXTZBG63k6g@mail.gmail.com>
 <CAC1kPDPeQbvnZnsqeYc5igT3cX=CjLGFCda1VJE2DYPaTULMFg@mail.gmail.com>
 <CAJfpegsTfUQ53hmnm7192-4ywLmXDLLwjV01tjCK7PVEqtE=yw@mail.gmail.com>
 <CAC1kPDPWag5oaZH62YbF8c=g7dK2_AbFfYMK7EzgcegDHL829Q@mail.gmail.com>
 <CAJfpegu59imrvXSbkPYOSkn0k_FrE6nAK1JYWO2Gg==Ozk9KSg@mail.gmail.com>
 <CAOQ4uxgM+oJxp0Od=i=Twj9EN2v2+rFByEKabZybic=6gA0QgA@mail.gmail.com>
 <CAJfpegs-SbCUA-nGnnoHr=UUwzzNKuZ9fOB86+jgxM6RH4twAA@mail.gmail.com> <20250513-etage-dankbar-0d4e76980043@brauner>
In-Reply-To: <20250513-etage-dankbar-0d4e76980043@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 13 May 2025 09:57:35 +0200
X-Gm-Features: AX0GCFsDFZdwWLBzFGFEw6NDwwOPLVDuadqeBK8hpwKan4IfdIF7U4uWzPHpP8g
Message-ID: <CAJfpegsmvhsSGVGih=44tE6Ro7x3RzvOHuaREu+Abd2eZMR6Rw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fs: fuse: add backing_files control file
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 May 2025 at 09:39, Christian Brauner <brauner@kernel.org> wrote:

> No, the xattr interface is ugly as hell and I don't want it used as a
> generic information transportation information interface. And I don't
> want a single thing that sets a precedent in that direction.

You are getting emotional and the last messages from you contain zero
technical details.

I know about the buffer sizing one, can you describe your other gripes?

> > But if the data is inherently variable sized, adding specialized
> > interface is not going to magically solve that.
> >
> > Instead we can concentrate on solving the buffer sizing problem
> > generally, so that all may benefit.
>
> The xattr system call as far as I'm concerned is not going to be pimped
> to support stuff like that.

Heh?  IIRC there were positive reactions to e.g. "O_XATTR", it just
didn't get implemented.  Can try to dig this up from the archives.

> Then by all means we can come up with a scheme in procfs that displays
> this hierarchically if we have to.

Yeah, perhaps it's doable.

Thanks,
Miklos

