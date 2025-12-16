Return-Path: <linux-fsdevel+bounces-71458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDE4CC1F16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 11:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AAA13302F441
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 10:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E9B327C02;
	Tue, 16 Dec 2025 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="P/JAYxmd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B181924166C
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765880382; cv=none; b=UCWzmXcbgOBMzT8GE9yZiotPpFycOW0pqGKwmpXoNKAJo4kcCiRCRHF4AjNEsgF+Bzp/8xqNgae2WYzGtHoS315bMzJjUc0FDszEldL8fzwaqodZ8i8g388vpj+Z3FShvlCAib1F8qTmvpzlGhc/9s33df46WaYaig0HAcFaL1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765880382; c=relaxed/simple;
	bh=zLcBDGZL68xOfBUpcW5rRUPd8zlDRU7zV/KqfTjRLR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfz5ctE80bs9hz0VIi4iNl7xR7A2MNWW7Bw1RxI4kRPa7KMoQ94FDq673eav2R8L4uJpkTv9sXdrhdcGFSaE3uanp95oFw6H9P1TEeECZtX1foDs7Jh1z8SCi2vNLxu0WcR5lX9zxRDKT3Kw76A56EbZbcJtBaQKmbI4jTDV3Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=P/JAYxmd; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4eda6c385c0so32495241cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 02:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1765880379; x=1766485179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QYQNXOQhQTvFjV/Uq3J4HQg6XCg4vYnQAKRJDYR4z04=;
        b=P/JAYxmdsOpLdIHz3mkYYYT0lRS+GZ2efktVyYTuCrfMD42N3JLVWx8oGF5qp3mUsn
         ciqyGF3P/Q3N+0feTIjAlEGXAZFHOWQuha2hxWlurwAzq13g/UMv/rN32ryaP8qKQng9
         +Oe/Ia3BQYf6UOvKSDaAYwV9odVTDAD2Jd2Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765880379; x=1766485179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYQNXOQhQTvFjV/Uq3J4HQg6XCg4vYnQAKRJDYR4z04=;
        b=jIMtAUKlFtXBAsF5X/VfZZQmM0AbK4bcRgPHmCboCPRTIGDBo/CV0vBPZSzjy6ZAyG
         knmSQjbU3GguUSQ9Z5ehPudcLhXLt7axQRdFSP2Q1L+BZl4hIE4OnzZzpp4kDHG29Uj3
         +F8x3iuFtOJtdARBJcN4a2qxtpI4Wttm1z29qh3bnLyKW9vvMwIeRwOXVhT9pZgohwi4
         HvU1b3OKtaUZVjALfB2rZPMvN1SBb+bKD1S8TzyT5cHDz0sfvvgabsa45JLm6tYczvAz
         aAq5hcICn8CzcEKXoAL94RfiZJzd0Y7NFm4qqnicKiKQCZGOZpy59StGHo6azKzwQhh7
         KryQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWrXBcF+y32UXrLKwwLqhJQkAUa6QWNXaSCOVsZ/JO14jvoVRTqTn0vpal40lOG0yzL4gcQqth19696mAN@vger.kernel.org
X-Gm-Message-State: AOJu0YwdQRCMw4DvC67UdmF8ZN/Fj4F9oi1PXigpvtnD3EDoQNkHvZz0
	YeM+GY1gasCeJ8GVrKezXvFXsmvkEY/8V8sLrJMis0cYvBT7eA/vltDSKIW1bn4JWiuWwy8d8aO
	/uaha/CwOSBtIsjBC8Q7iMERD0naS9HmuFQX9DCApXw==
X-Gm-Gg: AY/fxX5xhYueLGTxXMuIz2TPK2KJ6/7GgjsQR2QCmBkXpI0zEZShKjZFJx1Gf0FaPfo
	E5VfCZkt/nZNwPrqzFsxjDQkHEEuBsVmaKbBhBfzZVOWimaD2fz9TMZOAADk0ipJyOyaCXzdchp
	XjJ8ui8IE98j1QYW5oWUgV02xpZewA5KkhqtGihz4gYU0yzAR32TvE5Sa+xvFUgLHSBrdIxY1oj
	1TY6gkrbbGtFrw0cGSxhHPiYdp8Fr0TNPye8LvN3m1GOhR15ml/JmSvoihX1kcrcwTXqQtHeNde
	RWRQGA==
X-Google-Smtp-Source: AGHT+IEiP7nW75k5Dpqa86saxf7N1TX2bgHiytxthfWAsfFogVs4Mdp/+Aa3hacSbWtOaeCoWUa78IQo2W+Df5NIwa8=
X-Received: by 2002:a05:622a:1c10:b0:4f1:bddd:36f1 with SMTP id
 d75a77b69052e-4f1d04a0c99mr163290191cf.18.1765880379418; Tue, 16 Dec 2025
 02:19:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-4-luis@igalia.com>
In-Reply-To: <20251212181254.59365-4-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Dec 2025 11:19:28 +0100
X-Gm-Features: AQt7F2rokenvk5sM4EN1UGDF0w-Wkc3c6sBOB52VNsHQH7g_BswzwiKpX4gSxjo
Message-ID: <CAJfpegsoeUH42ZSg_MSEYukbgXOM_83YT8z_sksMj84xPPCMGQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/6] fuse: initial infrastructure for
 FUSE_LOOKUP_HANDLE support
To: Luis Henriques <luis@igalia.com>
Cc: Amir Goldstein <amir73il@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Dec 2025 at 19:12, Luis Henriques <luis@igalia.com> wrote:
>
> This patch adds the initial infrastructure to implement the LOOKUP_HANDLE
> operation.  It simply defines the new operation and the extra fuse_init_out
> field to set the maximum handle size.

Since we are introducing a new op, I'd consider switching to
fuse_statx for the attributes.

Thanks,
Miklos

