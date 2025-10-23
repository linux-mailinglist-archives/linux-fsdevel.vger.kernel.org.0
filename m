Return-Path: <linux-fsdevel+bounces-65278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B261BFFE56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 10:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F441A607AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 08:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DB72FF17C;
	Thu, 23 Oct 2025 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GhpUltlx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFCA2F7461
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207805; cv=none; b=hKz1wM/ZR+jhuObKA7eGdlP7efCqVOGz44/OcA+c6xaX6AF8dkwpp9OSZCPAVSGNSO9mnA64JTB4csHdbk8OMAm/AcIkiAdzVBnXpt217WoInVgk/hXHpKYkjLf3CTknKcv13tkXOXlVXFLmumA21Xo4zIPSDNIRgqPNBezHXY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207805; c=relaxed/simple;
	bh=GZ2o/nJlsEOzs00Oa82WFjuaDZobMx/ouP1Wbql+PLo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MO2XJAkbSLh6cFvJQaIFVfoM6hO7lADv5dFqU7DTW5ExF1sqqKcaTbpNnw/plfWXpSTidwWRIJMECGzwROgda/urxCusYrsGpI7hRstM078+/ZNlX/U6CrPyf6AEdSOH6UszoTI2QuXooMosMXbI1jeGOkVatEqBSO066QIcSGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GhpUltlx; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-475c422fd70so2930095e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 01:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761207801; x=1761812601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QpqWsbe7X8TE4MbamMdrMlILOwJyeV2HZGxH0RxJ4HU=;
        b=GhpUltlxb7pXO7xYnzD2qz1vBVpmNmwv/qPEqqVA5snlYpxMksSkOIwpsEwUiWxLiW
         Y6ryfxWnV7R9h/x2jXwpTkHzeimlb6pztsOLm61EhOhbFI81pNmmRfBzrYcV+UZyeGoR
         Xkcsxa97YzGiykhiDUk4iMzSaFv8sayVUBB48pE7DJs1g8J77oPv6z+LtVCWMj7tTC0A
         HI/4u7TGKCfEb8EY5x4RJfsU6eHGH8KrdEfIQ685Ap4au4wkg6rNt/enGnYhuA/OYmES
         gXxalzKaOcqQJAVIbVFB37ONZk3xFfi3qEwf24vsV1y/8y74Y6Wyp6fAGa97plN6VaJc
         WOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761207801; x=1761812601;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QpqWsbe7X8TE4MbamMdrMlILOwJyeV2HZGxH0RxJ4HU=;
        b=QsmuBoWUriq11gI2QaUVKrIyUfJkDpPnKdtM6LQkQ/C86QRfzZ9E90XSn6WKARce1g
         uJbyDuYj7e5XFv48sVNduZXNjNHrtg/pdGrbJjktW1m88N+OJi55QGw3Np7P3xY4k7vA
         qQukZyJvPECFlX6kd4/2aH2ESNWwm/NDj0I5EyIqq9IXDUYa4QaUf2C/Jbd7FXOkhBoV
         EP9QaD/16rpnYfv0N85t7G815c6mVLmN+OXVUnsD2KMhhMbdJmeQJY8yxtVVGZyk0NI8
         R9UT9STwh1LlKGoosQyqW0vuTW8fCqwMyr6Va/lHXG1DVvoxiG2Z5hTryeEuzstzXO1S
         o+MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNtn1vIxUBZEVTL0lgk34qQ6FHr6Wg63vpTvfCMgckwhmCNeJ8wv1c21NSR1GwGMWJ5rkftphYqo7ETYN6@vger.kernel.org
X-Gm-Message-State: AOJu0YwIqhh+TLCk+zvPb/yJ4pldMmfd4Gxj8g++kL4NgxF7qkUpUV1J
	2lY8Lmv7oVl62bqSID3/aK4O+VCmxALkQYq5pDWpGhhpt+TgH89sqSzbMPfW1FMtBmqn89XOqgF
	miQvlYRgJEecgEa/NvA==
X-Google-Smtp-Source: AGHT+IHRFzs92gG+pJqT1st2Vl1lkPZd3yrofQcAqIqA/U/9o7yE75rCP4nX2IU1q+y5Llnr+jhwkJEc7xi+Eoo=
X-Received: from wmin5.prod.google.com ([2002:a7b:cbc5:0:b0:46e:67c8:72a6])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a214:b0:471:ff3:a7fe with SMTP id 5b1f17b1804b1-471179123b8mr119070815e9.19.1761207800744;
 Thu, 23 Oct 2025 01:23:20 -0700 (PDT)
Date: Thu, 23 Oct 2025 08:23:19 +0000
In-Reply-To: <20251022143158.64475-10-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022143158.64475-1-dakr@kernel.org> <20251022143158.64475-10-dakr@kernel.org>
Message-ID: <aPnl92lLX9sCWrT6@google.com>
Subject: Re: [PATCH v3 09/10] rust: debugfs: support binary large objects for ScopedDir
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, mmaurer@google.com, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Oct 22, 2025 at 04:30:43PM +0200, Danilo Krummrich wrote:
> Add support for creating binary debugfs files via ScopedDir. This
> mirrors the existing functionality for Dir, but without producing an
> owning handle -- files are automatically removed when the associated
> Scope is dropped.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Matthew Maurer <mmaurer@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

