Return-Path: <linux-fsdevel+bounces-35926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B3B9D9AFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 17:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F9C283176
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 16:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB9A1D47BB;
	Tue, 26 Nov 2024 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DjLmNYfg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69F43EA9A
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732637073; cv=none; b=PSheH/ZA8YqZGQ0YwwT/j0WHvwwA+CTmpZpygvLdpmuwABp6TMeGyfw/VDfsK24++89wBpGI24NxwSb6m0f1/HfztMilzZQ1wnrzZx1imSC77GBNC/JBxGPHjbizF/jkz5bBie/NQD2k7RvT8y18cUOhtnGrkDCNdGDYlNkFUHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732637073; c=relaxed/simple;
	bh=AKSDaqx/4etPljZDMYK33mkBXajknuN6+uRkb/9oKtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7T13LEX1oA8wBtofvAd6MoSlSuSdv0ILBpB/PGnkpPgO61gRetj6WVUFBEDRLu2EBbthQoKTB2crpvEZjWRQr96ebv7nGALoguf9LSZ/9X/347tGJULdSGUDEjtkXm1fDUOr2ubwH7Kqa967yN40VNqfnN5mpahk8WM6IlAas8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=DjLmNYfg; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46686a258c2so23374451cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 08:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1732637069; x=1733241869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AKSDaqx/4etPljZDMYK33mkBXajknuN6+uRkb/9oKtE=;
        b=DjLmNYfgBp9eXmZ0IpkPAwPJbOrm0VOoPfMEPjZgEOYaXq9qmkSErebO0i6jtgXLiz
         4X1FYOrv2TFPxLAxjJygJ5DdCAW8pDDWl8Or6SzJEO5gdVedCu3ppxHEl9EDTVIFnqM9
         Ii2bnliA74K09rkY33kDh1KStXTvp6mz2X7LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732637069; x=1733241869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKSDaqx/4etPljZDMYK33mkBXajknuN6+uRkb/9oKtE=;
        b=So3xjBd1ybE42eyaCJB0v+RUoT3b/82tMrr+Bsxkm4mzQWon49b8BkIj5Sv0pYHnuP
         /x1X9iE366surC3+qexUIVlBUcITtDmem1stkS0RDPRlZ7N7KxSFhsohKcaxQJG1OYRI
         IEKoH+fA7CW7wD8AectaP/Na8ei6ylSm9PY8FNFeMXbp4jfO4Err/ax5Dj5gPz4aW5wO
         jrG+BtFkdk28V5FQNc2/UI/X5NuJqtgC/kaoUQmbBPg6SX7faTbPdb+ohfnGXMfXws+y
         gnyWtqgmGc4LTmsRSB+EnDELQeTN53Ma6pBGlPaEH9L5HrU+nWGs+UwoXOOGTD21mMib
         qcRg==
X-Forwarded-Encrypted: i=1; AJvYcCX/HGcklACEwj5OmqAiRG82zGZmR5bAgGzwQjKp9SUTGqCwaiCPKtpe03rugSqEADdPWi6pzC6/RNH70WaM@vger.kernel.org
X-Gm-Message-State: AOJu0YxJtwOdht+naAkAjXo0miNI/xve0VTuRfmNTaUkdBYZNHavnIG1
	/WjufknEQM20fhqqtiA1wlnqXBon4GfGCsDnSSSsE9k/hJ43R+ojqGThuXT9aS/TbboA0Fkj2H4
	+4Xwgcl04vgHOBii/30miKMQLbXGR0UQDmWF1fQ==
X-Gm-Gg: ASbGncvWR8ITbNiECWfagCpmK6crLUHvGyQ4VTxqOlj99PzP+FHL1ngNDFq7DH8vrI/
	6CZ9TWLLkVMMgTkZsdeA4574kMPmPiJxznQ==
X-Google-Smtp-Source: AGHT+IHZjgV4CkWJV0BjmzxHkmZyvhwVqQFY/zZXrMjjUEuaIMDUaghocl8+HGtVr63vyHCOCtQZlVnlXZB5NV2JqBo=
X-Received: by 2002:ac8:5746:0:b0:460:ad52:ab0d with SMTP id
 d75a77b69052e-4653d5687ccmr242641021cf.16.1732637069116; Tue, 26 Nov 2024
 08:04:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126145342.364869-1-amir73il@gmail.com>
In-Reply-To: <20241126145342.364869-1-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 26 Nov 2024 17:04:18 +0100
Message-ID: <CAJfpegszebgkN+vGJrzPTbdmkebQmAa0_921KSxa2QOTkbaSsg@mail.gmail.com>
Subject: Re: [PATCH] fs/backing_file: fix wrong argument in callback
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, 
	syzbot+8d1206605b05ca9a0e6a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 15:53, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Commit 48b50624aec4 ("backing-file: clean up the API") unintentionally
> changed the argument in the ->accessed() callback from the user file to
> the backing file.
>
> Fixes: 48b50624aec4 ("backing-file: clean up the API")
> Reported-by: syzbot+8d1206605b05ca9a0e6a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-unionfs/67447b3c.050a0220.1cc393.0085.GAE@google.com/
> Tested-by: syzbot+8d1206605b05ca9a0e6a@syzkaller.appspotmail.com
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks for fixing.

Miklos

