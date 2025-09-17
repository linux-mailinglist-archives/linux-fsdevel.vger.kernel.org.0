Return-Path: <linux-fsdevel+bounces-62016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC719B81C71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 22:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D441C80BA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 20:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2462D4B61;
	Wed, 17 Sep 2025 20:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Li8TGEPa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C1227B358
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 20:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758141190; cv=none; b=LxQlU/2KO7dWPIERYZplyaapS57mFWJtP5a6PhjxLBYYuK7fUgaaNDK5voNi/dDPR/g3p2lK4ZvDRPwIg4eQQBH0jADncN8gwthps7wqEvlkPJ0ui1OPVMk/1q9lNVivhm34b/BS8edJeeVY6Y1ctCXIkoUX79tPuHCPkWMeURI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758141190; c=relaxed/simple;
	bh=+Y0zPcfwWdxA+c0s4fHg8IZujVM2iirb8dLcM0lSQQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ty/bVVufnz6LSavQkZCyfVnCPb7bk0HYSXLAd4Vh2KuvXgk7yH3yRAVw4SXo4KSBVYqFZJHnejaUmTI98UEWPPcsLo2nMd8JvLEo+11P1vuMviqalPJXY0FFk8+Gev5QJiuOWDBinC/LfOHB/3f6hVhHNM0IMlf0nSsmYLfyQP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Li8TGEPa; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62fa0653cd1so225956a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 13:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758141186; x=1758745986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2/zE+U2NdiGVEzz6yPQL135dw9YRWvNuaGSRy0m5PM=;
        b=Li8TGEPa5mRkYzKa69QSMCU3Z17Ryqkk+O1FKdhVu+4KoxIq35Nnk6KCgNlD2IBcNr
         1elxyciqjz7zE0Ap4MFjApCsT16WjOMDUK26PsCVUbhlrAzKzKhUZZtwrTtS0KTMKsIN
         iUD8ta+45LhuMwKL2sWkBVsHkYIbAeXCRb1gjcymBL3lOZhHo9gMwVTxdytYZtpXc8qx
         1Z0Ug0nd9lurU81WyzHst5sStYc4UzFRd2HtwAupMWJambTIAKXfNSnzfSLe5VPoZjKG
         v+1Yu5/Bd+5alFV/DRAVThz/kB7lbiY+2/ODnc9PgBJ62+lsVGrK+6POvt76O7Oef471
         l2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758141186; x=1758745986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2/zE+U2NdiGVEzz6yPQL135dw9YRWvNuaGSRy0m5PM=;
        b=ZQS4muOHT8Nhnxjc28UM4gwDDy4Ea8fpaaZGzjLr14D1EjgCTpxE9YmsSLsCfTeLhG
         NgDH6F6qi7YbSG8HKbjuKrQc6EbInOJ79O5WAyIa4UAhpvcilsJmbmReV/bcrz5wWtDb
         E972+EsSjLaxKoEqwnPGpWOkucySCL41cOOOhsSw0i5+TRjHX03tKFzmU6V+k8CGgIJb
         G9zUyKKz30/IZ8gvSAyNZUH67LpS9dn3gTPLHcgncoWeBOOQv08GzxVq7lMro0yl3CIM
         F/ctlDX6yYHO2WIsXMGk63QS2XQ1x+L3wfqE5+xTOqllhyfa8PWr8l57a/7LjuXVu1aU
         ikDA==
X-Forwarded-Encrypted: i=1; AJvYcCXHCIcLRpBUh0YLVgfTt5YUpQHxrnLvYn3eQrpRjNNrLL0IWtbT3ngBSekJHnJ/RwDhfcI1WvzI5uScJZ2N@vger.kernel.org
X-Gm-Message-State: AOJu0YwwYLP4NffYoLgbV5ehbsT9ULvU7OfZEUNzfKit+0KKttIr7yVV
	L6nwXkTGBv44bnWYKHaXBAURY2q/nS4D1nNNL+QBVWa4hAP0nk/ZRnITEWgJxdwcCdJzt8MGx6T
	KgllCq924875lJs2eIGDewp+lI+W1E9e+JbBXUucL/g==
X-Gm-Gg: ASbGncsAWq5G6nKSndOpQ3EU4fQX44VShWY4XBxfAcpDEmHQGGr+sYu+ioVwAH5ogdQ
	3FQEAPfgm3R5GdBnM1t0YNKxgSgQVbSfH1e6CAM3LKhLZvJFmxkl27bgB4Y0fScu+kgZs5gsMu+
	Y8VQ4Tvri6pLENFjoAYRearqykcuJzsvaL4mf9snueMVtQlK3nfnPp6ZmgRQKsyRfUtS+S67kVH
	xpzE7tvGtIfXRaoAZXRha/bHZH6MFpLUlk4q0Qjn70dgYwBUVxOjrU=
X-Google-Smtp-Source: AGHT+IH9oujhhWDrl44RnWA34Ua+LIz3ygyCfay2po5pFCbVcM1XbntfX9EHMI/yw132NXrBxBGW0Ue38XZA/MmI8QY=
X-Received: by 2002:a17:907:3f9d:b0:b04:2d6c:551 with SMTP id
 a640c23a62f3a-b1bbbe51362mr375134166b.42.1758141186331; Wed, 17 Sep 2025
 13:33:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+-QRTC_j15=Cc4YeU3TAcpQCrFWmBZcNxfnw1LndVzASg@mail.gmail.com>
 <4z3imll6zbzwqcyfl225xn3rc4mev6ppjnx5itmvznj2yormug@utk6twdablj3>
 <CAKPOu+--m8eppmF5+fofG=AKAMu5K_meF44UH4XiL8V3_X_rJg@mail.gmail.com>
 <CAGudoHEqNYWMqDiogc9Q_s9QMQHB6Rm_1dUzcC7B0GFBrqS=1g@mail.gmail.com>
 <20250917201408.GX39973@ZenIV> <CAKPOu+_WNgA=8jUa5BiB0_3c+4EoKJdoh9S-tCEuz=3o0WpsiA@mail.gmail.com>
 <20250917202914.GZ39973@ZenIV>
In-Reply-To: <20250917202914.GZ39973@ZenIV>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 22:32:55 +0200
X-Gm-Features: AS18NWCqxCzXv8eyHW2GR-MxYUrgmiPK3CG9A2laulzc4bLaAxYR1-YXcuok9Go
Message-ID: <CAKPOu+_KWSAHF+U9UFrON3nugt9mQQcwCifCNbBxkKQUEnFF6g@mail.gmail.com>
Subject: Re: Need advice with iput() deadlock during writeback
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:29=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
> At some point ->kill_sb() will call generic_shutdown_super() (in case of =
ceph
> that's done via kill_anon_super()), where we get to evict_inodes().  Any
> busy inode at that point is a bad problem...

And before that, Ceph will call flush_fs_workqueues().

But again: if this were wrong, would this be a new bug in my patch, or
would this be an old existing bug? Knowing this is important for me to
understand the nature of the (potential) problem you're raising.

