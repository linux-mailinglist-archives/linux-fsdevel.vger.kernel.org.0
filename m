Return-Path: <linux-fsdevel+bounces-23831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45881933EDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 16:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B312838EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 14:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE2518132F;
	Wed, 17 Jul 2024 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zJs5e4BU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5C71802C9
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721227945; cv=none; b=ICJvxztvvDd+4dELQGgiC0jH3kzZUrE+IqLiYITwR5s7ntC/zCjI+lbYjaTZ9quHOuCQDpWtk1+A+rHeOa2ofD49oqGw87KXH8YlscugkfMb9+cQrkpraZI63XI/Eb8575sEkbFv9ROstCthet4wOPAScwMQDBLrfQEf80zYV38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721227945; c=relaxed/simple;
	bh=y0JG3y5aoaDgqtLCYQJrI8S7T7ICF5GZVV88Q9b3Y0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4uB9vsKe8ymtePHUbaJV5mX/GOb5T6L8/7SFjydtxZiBKHfpLq7cwH2mDCbT1H5hWUmABI1M1k/FVDi8vEo0gi+gtsOdO6tGrXsurAuH5ujEnkygFazu7/DDHCIaj6mKWKGj8PhW47BzQIqrb5GulG4pbYE1Nyz/A1HjuVFT7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zJs5e4BU; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44931d9eda6so7832691cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 07:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721227943; x=1721832743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nb+Eut1zi4iEeMHx2j3pvFjfg9gPbVdzAuF7tqYkdH4=;
        b=zJs5e4BUo6fPNZFT7wrmORHWsgosGk2S90zdtkAHfgA97OlLmrJ5I01QoeHF50jiCS
         owPQXIthw+i6OAujQ9ASdMaxZDiflBqCfP4bAPTDOG/aOkS7vDC2giTMkOHOGhUckaze
         evEoc6LfxMhQZ4hfX+DMvETNfTRk0lR3noJSGam1kPbsz6g4xLqdpFMK7d8tGqc1PoIl
         sMBlv/9hI9AhA9NWDOtZ4DIdfh+BzYoa0/Q5ytrQQwGQicLdc+Z0WRxDO7y9dhHVgS9n
         WJ3Ky0fOQQLU1iapGc4M3e1sdd/Lp2v4CcdkisOoq8DU3A9M7XO6Wq1uy2ypI1WcFu/W
         6tYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721227943; x=1721832743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nb+Eut1zi4iEeMHx2j3pvFjfg9gPbVdzAuF7tqYkdH4=;
        b=Y4JzzJXg5bg3sQQj0akWJ2amnrPd8l88kgw/Dj17rpOtCrB4HN37W4Lq42CYNAV1fq
         s1pIOhczFq0vUwINL6BQdPhemBbpus+RkJCtlLQ8q7jMR8UYfot5lJ5FoujLDQElCd+s
         H7Jerk+/rIS27zFtERSf9CG8ydpGca5SeAHjysSs0ZEAsMD+iDdf3Il8lDHyvk7GgGe8
         VO6w7k4xy4SdI9dW0cMGH6FgUsYmEn97w3a/TwcGBw7AGndNQzxwnPO/bONgesNFiBkb
         z0k4L77EhLr9xbxNy2KfXLSPqczcss4dMiDByEyfRw9fl8KYXHoOrwjYxq/44m25um+B
         4YVw==
X-Gm-Message-State: AOJu0YyUbRrGIZT57/fRDiUTj3nE1NN92Kfi0hqXANFSfmCtilr/fPVT
	SflEWw08r2+CIlfrbqoeTPgB/FvwcDqnLmvuzD/MnpoPwU/b8T4x529E5KaZxg8=
X-Google-Smtp-Source: AGHT+IG1WFqg5If+GY+K2e9/wAbvqVvlLxI3Kauca5EzviZVCWo+4ns5/R5nLVsj2qZhIcCZX00BJQ==
X-Received: by 2002:a05:622a:1a93:b0:444:d42a:c522 with SMTP id d75a77b69052e-44f7c9f9bebmr89737451cf.4.1721227942636;
        Wed, 17 Jul 2024 07:52:22 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7f9b4asm48634211cf.54.2024.07.17.07.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 07:52:22 -0700 (PDT)
Date: Wed, 17 Jul 2024 10:52:21 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] fsnotify: Avoid data race between
 fsnotify_recalc_mask() and fsnotify_object_watched()
Message-ID: <20240717145221.GA2016929@perftesting>
References: <20240717140623.27768-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717140623.27768-1-jack@suse.cz>

On Wed, Jul 17, 2024 at 04:06:23PM +0200, Jan Kara wrote:
> When __fsnotify_recalc_mask() recomputes the mask on the watched object,
> the compiler can "optimize" the code to perform partial updates to the
> mask (including zeroing it at the beginning). Thus places checking
> the object mask without conn->lock such as fsnotify_object_watched()
> could see invalid states of the mask. Make sure the mask update is
> performed by one memory store using WRITE_ONCE().
> 
> Reported-by: syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Link: https://lore.kernel.org/all/CACT4Y+Zk0ohwwwHSD63U2-PQ=UuamXczr1mKBD6xtj2dyYKBvA@mail.gmail.com
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good to me, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

