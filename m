Return-Path: <linux-fsdevel+bounces-71542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8E7CC6C33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 10:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD5CC300E173
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 09:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FAF33A9EA;
	Wed, 17 Dec 2025 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2M8hdmU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112C9331232
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765962679; cv=none; b=lvz6DN6jy0lERj/zlCnGaoMxWLDmZtO3tur6v9TVH0Novzq4QAT65MlX67qMgIgjgDZLlnW1UBVNdk9bJZPRK0WCQuCezsvsUP3m9U0QF+SlsuMQ0/8Py2wDFLYoq/zjC+NgrZ1A7vvnghTTzsUOKyR+fXCEpmO3cfUFHYUdvCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765962679; c=relaxed/simple;
	bh=ZH4GJrpKT6WVV34WaQPbQS4jR0cBXxRpzzcDfBvvTr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dx5al1pAoaz4s+g8o6wbzLdeReuQ0yktbCowq3MUGEYdqEhg2nsYplzFGMgYpHEXsbOUQ1g40cN61tEJkcy/e6VLGgBSIqHGuTTsJ4FkXy/nX3SH/ODK26xCA6V610bmyVVSnCHFWDGxxQsqOB7I1ABaTAKZLPZRbMcuvVQCDRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2M8hdmU; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7ce5d6627dso420601366b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 01:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765962676; x=1766567476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkX8piLRjtRqibPp8yVcvIodvcdLp4aAOS2IgqKnsI0=;
        b=G2M8hdmUE6IwlzgPHEU9bBbDcpTQXkRdWcGSdg5hs9jIXTY+eT2S+u6bRMudce9Wt8
         oUjXxx1xEAdpnEzbnHt/oXV8DDloKuVqwQQg9usYojJgjx3H+JuADzOmq5yhRFcbS30c
         aBv27lOyGwo52AovGCVMcSCZyJEdVI3R/nQZA7rB+xgvcog1d9S4I5ypn+Sxm+Ru1qY5
         qOhZOre4dXdTn8bpn9lyIPVTNisLBefyhblvN/u81Z7C0VPVdZwEiqr4Whg3IaFzYwM8
         l6ivo+G04Tr6pu0B69l5VNLrHsqURcGFoTmsoFYqdZ9R/hxrC0dFx8Mhwt4cgr5gvsot
         HrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765962676; x=1766567476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dkX8piLRjtRqibPp8yVcvIodvcdLp4aAOS2IgqKnsI0=;
        b=C57fnyzMjnbG/1/Xo0nBaXZnlrjwmt9+BgUHF4PkP25g40Rb+Tei1pqsMjcGgYZbfH
         R6Xjf0ToH8Q3gpLhsay0yuemru0Zk2Pb7hm91N9gv8z+g79zjw0VXGAOy0IXn/rcaKFv
         LE4ihiQzXjoE3yQZAa6YZw29SbCG4jWmqpjTFA8wQOn5WTf3SQhNwYQuP1JbOBdLp6OQ
         RI5KhPaKsOGyTLHmrXtP9kz6J1hpzZ+S8dei/j9p0MzB+ZVKO64XzI9i9E4W0HicSB5o
         o2a3aykDaq8g6IMxD2aluLghK6yD3Wie0FPEm5VTnPy+eKTF2R92VByHxr9GLgCfHEkU
         Abrg==
X-Forwarded-Encrypted: i=1; AJvYcCXvksr7axTne5Zn2zv1TiyvxhkJBSJNCXlzdUp9U87WFTzcCE9ZA5EAUzaER8ZuJF9/7ccjUujTLEx+yJNK@vger.kernel.org
X-Gm-Message-State: AOJu0YxedqEP1eU5PX8pUFC71pIYUuF22VARsC17tJdErbdAGejasbSW
	kv/JFRnloRH4Dfn6XLYkrsOWhNDte9XGYLcEx89oJH7iO9byuMgN9PmuUGNaoClto8kZNLISxx+
	C6vLstQX+tcieU3Z1++/VJ10ikuP1Dzo=
X-Gm-Gg: AY/fxX68OKqtN+kFITu2rbBieQvMW8t2lT4gJpe/Ot4/5rHbH8PjAjWujYdQ/d6Yggj
	FBI1nfrf0SPiJZJcDLBury96FpzzkFjNg0kJP4ihRAMqfB2DnXGWNkpZrcU6S7y9dU0fj7cZxHn
	QK302r0wN+VIwZFsMpLTG4GCJXPqb5KXAPpzVgHyGFbzznHDA2K0cwfGLMuzEorWNn/e9WIBjEd
	8JMY5Ws10w3JX4EGbIYvX2SU5iB1eIJ1tnw0sIqCmU8hXvm+217JQKI5xoIrLuu1xtiwBoyBAhY
	g2RNzf+kItKf9PFpMcG8agB6xoQ=
X-Google-Smtp-Source: AGHT+IFjDvpTCzC6FVeuCec+MU2narzRcrFX/PqSW4UGTJcPg3u0Jp/emF2ZFDdnnbG3PezkAQl8kLr6XVObelHh8IY=
X-Received: by 2002:a17:907:9447:b0:b7c:e4e9:b10e with SMTP id
 a640c23a62f3a-b7d236b7b61mr1967625766b.18.1765962676076; Wed, 17 Dec 2025
 01:11:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217084704.2323682-1-mjguzik@gmail.com> <20251217090833.GS1712166@ZenIV>
In-Reply-To: <20251217090833.GS1712166@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Dec 2025 10:11:04 +0100
X-Gm-Features: AQt7F2o_RKIiBlMuuKb78p_VIdJ9P83VXWWSYUPjEhmWuewzXfhA4HbkfAUBIsU
Message-ID: <CAGudoHE5SrcUbUU8AuMCE1F_+wEUfM4o_Bp9eiYjX0jtJPUUmA@mail.gmail.com>
Subject: Re: [PATCH v2] fs: make sure to fail try_to_unlazy() and
 try_to_unlazy() for LOOKUP_CACHED
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 10:07=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Wed, Dec 17, 2025 at 09:47:04AM +0100, Mateusz Guzik wrote:
> > One remaining weirdness is terminate_walk() walking the symlink stack
> > after drop_links().
>
> What weirdness?  If we are not in RCU mode, we need to drop symlink bodie=
s
> *and* drop symlink references?

One would expect a routine named drop_links() would handle the
entirety of clean up of symlinks.

Seeing how it only handles some of it, it should be renamed to better
indicate what it is doing, but that's a potential clean up for later.

