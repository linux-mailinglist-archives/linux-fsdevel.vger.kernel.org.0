Return-Path: <linux-fsdevel+bounces-42157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00736A3D588
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 10:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A85189D2F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 09:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448241F03D9;
	Thu, 20 Feb 2025 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dHGo4aUg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFB31D7984
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045435; cv=none; b=I/gBdkZR+mGcaGCeUtve2QlaRJcEQ+aeS2Nji8VTRdIgWm8DKm1IzrIUztenPFM+p0oUO0FefUwd4JCMaJW0b/9sREOApUAueuqgaPscPu+hrgdvwZdXMBIeG3shxZ0GxPY1akaCQwlit2ggTHVNO9Kxw47UM4Pjap6CfJqdRGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045435; c=relaxed/simple;
	bh=pio6oGY9tvwmnSgztfKFb9YvN2qyDo3So7AeU0yw2Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUrvsXvGuVwPecQF0/y0sRZhuKFTsqtAb/c0IE39g2yJ88Q0YkCZPZIOz2f2tl4akVgl7CcolWx5MwmKmVVVwYDoRyo2lD+nvtA40RAzN1tX7hT8va9h37SO7WSL3AcstifZYbFQcvpZaWisni/CquyoFxZqt2OjOXG3jkUzMqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=dHGo4aUg; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46fa764aac2so6323711cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 01:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1740045430; x=1740650230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dnYWhNeFVyqRiq1Mh4/pJI4c8Rl0YKmvBSdG+3U/2FQ=;
        b=dHGo4aUgrQuW5b0n20bpkPt8F/oIuenuLBRWkjHGpbEXW7B4XdIA8t0xXP12UK8AZA
         knqHn34Y785T03lywXxzdxQ38h30NMaB1wTDTi/Zs+3EIe3xikSlY4cjBnlozfFTnDxY
         I2w2nqNmsqIRUkY/KDnCOUJYL6/M+/CXo6U2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045430; x=1740650230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dnYWhNeFVyqRiq1Mh4/pJI4c8Rl0YKmvBSdG+3U/2FQ=;
        b=n0YxtKG0s6eq4BU/S7CoaExIpCXK4ShMRGegu/bZw5AZhgHWeXroEV5/K5Hh6W08jx
         Ecw9fdW4bQq8NAGaI6Dyi26I2LOkI2ZcuwZ99v0dqjnmiFAITc+jX693/373ohLF/3HI
         k5kZvVYKt9ubemAvABN4p1uYrTpfwFr89wKMHaG8syIGDg0vPPgQFuSEtpWG9ttzKXdt
         ptXVh93FkX5Z1nUflWMdpMIHzL1YLodyREnmQkFmdxXjn52BVMJn+OZueJtpjQ3PEiwJ
         J1/5GOpfhB3hhyPK+yi0j2OOXeITC0kvyAmcujNMJSsRHI8boZNqoMbs4NDasJQKG7fO
         IjVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrte9jDqI9Q8R+SDnlRwBYPmUsYSDREssLHf/cAykdf5YcISyyKLdTw6IinND/15apyAo5g6p530Zfe0aF@vger.kernel.org
X-Gm-Message-State: AOJu0YzDlfGIFt6Y8kltzEa4GrUwm1kCEc+lixCc33u5+XNk/oy4qlnV
	vfZaF6LFWe74HjNwFnKtzoe5+ZyvPDk1iitGTVXcKPXpjCjRQJw33+wtAEJYV+TSG5HReuo+Qx/
	hP8dP+9TFWqZ+USL8bzBpP+yAGV5a+Pmr48jDzw==
X-Gm-Gg: ASbGnctyZPdhH0x1/af/HpKnL7SoPRjt/hydD5bUqoZp5Y2/D8XpNvS6J3i/ckTqJDM
	eWJ79BR1kA8jqlh3gksDl/+yQ9iDVgFvZFuAvtjfcPLF9XYDy+99b3ilT2Fwiy2BtVSZOkWI=
X-Google-Smtp-Source: AGHT+IGQjO0U3qilppnMG3dkKlU8X+OBfiLfGH6bLul2BZ+8eV/+TR6r55gpTPj+sEOza/pJa+rxtFcoFnOpl7BOzlw=
X-Received: by 2002:a05:622a:2598:b0:472:1e5:d576 with SMTP id
 d75a77b69052e-47201e5d846mr157254781cf.32.1740045430742; Thu, 20 Feb 2025
 01:57:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegvVtao9OotO3sZopxxkSTkRV-cizpE1r2VtG7xZExZFOQ@mail.gmail.com>
 <20250219195400.1700787-1-samclewis@google.com> <568e942f-7ef9-4a00-a94f-441f156471b1@fastmail.fm>
In-Reply-To: <568e942f-7ef9-4a00-a94f-441f156471b1@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 20 Feb 2025 10:57:00 +0100
X-Gm-Features: AWEUYZkWQrExWCOYElmxx4wZYN9nYtIQSBHjeLN1ADKxUdRnMvXV5PyI_CpAjzI
Message-ID: <CAJfpeguEsq2amd-UxiSEktZLSpR0s+LXFeknpLdZR6vk8fbb_A@mail.gmail.com>
Subject: Re: [fuse-devel] Symlink caching: Updating the target can result in
 corrupted symlinks - kernel issue?
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Sam Lewis <samclewis@google.com>, fuse-devel@lists.sourceforge.net, 
	laura.promberger@cern.ch, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 21:22, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:

> I think we should write tests for all of these fuse specific operations,
> ideally probably as part of xfstests.

That's a good idea, but for now the above Tested-by should be
sufficient.   I'll post a proper patch.

Thanks,
Miklos

