Return-Path: <linux-fsdevel+bounces-36020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB569DAB22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 16:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847E816445A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 15:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8F3200B8B;
	Wed, 27 Nov 2024 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TM9pcc84"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437DA200121
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722912; cv=none; b=XZQqMW204FYX6h/wvYe7ci/u9h15Qwr3hxm4kNukJslgLATjOHOdozx0HcrRjfHeh5MOYg8zg1Wj+2p+Cbltz52s9GV1WVz7x6LxrwX08C79rpcFBo7lLWgodlMgDTcuSywFDM2gvBqsk2VlvGg0d85ngAEpMKdsgJPHRyF9ywM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722912; c=relaxed/simple;
	bh=hYOF5+CSvFGGwMZxoKhXQ5ulU8SpkTAOXD2Ro2loI+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKeZq+CuW+pBsg81LgVxixsoDIZdiDbUcpBy8vX2jCBrSAJq16VLDCWxcl/oZG5bg2XO2uvMfOAZIhOoj1D0KuXUStmKRadmqrC73/B/N5maTqILhYI1lvrThiejYMthKr4GRY5IRc8sLgVdcd49o1fzs6w+NaKYFnbZDWtuvgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TM9pcc84; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53dd59a2bc1so6477029e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 07:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732722908; x=1733327708; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hAr4TZdsOU6XWFX8oKIJY4uIFZASuI0VfNTDSWNUv0Q=;
        b=TM9pcc84VjQNA9/tfEhI7RjZXq9vNbDTfVzZVMFEIa0BqaJk1GfVm/UIHsKOC01dJn
         lSCmOrKLq3jcVeFJVE3iuP9jjr4zojir86sdGnrG18TVlvuU8uj9prtF5esDyP9YOukf
         tkEZ0JbiPQXixC4LfjBiqifpe4OoErBOKLdQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732722908; x=1733327708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAr4TZdsOU6XWFX8oKIJY4uIFZASuI0VfNTDSWNUv0Q=;
        b=s4PifnV+G3PUWXKiCXn/Lzo8IIR5Ye37pGenNiRKJhC3FSwz6lPXn5qYf1NixwsAOt
         xsrhwcMLFukU+hIwj0z9f5e16UiyEMHXFhe5hLSLP7X8ruHU0eSmcmEoA+ubyQM/0bbM
         +OG6stkec4fc6Ywcnop67RGeCdfBYH6OOXSYJh1PAmbzyegE+HIPl5/GorX2HNYG3iKm
         TyG7abORhSWSDFmcl9MidhTlDNgrxCblvlVNCvj7DMu236OSI2PJVr98r7c6kdAijptc
         mzg3XsoTC7vOLye1aMjOCM4InDlYw/kNBBNVB9AuZaKq9h2jzLKjQqElZmJe58cMQRUj
         +06Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgP5AvnJvvEcKx7bO3GLYMuOv82Pv8i6tbX6XX4gXTMZ7vhTNEBoZvRV0m2z4dD716SWBqrXL8r7JItBoe@vger.kernel.org
X-Gm-Message-State: AOJu0YykjI9tn42gVBKqwEAFs5J7/oxaNUCKUKUZ+7g8svg2gwds3zaL
	p12/00Z2gzF10eOeI14vW9iVEFiDSKpul0iUG+14WrUtt1iRCwQ/pWL0DC4oFgpT1u5qm5tZCfY
	MKhK9OA==
X-Gm-Gg: ASbGnctPk/eNhprIegkyLInQPvH2Eb7uf4q2WnUm3UB7i4Hh05EGTX7hJkIRJ4XnA1m
	feGEZzfaifGVZd4B5g+Nx01t/NZIHOeTeSTtNNr8Vj1cNYBkZpn71eRzeaSkkbQP0o33Ml9NKPS
	/Y2IjUYot+ZakBn1XaUATRIJMxYpQCDAeJkXqmhfrio/IZ/6cZFy1D8+AS2XenfYqjj9ax6yA3a
	1+1shLMItFrlXaKlqPoZZD6uS18Lw2vaHpdLSeoJHkwh0L/jjBytqmOjvWLLi7k3T46T1boqj/3
	BWh7bSaMsRjN2zQ20sBRUZ+E
X-Google-Smtp-Source: AGHT+IHsoZiEtJftVqj0DBLfjUtwEwxtIB2KgrpSVBXiJGEj/R4DfyvMb6CN9DCUaNpvOyUDFl1Z5w==
X-Received: by 2002:a05:6512:39d0:b0:53d:ec93:fbb7 with SMTP id 2adb3069b0e04-53df00a9782mr2406273e87.9.1732722908131;
        Wed, 27 Nov 2024 07:55:08 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fe50sm730418766b.102.2024.11.27.07.55.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 07:55:06 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa5325af6a0so644270566b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 07:55:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU2LA0xZtc0BfmFR82dcHMR7L05HOGy9WFxUJQOqbugBEQ7nfsJOxZ/Va6kY+s6cVHmQYFoRW638KW06Sv+@vger.kernel.org
X-Received: by 2002:a17:906:30c5:b0:aa5:1b7a:5579 with SMTP id
 a640c23a62f3a-aa580f202d9mr211472566b.21.1732722905907; Wed, 27 Nov 2024
 07:55:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACKH++YAtEMYu2nTLUyfmxZoGO37fqogKMDkBpddmNaz5HE6ng@mail.gmail.com>
 <4a2bc207-76be-4715-8e12-7fc45a76a125@leemhuis.info> <CACKH++YYM2uCOrFwELeJZzHuTn5UozE-=7PS3DiVnsJfXg1SDw@mail.gmail.com>
 <20241127-frisst-anekdote-3e6d724cb311@brauner>
In-Reply-To: <20241127-frisst-anekdote-3e6d724cb311@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Nov 2024 07:54:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+3qEU9S9sgRLesCMKJ1w_e6zwEt0f30=8NSKhN+2LjA@mail.gmail.com>
Message-ID: <CAHk-=wi+3qEU9S9sgRLesCMKJ1w_e6zwEt0f30=8NSKhN+2LjA@mail.gmail.com>
Subject: Re: [REGRESSION] mold linker depends on ETXTBSY, but open(2) no
 longer returns it
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux-fsdevel <linux-fsdevel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Rui Ueyama <rui314@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Nov 2024 at 04:11, Christian Brauner <brauner@kernel.org> wrote:
>
> Linus, it seems that the mold linker relies on the deny_write_access()
> mechanism for executables. The mold linker tries to open a file for
> writing and if ETXTBSY is returned mold falls back to creating a new
> file.

Uhhuh. Ok, unfortunate, but this is clearly a real use case, so of
course we'll revert the kernel change.

           Linus

