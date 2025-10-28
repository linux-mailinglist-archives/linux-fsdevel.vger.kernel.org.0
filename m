Return-Path: <linux-fsdevel+bounces-65878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 291F7C12FAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 06:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 884DE4F3904
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 05:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597182D239A;
	Tue, 28 Oct 2025 05:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bBgshXTU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F5D296BBC
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Oct 2025 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629646; cv=none; b=HnXNWL7EIjXEJDtz0IJeTdZlmKiV085VIU8ljaESvnB5oLLMiydweDLJcC3GhC5sUYYsVnVZycn92L0qjap8pP7RO10Ct1ETH4YJELj53VLSeVRGizz2MIDnu/lb305ZJ4mOVkvLjv9IHQYDHIv0CNknIXYZxVvo79yx7MKFb6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629646; c=relaxed/simple;
	bh=UX3h0Pes41IJIATGA34ZfcGcoxGHwBRZyrCwKR+AqI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktPS+6ZMhya1JJKE0qoCk0gQpGEw5ph2sL2JVX5qKpfE2tzDHwsOWOJE6t6eZg9M3w6xFEnejNtlWwBbhg9V27Y5Q4O7csJzVNUHkO1PzSuZ7FYB45uOAruaIzLphFvd6yB9SauBr9npojBoer4VeQBftOarJSF/VaaVczzxLpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bBgshXTU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so1841933a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 22:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761629643; x=1762234443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kLpGC29sIJuMD8EW6D6+ekLf15xOznYOaep7iLxbnWw=;
        b=bBgshXTUSZSa8iGJGyo4g0iefNe4uN4gOLC28dAwGqfDx/VOI896zXE7Av20WmJ53n
         9MRj47BQIxXQAbNkhhf5bjGe3/Ita7BQpu2FbmszHueGI6H3lnQlPdc9AFdeyVwgFJgn
         zR0vJqEheiHP+5on8yPNNq8GabK8BSwJ16WkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761629643; x=1762234443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLpGC29sIJuMD8EW6D6+ekLf15xOznYOaep7iLxbnWw=;
        b=JhksI2Yvtwz3+V85xtlJ2Tq2mVoOd3jl5zSbwB8kbXMYRfm1WNT8my+Aqt76NhPGSB
         ISwCAR6VpIBTeaX+u9ZFGtgzOiJWCWx2pP7jr6bXuFXUfgTWzGF3+rXjQTSjPlEMkFI+
         4mH1sOmcDI1b6Ri7APXdAKqKSjWdn8e8otIoLMFec6uBa+LYFsQMgdZPwdjUOPruYkiM
         GeGHOmXu/UIGygCE7uE/O1oLmPTedsl/EnUlNKf32PupekkD+0wT1gzr1L6e3R5qWt/j
         A3XX4tlL8eP9CJGwost40cRk3l/Xreini4IGnA3KIZXXk1HowocKxaTOcECnMX9WqCer
         zA3w==
X-Gm-Message-State: AOJu0YxTMbY2f7tuSEGwbDJjzpMME0Gbw6G0h/KtYJqHURHBxWDqv9YQ
	T9Ti/x71IywTxOPoC+UHe4MHzN7QGmd8e3A//fJBdQxqxULpqLoUBN9C8GUeNXmt3eupr9VyomL
	7+ih70qL90Q==
X-Gm-Gg: ASbGncv4MXdIhVkW32AItX5NkyDZBURH2S1K2m3Dw4oN+h9Iarwkq/523IuAje1NRmy
	aVYV2TnLzGZ+r+wMrKMekuqXdTDX50g5q6ndE8J9HAY9ECEFWbw/UgTrGX/18KCTKaq2M3f/iJy
	rg05UzrZYLU/+LPU3NRVyHtZHR7yt4CWK3vkid46sFxWRm62I/q53lB1E5zWhhgETjwfJHnUlyD
	6dx4EjDTvgnDZyjNtEcDH80Z3MP5KzQyRFYdm3t2flRvewQofxxrKtvH5CMyJjdpKl4dG2St2m2
	xWzZTaK5BydV7LUJwArq+kkYn49smzrC02LTBqGttNcelFJxGNU7ApgPOG7r+GhAd2jrksV/cD6
	bXPjEm0lVDyJO0c1xMJwfOI1cRgVcI41gZennLOF/ex0b/6WppHbXQv6MQ3ADF0dShUomo4ZKcx
	R9Q4pZ4Mttu2NH0x1Sdyso5ZLz+m0RTA8MD3kz6QFjjcysHbPCA6jonB6kDhhU
X-Google-Smtp-Source: AGHT+IHh9Y7S/TffngZACPfa2x1DuVnRCwIgpE4x3PJDckJ5bpLVxSv3ypQIVUaQWHqnJksn9WwQqA==
X-Received: by 2002:a05:6402:4307:b0:63c:82:619a with SMTP id 4fb4d7f45d1cf-63ed8495409mr1833421a12.11.1761629642745;
        Mon, 27 Oct 2025 22:34:02 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efd0c1fsm7983634a12.37.2025.10.27.22.34.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 22:34:02 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c556b4e0cso2604057a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 22:34:02 -0700 (PDT)
X-Received: by 2002:a05:6402:2681:b0:63b:ef0e:dfa7 with SMTP id
 4fb4d7f45d1cf-63ed848cba3mr2102592a12.6.1761629641674; Mon, 27 Oct 2025
 22:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Oct 2025 22:33:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_FZnLha9Qr2sMQPXa1go4FPq2p5d7CnMoOnCimS2Wzg@mail.gmail.com>
X-Gm-Features: AWmQ_bkfyF7pn4e6fUY7bNVBhf2DrgjCvQYqt5ZlzergSjGB0BKOD2LLrniXl7E
Message-ID: <CAHk-=wg_FZnLha9Qr2sMQPXa1go4FPq2p5d7CnMoOnCimS2Wzg@mail.gmail.com>
Subject: Re: [PATCH v2 00/50] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, paul@paul-moore.com, casey@schaufler-ca.com, 
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com, 
	selinux@vger.kernel.org, borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 17:48, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Things get simpler if we introduce a new dentry flag (DCACHE_PERSISTENT)
> marking those "leaked" dentries.  Having it set claims responsibility
> for +1 in refcount.
>
> The end result this series is aiming for: [...]

The series looks sane to me. Nothing made me really react negatively.
But that's just from reading the patches: I didn't apply them or -
shudder - test any of them.

            Linus

