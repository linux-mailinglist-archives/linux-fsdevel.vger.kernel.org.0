Return-Path: <linux-fsdevel+bounces-8308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40AC832B12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 15:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229471C247B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 14:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC245465D;
	Fri, 19 Jan 2024 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoT6QI8O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F0E54645;
	Fri, 19 Jan 2024 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705673549; cv=none; b=iA4rJ1wdiFWDvcGSbBo+PJLoMU8G3Vrnd3LWjmwCIv/6/B26sqDK/osIzkDPKw94mtT2Zqk9yS5oZpxQ9F7PQn4dW/+hlFb/0HxroS0I7/E1OEyU62gN+zgRVoXema/NOLc0uS/cQ5JI5r0Dg+7wy3zK/cpJeYMMa0bMcdXYkTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705673549; c=relaxed/simple;
	bh=/791Nq+WO0XaOtu1ign3A188Oa4NUF6ZaL1mxnsfSKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSicZ6M3tLJBpF2RKIjfTEaujMVHWuUVCsn8Ay7QRJ3zhWm5rSTi/sN2z6CXqOpSSOiTn3/PHSSdTBh4J+gRnYZxqEk1YNfxSMEmZso5f6waAF+Hy5ZTihQWY4QPifCKaiD+LnhmLdvudl5MU681Z1mrHTh5SDqGk464454HpIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoT6QI8O; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78333ad3a17so58517085a.3;
        Fri, 19 Jan 2024 06:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705673547; x=1706278347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/791Nq+WO0XaOtu1ign3A188Oa4NUF6ZaL1mxnsfSKY=;
        b=BoT6QI8O7oDcjSsJO6veXuikVuLN6Uy8fot32+j8O90P0acuYeXLMtMjM7D5/Kz4Xe
         VhqcFth6dqK0Dyj56vhi0NygX9NlLTSOvHTsFDjZAh5yfR5fdFCozloP7Q8qmxlQdpen
         sYnHub6xvkZmChEMjB8KryMK3GL49E5Z5KN1Xr1pTTi8vcRQ4L5z+ZbAKimGFCXq7tZH
         HkUkM/r9D0MYddi22I350bdVwLQArdGXyPcRdEoVqvcUophMOgMnSLoEZn2dHYiosmC3
         DaEOX+SHVpoVEQ7lgfTSr1cgRcpQK1HzS4Q8I1tQy1BoyjuxqTYzY5YJpd1me2T3BfuL
         0ARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705673547; x=1706278347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/791Nq+WO0XaOtu1ign3A188Oa4NUF6ZaL1mxnsfSKY=;
        b=Q/NZjiVG0ePHj8keSbV0L/so956KNe/kjpmkTmlgZLQyJFhMG3+mQZ9YzjMQNT0Bs4
         xNTmRhbf6f7c9rGKw7HskH8vGX+5b/f571autuKlF3kInG17s+GV4WntT30h1yPqIrvt
         K3VvSjP1XICnSlKJTK5EaOiZK1a0Zrh5GQfk86P+Rkb04u9TRGo0wVcyj2/bSftKDE+0
         LyHP+6NDOiRIRMImP2ufck4ZV/4yNiY1vJog5CUXRjv6rSH+n+pmJmeCNhbOYtYKujLT
         ODB8fTwxajaFEscU7bWr9opYIkvFWOxwjXNAhhNM9IBf1EpLkHprEfFQdAiPDfBGClhH
         22vw==
X-Gm-Message-State: AOJu0Yy+9WJy4Vx/CLCpyJwAJWHLy4OTjyzJIp0aN4vBMXTdEad4GjU8
	TIkeVwKeGMP9ZoHbjx2aH+cwArwyCCYhsv+9hzWKt41U9a6qEuCrvyWkE6CA7uEOLUGfVEvJ++I
	whQ7FPRc5fGhWGCrUXJVLeIqZhcVuj7jOyiY=
X-Google-Smtp-Source: AGHT+IEdIv+xO8p8RbvYypxBJ1mIVf9zj01S2p3kjWp7eUSXlgeiz/VSHJLCYf86QQB6f4zR+D8jF5LuG42088mSPA8=
X-Received: by 2002:a05:6214:ca3:b0:681:7fbd:cf2a with SMTP id
 s3-20020a0562140ca300b006817fbdcf2amr2515137qvs.61.1705673547337; Fri, 19 Jan
 2024 06:12:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119101454.532809-1-mszeredi@redhat.com> <CAOQ4uxiWtdgCQ+kBJemAYbwNR46ogP7DhjD29cqAw0qqLvQn4A@mail.gmail.com>
 <b50d431b154bdc64462e561d9da8f04e53f1603c.camel@redhat.com>
In-Reply-To: <b50d431b154bdc64462e561d9da8f04e53f1603c.camel@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 19 Jan 2024 16:12:15 +0200
Message-ID: <CAOQ4uxjP+smqWY3uUXwT6x2cpUn_ZXOj2kuSUV42sbN4qzdaEQ@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: require xwhiteout feature flag on layer roots
To: Alexander Larsson <alexl@redhat.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > Alex, can we add your RVB to v2?
> >
>
> Yeah, other that your comments this looks good to me (and I tested it
> here too).
>
> Reviewed-By: Alexander Larsson <alex@redhat.com>
>

Added.

Thanks,
Amir.

