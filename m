Return-Path: <linux-fsdevel+bounces-63280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 416FFBB3F0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 14:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70D519C4073
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 12:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736723112B7;
	Thu,  2 Oct 2025 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS34vgkj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845E630DD20
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409659; cv=none; b=PwAux3yMwkEqs//KdVVgYPxA48wikIVQLlkr3keTn+BdfvWNhJvvq17TuDUrdggdqYE+lsqmGl60S4QTsBXQ6RPPdTQqTZaUV8svAOlE1MPUmdGQZls6DFSTOUbu8oW1LOSiwgzsFS5gcS53g/S2cr3k4QDeqrkSQQ2WfDbOBNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409659; c=relaxed/simple;
	bh=vshfgEXM240g8Ur6ZqCHQY7TZT43IjstqImcXZNXMvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cA1SoeicxoS4Y/fDEIvJvawYdEYOltnZsDS1jLHLKmGm3kNfPU5hlaTpn/mkrhP6O4x8+ktNZmRhUYuVBhP5beLmXRm3ji4FjXpqPdsUI59eYZ3dPe6yDGIHe26jaZN2PD77LdF4MceAVUBgyob1R7rsrp+cvn/hORNYsVJoAS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mS34vgkj; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b553412a19bso713348a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 05:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759409658; x=1760014458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zyF1KlzIyd2frb4q1kwOC8yXFthhhhzMu8IVSVepCNk=;
        b=mS34vgkjGrzi3EplnWV5FJuLPyYtTZjUd5YHYN7XwIDxNYfqHzo8hNgMMv4MB2pwkP
         /M0uYuOiN+72/7riSn2nEWI+8dSsUqh4cMSz3uXJ197ElEbq78iLWRAw4qGvXXLUIeCz
         Fk2DRl+Oefva496zrtV1KogR+nxgE/JviTDCdJp0pcPQZWcGWQhV9olbJ49wrsr/NGWe
         XfLKF+VY0d179yBLmk/VtAiY5mwORQu7izZb0Vdb4BFibuYNmEEtGatV/ds2Jd1UGxtL
         Dzq5UUd4lAtd4F42OxOrdLoucUSdmHi+Wh6zIAFQbALWvWVaFhyKdKMi/Uy1P5Z060Ux
         WwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759409658; x=1760014458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zyF1KlzIyd2frb4q1kwOC8yXFthhhhzMu8IVSVepCNk=;
        b=SZeQKy45WNh9VnFRda6SlnxiDf/hxl+yoCk4kePyxHbpIRHp1+8exdclP4B6twCTD1
         RQFNh8P3hB8vULwg/P10XHOBads4kUtpXetKr0KXhrDdFqgaqPrEmIwbhFomAsUBu6nh
         aubcsc25T697c26TuZfVH1ZwRho7ecczWgXcRaiXJ4VYA7rOdsz216/jRw9xacGqlKvl
         d1YqnUTeUM9+sLoSX+mRXgcsQyg4Eayjk20ih/mPOaIxCj5aQufgYyxgZHW4NXGuxlgR
         AqBiDcO2SWkITvOnYn/APAaKBaw3u858e4gPIURMnNVXWmxt9Dj5z2fDg5l2LNM5ofAl
         7/QQ==
X-Gm-Message-State: AOJu0YxNacQ9I1VJMN73CSFwtkfqQB9WPlc8YVzFEARKr1zRChgOihsA
	GU+BAESyHEHwTn0/hOo5hhlt/daw3fk9wxOqRHytU+u/jw80z1Rd84n5syJNpgOJHHAQQjeIcqI
	GgRHlAZTTNDibjQ9QVbrnX3KkCNkgDjy/EYUx
X-Gm-Gg: ASbGncvWqGJRGbz0KWKJjLNfze70PWX/bHtGmc77k97dnBSTdj88ijhwfRxVWuZKzmT
	DL3qFcKTpuC9soDiFdDkQzaKZ+Rb3z98YlOGPg8f8s5H6EhVb35Z56r4nhCM6kQEHNmth6LWVuO
	wZiogvZWIbXUU8xnQ5ZfsCEHT5m9wsv7dUy5SjKG7gynLxLZ2PEhaPpcgY3LyscG5LLObS7uzc0
	MbOl+cii4RGLFcI/4OHRwrMMwVaF82h
X-Google-Smtp-Source: AGHT+IF4j+gFjOlRuk6+ym8T9WHqgkvCZyOozmk1mhgZ3w5g5soIUvtLFo9TbH6946RsWQwg0QXecevdvcN63wfNpQ0=
X-Received: by 2002:a17:903:245:b0:27e:ef96:c153 with SMTP id
 d9443c01a7336-28e7f2922e8mr88045895ad.19.1759409657765; Thu, 02 Oct 2025
 05:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD8Qqac-3Oss=M4aU0B_gKCzBhuUo0ChH+8wFkWDPz=mQVqSiQ@mail.gmail.com>
 <20251002123505.GM39973@ZenIV>
In-Reply-To: <20251002123505.GM39973@ZenIV>
From: =?UTF-8?Q?Miroslav_Crni=C4=87?= <mcrnic@gmail.com>
Date: Thu, 2 Oct 2025 13:54:06 +0100
X-Gm-Features: AS18NWDJ2QGIwhL_KouCo8pqVA6eP2GtK4c145vLiWp8XA_vKLgxpKWwouo2h5E
Message-ID: <CAD8QqadrK6nY3e1BZV7DHkBwUNevHnQC1cWi8akzxY2Z=B-b3w@mail.gmail.com>
Subject: Re: shrink_dcache_parent contention can make it stall for hours
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Currently disposal list is modified only by the thread that has created it;
> which lock (if any) do you have in mind for protecting those?

You are completely right here. It would require additional locking.
In that case, I would suggest something different.
Skipping select_collect entirely and calling select_collect2 instead
would be better.
It would need to be modified such that it populates select_data.found
The no contention path should result in similar results as all items
will be collected in dispose list. The contention path would stop
sooner, on the first
worksteal item and prevent holding the parent->d_lock over the whole iteration.

> Do you mean dentry_unlist()?  The problem is, how do you prevent those parents
> looking inexplicably busy?  Cross-fs disposal list existing in parallel with fs
> shutdown is very much possible; shrink_dcache_for_umount() should quietly steal
> everything relevant from that and move on, leaving the empty husks on the
> list to by freed by list owner once it gets to them.

Right, this is not an option then.

