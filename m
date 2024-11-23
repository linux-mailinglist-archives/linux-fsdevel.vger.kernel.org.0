Return-Path: <linux-fsdevel+bounces-35626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9517B9D67A6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 06:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22837B21E93
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 05:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8026C15CD74;
	Sat, 23 Nov 2024 05:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SVksmGxG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A8C23BE
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Nov 2024 05:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732339399; cv=none; b=ZSLru7n5FTN1qzcem6uTBdRTdtKZO0u3zWimPdcgJo2DvxMccrwuonobaqtrMMMrQQeGjPgddLgIobZB8CkUn7uJ+JuYKNKO0X18IiTAXvdloLxD9ofRiJtVywxkNaycQVCvOYNFwZvpyOM6K9k9wbJE6wkK6OWbRtjzuNNaZCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732339399; c=relaxed/simple;
	bh=rU0rvkhWpzGBrA+g0K/jMXCk03/3N95dD4xq/uowYCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHJcTJLobi44aYnpT7gFKbFbE9C9AOA799W+0TxR0Sq77WwGF0cxPqXZxoDT+MchQKewlx1vDKumdg1OHxoJ7jL6p7E9gOXb2+2btCbPOo5WpntjZjWKxaTM5FrjhgBlxJlLRa7nXoAVxGOfb1CX7RkTF6FrSL91bOVJb2/pT10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SVksmGxG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9aa8895facso457786866b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 21:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732339396; x=1732944196; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VSjGp3IroYTG1NE8bIcBd1OeNZO7AKZ38NmgfyznURE=;
        b=SVksmGxG5ezSmFUX8d+wEvePukZOKvAWqRFVOxYmdZAcpetQrZ14ceNAUJD1jSQDFX
         NBpUFAXl6yUd6xQH5PoHDshKP5IQXqh/ZyIFTn/rTry9KOKohe1cHOel+qF/SvasdS8V
         Rgo8zngAXO4y3uurnFUz5JytFYfZny0RtE++I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732339396; x=1732944196;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSjGp3IroYTG1NE8bIcBd1OeNZO7AKZ38NmgfyznURE=;
        b=foeSE5/999JMBpzLILB1QYduIOzHr410uGkvyTK+r6uf9BvhDQjRt5DG1RQBkN18Z5
         M3FuIHaFZoT2RmGY2ufQ4FLdJB4TK/6fBGX8RgN4yNCt91Qybngs6LMHz2EnoAnsxyri
         9ZKsc3FKxrXCJERSPVwgN/+bbtUkNiJIYtDBZCsDg48bwCz0yp+CUbYO+EuCXi5J1U5x
         sy7h/t5yl1UFev0HO/ILtUumrzYfYAFWlvicoG0yaAObvQ56rMvF+gECzo82lVeu6e4n
         LvMouGnLNV5ze7l4Dl8W3yiErc3iEZ1mCyRBDnao/n/vkUYvBEDFDEzU3ZNm6lASgKo/
         rinA==
X-Forwarded-Encrypted: i=1; AJvYcCVGt37+nVOSsI3s37vxpCGvPaDYVfwfRFhGYjp2N97sI7NAY1Hw/EmDXbjF7Ig0+APu9/WldHTWAiAI6zD7@vger.kernel.org
X-Gm-Message-State: AOJu0YySToyatvLBXOO/RpMuYXPjuozS9dYzgDE9Bb1YkhBFbXSjWosW
	j7Ztp9mcwWhY2XAk5eEyAPGjM6lEF8o66DdyNKNvkRs/YNtDIQnSCrdgpbEIHVYnUhb0EJ2feux
	YunjG2Q==
X-Gm-Gg: ASbGncuKaf6iOooLR6PSmqby7R2UC7NlESigQ0cPzlp1LvM+wLQPNiltt4djcWNPggD
	B8FFGAJQdxM4DyzjzIiwnrn+vEEyV2UU6+bvtmxv059/BvkzNYHM4pvjwg4VQQmS4+xcZ6P2s6A
	2DE/HiCrNlNEW+5G69KKzpWPv4ey8ditzP0n+ug7/iel9GlkD+5ym1SG5qrbkN+hkRVyuqhaVfQ
	eW64hAAGIe2IV9Y7ZcN9QXMg1luunIpnFbDeSYjDMEk50NFGGjgt9WXtZRCPxGLNo7ltU9x0SXW
	N1IAJQ4IvayRxStZMKIQW9qK
X-Google-Smtp-Source: AGHT+IEFpk8mT2SP6pkk7QcQA5sbqjdAKAJm34QBdWAa4ma2r7tLFvJ+fQvFcDsbk42m4E+QVmA1kA==
X-Received: by 2002:a17:906:4ca:b0:aa5:d06:4578 with SMTP id a640c23a62f3a-aa50d065310mr404800466b.28.1732339396359;
        Fri, 22 Nov 2024 21:23:16 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcf9sm176977066b.118.2024.11.22.21.23.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 21:23:15 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa5302a0901so51984266b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 21:23:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVo0uYR4QYQbc37WArqiw1rdQ0sUi0yzDjvmJEhRZtjjxSKqQvE5XtkjekZ5832oU4BPPW+tOFrRviTJvAZ@vger.kernel.org
X-Received: by 2002:a17:907:77d6:b0:aa5:31bb:2d with SMTP id
 a640c23a62f3a-aa531bb011emr102010766b.20.1732339394655; Fri, 22 Nov 2024
 21:23:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122095746.198762-1-amir73il@gmail.com> <CAHk-=wg_Hbtk1oeghodpDMc5Pq24x=aaihBHedfubyCXbntEMw@mail.gmail.com>
In-Reply-To: <CAHk-=wg_Hbtk1oeghodpDMc5Pq24x=aaihBHedfubyCXbntEMw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Nov 2024 21:22:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=whRp-s-GNZNdtCe8dOhpM0zihk4wUAXK2RsCf69fSW99Q@mail.gmail.com>
Message-ID: <CAHk-=whRp-s-GNZNdtCe8dOhpM0zihk4wUAXK2RsCf69fSW99Q@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs updates for 6.13
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Nov 2024 at 21:21, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I don't actively hate this, but I do wonder if this shouldn't have
> been done differently.

Just to clarify: because I understand *why* you wanted this, and
because I don't hate it with a passion, I have pulled your changes.

But I really think we could and should do better. Please?

               Linus

