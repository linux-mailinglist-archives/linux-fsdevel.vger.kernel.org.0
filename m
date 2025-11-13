Return-Path: <linux-fsdevel+bounces-68187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB949C568B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 10:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CC484E6EBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 09:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230A82C1589;
	Thu, 13 Nov 2025 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XIfAo3Dn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F221014AD20
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024574; cv=none; b=LWztTsuwQe0yOmil3NF3yZAdWMdMUocXOmbLEzFpHTiUq2iBjM/lmHnSeP8JpcMuAmxZ43UufUJQxWRbcgbFtMVpSSOR93PEWfX9o7jw7VFQPnspJOhyWS3t9X3EuqBbtF8Zcj1DrGKurXvlB4KeBA47moH3NfXRLRNDtAvfuBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024574; c=relaxed/simple;
	bh=+2aYOVpOS5bBgpP7Z5YXww2cJhfLh4MenTeNlSJM53g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8b9g6E8nzm+CIFG+ZjSiZPfGjFosdy6iYLFr4p+c6ddWJY9o6kFixu6d8NFl0v7ycpRHteo8MK9HCsRV9f5M8s6FJneW7YSgFJTsb+cN8OpNLpKMTH7nHfpDtyBD096tSCx1l6Z0R/pHc2Jigu+VrNzkiU/Iryn1RHUJnlUBtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=XIfAo3Dn; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ed66b5abf7so19581541cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 01:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1763024571; x=1763629371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TWvOwrM4EIFLxWTAr9N2lYCmaASWWMPDLvVsazXwlAU=;
        b=XIfAo3DnQbdgRZ533BrkbyDd6ceYsOHsMztLiOcA4ibD11yYlXplJM5IdOhFjnyMyM
         catAXak8nPRgDPdygw4thx+SfVVbVc802MrpPYkGM5OFcWTIF3rtjETH9NQeVFxhUAE7
         zZ2bAIkO7mUZVgidSAhb8GV+y9nhjDPLsjmWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763024571; x=1763629371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWvOwrM4EIFLxWTAr9N2lYCmaASWWMPDLvVsazXwlAU=;
        b=cZrK1crFnMQvJPfIfOV6D9ADlK/m5owkIuFwg9DKY778TWcHnLOt/N7calUO5SKJNR
         mturMUXcIDTRawc765/B0TiTxI/teBzuhMLkBNRFnB/yWyLNSWcRQUvquCVz9+VK8Na5
         0LrZt3DBtSdrpugiI4M4GXS+yARewdAoPDMa8h6sRgyGTPkOlY2FpfgT65l+RVEwPKPD
         a/Z2CfkzHLjUiSIVVWX5PzRh+LgzXf9/zEDESHFLMlXa7b+EpWdTI0CvqdEpgDYl9zHO
         uy87l10J3tNtVF7z75XVbxs5RNJkASjCzRPdcsH28sYHHRfXaDR0DPsPboihuZl48Q/R
         HyRg==
X-Forwarded-Encrypted: i=1; AJvYcCXZSfpxU5oa5rbGh4zI3DYPnmufVQoOULl2Fv8orB/rYEb6H1SsDVBhqavqKNEZKpJ5atrrK6hNcZhQB8Or@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0A/yzVf1JPibG7UXRxswWvXLj6hqaAYBnJwt0FqRnYvh5hsR7
	BjqTXF43qPj5vbOr53V8vC7c+89aPr6dc1ujdkCAbcfev37AogldWfSChs4CO8WaqouT+H9zlur
	4SNRmsrzhxCP0j8/cKW+wzwsNg+e2vvCQ2xj2M+p0KA==
X-Gm-Gg: ASbGncv75+8P0kiMMKgpDrTjg0IYUL0T36uSEMO7+klqaR/MiYzYYd7cTJukfrZmhJu
	yyy+QqWdRwZzgW3bNrGic2jRpeZuwr5NETjxIMqvOKEMhqCq677Z2DshEs01WkyacXq/cwbQQHL
	hPGx1WD7Cf9iP2r7aOCZVhhY8xnGlnENQSi8XW/oxe5E82RqgWa/cvaNvdiOgIsfNOb4hraKN4x
	nksz7gCpH9+sFDUa86e49JIxfxcL4PPQ1tZSJKUi1M5f7Bi/P4n46MJo1y3
X-Google-Smtp-Source: AGHT+IEo1Nrj0O5OxCHbv8cWBfGc+J13Y2GimQJ/FIKMlV9fnh+jQ1vE/xUUtYsbyn/r3EbawVBwW5rbh8Q55a/XjSI=
X-Received: by 2002:ac8:7f50:0:b0:4ed:ac1d:42f1 with SMTP id
 d75a77b69052e-4ede700fea0mr40311301cf.16.1763024570563; Thu, 13 Nov 2025
 01:02:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916135310.51177-1-luis@igalia.com>
In-Reply-To: <20250916135310.51177-1-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 13 Nov 2025 10:02:39 +0100
X-Gm-Features: AWmQ_bmGnANqif2wG0mv6prd2r-EgODLdtrh0KU2w2tK4xhsFaImIUtLHlAvyxo
Message-ID: <CAJfpegsy78ZMkodX2+1Y9UiPZwY8dixstPtdcK0A3XphXxGbcw@mail.gmail.com>
Subject: Re: [RFC PATCH v6 0/4] fuse: work queues to invalided dentries
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Laura Promberger <laura.promberger@cern.ch>, 
	Dave Chinner <david@fromorbit.com>, Matt Harvey <mharvey@jumptrading.com>, 
	linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Sept 2025 at 15:53, Luis Henriques <luis@igalia.com> wrote:
>
> Hi Miklos,
>
> Here's a new version of the patchset to invalidate expired dentries.  Most
> of the changes (and there are a lot of them!) result from the v5 review.
> See below for details.

Applied, thanks.

Miklos

