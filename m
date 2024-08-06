Return-Path: <linux-fsdevel+bounces-25143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF0394966C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 19:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623D51C23A50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 17:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F07F4F8A0;
	Tue,  6 Aug 2024 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Gj9u8cqh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D83481B7
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964015; cv=none; b=Jl59faJpnKloGaMy7BA9QR1h6zF51MhcH7vlfb1S1Ubm3dD7oNwAtO55RQDnQYb0JGr8D3ju1eKST5BV3C+vSO+amzOqqH41AiNu6OmfiqOgK3NtF4qP41f7mBJHA3pO6tCBn1RB4XBL9QVhQaKBohzsr7u/7nWZR7oXOdlFF9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964015; c=relaxed/simple;
	bh=oHLSqFcCjnTs56fOmUFrUhP7q5NKtYBlS6wIyfG/Xx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ey/vyndQNqIstQc74rU3MHhBmKd1pp62zQMRHLW1F4nVX74O4bADtGUtB9ELDclGPjH2pfL5fwizSyIUIoqtw4me+cJiU2RKjkJDWRZmBgMPuEZBXRENeeiX+i4ehS6bPPNyAnvV+G/95TqYk+icwrH7eVJTFnucX0FyX4E3Bvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Gj9u8cqh; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52efd8807aaso1469570e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 10:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722964012; x=1723568812; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpIYaaRgZ4zGsziO5jW7AFXvDnjBaproabP0NbXARzU=;
        b=Gj9u8cqhK6DPRdv8rTNPSUjNGQYqtSO7tciobeBQMBfOPExKSBWOO6umRRv4PwfUCY
         2m4jzCERjs3uENLCj/T6cgtUoYmKI6ubqGLvLz4uNsr/bxndz6V6x+Q6TGOKi9cASAoc
         vLewecz3YFA+9UkS8a/wJVOa9WBEnFS4ZCs7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722964012; x=1723568812;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpIYaaRgZ4zGsziO5jW7AFXvDnjBaproabP0NbXARzU=;
        b=JdX1Rj+id2oKQ0+sxp8ONCdTtWgqLRQz9h5r8qPusBx7vdQuTGIFfUpJsfvaTOAYEz
         rMNJI1A8k5Sxxtk4FYP9BbfZb6FiVpIk62LA1RTA5959gkbYDJuXJ6HDB7ySo90GnnEe
         +mOubS6YebaoPG2hEdiZSuF0LOkHzLj628B4WXlpaCKMEsQq3qUT7zcRrIy+BCj/pjCp
         UbPpsAnYd+XgKJz2n2HzYmkmjIlpbahV2wE0xuJtEbvnRgJMUUNPa4gYxm+UZDRpDEeb
         tINF7CuVfBiiac2sSjKOHOwyLB1tegI9OM8UaKXbXfnh010s4N561jWv/cn8dLbduv9j
         qJxw==
X-Gm-Message-State: AOJu0YxO0cUfEhWvutJKI6GJ+y/8rebr0YJO6obf/43kLAzh5kOrSJmC
	6MSEsMR76do17gnRERxQP+9UC2o9c4jSXDHVs2+eMPZpNFrMyasNkumtCGoDl9fSps8CKjS4C4U
	Q78jNnA==
X-Google-Smtp-Source: AGHT+IHDXlH82BIu75+B0olWyksaGnKyForX0ZgWsK6zvn1OFTzki8iAhg2Z6XIm01tCJWthLhJ+Og==
X-Received: by 2002:a05:6512:3ca6:b0:52f:ca2b:1d33 with SMTP id 2adb3069b0e04-530bb391d8bmr9478312e87.20.1722964011464;
        Tue, 06 Aug 2024 10:06:51 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0cc2asm563371566b.63.2024.08.06.10.06.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 10:06:50 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7aa086b077so101155166b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 10:06:50 -0700 (PDT)
X-Received: by 2002:a17:906:6a16:b0:a77:db36:1ccf with SMTP id
 a640c23a62f3a-a7dc5106e09mr939681166b.42.1722964010283; Tue, 06 Aug 2024
 10:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org> <20240806-work-procfs-v1-1-fb04e1d09f0c@kernel.org>
In-Reply-To: <20240806-work-procfs-v1-1-fb04e1d09f0c@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 6 Aug 2024 10:06:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjFatSsvba-9PTyTGRxi6n-NyWxro-XRvR_CPq+hvPTfQ@mail.gmail.com>
Message-ID: <CAHk-=wjFatSsvba-9PTyTGRxi6n-NyWxro-XRvR_CPq+hvPTfQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/6] proc: proc_readfd() -> proc_fd_iterate_shared()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Aug 2024 at 09:02, Christian Brauner <brauner@kernel.org> wrote:
>
> -static int proc_readfd(struct file *file, struct dir_context *ctx)
> +static int proc_fd_iterate_shared(struct file *file, struct dir_context *ctx)

I think the "proc_fd_iterate" part is great.

The "shared" part I'm not super-excited about, simply because we
finally got rid of the non-shared 'iterate' function entirely last
year, and so the "_shared" part is pure historical naming.

In fact, I was hoping we'd do an automated rename at some point. Maybe
not to "iterate" (too generic a name), but something like
"iterate_dir" or something would avoid the now pointless "shared"
thing.

                 Linus

