Return-Path: <linux-fsdevel+bounces-26824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F0995BD5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 19:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CECD1F248C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F68B1CEAC0;
	Thu, 22 Aug 2024 17:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="o9VDAYZo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FADD1CCB36
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348055; cv=none; b=kxGTA0QdTOi4UnOE/jvDEM8gK3IXI7UMTrSC/cT8zJHHAZjsjbEjCLt+msMi3Z3Rm+50eiIHy0GXwhqpK2IX41aePOBN8o+v8imMLjl7Dba5OOzbKbD69CuFDyQIolHt/5F3JJKuUafrUCx+tZ0OxpvS0oq2Tr7abo6L9xQKC8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348055; c=relaxed/simple;
	bh=X271o9T50er59RtihIpbs8PRlf8ZCHxqW2OQG//RaMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpCNKXy7mTLp9P7clvC9Z3LTndk7zGqSmwPHYQU2znRjlGJV0dCo+ycfuLkR98zK6WX8BSQCXLUACvIPZTpKqhEMphLn+yiXUxkEOqiZZk14iIOCrqQt3ZvblNZD011uFBgaJZHvgkUcX97+DBcKDWztcET9yfmcQPmOtHFSgGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=o9VDAYZo; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a86a0b5513aso5790166b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 10:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724348052; x=1724952852; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c4SkFUyZEvGcixofHc9OJ4bNLtK3IhozIOBpbbZR+Ac=;
        b=o9VDAYZoVRlOLmfsjkD4ztG+m27a/fSOxOeyTupva5UTUnyeMC5d0qEDwFMW53WE1K
         MkbE7nfLn2ryV2vZ6Ulh2HqyISbADlNvqGciWCJPtjfrhq9HVrxce+GlhopTYUI77JVe
         uC+O9LAON4qg8mTYP6lh0BqL57SyxpfELKe3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724348052; x=1724952852;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4SkFUyZEvGcixofHc9OJ4bNLtK3IhozIOBpbbZR+Ac=;
        b=nIOTrwWJz/imeyTgHwfwweJaBVO/6t+xycSEW4ZN81ZsJNBbFFe5C0qN4VrOPp7Q7O
         TQBj8/gD5rlGLTmmIvyIGZtD1nEN1vBDhrQx0YgB1gm3bh5He12YkJvMKyZ+u++lYrTP
         bzn3Y8dlOlhShTSYnOJvlZP6HuaIJjDRkYteUgbXME6tCNVxX2ebytkbEIige1mLt8m2
         tArLSVh0FTMgkZfvV5JMLaEcagoN1wnKBXK1Cp76n1BjorlMz4Yv582xC1dmg9AjCajI
         IyN83bwNvMenSFsf61hze8fU/1oPCq1Yp421Hiu5VuIta8b35jp6/gXpxhM2WqH3y/b1
         1CXw==
X-Forwarded-Encrypted: i=1; AJvYcCVcAnWNPPfbS3nEmRY7YjfyqnQ93x6GJ390pQzvtG9hWPPTDN5FURN2dj1o4sJylPl4JxuMNdb88Da9MfqZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzwQSpU8UGMHLwAlBWD/KXZpoaeJC3uxOv5gcqmXA9ge0gVdj6u
	Zc/xxnzUkyO3tV0MgE9oMI6ossuMFk+mspLvfmlpb+ibTyJW9I5txPg1dtPuzec+u+WSxvzubdE
	Oa3fPTzMl7XVuO+OUFtvYj+Q6e1AxU2xX/bpNEA==
X-Google-Smtp-Source: AGHT+IGBQjV4wAiQiqrib9Su5HSQzemiaq9WzbAu7TL6sG5zCTBTXoyIEaWxAFLqvXVy7vZxDR7w85Jk1HvEw6sYufM=
X-Received: by 2002:a17:906:ee8a:b0:a86:9107:4c2f with SMTP id
 a640c23a62f3a-a8691b8c6bemr270637266b.41.1724348051714; Thu, 22 Aug 2024
 10:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720549824.git.josef@toxicpanda.com> <2d72a44fa49f47bd7258d7efb931926b26de4004.1720549824.git.josef@toxicpanda.com>
In-Reply-To: <2d72a44fa49f47bd7258d7efb931926b26de4004.1720549824.git.josef@toxicpanda.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 19:33:59 +0200
Message-ID: <CAJfpegtC7A+YXDc_U2cHg-VzwOsWp9rTkYyZwJ91923SdJqCdw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] listmount.2: New page describing the listmount syscall
To: Josef Bacik <josef@toxicpanda.com>
Cc: alx@kernel.org, linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

Thanks, Josef for doing the man pages.

On Tue, 9 Jul 2024 at 20:32, Josef Bacik <josef@toxicpanda.com> wrote:
> +.I req.param
> +is used to tell the kernel what mount ID to start the list from.
> +This is useful if multiple calls to
> +.BR listmount (2)
> +are required.
> +This can be set to the last mount ID returned + 1 in order to

The "+ 1" is done by the kernel, so this should be just set to the
last returned mount ID.   Also maybe explicitly mention that a value
of zero is used to start from the beginning of the list (zero is a
reserved mount ID value).

Thanks,
Miklos

