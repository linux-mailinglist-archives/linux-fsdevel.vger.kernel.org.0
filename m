Return-Path: <linux-fsdevel+bounces-55258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 464FEB08D98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 14:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1574F1767BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 12:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6762D94B0;
	Thu, 17 Jul 2025 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgHVhJnc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BE82D8780;
	Thu, 17 Jul 2025 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756850; cv=none; b=hVPD/GuYaV22mo2lG+oZAThvunuWhYcd20nusRzNaZXHeIwohF8W3LH8x05CSrxxHrVBO8L6WLggnCW62FNxrtWCJ27NWIfGoDdGjlc5LR/qYz2R2TKRWGPxK2uGnle1o0Ve7u5TQw/YpK4QKDHEAAWpCuARoYu1SnPC7DWqW8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756850; c=relaxed/simple;
	bh=kJ3TcNtqxJ4UBHv9gRm9Nl6hZPzML+Z8jngwkHltC6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gUh49gv9rAPTdFwuFNV0IDlLVH0b4lx7J0Vyr6H+gKd9bJvPT2gpMlKb/3eV0eD0+UA+FeCm+Sq9bgkTnpoyUsybdHEm3zp4BdwKMjORicRtAxGuLsmXeU0epxSRO35VWDLC4vipNcSFNweTcFAWvi/VDIe5798hL2hURFxCqro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgHVhJnc; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-313cde344d4so985485a91.0;
        Thu, 17 Jul 2025 05:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752756849; x=1753361649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66fafN7y/FqPwPZ6l2KQaePQVNkTt08PGWQH5KMaIRc=;
        b=LgHVhJncprxYUAULI22YLtcKnrSYJS/bundDczunh7Y1dKwwxO+jB+crnozc4Ss88V
         BhEBBdhuZHXntosp5eErSLqFZc556rupbwfb0Cmc/sOeOQRFfLRuvWe+5wxLWBXMKgfO
         1iKwY6mtpiUuNJ2EVHZgxtaC5oyak3BgiLT1pIUB9YmiQaPg8FHBPY24mI1/K8cvouPQ
         adPLvoHwg5X9jkcU3EDmk4G0IR+rQWVTnCueg0pDgBEPiNIo8k+0bB+IdMX8eHxv6HU4
         Vz8QO8w7D6n87oSD8erNyxOjzkFUaKYkaYWCEWOuYT8qJrJVpeVW4dCP5uKsQhShZjAQ
         1NHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752756849; x=1753361649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66fafN7y/FqPwPZ6l2KQaePQVNkTt08PGWQH5KMaIRc=;
        b=KjA/qR2NTeyQWibYhVYVj1mvASFSqTvkrmCMpsNt1wXtsQFtoHyE9ibGxAibXy5rXP
         VK+fA+RxsSy5RV43X71SW2UhPIMCPiWFEfxE5x0wRVozvkA16FMXLgCL7ltaAwwhyAB2
         WjMJe9yToquZosHWupxb8XXwQpkxivvzJ5h6clWuJ6cXFl2GR1YMCFFYg1EgLdr/wB/0
         2LI+07h4h1GhflVbh5jBjUJSlfEAI86Yn5JAKcUn4R0QIOrnueZ5xDR29pM1BJr6CC+P
         j/GhsHSoVgEkbuGnqOVtfromuFwxCo4V7nVAUxxZJ6SYx4KP2uw6p4eqHGHc3fV9o9MK
         Hpag==
X-Forwarded-Encrypted: i=1; AJvYcCUzPjNS8iTmSx4gzbY9zqmT4jvszKiJKtHjKwsmAjoQO6z/Gg8Eta6KNkU2KZGjUK+oc1SWFsgU/cUrGzhU@vger.kernel.org, AJvYcCV/IZAGsYsXONWnpyNLIcOMUyRr3heu8d7+B5SWt20IgHr7Gp0UyB3W9rCxW213ACBYbggAS+O4mQdfYtnV@vger.kernel.org
X-Gm-Message-State: AOJu0YxTV7qgbwAVK04uj+Mi5nextmH5vqCIy3Yo5zHekUZ1Ps/T5zai
	iUOrkvJPv26QwcSYfpz0Fltg+BFUiNT7xbmm/atdsvj+7W4o7eQ+RJYRLmChM8V+BDws0AALOLo
	Fu4ClLVI9BWcN5MoE6AazZY+dGdhLdcY=
X-Gm-Gg: ASbGncukWog4uUFDSTCIZEd68lXBKPOyMnlAPZoCAst4/NFNNFiSUcX9xSLmUmWv/sC
	BrEe1HRoxkJ1Xo4jdFxS71W7e05mVwn7x2Czb7H/qZFIZZzoouQpoihhDLvs/kuOUIbP32qWONz
	bjF0YPaIwe40pT78wH+57vXmNBw3F+ytli4PuFD8BV6Pu1bLsz6sSPD0S61n+ID6MTR0aKoxZFU
	79+oVp23lUb/a1q68N8pYPTBDUGeJf2gPuAwpQ=
X-Google-Smtp-Source: AGHT+IEqXnE6g0shAhYpyHHjmBA70nbCjn2WGPGjoXBKqZylFTjNb4AZWl/0OI5gBDLEaNiEBvzrORHxYnwaiQOt5lU=
X-Received: by 2002:a17:90b:184d:b0:311:f684:d3cd with SMTP id
 98e67ed59e1d1-31c9f3c6068mr9007649a91.12.1752756848519; Thu, 17 Jul 2025
 05:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717115138.31860-1-darshanrathod475@gmail.com> <aHjsdy3LDpkzIgJG@casper.infradead.org>
In-Reply-To: <aHjsdy3LDpkzIgJG@casper.infradead.org>
From: Darshan Rathod <darshanrathod475@gmail.com>
Date: Thu, 17 Jul 2025 18:24:15 +0530
X-Gm-Features: Ac12FXzNYVEyzGQTULeNrVSCUdgN4QXMjz4trhJtSx5eUdpVlFSK9IfPlq3AjHA
Message-ID: <CA+db+r76Sxw13Wsz9rCDEwCCB9DdpQqOvQ9a6qOxzmSKLfgrkA@mail.gmail.com>
Subject: Re: [PATCH] fs/aio: Use unsigned int instead of plain unsigned
To: Matthew Wilcox <willy@infradead.org>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-aio@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

You're right, I made an incorrect assumption about a general coding
style rule. Thanks for the clarification and for sharing your
preference.

Apologies for the noise. I'll consider this patch withdrawn.

Best,
Darshan


On Thu, Jul 17, 2025 at 5:58=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Jul 17, 2025 at 11:51:37AM +0000, Darshan Rathod wrote:
> All instances of the shorthand type `unsigned` have been replaced with th=
e more explicit `unsigned int`.
> >
> > While functionally identical, this change improves code clarity and bri=
ngs it into alignment with the preferred Linux kernel coding style.
>
> says who?  i prefer plain 'unsigned'

