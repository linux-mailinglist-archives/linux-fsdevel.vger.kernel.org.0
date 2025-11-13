Return-Path: <linux-fsdevel+bounces-68190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3B2C56AD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 10:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F239421115
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 09:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD10330329;
	Thu, 13 Nov 2025 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="l3AYlvul"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD129320CAE
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026735; cv=none; b=celAcbWnPt+yM/szul7IWMAd90f5VMl6KaQITtaD+BVzT0Q7CUylLvepYvBLx89/GsH6PJwwXP+8ecOSzZeTwPqQR4FG6cy1sy/LjchdNMC6GqK5B3ZwTPIPe/J7VsjsLn91KVQVuk4f7nkJj2pPoGoqrXj74/WxcOVk7vPJcdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026735; c=relaxed/simple;
	bh=EdPs4juy62ccnbqwisb9WZ/DrX2JL18pTQunI2hiDLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCGpwmCvqzH2SItXA/byhtYHPn40ViBgiMIZZ7grWrfhYvCkCoDI7Opm6FTCX5Q2Sp8S2QBdeCLwcBZ3V5LwDSJAFppk51X5wqxbu+81Zo9lTYOlXa/1iD9+HsyX7n7ce158TF5LokjLvPs4ZhD7eN4zDWNDLkStl43RCWkAv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=l3AYlvul; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b28f983333so70362085a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 01:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1763026733; x=1763631533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nP5WgxtbS89E28gAoqSP0cIIjeJeCmahXVnlmty8cBU=;
        b=l3AYlvulAIbwKljzbmh9+9dS2jgRudxl1y/fDQOvVRkVhYb/7YmAyQNH9sPgpGHFff
         C/e4NtvFMIgC8YhFW9pqeF7cbb3GkicWnL8TVX/7dhjaSdhpOUB8IvMHqcghSFUNnK9a
         nPcBaRIlv2nd5JDE4s5UexH7kHw74vWaehdRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026733; x=1763631533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nP5WgxtbS89E28gAoqSP0cIIjeJeCmahXVnlmty8cBU=;
        b=k/owywOCAVtgIaFozNndABGelcn4v++Of6r3Rfseq11jajisF+O8T86h7ZMj+6uDJ1
         4/PWb72blU/j9PyZ27zjTIAzQLEy1sQjFUldVEaBj00x6qzjB9L5tALVyMBI55lCpBUL
         NeraaTzP7ZatihgmVsSSxL7kZLhI+q1T7BY5JAUv0j0QxjNDSQNEBuXno7Hb705JHjWT
         DhKea80vxN3mYy8MP7nVLSZzmI4ry4ANlJauMTn0+xonVdphCr2N2vSAFe2FwVTOYGvL
         PU/asJCHogN7T0ZJiPqm7rIOBxYoceouVEvAJnuzteC4UfWWSunMLizD8lT3N97ZGAjZ
         Fj3w==
X-Gm-Message-State: AOJu0Ywl/36uZXr5qSo/+kaXRqC1NF8qwV9Sfux0BpfWX2xdRAm3Kb1k
	Mklbr1eSk70mX0HTvU8H9PwJzNBXkG8vOUG+F+3ayxAIC73cly2ABNjq/8huJNzDP6kvXkRbVyf
	PSGW3Qm2uxKYmcT/1D1osgCuNSZoPsYHR+NcmlUGD2A==
X-Gm-Gg: ASbGncsTrhGjsRGumTAs1+HwkWAzCwIxyHc9I1jhRq+i5Y+rmNA2o1MMcGWh2nXhdyv
	FbsKoW7l0ZTKskTpDIg/IGnlDlzRNl86vYx6ZImumqxgSF+5xMF8QZS3PVdhLxn6Wx+4pm03ToU
	bEm7hzHznW2+RuOOuSPlr3bnaGbblSyOJV+iewdMXk19NvW+Mw7uc7zu1aA1PxPWV58P3pQOBY2
	sSeLFj1NRIGJNXwdcEJPvGuzXZU99oKXmYNDHos1AksRMvsO05jT+Sjea/+
X-Google-Smtp-Source: AGHT+IFLA6qK67emnI3r/+0K97kMNI5gwxD1/rhmSygkn8geJv98fYFwYjHwP7mxFNoiS+2kmbVw/huQnP93tRr0CCQ=
X-Received: by 2002:ac8:5d0f:0:b0:4ed:b83f:7896 with SMTP id
 d75a77b69052e-4eddbd77352mr74696081cf.49.1763026732674; Thu, 13 Nov 2025
 01:38:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929130246.107478-1-mssola@mssola.com>
In-Reply-To: <20250929130246.107478-1-mssola@mssola.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 13 Nov 2025 10:38:41 +0100
X-Gm-Features: AWmQ_blm3OU1lrWKh6moqo6AjuEBiygoCRZ2c9tWVqcvk8C0yMuYS2IyumsP348
Message-ID: <CAJfpegtOMPM1ewvySr8d15rCCWVXGPYhSutF7_UGfE++6D7QWQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] fs: fuse: use strscpy instead of strcpy
To: =?UTF-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mssola@mssola.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Sept 2025 at 15:03, Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.=
com> wrote:
>
> Changes in v2:
>   - Add a commit to rename 'namelen' to 'namesize', as suggested by Miklo=
s
>     Szeredi.

Applied, thanks.

Miklos

