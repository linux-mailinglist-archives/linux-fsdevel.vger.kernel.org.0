Return-Path: <linux-fsdevel+bounces-65122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 289CEBFC9B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79EE04E602F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9971332B994;
	Wed, 22 Oct 2025 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM0sIJO9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902E82566DF
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144176; cv=none; b=HlMX2zrAwt9pjNp6/uG3Y4MgfjSeAdlYHoySK799LaxQmM8oLK/uIR7hWHuANJu7vQ3Q9Dzyfy3cukfGqzAR4lJAVoWQ5qNDP57IHWj+aA7QjnypaZDYXXBdwOFxPtN2r2ph9y0zXR59e3YcCXv1Zj3pefej+yMDidQalMThvhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144176; c=relaxed/simple;
	bh=pt/hb6LquN+6vliqbTlWkpEkStkiPbe0mMgm1WItlVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jn6Goux/YMtm68AlRltD62B3FW2BLlKWQdab1o3bX/iC6Rn8hr3NoUCMhlmJagnqwPy4UoHTIwtfmmXdJtxBPgHEUPc/ST9XaX9DGh9MUJye/s0iTHBKAJHccxaAer3PGaFoLhHR9UDEB+u9CiLKRHl4h7ypd5maxwlWTPtThpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QM0sIJO9; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b63117fb83dso314815a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 07:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761144174; x=1761748974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pt/hb6LquN+6vliqbTlWkpEkStkiPbe0mMgm1WItlVA=;
        b=QM0sIJO94C2ZgElJUunuEmp+k2yxRo96skeqEaS50lUIAckKVlWK9oJVlPzAYybRGA
         fdaR3Qb4lSjjIBdrI7von+o6a50ITjgxMPrnTeSIkgMo1hAePVwEuTqH/ps09IvQlQ73
         qH/nwxA9e4DnApvCFqcKUvEFj5M1Qj3IcIPz7JBQ2T/z95ydOK9YFneSaYndF8xy8E2f
         PU6SlbQrMKppx4CtS2miHH0cD6QCL/NuB9FdVocDIPAmZnTwl3hFD8r/4RLDXafNTGmm
         ajowQJRC+48wqWaPmYwR4If5x2j0Faih8lZjzEp9kvdzQr72sCYrjJ8okbKmYDf7Z6bF
         Yxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761144174; x=1761748974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pt/hb6LquN+6vliqbTlWkpEkStkiPbe0mMgm1WItlVA=;
        b=cF3E1GWwD6OKqATOnkH4RYiorxuqjZNO1Li+MYW5js09k4QSOPfEZ9OQYfRMbrgJZL
         23hEvxp3ySu67nk7qZdIaD3R1V86pIAe1X1TaXayJOPeoMAQXs2uaHwr1E4eeFDaTy8S
         cBC8doCvCJeHKcnwCDc82m5CSJZZV0KxNYjmJdw4VTas1Ewjv0cKVQOLAjl+Cdu5cNA/
         /oX/NFZ4Kro5zCFX8fGWovemwYYtHbZqUL1wEXzUtaPlt2joERVBO3Pw915Ea9ANzi/4
         r3sqxwU75PuRD7U1IvElJ9s82SPRqOzqPRfrF4X838H4BtwkZix7zzWU9MT53JhhbbE1
         PgSg==
X-Forwarded-Encrypted: i=1; AJvYcCXRhEzMQSgSIH+FRxcpBQrLKlpz4voz+LxL6pb/x/jg4ctmItzZSb/Brozszio1JwmTw1Hk5+nMriMUpz7c@vger.kernel.org
X-Gm-Message-State: AOJu0YxcNDbGPX58L0ZYcgCb0xLk4Ml2Ukm6XL3r4wX6dwqrSTeOO4A2
	r51nQJv21ZZkge2MeU3HyNxQ9bTLfQmLTBgEJBvs4XJFskbSkPCwAar6J2FRE4X5W5Kwv/kKIbn
	bUN0jy3PsSOBd+Sh7gp1ZgzeGVaWnjcA=
X-Gm-Gg: ASbGncvQFWPicscloUF1l6WhOw5DwXdd+v5aRQ58ElKbA9hBBcCLPVCOQFfNISVi4Gq
	uOGXhh5BDcsYRtmywVBZHfz0Fkg6od9rJB1nrc73LVjjGqqqyJhUVFMrtoxKb5RKJYrQcy9ri7R
	8MClRRLNEv098oTY+EnWODoOCCZ/ECu96Y8gYS7N6aNunBsqaE/l8uXh17uobLzWdu2GtSgKO8C
	i1Xg/IRbEUB1/jaghWheofaDuTqUUITpnglHvLGxK8cMY4+VDm8bYoI9cVDrWOeN3Pow3aKqqU0
	yPkbPYNJk6pxsD+qIH7Ff827payTIZ8AdGvDbeKUHkHfzKS23ZCz/Bcp/i7xFRseRA8blHvEMug
	rNtjJY0tuNIny/Q==
X-Google-Smtp-Source: AGHT+IF0dLkMwF0C67XY0F31H5GqaR1j33ZTT0zRopJ3lXzaqdzE6cfhE7MiQK1KOT8lNdOakdaI73cMWJN4Y9UAbrA=
X-Received: by 2002:a17:903:1105:b0:290:b524:ec80 with SMTP id
 d9443c01a7336-292d3ff86f5mr56183865ad.10.1761144173719; Wed, 22 Oct 2025
 07:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-2-dakr@kernel.org>
In-Reply-To: <20251022143158.64475-2-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 22 Oct 2025 16:42:40 +0200
X-Gm-Features: AS18NWC_EFQnXFqlR8pd3BpYF88Juy0VblqECc1zdm3U_MxrNHSthFGuCElfR3U
Message-ID: <CANiq72mUauK+Z1nqU-m9LeY4mn2NQPHKNY9Psvfcbw+Axbrhhg@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] rust: fs: add new type file::Offset
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

On Wed, Oct 22, 2025 at 4:32=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Add a new type for file offsets, i.e. bindings::loff_t. Trying to avoid
> using raw bindings types, this seems to be the better alternative
> compared to just using i64.
>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Thanks a lot for this!

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1198

Cheers,
Miguel

