Return-Path: <linux-fsdevel+bounces-32283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6619A30F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 00:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8562B2865DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 22:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2971D7986;
	Thu, 17 Oct 2024 22:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXCC9vs0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E3B1D278C;
	Thu, 17 Oct 2024 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729205275; cv=none; b=fbCVmrKVkGfkz/c/d3d+4tFPG0UNxXLP542MKVBN7j+cYYFjEGnqWIinr7dpvPWhBzoAi42K9JxtRixc2EfHCAaUepJ8SGUzJyqv1j2DxUPzyF3HBZeNOV4rD2uj4+YLUvSChURauV+tTR0m6FAdlVJ2N+CgpXgKA+kDlTjgiDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729205275; c=relaxed/simple;
	bh=AT0CKTmzN9UIcVwUdUYWDqnb8/y4DzK1JkMFAUKplHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URRIv9WgUoLukt4zal99qqthTkZkbyFpDgt75GeZyh2K6v+CHzaF3JDVtSXT7rinfMVyEJ36sPvT64+6XT0Jmp2yiTRtV/Bmlplke4KrfQR/8Q+ZPQT2G14kyBfcn+EawFTevSv9yrUKMKSJN+5QQD1VCioS1UKBDxZMO+9bY1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXCC9vs0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43158124a54so1807425e9.3;
        Thu, 17 Oct 2024 15:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729205272; x=1729810072; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AT0CKTmzN9UIcVwUdUYWDqnb8/y4DzK1JkMFAUKplHA=;
        b=TXCC9vs0WRM1YD6l9AsnFfzs+0caGK6Y1OS48pKpzjXMbOm8PmuswYCtMm02BBd4n9
         kPO4Tse7n6L/oIFPBxBiml4hil+g4lx8D/h9ZaDzrT46hLcFlTKQDLHmpfmLPRqZmQYS
         xF6whGJ3ixYeOZGitf/OZkhRwUTR5+WFcP86WzzxsBvhCjik7Xt85B2OhZVOciVEkVcu
         t6/hC1aqpdfHkZtOnwWtm4gTXDkisWztZvNRslN0lM6geCE0MBPp0dfnVPPtc20BggDC
         S9u7DFUcyolGGQu/C+kBTy2kcXbwJxm3rwxCMzLt+SmzRqe0BIzHP09rLE1FiIZeZ8zr
         bT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729205272; x=1729810072;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AT0CKTmzN9UIcVwUdUYWDqnb8/y4DzK1JkMFAUKplHA=;
        b=YL1WnLMw86G30UOFkKWZyobv6bJVaIONh20uGsa9feGCO/Q7/UyljbBxk6x/yL4+9g
         rATYlKzMKXy397OEW2x2NtenXPqNBEPG4NDpTlbAOSPk3KXi3wxgVQVbk++HAYHcai1H
         1fb1ncl6PTaP9By8ptC4gaSochsxlnuMa7WdjK4vf1RVxiEGpFV2r7ImAfVeuDXJUxTl
         kJFocrFY5xJ3rxwnNevaAv5iuXjzvIVkFZFBO5nkO5ekJyhVQ86pl7KjOzXZKV+WJkaF
         q8XTHjbPRB5T42vhI1zCXUJuFZPkNfxjb/peJj2f09dXgInUEOksDg+hOah/XBnC0EhS
         aO8g==
X-Forwarded-Encrypted: i=1; AJvYcCUTPGHdjEwx0uyLcsCv4ld+jHBIgmvCxc/1SjubC9WghFMKk3l7ulngu04epUyRrZUAv3AeljxBlBR9vtyN@vger.kernel.org, AJvYcCVMlIrmkG2Cc8JYsuSgDOeROkgrL2Ku57EU1WXVnS4lVb/+PXvyNqr/MaTCqJNiWYzTXXmeI2HofA8cNId/@vger.kernel.org
X-Gm-Message-State: AOJu0YzS5ohYQgDsbObHiVmK4m19lbpFU8rDUPJLJm92EscQo5jN2RuX
	J9DrnIkQYMuvCHuqG+aQlzuP/NFStEd+9ULkooTLtems/AuMIV56W6Mv4nqLP7QctjE2jKG7s12
	TVxAY6aAkWL4KsIxVqnSakJY7DZyRE8ge
X-Google-Smtp-Source: AGHT+IEj3Bezk3oy/u5PlhV0gduFBYFDDk4hQmhS2jsHk6PcYNkNX6O+zW6SHbKUMZZmQCP43pxBC9eIl4PRTW574PE=
X-Received: by 2002:a05:6000:1fa1:b0:37d:4864:397f with SMTP id
 ffacd0b85a97d-37ea21da66emr149426f8f.3.1729205272264; Thu, 17 Oct 2024
 15:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jz4OwA9LdXtWJuPup+wGVJ8kKFXSboT3G8kjPXBSa-qHA@mail.gmail.com>
 <20240612-hofiert-hymne-11f5a03b7e73@brauner> <CAJg=8jxMZ16pCEHTyv3Xr0dcHRYdwEZ6ZshXkQPYMXbNfkVTvg@mail.gmail.com>
 <CAJg=8jyAtJh6Mbj88Ri3J9fXBN0BM+Fh3qwaChGLL0ECuD7w+w@mail.gmail.com> <CACT4Y+YS+mSjvx8JheONVbrnA0FZUdm6ciWcvEJOCUzsMwWqXA@mail.gmail.com>
In-Reply-To: <CACT4Y+YS+mSjvx8JheONVbrnA0FZUdm6ciWcvEJOCUzsMwWqXA@mail.gmail.com>
From: Marius Fleischer <fleischermarius@gmail.com>
Date: Thu, 17 Oct 2024 15:47:40 -0700
Message-ID: <CAJg=8jyj=pRA_dW9DNA0O841W9jRzg8jV6a3KFtD2Nn=seCwyg@mail.gmail.com>
Subject: Re: possible deadlock in freeze_super
To: Dmitry Vyukov <dvyukov@google.com>
Cc: brauner@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, harrisonmichaelgreen@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,

Thank you for the pointer!

I tested the reproducer on 6.12-rc3 - it does not seem to trigger the bug there.

Thank you and wishing you a nice day!

Best,
Marius

