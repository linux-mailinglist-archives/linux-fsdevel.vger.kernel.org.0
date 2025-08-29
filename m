Return-Path: <linux-fsdevel+bounces-59614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A0DB3B34E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 08:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E572B1C826F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 06:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7F9239E8B;
	Fri, 29 Aug 2025 06:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="A0jgsaUu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945051E766E
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 06:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756448702; cv=none; b=enDrNvz9GTVOwEeRXaR7vJpNG+HxBwExSFIZdGXZRIdpuOvkiVRDXFF94zOlyqa0zJDapSHl1iSjNa1SZi/u60CDGqWwy4B5d/xn2vEuQebcLDvLYBC/tWNP8S65z0dzUspW6ocsWVwxuedKK5tlX67xGl9y/UtbYmxahWhFKDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756448702; c=relaxed/simple;
	bh=ch38jeU0xoXCXvVz2ghiL9KPblQ6aZX/CSVmk8WK5YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8jQ6UHnWkbBdwzMR0lJIrsyr6rhxBaHXdzjAVVy12ts3vmCQ7AWDbdGLFP6rQB5j36eR4Mx4EetWw+E+Bm4DbEs6GYtKJZ1JiqpsTVkJ81MJHicRWYfALSwWZju3kDWqw2jbAvAimlYWhrFJVWNs2nEi/c0J2kO69pFkUyOlPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=A0jgsaUu; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b2d501db08so23738001cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756448699; x=1757053499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/tpVxCW+Yl0SuSh+/4WXOPLu9YY9SmePW3yYiVIwB1w=;
        b=A0jgsaUuXobd7NVRMHuMZmxA5erGmhjGXTokW9saULWggdqvUcbMYNhaTyykKitzhr
         8tzwv0OAbJ9lysmRNVkPS8aJmaAZ8Mv0ByNLfovbkW0uoxKX4hMQrUsPgaEP0AnGYVsj
         szdI5ClJxs5O6aQjOH84zRoqXn8tYbNkaFK0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756448699; x=1757053499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/tpVxCW+Yl0SuSh+/4WXOPLu9YY9SmePW3yYiVIwB1w=;
        b=vOctWlLD4GULlm9ryoDU6VZeKIwsUBcTBmSMVtyIjNbAwg62OalpsV7h6wXNbQtmCl
         jkuG/v+q5ilPe5FA2ROsu9plbISFK695C5AmwdlRRXKvggFvLH9zsOZodJyBaj0fD0qa
         eNJpFXxvo5OQI3YWjAIg+y465Oia8RdEQI1TZjnuOISeAzkKGaRcV/M9oTKuIoMXBtea
         CHaRkVqcD0NA4OmqbtlM3zfRYbcBrvLyi1dQjaiWI2k0J0Hdso2tTWkqiSpvu+ED7fi+
         D1xVobjgJVjZx7t7akwPC/7vjyKgFP75pbvDMxokAHAGP3C+rxHNz0xmHdnmOTvcMa40
         sTNw==
X-Forwarded-Encrypted: i=1; AJvYcCX9lAvI0sRllPUXLqMlFsN9Y2uIXqmQz5TifNBsjB8ALg+6nnsUYTnX6Hpw9JRYJT93RuGkgZIpyG8yeaB0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw81wZKmMJSs1aiCKqfRMXZxox9tmwBu1p+oEY+25BwLrPxgP1M
	nDxPIDRBq6vekecWDX2YsKILX3WnHXYZ145P5fz92C5/YNcN5r8Mw1Yxo8awPeUoUO3r1D/H0uq
	io3Y2JOZMDl0/x1wKxx2LUF71vLN1PBbUBWS+8g3Y9w==
X-Gm-Gg: ASbGncsO94Wwsbilg/P45pW2yO70YpN/QStZOnYv4MCuCH/pAYTwXg1jNF/k/knnjmO
	EaT5E0UX7KXX4+afON1DN2SjAVVy4Dm2kXOmlG7AX+JLiuKaSVpWFfSQT6VSyC9PQcLuk1+D+Lu
	IhYLY2bVEYG1Oy0AOeL2CqWTmLycqd19V9l3hi6yjom3E8nv7bBsi4j+uVBvcK2R8/PDQ7aiRg9
	sGz4JXm/boGXQEXEDHo6lOS5293ohbeKaxSebk8y1ArH+gRHgQ=
X-Google-Smtp-Source: AGHT+IFc2fEMzj5bBsXEOmczH7ZP57DmlmV/y060dDespXnhXJLOwxVW5LQkY/MbpmBCkEymsW52yc8DyMbw8kJw3L0=
X-Received: by 2002:ac8:5a12:0:b0:4b1:103b:bb6c with SMTP id
 d75a77b69052e-4b2aab06891mr288731851cf.62.1756448692979; Thu, 28 Aug 2025
 23:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs> <175573708630.15537.1057407663556817922.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708630.15537.1057407663556817922.stgit@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 29 Aug 2025 08:24:42 +0200
X-Gm-Features: Ac12FXxgO4ONGGAQx8tnAMI0d3utL0N8xy8MEf5su_4q_xgfCN47Nkvih7sICUo
Message-ID: <CAJfpegsp=6A7jMxSpQce6Xx72POGddWqtJFTWauM53u7_125vQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 02:51, Darrick J. Wong <djwong@kernel.org> wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Actually copy the attributes/attributes_mask from userspace.

Some attributes should definitely not be copied (like MOUNT_ROOT,
AUTOMOUNT).  This should probably be VFS responsibility to prevent
messing with these.

I guess the others are okay, they can already be queried through one
of the fileattr intefaces.  But think we should still have an explicit
mask to prevent the server setting anything other than the currently
defined attributes.

Thanks,
Miklos

