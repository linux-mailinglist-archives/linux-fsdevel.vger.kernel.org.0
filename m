Return-Path: <linux-fsdevel+bounces-65011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC291BF9319
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 01:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B3B1895379
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 23:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53BE2C08AF;
	Tue, 21 Oct 2025 23:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkStA10V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577DC2367CF
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 23:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761088599; cv=none; b=T0q2qgY4DOF9ibrCM4mHOOk+CcVUgMy+udbRKRHZ6Yni0pFx9wt3nvMflDqLeV9Hy1g2JkJLmM2qii5hN+rYqRSmuBGAF03ei3nJQzvS/yIC/8qhxhpaCc3C9VT3QFoXzgl4cmIUpq0OVm9Q3rbQS+oFoSJMA54fQZk35Onfeq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761088599; c=relaxed/simple;
	bh=4Jm32qXMHIXKKOfLhgjYBhQWDQDVGDfzHihzO3VYXnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWchzAs+GSSyOu78yaEizJScVPrCOXb2el5mueQeMGvPXLlCiXM0FtWtlXszBmy/cogPrCGqbhEeEnocEbycBwsEN09Uj5TxE/tNWHYtdcArRECzrCtuWM5VXGwfLzRM1kwSp24Fs2DIymCVnXLx7Eedp4aT92p53Mvbixt1aBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkStA10V; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-28d18e933a9so9930435ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 16:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761088597; x=1761693397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Jm32qXMHIXKKOfLhgjYBhQWDQDVGDfzHihzO3VYXnM=;
        b=OkStA10Vw3UWeBxyZJ0pQvU/iEkgE38lSXKaWoXic0SbRkNZXNv++Arxy7I8csNU3D
         b0c7Fdkm+NdRhc1MZfP+EzYbpRXFHWcybsyPLabRslNczbXYpn/VdCkhMDOGQKzy7psi
         /sKQW4/A1THyv8BGomLVfZmxoCxEJJjD1jiLDEAI+SN77qlyVttM6nK6fYpyd86ZRYCm
         647UyhAh5yK89hfPIvNLlx4rUctTEq8e3FfyNfJp8ZqkC5ILKkvZ9bO1HBtHZ+xSoJYg
         S6Gi/vMalFPnufve0j1SJcZAPWxilkM6nu7RIXw8h0lzrz48L2HVSMj5D15kGMUnVmO2
         hqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761088597; x=1761693397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Jm32qXMHIXKKOfLhgjYBhQWDQDVGDfzHihzO3VYXnM=;
        b=LtpzMrHya3uQW+hB/PUl831SVlbmU9PhHbAPX/w3bbcjcAZ0iZOSOn63ye+Sp8Z+qw
         owXS6+TEzJEVe1iWJG0REEhZCfLcKX8BC7iJcKEp4Tqxkp9oAIU2K4xh153a4KXzC/gu
         7k2oGAI+XhI47nTOnyRJW40e2dabdvGVuCzzYgEZdwTLPbNiZqEOSYG4zNN4RGtd9XYH
         T6M3SFXsYSj7gzE9vrywo8FmaChIs9yOVX/wnSYe0rIEfvp4XRHUls9HlwWsBA5XC1iQ
         oDCblECQYGPZH1aslrNiDde9ljL9y44nn422zHEWEaACVNrYo3Cpr2FnS/avZMyCr+E9
         QdhA==
X-Forwarded-Encrypted: i=1; AJvYcCW7D0kU8jTTM90SN+I+kCx7qGyC7HAwRPdHC3VXJV3uEGmavXrCYGvingNeD2c/vdqsf1ljTN+X82mId4rb@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl/5z+ZDV+m866SHYUB2OctUsCj6KR3I6lCJipuwUpezcQrvfI
	3ZC0bSWQZ58+5n7kvCkAQ97fTEzoXdLZbjDaUVez330Kvp6X/WijACeaJ/b2X+QmdVfwrzNk11n
	AOKQFY7pAargd+qA4vGReab8+MwqkhXg=
X-Gm-Gg: ASbGncsOrTNX6WfCkuWlhrENIIqiCZGcK+uyYB3PkBBoh4TXXz3+FI0Xkf4Jr6EVIZh
	7xCW8It5/8pcsPsGIPkduzu4fGCQZXKChI1T/lQ4hROBh5Fhlk4KQdCJZLAGQHe1BqD+oObpOiV
	CM6NEpnDXu6SlyHpBKe5QgOhr0m2NFoMpRrbydU1jMVE0/D/YBjksmIawpu0iYxJe9+Uz7Pp5H3
	cvyLjZhaeb08yDUYNVOqvt2uZx3gFr9Qo9B8cSUy6IcmQtf9pnlMECJHxgRnj4dAE+0N0JCNrQT
	EeTbbH08DicKTomgWEhq/pBWrRiLfVkvC5bJmQgal+4LjJln8MW2ecc7ioQT7H2uiY8eOsOWyGj
	Z8/b+YkFhStczdQ==
X-Google-Smtp-Source: AGHT+IF06VtyL76w1sSXtIw9bOE6xMloj8rrlvRiJ5iGqaR5hCWDZI+RDSI94yfKuWAc4TqZzzRiWCMUqEonx1/aW+A=
X-Received: by 2002:a17:903:1ac8:b0:290:ccf2:9371 with SMTP id
 d9443c01a7336-292d3d97a7emr34673855ad.0.1761088597450; Tue, 21 Oct 2025
 16:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020222722.240473-1-dakr@kernel.org> <20251020222722.240473-2-dakr@kernel.org>
 <CANiq72m_LSbyTOg2b0mvDz4+uN+77gpL8T_yiOqi1vKm+G4FzA@mail.gmail.com>
 <DDO3T1NMVRJR.3OPF5GW5UQAGH@kernel.org> <CANiq72k-_=nhJAfzSV3rX7Tgz5KcmTdqwU9+j4M9V3rPYRmg+A@mail.gmail.com>
 <DDO521751WXE.11AAYWCL2CMP0@kernel.org> <CANiq72=N+--1bhg+nSTDhvx3mFDcvppXo9Jxa__OPQRiSgEo2w@mail.gmail.com>
 <DDO6IUEAVBR0.14AZ0UXFYQF48@kernel.org>
In-Reply-To: <DDO6IUEAVBR0.14AZ0UXFYQF48@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 22 Oct 2025 01:16:25 +0200
X-Gm-Features: AS18NWA1db9xaE-Optx34cBClVs97tRs8EsVnoB259x46K9u88Yu8XRI6Dm9EB0
Message-ID: <CANiq72kA8ZMf4ivQa4JTt0ZDmJ5bxWdpjgNb9bfW9n27HdTQ=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] rust: fs: add file::Offset type alias
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, mmaurer@google.com, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 7:34=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> However, I understand where you're coming from. Even though there's not a=
 huge
> gain here, it would be good to set an example -- especially if it's somet=
hing as
> cental as a file offset type.
>
> If this is what you have in mind, let me go ahead and do it right away (a=
t least
> for the things needed by this patch series), because that's a very good r=
eason I
> think.

Yeah, exactly, it should be fairly straightforward for at least the ones he=
re.

Up to you, i.e. we can already start (the code you showed me offline
looks good) or wait for someone to send the change (or since you
started, they can still consider more operations and expand the type
etc.).

I will send a small coding guidelines note on type aliases -- I can
reference this example when added, since it is a good example I think.
:)

Thanks!

Cheers,
Miguel

