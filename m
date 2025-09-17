Return-Path: <linux-fsdevel+bounces-62018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A67DB81CA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 22:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6D41C054EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 20:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CE57082D;
	Wed, 17 Sep 2025 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="MBzCfgQ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CDF2BDC33
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 20:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758141424; cv=none; b=GQuA66S6HVlr8Aw0Dg0m7HCPlAd6u/xgoseBbnmS9rbxySiLzvtnKteWct371uxnIxVrr72iVNfvCFiAAeKLZ00vFL+Fif/Vn6kLqBMeMvSdFcJfZexXjr1tec2u7jGnB+Xo8rkBZLqptDkWbi1Hf3XGGdWt3I0fDeoqcopO0i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758141424; c=relaxed/simple;
	bh=4UTP14/ZBWdBW20f6LTJKvgiuhF7FTrxq4n4nfTui4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nov5mlYS72J80NtIpXt7FvLxycHq9+T8ChDVTmvzEl+7dq53DGEmhOZ73rsy1UdHyT4J29wjUNR3Hmw/GyqkFj9ouhzEw9lzKr1qzqVyXwTIQvxirjDphpGYlAa0F19B9HS5bsNoe130tkgv6zWra2qm3fWb0f3TGjAZ2OHC3vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=MBzCfgQ8; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b079c13240eso39148766b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 13:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758141420; x=1758746220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Chf7X+qGiFJJFnzlWxmYJPQYQ0EzCnC9UbWxIFQaqrI=;
        b=MBzCfgQ86C3Clio1lwYTkXgHRwrl7dhwqv2GbSbVdX1vZXp41Y226ALZMTnk4FZID+
         s5lpgTiaUpn1w/rD1lsKVEj8jiGx2FGNr2bDSwptgq2XjY4ezMOYg2LdMCO4bpCphym8
         pMq+Y9YEBE9kWFbnWhq1w8cP4phaW4szZ5DQs0lzoYDTm//FnFwJfRJZBzqh0I1/BWXN
         xpE/fmZ6NTq6yyWN+8taPQQZRSsexFoN9z8ymnDg+cFm6AE+ZIJAfn4NFx7QRF/gDWIM
         hT6S2X2SSgWxUjuaciReKNISHugDqkTEhALoalcTtOce7j4uBfEWgK1XdjhCpaZ5kDs7
         yZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758141420; x=1758746220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Chf7X+qGiFJJFnzlWxmYJPQYQ0EzCnC9UbWxIFQaqrI=;
        b=B5F1IP/NhgGLG2bU66FLZb2VAI1To5v4KQ6FxEs3f1fkrVZFIK/nVZFqpzeWQ878jg
         zOKEpZARZ0a93fmgJm3jq2xeaura44ciCLiTdh1KPB01wSMwQYTbN+61YP9+ZD+MXKYF
         0+B47CxGQs9uQsxMWHVheOi4+hl/32ZwC4p2G54Lm58WEEAgIYHVvAiqKlKnsnSjPwPN
         /3aQZXu2YnPJbSQwWc3lY9wSHhIWGV3+RZSsxobNdkqQb3azHgrEcvgqtYwwZQnrZKYu
         LC3sEjjU3JbwPdROzP+HSNZ0mfCU7WpN3PgqLUWHAHlTK31qDQiqwxmc8r4XHucBvXQT
         +MdA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ2bHiwuUR0tZaHBNRVNsc+h3TYqOrJqmCB3MCHhG/OXe4rpSHCF+mKg4kpD8b4/d0LSrSOfTlqSbsixPM@vger.kernel.org
X-Gm-Message-State: AOJu0YzBWZLlAr4VZnwiH+Y0yLEh4JUIFyLyMuDDf9L1sEI8ayc7Piv5
	U2tXY05ffPRPwQSPIbelsXNd1017IRoq9I3uuuqkTs+hk9dZPUXG3kanwQzAp+4DPDyy7v7lk1T
	q5QrUoqDCEGgnEqiAiSzoY/1sCeeSjt1buCpxSH80PyyagZjjtqGw+NA=
X-Gm-Gg: ASbGncvYW12SG2SebKJ9LXqrNRC3XjPjuO8/4cGQojQ0ehqCr/bgJAqQZnzDKLb/9da
	1xOv7lBAPApqN8Y8vJmWbkCHQPR/dij9yxyu0L80WtTEuxTZS9eEE4Glvw9ccECpBwMZi4fSD87
	rnCoTG2XEKd6DqIp/LH9euUt/nInBJ3/sBaDYBKyRA18Lk2MT3msU9hJdBzbIRCQtwnHzxrxvwO
	YfsBa6PKZbvbNl3quiDndR/AremvhVo88Gq
X-Google-Smtp-Source: AGHT+IGfptemIFohfTy+lGP+G94GDKuCT6cuywROwctnniSHmTHsaA0aWmc8jBz7sUxZychQu36GLP7/p/srVhhMhOs=
X-Received: by 2002:a17:907:dac:b0:afe:e1e3:36a2 with SMTP id
 a640c23a62f3a-b1bb6beec18mr411560666b.31.1758141419817; Wed, 17 Sep 2025
 13:36:59 -0700 (PDT)
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
 <20250917201408.GX39973@ZenIV> <CAGudoHFEE4nS_cWuc3xjmP=OaQSXMCg0eBrKCBHc3tf104er3A@mail.gmail.com>
 <20250917203435.GA39973@ZenIV>
In-Reply-To: <20250917203435.GA39973@ZenIV>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 17 Sep 2025 22:36:48 +0200
X-Gm-Features: AS18NWCHuKu5FkRi5MWoSntMnfUkf_rpkIBRpCjAVUQOvwmxI5LYn5BBnB2B2gI
Message-ID: <CAKPOu+8wLezQY05ZLSd4P2OySe7qqE7CTHzYG6pobpt=xV--Jg@mail.gmail.com>
Subject: Re: Need advice with iput() deadlock during writeback
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:34=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
> Suppose two threads do umount() on two different filesystems.  The first
> one to flush picks *everything* you've delayed and starts handling that.
> The second sees nothing to do and proceeds to taking the filesystem
> it's unmounting apart, right under the nose of the first thread doing
> work on both filesystems...

Each filesystem (struct ceph_fs_client) has its own inode_wq.

