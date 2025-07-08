Return-Path: <linux-fsdevel+bounces-54306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A99EAAFD94F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 23:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9C81C26801
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 21:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E882459F1;
	Tue,  8 Jul 2025 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp0ZdoUe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CBF242D68;
	Tue,  8 Jul 2025 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752008979; cv=none; b=XuhUlPn661N1cvjZRa6llgmJN6ikWSAcmRVG/Npdm/BMXggHKrFnj0Tlc+xyjXCcOsbwVcpHKYB3XXFOERboi9jEfiML+mJCZvjcy2lq2j1aKQuvDApb+ycA8dcWki/IyV66xxz6n/DP1sB0Rqn5mspwsjxnMiYimmpLSDWEnaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752008979; c=relaxed/simple;
	bh=QWLNdLsfHgBYTPLJ8dN7bOMak5I+rhzE/h8J7IQXbqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcEgLG2jKeM7npwYhOHUPPvBRFuaF37TnyXxA2CXbs9k25pJ4rW2hjH8YgG5QmG4QX9rPwhwcRxv+Afn+xUHNolYR3jVAStAKdMbYzZYwMzt+QZ6mwiuFGFPwiMljVhT0o7+QSmGsGT3W6swq0gnRaKa1pg1+yEK+O6YInXTWiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yp0ZdoUe; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a9bf46adedso26468431cf.2;
        Tue, 08 Jul 2025 14:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752008977; x=1752613777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ialp/oquiA+rEtbsg9r8WrpxV/qZnDtRKdb/P4jXX50=;
        b=Yp0ZdoUe3GcecY4nfds151s7Mm6DCVhfM/Hb67itB9iLL8ti1Z0hkYzhZLKEzjd1Jh
         EjfClPy/2n4YpTeoMkNQlHyw0PXtEgR+tRrs++0a9UBdlZHmcUJmvWTx4ufdcasKDXRF
         8YQVqeLdPJXmyQvI4Lf7JwIP5mH5nJNwnWDC+5NB9BBijbZxLVF6DeN8hUbdchG1Iod6
         Fd6WfwR+FH1xhpM0Q3SoMioV/rKiSpD3qjgyv1Ee+ElJS8y1MgL+MeoCyst5Lcyd7fhI
         BtYoUEH/rAD1Gbfcn/DFQRFCzPCFqnyRp+cmzOWgSE6rm9LCY3onx+SzNIgVUfV03nA0
         106w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752008977; x=1752613777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ialp/oquiA+rEtbsg9r8WrpxV/qZnDtRKdb/P4jXX50=;
        b=bZCIRZOBxvc9QaCTHdWvq68/eM6ELu2TzIL3VdY+pQE/8a8XIa48SO4cD1GGUxTlQH
         OaNc2tV4CLZcJA0Ek2vuvm1OIijMA5rd/kcQ6UECmaT/pzpEP/dtZPQOJOnkzxRRQfZf
         ck5/Yq5kWC4wAU9+n/nQHcbRHjBAiIowIulSumPHFGxuwq0ADegvlR0tykAp0jD1V3Vd
         dniT53AEsJcy7QbpEg6Jx+YtMTsk5y0TYPwALcAYQiHwsZzMoGBwez0wqds/nR1IoCHg
         qDCX9k5ZuYwrmy3gAEBjkDMByWVt4/Yt5Y0I3cbrGGYsFAub/+sUYCOpbTNESZGDqmIT
         r0zw==
X-Forwarded-Encrypted: i=1; AJvYcCUuTNEBpKLnMfVuX2+OP1qO33/92WxkBz7jaeCAXYrLbMr7rWX1/z/BjAFmYwQAkUfacNA43fpEG1x8@vger.kernel.org, AJvYcCVr2QYbSodOCQ0RMstqHm/yrzDEb41sCrSRkFwhzGr0CXdjl3aZv4vTn45gRjUOYRhf2TP6e8wbT3nk@vger.kernel.org, AJvYcCVviw72kxcfV6ezsVusnOaRpya3XZI2SajmCiNirsJUnYffb2v1fvyLxfTCdl+Awl0ayLZmX+bvZaSKKA==@vger.kernel.org, AJvYcCXVeggF/tLIRcEYzrUhEoyEXU5sufdty0q6qX/lf0MZCidqtCK2/FoMdcivaoZ5ww3+ebrHd4TAPwmd7HPUaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaK49e+Fc8ce4L4jwAAwpgrMbEIjW8FXnufOWVBfyb2obPLVJf
	dCoWe3ASm39hCKjNQw0hPEkHXYBoqKsuxUlQ4MikjcwRGFSOg71l6ngglivqHX4DZgLq+vrnCkq
	iK+vgWEJa0yjdsyvhVR8lFaeRGXUtyv/zqNReDy0=
X-Gm-Gg: ASbGncu4zA5aSCZjMZULMqGlRFKDq0w4DPr2/iF4vrzSZ5DZ32zq6jIe91kaZWl734B
	Egp84VVaIxMXHVraG71Zxbr+gLl7IP16Ez3xBGv5M4JCPRC4pD8PD3k0IFcy/nD78uuzHq7B04U
	qjL0t2LQdx09MW4QC2Cb8MK4M5FwxbjTIEhgXJfoGxZfg=
X-Google-Smtp-Source: AGHT+IG8Jxilvarnzqavf3sYJxobHNvcI4fkp9fkNWwp0crZArdntUIdq+T6S/aPKzK8d0h4ceDCQNVW0Iz2g0YtdpM=
X-Received: by 2002:a05:622a:1143:b0:4a7:9b9b:aad7 with SMTP id
 d75a77b69052e-4a99885b516mr321562271cf.49.1752008976611; Tue, 08 Jul 2025
 14:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708135132.3347932-1-hch@lst.de> <20250708135132.3347932-2-hch@lst.de>
In-Reply-To: <20250708135132.3347932-2-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 8 Jul 2025 14:09:26 -0700
X-Gm-Features: Ac12FXwl0brNflKWwfGY6FaTYwWdG-adXu8EY6-C3m2Ipq4pCXjGyAu9EGigUko
Message-ID: <CAJnrk1bmQzsUeWTRaVfQNNO4C3eQ3Pw2jdk9v-r2VEa4tr1xxA@mail.gmail.com>
Subject: Re: [PATCH 01/14] iomap: header diet
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 6:51=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> Drop various unused #include statements.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

LGTM. btw in the 7th patch when the ioend handling logic gets moved to
ioend.c, #include "internal.h" in buffered-io.c can be dropped then
too, but that's a very minor triviality.

> ---
>  fs/iomap/buffered-io.c | 10 ----------
>  fs/iomap/direct-io.c   |  5 -----
>  fs/iomap/fiemap.c      |  3 ---
>  fs/iomap/iter.c        |  1 -
>  fs/iomap/seek.c        |  4 ----
>  fs/iomap/swapfile.c    |  3 ---
>  fs/iomap/trace.c       |  1 -
>  7 files changed, 27 deletions(-)
>

