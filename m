Return-Path: <linux-fsdevel+bounces-45550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC337A79525
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 20:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA591890A37
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 18:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FAC1C7009;
	Wed,  2 Apr 2025 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gvb7ZoND"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E99A19E826
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743618816; cv=none; b=N2CEPp6Xmnu7ciinl8VYS3hU7cEO6BTX5U3ckorHa2S0b4rtqr//VegUrIbnCxR7IlazH6k90euybRJnZlCTX/71qKgzZtGVmlliXBxuZ2Ei78l8Y1bqfKyLDPyGAwEk+QW28uiEGnyz+vbISjIHoxfvXL7TwwL+teK+ZfpgrGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743618816; c=relaxed/simple;
	bh=wqi6nGu8pUXznFhgWtoqTXFFKD9sn7Y6HiqC1464LAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mb9ghrqucV8SI0ySh1dNa0xoN9/oRx8gml2gn5UYhIxtWTVbLK70PesnCFpMwxJMCduefkUHieWRgSHRCyl6LUWsbcFYAImFQZEh+mps3sVwWFa7Lh3uIg1MFiraxlacBHEmNjftxPIr1mD2AGXnA/nuy5Jiga2+HNS1GObo2qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gvb7ZoND; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4769bbc21b0so413961cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Apr 2025 11:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1743618813; x=1744223613; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mh4t8UhrAnxvgxnJaPo/M7iBrdK2Iqc4GNc5uJL4yPc=;
        b=gvb7ZoNDf+7Rv2KW5E2RpnHVOhDtj6L95Z1ErAFbeJih2DvINxgbU+DFmjP9Z8ysdB
         qafetjqaKZAB+azbemJ/un2qOstbcl7+Ww9cnnI29Ul6aHt3qCFZtdtFJKRBV4y7RDqD
         JGXNCMi65PdCKlEYYX5Ztud8fRmCBANBZW4m4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743618813; x=1744223613;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mh4t8UhrAnxvgxnJaPo/M7iBrdK2Iqc4GNc5uJL4yPc=;
        b=GjphBPMYP0g+AYQBsqmpqkFUQknbM6bd6QWnGjTZv6cHpuZxEAzeEikmr+MeVGN9IO
         r9s0l5QFRFiW7L2+xFgatehvfmLUb/TAt6xDr9Fu8FJTI3pVggIv9K9WA9y3rjy3TtsY
         CjicsKJ181pa7tAOiBHcwxhn3x4wK99WxeLsBsPttqnnko8ytaP40jJUrMy98wzNOjsY
         oGbTnmqO20JKSwBjk0cPbA/kz5/3U+9DFNzomSi2OYChyJp2gqXfEKz+Z0B/JhuOmOKk
         36duifgamd3NUAP15cBx4SNamUPoq1mO+f/G09rWCQYzs3Ldr7beuarQ2yW4xTUtQ3J+
         S5dw==
X-Forwarded-Encrypted: i=1; AJvYcCWm2S/vX2uGrS0NYws3f3RUPm8xUIoEpZ5VBrSuXpR4/at7oD16HixCdpzWWm/VB22/CCLF5j6W8vsUtC6O@vger.kernel.org
X-Gm-Message-State: AOJu0YyUpUkFV9AI4LBt5a4cAFSGjFdiNay7lHSHGw/MLalllWCT20BC
	LOkJX8cHzBFOhb8bEHH7CQnZp9tTe+NUGffdAw4teRvU30TFXa2ntG6s3E+sspIBMJ7RzS41UYl
	GGFUYcI+QhkXdyxd4oMW5RILnT6YSD52AagPh0g==
X-Gm-Gg: ASbGncuQMGF0fQaIM3h+FxFJxnQOEfbxsjlqD6OqsfJ43Rk02HZUZaleKimErNxP1jR
	wCoDZnoZYPq0ApX44j4I5XAwPujVayqAPKlFqWF8Vsfm/Fz9V0BpsTa5JQSkhqAukgLOjUF6/1b
	xZQH98j3TbHx+2AXI2/XKjRgdp0Q==
X-Google-Smtp-Source: AGHT+IEVPZGuS7E8zjeanmyoZ0TzSSjqi4+yIa9XqOLN+47hqk465L+EhhgZrDVkMbJ7zCmvXdyGiiVCRBD0V5vYbYc=
X-Received: by 2002:ac8:7d45:0:b0:476:9847:7c73 with SMTP id
 d75a77b69052e-47909faa711mr47825501cf.26.1743618813131; Wed, 02 Apr 2025
 11:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402-fuse-io-uring-trace-points-v1-0-11b0211fa658@ddn.com> <20250402-fuse-io-uring-trace-points-v1-2-11b0211fa658@ddn.com>
In-Reply-To: <20250402-fuse-io-uring-trace-points-v1-2-11b0211fa658@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 2 Apr 2025 20:33:22 +0200
X-Gm-Features: AQ5f1Jprv7glnIoVkEmyhn6zcWHQ0FqcM2qwTL08mG-5PlqMqZbpYTb-Eiw6jLE
Message-ID: <CAJfpegt5VGcSPOFA10YhGq6W+pZR8m+YEfhLSL8uFbJhqT7kuA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/4] fuse: Set request unique on allocation
To: Bernd Schubert <bschubert@ddn.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 19:41, Bernd Schubert <bschubert@ddn.com> wrote:
>
> This is especially needed for better ftrace analysis,
> for example to build histograms. So far the request unique
> was missing, because it was added after the first trace message.
>
> IDs/req-unique now might not come up perfectly sequentially
> anymore, but especially  with cloned device or io-uring this
> did not work perfectly anyway.

Well, we can try in any case.  It would be a pretty insane server that
actually looks at the h->unique value, but not impossible.

Thanks,
Miklos

