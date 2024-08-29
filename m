Return-Path: <linux-fsdevel+bounces-27785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227F196402A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 11:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9802874E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 09:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C77E18E046;
	Thu, 29 Aug 2024 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HR7voTzs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66C018DF7C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923861; cv=none; b=X9dwfcLWzqT36/9VatG8idrFE7364jSdH6/z0gwaubnauR86qXEevtA5f43G9or6przDhQ8hLPXFhMwuZnxA4oBkd1a73l/6n89SjeUq4ApzKsyg3VxjSDDxAKUj/lyF50e10okojWDFy8wYuztuVEYUTJTjIN5s/oz3Ya/hM6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923861; c=relaxed/simple;
	bh=wgIc0h20EUEkDuMIR6UAqBYfWu7EPDfLEI64i6LhqAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ob5M5xPF5AIwsOJdXNSxKUDtimry1gHDiqBR7LeyOq4SVpj/22WEr6YaWC53WMUOhNiuoEpbr388mV5cMkhNJaTzNyyt1+GLfyqC88OEOf7SgLKc7LKT2QJQft1ts5b4Zv92y7nAwvUN4Wg8HRUc25phyGIxYj5yCmioVa/S1Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=HR7voTzs; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8684c31c60so43564166b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 02:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724923858; x=1725528658; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wgIc0h20EUEkDuMIR6UAqBYfWu7EPDfLEI64i6LhqAg=;
        b=HR7voTzsKH3pKadPDgW4gXpOBUiidIRFNVU3PxDKWYvKUCYEh67u7YcRVmGXHWWGOp
         yn80NC1JP8vc6QhCehwo30lpxBJNc+WOyMTqaj9W3qzLyhgkCkv5tymNaFuQT2Sggerz
         v402fnt/wA1NmivCsAY+DzhpKUOopSM/qUM4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724923858; x=1725528658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgIc0h20EUEkDuMIR6UAqBYfWu7EPDfLEI64i6LhqAg=;
        b=GAkGCk5sn1Wp076Csc/9ECePdnjmqlgDUCIdTIA8KHE1MGqxIzzMBYY7sKYp1itwrG
         UHIV9fNElfvRBOJP/FXJ3JvceX3waC8SMznMuSXEOWSXPMyOkeLwgwwVYGcC68zpKvYv
         OX1+sSd+7ez6vU2y/kNhUVHHxZDuItRaATstsCcaHZgPJgdLgpSn9diwA1HbMg9PLmF1
         GzeG3U7WySCYCKcQ412okTWpo1WZSJy53hj/kfKhNENfQsDRVRmCNoGjG+NtaZrr8dOB
         q3Ohb4BcODv62Ly23f/ESG7GzqnVpOYvSA88+OuAwtpAuTx+q/KMRADxrZwNc6/CJzdE
         2tNg==
X-Forwarded-Encrypted: i=1; AJvYcCXoKFAY/0LQQnZiCSZ9vfeg6EBOWr32GSMG7w5VTbL8QMLH3aUZU2XyXNxBCE35AfgTXjZvUX6cQ2fRYY4r@vger.kernel.org
X-Gm-Message-State: AOJu0YyCOyFkhUP9V/flBxhFyaQledMuLOVAmuNUTZnlnAxelLgWDM21
	fzQGnSqqV+gIQVUCfmMGTM/YcBS/lii1E64BW8E4zNRaNlBHTaFB3y4JkBpLiR+s+czelOGbdoo
	coAGJ4JaOpdsc/SKYGe+zzVSTPW8VF5+BA45Dxw==
X-Google-Smtp-Source: AGHT+IH3wOalvCTUmmNxL4d2BqWH9lL0Z711lP+HuvG3s42bYquFhA+L2zL3tvqbF0DSSmA0LWMWaMVm8D2V97MLcjU=
X-Received: by 2002:a17:907:968e:b0:a86:c38a:34e0 with SMTP id
 a640c23a62f3a-a897fad8074mr148633366b.69.1724923858101; Thu, 29 Aug 2024
 02:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <792a3f54b1d528c2b056ae3c4ebaefe46bca8ef9.camel@bitron.ch>
 <ZrY97Pq9xM-fFhU2@casper.infradead.org> <5b54cb7e5bfdd5439c3a431d4f86ad20c9b22e76.camel@bitron.ch>
 <ZreDcghI8t_1iXzQ@casper.infradead.org> <CAJfpegvVc_bZbL1bjcEbEh4+WU=XVS94NMyBPKbcHzAzyxM6_Q@mail.gmail.com>
 <ea297a16508dbf8ecfa4417cc88eef95b5d697e8.camel@bitron.ch>
 <CAJfpegsvQLtxk-2zEqa_ZsY5J_sLd0m4XhWXn1nVoLoSs8tjrw@mail.gmail.com>
 <CAJfpegtNF4yCH_00xzBB1OnPBHk+EP0ojxDPp=qCFVKC=c14ag@mail.gmail.com> <23a1d750092f4ae85364ee73b8efa1c7653db86f.camel@ziswiler.com>
In-Reply-To: <23a1d750092f4ae85364ee73b8efa1c7653db86f.camel@ziswiler.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 11:30:46 +0200
Message-ID: <CAJfpeguKFPpGUvS17hE032hus9hV51NcTYu_+atqHaiGXLHvbw@mail.gmail.com>
Subject: Re: [REGRESSION] fuse: copy_file_range() fails with EIO
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: =?UTF-8?Q?J=C3=BCrg_Billeter?= <j@bitron.ch>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Aug 2024 at 11:27, Marcel Ziswiler <marcel@ziswiler.com> wrote:

> Any progress on this? I can confirm that it does also fix an issue I noticed on Fedora Silverblue 40 running
> 6.10.6-200.fc40.x86_64. I successfully tested this patch on top of latest kernel-ark 6.11.0-
> 0.rc4.872cf28b8df9.39.fc40.x86_64. Thanks!

Planning to send a pull request with fuse fixes this week.

Thanks,
Miklos

