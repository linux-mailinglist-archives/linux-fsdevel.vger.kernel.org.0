Return-Path: <linux-fsdevel+bounces-62008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FB7B81BD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 22:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A395B7AE239
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 20:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206F02877F0;
	Wed, 17 Sep 2025 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="CLsAjjPD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B40C4690
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758140382; cv=none; b=ahvhgzZLwyNuNn2szgwwbWdxLx+tnIlSN6oRIDJgS8v7sWqBgwCwyMUl9QhLAI0d+7Psghlk4Phv/DU4glW7WpbKZR35ZrWNgVsPzw9SmQYO2McJ6XRaDDRTW+yi/VtlUfMr4CJEybvH/XR3T0u8YBhxOxYT2f8up8aUlyytzhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758140382; c=relaxed/simple;
	bh=DdJUxUNFZhPzSovCJFZJEIo7a10mS+SVD1T5lJDA/ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6oWMi4A6b93ReIMpppepP+6jKiVx2R34LdJcMvpcooQsb07P9gCZ17LPvS34zb5VBNJo5UR1JnfywEKRNVPTMp0eVTo1QRhi+jPe2iVsI2T+pQIjXtxMRuatFF+qrBoYeMlzsWvCiuE1yDRIj2c2BcK0aSuM8Jsle8UahzWr7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=CLsAjjPD; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62f277546abso257090a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 13:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758140379; x=1758745179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdJUxUNFZhPzSovCJFZJEIo7a10mS+SVD1T5lJDA/ms=;
        b=CLsAjjPDj/JXR+ZfsKLXRmuRlbqMpeXnZSqaDzvzNUfk4FZHY+7/ae/nrGyDyRwCj5
         m9m/I4gYI4lfcEANyfoTnf1IDh6rcbKPaXMywbBC8p8Uzpq85c8LYNjqH45jJsdS+esS
         hqq67SWaZD1/t0ua9uAG+Vttm0ecFMZHHFC2Ze0sqCtoM1iLwiBN0yxzkUUmH9HRlcoZ
         O6uGg+gQyOwwNWFkXmcmDcU018NYqKv0cQOT+YAT3ay+C5ZPh/Fi2V0ibBLtIhkt0/od
         /hOjQU9yyR/ppVBWYk8ZxKPI1l8c8RGloUKfA7O4ZgnrBwggBOQdLg1BSZAPiYzaFtP/
         4PmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758140379; x=1758745179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdJUxUNFZhPzSovCJFZJEIo7a10mS+SVD1T5lJDA/ms=;
        b=K3NgAimaV7RhpmfVMYoHX6klBT2NRV76Vn+4B07CqenSD1a2odC4q8dJ0Yio3BOV1Z
         x1hF0T1KSJluKrmJVeXWir09HKdgs9Mg8/LXJI01HsUO/uuUgJYfPnrL9y8c12mdOaRH
         rbaOz7MVYZXHSsWzOrrI1Ok88U9QSWWCsExS1lCVr3wDrTfuqK2H0T5F53buQk/GUJkm
         AXl/D0C0H7hrfBlD+8BxfZV7HzCQkyzgpUinohLDAtM/CtccL5ez+IyOyLXDtnbymwph
         Xugie4SjUKxcOu0LUsJZSnbKii1iv54V5axl4j5T+69/r3e7+OHc+nszkeCzz9ibdTBN
         DfGg==
X-Forwarded-Encrypted: i=1; AJvYcCW1Jnj0DgbnNAKtFRt9SWLbGb6xMr0SjBO3jmqSU/yV920YVRluEezm+9YQ9a3KV0DDSEKFVUkS+Gj+9auw@vger.kernel.org
X-Gm-Message-State: AOJu0YxazX07W90/3IUKVg6i0hC6YAtHoCSOyWuOrn+M8zoW0WQ6133c
	KafqsFmZ/b0C9Xb17+E5ItK+2jmmjk5X1HSPzpvHl0BzUoLWJAxs00YZvLkrZ+txOY3HdMw+soF
	i6F0KaNKc/fjeY47tVGFa8TU1Rit6kbC9zPk3gkXaBg==
X-Gm-Gg: ASbGnctE6TqVoY4ZDxoNcPKFv/dfi78IshHM6AkKch/0OoVKyyDqvJr0orLkdA+4qEf
	spTu80nHyWxRfJeLwsQdRTK0D+qvWOrVv2tlnIz6ALEe0zsApllKASK1mkbLJwf8Dbe78JWKI6I
	UrmUKoeo9mSEbxMrZwuymFGkiLdvOXM5TA99UtVhMDi+ygFnpu9ftpfQ3LFeQyZ1yitbdYc/p+e
	bDCOtlsdhfyi7KqI1zW+HQQQVP6JtYPuwOlcn0GSsc2kH+dhK/cNG4=
X-Google-Smtp-Source: AGHT+IFQaLDy/LlqDOKaXH33/5p9CVpaIIbnENcFkO7c6Maci4zFzsFceKZ4fsH5U+Ovj7N6lS3oxCJsn8eTAC3ubkw=
X-Received: by 2002:a17:906:c156:b0:b07:b7c2:d7fc with SMTP id
 a640c23a62f3a-b1bb5e571cemr321943466b.6.1758140378862; Wed, 17 Sep 2025
 13:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+-QRTC_j15=Cc4YeU3TAcpQCrFWmBZcNxfnw1LndVzASg@mail.gmail.com>
 <4z3imll6zbzwqcyfl225xn3rc4mev6ppjnx5itmvznj2yormug@utk6twdablj3>
 <CAKPOu+--m8eppmF5+fofG=AKAMu5K_meF44UH4XiL8V3_X_rJg@mail.gmail.com>
 <CAGudoHEqNYWMqDiogc9Q_s9QMQHB6Rm_1dUzcC7B0GFBrqS=1g@mail.gmail.com> <20250917201408.GX39973@ZenIV>
In-Reply-To: <20250917201408.GX39973@ZenIV>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 22:19:27 +0200
X-Gm-Features: AS18NWBTAX9o17WGEZG3_vr6672P-Z73BzGF9K0FZmb6uSVnrvZWBv6zug26UJ4
Message-ID: <CAKPOu+_WNgA=8jUa5BiB0_3c+4EoKJdoh9S-tCEuz=3o0WpsiA@mail.gmail.com>
Subject: Re: Need advice with iput() deadlock during writeback
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:14=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
> Looks rather dangerous - what do you do on fs shutdown?

Sorry, I'm new to this, I don't know how fs shutdown works - stupid
question: is my code any more dangerous than what's already happening
with ceph_queue_inode_work()?

