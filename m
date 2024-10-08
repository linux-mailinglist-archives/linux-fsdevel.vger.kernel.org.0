Return-Path: <linux-fsdevel+bounces-31357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A03F9955A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 19:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7251F261E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 17:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0CA1FA260;
	Tue,  8 Oct 2024 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LVEG2euN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136011F9A9A
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408589; cv=none; b=EZcy7cA/EWFa6WshY3354RKfRL0eLPin69iVqGsILlJD6zOpqaqg2JOkgFiC/onIAritUUQVjS6Ky45SOgLZCSs76OhDBQCBd78dPvhyVFYyzmllce5c/ABMQ8kJBbC4FTgPcNqKmDvpoFroa3Qd+qZSXAlgHSWK+990yG+a+cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408589; c=relaxed/simple;
	bh=wSzJvZVTHd7+YmRM3awZcfGN3GiZns966yZ33wD2sb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZXjck8vNAm7ueXiWATTaAXsIAtaY4/QFYhiaMQh3Vk1XconH87tkH11okt4fCCfaH+yFpfEr7TLP0zR1buBy4u75gH7G5DKDX2DKOTOffmB3NdXtSv3DFxxyXeHDBeqL4mezpbmOdeDHhhagB2ToAiubA76rmT/rxY3Ae6+NUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LVEG2euN; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5398996acbeso6635937e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2024 10:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728408585; x=1729013385; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9S+19Kd4HHaDp0BIocGtLD/Km98j7MUve8vt0hS5nao=;
        b=LVEG2euNXB+Mk7DPtg/hePrf6LRGM8JXHCXRaVBeC72fHn4tJZvfUmEEwaxpfOwrC8
         Z/Ug7CzhLmgBH2EG5Fcv7+aGS55NRfnOZDWvTnQQsvHPqDMiGCLRh3kuCPkZZZ2ccEHr
         Q+ewTiLTB5UNwYnCXb8nXNfg3YofwYO2bQrIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728408585; x=1729013385;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9S+19Kd4HHaDp0BIocGtLD/Km98j7MUve8vt0hS5nao=;
        b=xPp21cpdY1rCkzE3HT4nq04Py5AL+TWLiMEZMWC+5YUxo6tEoPSrqYbukoaXO93qct
         jBq+uA99hA83gnt22grAaWA9SIhD1C3Wvas5DUz/ocKkqaNNkCfWqjzb92GjDfxBiAjI
         zjUW2bd7HzQo8mnaWfiy7zPRRfFBHUwZ3C3hVVIeRskiHEdgTrhCrL3ntXI0mqwtdq0D
         QZ87gsejvYGRhqveF7WLRppsABSkE8zGwYizcd+6mD786BhIggkm4n8qJuyT0QsFFOL4
         11GsLePBWQ5ga3AYfyfo9XCqh38upjx1fiv+nh8Tvlu8DyeBOW8/coZ+9iS6q/IYQFro
         t4+Q==
X-Gm-Message-State: AOJu0YwqY7eJ5sVBpOKYUupTuQUlm25hfBCEOxHYlZyrb/aTf550lJCS
	WI7m+9iCvwuJVqunFSF2q/RHB9FnOo3nFDVzYdzuJ6mdy87DoupH7oCmeTllbNOTRcL+wgd2VhE
	koK4JXw==
X-Google-Smtp-Source: AGHT+IGMM8tFxALSSZnXN31QcA1GuGeNEat+NCOhBVHttA0fVg/edFd1HWBsyFbC//wPIHJKg0NBEQ==
X-Received: by 2002:a05:6512:23a7:b0:535:6a83:86f9 with SMTP id 2adb3069b0e04-539ab9f54eamr7419196e87.60.1728408584942;
        Tue, 08 Oct 2024 10:29:44 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eb4b9sm4524001a12.75.2024.10.08.10.29.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 10:29:44 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86e9db75b9so909588066b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2024 10:29:43 -0700 (PDT)
X-Received: by 2002:a17:906:6a25:b0:a99:6a5a:bba with SMTP id
 a640c23a62f3a-a996a5a0e0dmr273249766b.2.1728408583422; Tue, 08 Oct 2024
 10:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007-brauner-file-rcuref-v2-0-387e24dc9163@kernel.org>
 <20241007-brauner-file-rcuref-v2-2-387e24dc9163@kernel.org>
 <CAHk-=wj3Nt6Fyu_YYuNoa+Xi4h__MxAjJs5M3YTHvTshehegzg@mail.gmail.com> <20241008-gedeck-jemand-ebd8c1bf2737@brauner>
In-Reply-To: <20241008-gedeck-jemand-ebd8c1bf2737@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 8 Oct 2024 10:29:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiL9hj0AyqXW1qYnu-L9i_rjdCNGUSV-QBm8jtMjQa8kg@mail.gmail.com>
Message-ID: <CAHk-=wiL9hj0AyqXW1qYnu-L9i_rjdCNGUSV-QBm8jtMjQa8kg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fs: add file_ref
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Oct 2024 at 03:12, Christian Brauner <brauner@kernel.org> wrote:
>
> Switching atomic_long_fetch_inc() would change the logic quite a bit
> though as atomic_long_fetch_inc() returns the previous value.

You can use atomic_long_inc_return() if you want the new value.

So the "atomic_fetch_op()" is a "fetch old value and do the op".

The "atomic_op_return()" is "do the op and return the new value".

We do have both, although on x86, the "fetch_op" is the one that most
closely then maps to "xadd".

But if you find the current code easier, that's fine.

            Linus

