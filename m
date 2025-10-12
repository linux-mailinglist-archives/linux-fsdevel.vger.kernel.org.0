Return-Path: <linux-fsdevel+bounces-63856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B114BD00C6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 11:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DCDF4E2ECD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Oct 2025 09:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2084225CC7A;
	Sun, 12 Oct 2025 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1XFtdMy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AF525B662
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Oct 2025 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760262053; cv=none; b=OmVjPKon0BdEF1JxC8SmhD4g4FgwjJ3b6eObqZFCDcCkRFXpEBwC7TlcKYbN9ZnuCsO0dvXkQJTF3/zcRYQ8PUJfjIcqkxKElpZx5b+nfyW54mvKTBsDh2zwdXnQVrlssfdXvM4bk1rTqrC9rdjAy/zu10yUxocGj9P7HNfHh00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760262053; c=relaxed/simple;
	bh=z7VfEU1r/Dsm5nX9xRER4JSx0tzCPxyJY1p/Ak7It8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRG+Uf9NvVPyW2wxYPaLpwJNYAPEyxnJA5PGBH4I4jpJPT2AO8cQxvgdntkxr+QZdJxzDre0R9b3kSX16bB1ddXPdi1IkIoEKCWh4CJhXzdefaD/5C0iMa72V1KsF27J+i1y2gI4PTHr6njl+xguLLa0lpPwJnPTZakEwu34vvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1XFtdMy; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6361a421b67so3388330d50.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Oct 2025 02:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760262051; x=1760866851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z7VfEU1r/Dsm5nX9xRER4JSx0tzCPxyJY1p/Ak7It8c=;
        b=G1XFtdMyksR1fYnplenpnBJg5rBXUydVHsla0P6iJNa24abdMdwoDlXEFMl4DTXxuK
         vOM42xlKw9o8u6TNMVufuifNrKtXHoRLrptjjBKV19CJxnSFaJ6fdDNa8uIELOLlT+qa
         AMxajuq51KVU2BjmcldJ85GiyPhC8xO/Cm/wxN5jR2kC9xWPJ4o7nLZrfH280OcmLGTr
         pHmt4+S0u2p2SkDh/aoFiVxRuTy2mmA2FLzaxtcZfc0R4x8ymELgZwZ8OixTxnPrnfaA
         kTqVrdbWrlaB/zrl+kf+AK/mmv5TMdaaLLFQ+N42Waj8bO8Djb4j29Bjb/cF0565bPUK
         Kj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760262051; x=1760866851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7VfEU1r/Dsm5nX9xRER4JSx0tzCPxyJY1p/Ak7It8c=;
        b=pE+7pYN22WTj0yoo1PeAmjIgkmeteHDpp7QbsdHDCmANii9+XgPYr3pUbyfhUs0KTv
         2+goPE3yZ0eE6WPOoLedQKOS/NcVaO2rVgrTugYgglUcJzfr8IwRRQNWdVFU0eVYpeQ8
         yKp2sbGLCCr9zuh4fIcmHGlRHe36SR2cGVUsqDTE40YobMIhv+P/PE+brVLLy6TmXl0i
         erm4ACmfrosXaai8XB1iH4IjWf3Kphw4/mCeOjmN6fUfnqymC1sRag2wEXCXHp3AKA8q
         o0FAuHKwLJnhz4hT2HKmv6iGEEIE4+aQkefRSIwfQ9jglcdtITXOgtAJYE+HgFQb22Iq
         Nxng==
X-Forwarded-Encrypted: i=1; AJvYcCU1KR0Ov69lZiFwx1I+0qacFbNwXJZHBkbjXQuHxI4ONKFGGyOpvs3t/685PeOPHJfXFETMZyeaBW/C2IFU@vger.kernel.org
X-Gm-Message-State: AOJu0YwAqyR7bTXXYBk212fS+NiSQb1zmO6oe3VJlOrMNSRL9txO3Hmm
	SvbeoJE7lkypjRk85z+wuo0ZED3DuhWbmhKbOzUa1eNAEvyIMYRIsMDlUlA7RwYyk1fguHqGpm2
	YqSKxYsZAWiM9ELRkKMXdIomXKUXqPS0=
X-Gm-Gg: ASbGncszDmXkF/fPoMi2TfJVDNAG6DPqeAAwrWn+Ej8uAxKmpCN2UcHGK/ItttTDiU1
	yFzKElU42PucpIlpcJbhWlDWkJUq1oBj+q6gPtQ1L8yv/loUAs2kotcqutJPa5edxjqO5xSGe4m
	GYZMrLSV8XzJCyrrptnfvqM1RQTQLvp1McITxkcWzDRFsGUHK3XqObx3VY4brd3aPBM8fdKqmtp
	SuOBGmATALCXWVkw6zKlRJYLjtr3nM2aEZe+ULjhC6SKhsMNl6sm7tvPf/KlC64DA0fOJo=
X-Google-Smtp-Source: AGHT+IGHFLSueRL03cNaK2/yCt+aziBSAitQz5o5MUcbkq+Q30p3V5Ti/erI1KZyKhu3zJtqr6MsmGi4UpMb9vOyMVI=
X-Received: by 2002:a53:b082:0:b0:632:ed6b:754 with SMTP id
 956f58d0204a3-63ccb825bc0mr11483728d50.9.1760262050847; Sun, 12 Oct 2025
 02:40:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMw=ZnQki4YR24CfYJMAEWEAQ63yYer-YzSAeH+xFA-fNth-XQ@mail.gmail.com>
 <20251012061438.283584-1-safinaskar@gmail.com>
In-Reply-To: <20251012061438.283584-1-safinaskar@gmail.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Sun, 12 Oct 2025 10:40:39 +0100
X-Gm-Features: AS18NWBvP1QrZ3o2ndrItBzM4K3K3jc8q5I7qUu-9SsQvSSAU0AmLtP7SyKdnS0
Message-ID: <CAMw=ZnSBMpQsuTu9Gv7T3JhrBQMgJQxhR7OP9H_cuF=St=SeMg@mail.gmail.com>
Subject: Re: [PATCH] man/man2/move_mount.2: document EINVAL on multiple instances
To: Askar Safin <safinaskar@gmail.com>
Cc: alx@kernel.org, brauner@kernel.org, cyphar@cyphar.com, 
	linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 12 Oct 2025 at 07:14, Askar Safin <safinaskar@gmail.com> wrote:
>
> Luca Boccassi <luca.boccassi@gmail.com>:
> > Almost - the use case is that I prep an image as a detached mount, and
> > then I want to apply it multiple times, without having to reopen it
> > again and again. If I just do 'move_mount()' multiple times, the
> > second one returns EINVAL. From 6.15, I can do open_tree with
> > OPEN_TREE_CLONE before applying with move_mount, and everything works.
>
> This sounds like a bug. Please, give all reproduction steps. Both for
> EINVAL and for non-working open_tree before 6.15. I want to reproduce it.

IIRC Christian said this was working as intended? Just fsmount() to
create a detached mount, and then try to apply it multiple times with
multiple move_mount(), and the second and subsequent ones will fail
with EINVAL

