Return-Path: <linux-fsdevel+bounces-46306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F978A867DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 23:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C17B4C3C70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 21:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BB1280A37;
	Fri, 11 Apr 2025 21:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAKuqloR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1449F23A9AE
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744405377; cv=none; b=Wjhrpc7C82h43ChG7xHANrezoZL7nJMY9vU+r1BQvbm2joJ5GUr6CO8PjQ/BPv50OEmm8HcTQGZyBXMDKMdQUQ5Op7LzeaZLY3P4Zf2OUXssFxtUbPaVtV7YPHdSsSX4GJjYn+oL0cAsByigedzMPkWQsSj4qCmkjMwriSXQ/a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744405377; c=relaxed/simple;
	bh=vIH/f7PDE+RmYLbSA8keMAULZynyC90xcfuVIsM3NXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4KMgdLZ/rEDzUPiGzUnASE+jzmKEb0yT3bpwO5L7Z13JlmjYQPEUV+MK7NeShrblEwuzZsKqe2INlUM7nt/XwDKu0+yQT+KPQ6GkEdcL4m8XrS3mUUfSuU6kLYkXrPN+TKgNnJ0Z6LTjY+sYy0jetzhLUPbwGeJEwDUECurC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAKuqloR; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so1512977f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Apr 2025 14:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744405374; x=1745010174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zx/Ps81D1wUAxnvwxwG/eiimmAhng/9aeMmJYUs/3yg=;
        b=NAKuqloRDd3YaEBo7L4SezVZ05KKPw9Mr32nEdLkIZHn9TwF/xYvcN5a5PhKhAP/uZ
         +slxH+w6cPoGEs2T5aJ4Ev3xwOY0XV8L5971FT8z9VuecWNFZMfOiVq4C4BmCHGhn6xt
         8lMPlE2Q1RvcoKg218s2GD6cmClSTfWgJI4fgr1798kl5IfOgQYD/diYXlMrdrGq3Skn
         H61Lw5o/aG4ZxylVwuRPvhJZJ98mQGdADDhvjIMy++H7emdkbdJMTw7ti2z8J9VTPptV
         LlXooarx2x4KiFjv5ktQkao0NeiA3gPpzOW9bMpeow3miknJzOiimD6FY//GTUTnu5BM
         Ncmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744405374; x=1745010174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zx/Ps81D1wUAxnvwxwG/eiimmAhng/9aeMmJYUs/3yg=;
        b=Kf/Xd2+yNQcqCvx0sgK00Q9PrLpR/ZLKmYVTkObHRBqYgCfGwb/idTG1DXR+XRq1gZ
         +aoObBRQM4OxQmj6nWs4+c2GXijHLwsKeTcUIKCXmec8eYbYn1GhzKGt+IuyURnAOoDg
         UC4z4n27kiGehzNMsvuCnRMWJ/Dg9kqG9CEI3vFNbCJM5apD6aua2SOBYV6VPI498RRU
         d6+DYmbg9PZJCA1Oyt4DBh9jGNK23X5hDGlyrtHpGJb7HQL4/qLFbYBDSESZrBEXZRCu
         WfFOkgxOG9+HXRznJyRdrLDsZIKKzvEE4TMSZP/AiP6fZlguHGdoYjg5ZoG379ljFMhM
         y5hA==
X-Gm-Message-State: AOJu0Yx3yTjmEOHUWoBTTcuEXLqvYeN+F5M9GY2FWWmK8JP9fMUnAmah
	CSx1y758j+FnHo/HslFqE0W2qXXNuXlhUagvv1zAaMX4urDa1lsp
X-Gm-Gg: ASbGncs1QVC1u0uA1ZWdGqgcKdh/dEaUybeYAsD9guX59c8VhJNrbfe6yPnFbbVTk4A
	asLMO9dFDwKeOTOlQPkR462M6wgFFk8GWniIAzgT9M9tWoC3yhfd6RXB4Kc0xaxBkbdvC2zH5bD
	ny+H1EGE2/7AHMH8EgfdL1eQIAaFzFnZF8veqnxlC5UoayZKOn07an4w4hXYBfV4AnzPFdJ/JtW
	WCC5ITna2N18auFc3OOoypll6l0L8Bdi4aepONfZDwQTn7U/HT++HCj/U4VbQFtr2MSwgYC+Iyp
	rEB/j5XcvlzCpj83YWGxfUXPXD4K5U3dAVwuAdnYjNt2H4FrIMYh/w==
X-Google-Smtp-Source: AGHT+IF4eaReYBsbwO38scH16SQd4RghP4gf4E1xTonHwhHWv/dvG/I2KU1KI10ULlMK/txmhSYgcA==
X-Received: by 2002:a5d:6da4:0:b0:390:e8d4:6517 with SMTP id ffacd0b85a97d-39ea51f5dadmr3470469f8f.21.1744405373945;
        Fri, 11 Apr 2025 14:02:53 -0700 (PDT)
Received: from f (cst-prg-90-20.cust.vodafone.cz. [46.135.90.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96c614sm3220589f8f.27.2025.04.11.14.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 14:02:53 -0700 (PDT)
Date: Fri, 11 Apr 2025 23:02:43 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
	Ian Kent <raven@themaw.net>
Subject: Re: bad things when too many negative dentries in a directory
Message-ID: <e34pa3nuduyjztrm6byky6sipi35ue5pyip3ro7labmb7rxl7w@skxqzxl23hw4>
References: <CAJfpegs+czRD1=s+o5yNoOp13xH+utQ8jQkJ9ec5283MNT_xmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegs+czRD1=s+o5yNoOp13xH+utQ8jQkJ9ec5283MNT_xmg@mail.gmail.com>

On Fri, Apr 11, 2025 at 11:40:28AM +0200, Miklos Szeredi wrote:
> There are reports of soflockups in fsnotify if there are large numbers
> of negative dentries (e.g. ~300M) in a directory.   This can happen if
> lots of temp files are created and removed and there's not enough
> memory pressure to trigger the lru shrinker.
> 
> These are on old kernels and some of this is possibly due to missing
> 172e422ffea2 ("fsnotify: clear PARENT_WATCHED flags lazily"), but I
> managed to reproduce the softlockup on a recent kernel in
> fsnotify_set_children_dentry_flags() (see end of mail).
> 
> This was with ~1.2G negative dentries.  Doing "rmdir testdir"
> afterwards does not trigger the softlockup detector, due to the
> reschedules in shrink_dcache_parent() code, but it took 10 minutes(!)
> to finish removing that empty directory.
> 

I wrote about this some time ago:
https://lore.kernel.org/linux-fsdevel/f7bp3ggliqbb7adyysonxgvo6zn76mo4unroagfcuu3bfghynu@7wkgqkfb5c43/#t

bottom line is only a small subset of negative entries is useful in the
long run

while a great policy to tame the total count while not hindering
performance is left as an exercise for the reader(tm), I outlined
something which should be *tolerable*.

