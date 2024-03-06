Return-Path: <linux-fsdevel+bounces-13818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9CD8740F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 21:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D1E1F23929
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 20:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4128D13E7E7;
	Wed,  6 Mar 2024 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="nxITYk6F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ACF13E7DB
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755200; cv=none; b=cStXN1aupUPNM/GZje4iRGFwrYBsgklguS4orjhCequCGtVIWcxOAXsebBNyz3Qj6rAga5vytZU/wIRk2dO49yordWSw58wZhdaSzmg6hk7+A9nHJ5na5eAghURpkGDQP1rzn0i5z6o83AI+arIzvfaBPfg0xuFEqsTk8FBGLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755200; c=relaxed/simple;
	bh=MJQooKERrkO5M8FdxXsbgrCB1vQwZZRXngnYowa1Ucg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pe65pBlBd1Bx0zKEmUyHbC4sM1rYEoyO+BbJg3S1oyZdcZwPBePSK2M0pIAQJjAYaRYSocl2a/asA0CRxqSaAIDA6TS06NUJF1HxrawZEFyRL1ngtP2b02AGP7wF92wdyzjfpaY/mj/1pUmDZkgJmtntDZCXsjIcWI/4EoLer1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=nxITYk6F; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6098a20ab22so888247b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 11:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1709755198; x=1710359998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nk0/J29KPf4TmmeCSNMEsRp4h+k2/fvkEQwAaLlHWxs=;
        b=nxITYk6FUOJOhKf/sKhG47NLK2mwoGTzHmTNNhxNIk7Bj8T0g3ZXECO7EtcSbbER1L
         XjxBYhZohxdwY4VBAYKuMI4JSwJEYP2iAigz9VB0licnoowBnxfUxJ9tGsxhL5sZow5+
         sOkvA06fPJzle4rR3N4lrtCRMvFVd1tv6txgRiDRczMNjT3LuReoqnwbMQf7Yqx95zzO
         mde9jwIbLHrz1zpSU52WxOFTXRGf9+TA0pTf5na5pOZvEySIAMVSz+RHkZHJFSTsoiwT
         WJyfZSZrEu56E7OmanKvlynbnnJAqGBgJtm3YxTqt8khigdtDEZGkQq6smn02PrGzagD
         k8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709755198; x=1710359998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nk0/J29KPf4TmmeCSNMEsRp4h+k2/fvkEQwAaLlHWxs=;
        b=MmaEjhO1+HYUZo8sTfWxJMjVpPd8Baw02fVFV3qOvtv3ZeYGP9ZzlW+fZjX+8Rp0gb
         /ZNqlBTsQ+b5V2jU0NHwFUeJEI3m1Ckcr6tpJHNUTDU7XIfvl1Kg2sDnyBqeoqhhLAeS
         ongS+J0+pV2y2eWJr7G0RPNoq+s1jaLt2MdvkN1CTlCNqkLDTliTgoC/HxS50iHKlDOs
         EcV0YA9Jr/kFNK8MGqOeynvHOt7vOKmlPEteIxNBxC2S1I/oawAN3duvIac+0jj0Ufk7
         PrNOHNMHJApfACyVjCjpW2MuCAKYCudChApAgyee0oEgxju0mIrX1HKMJK7WkhBNV+Qp
         C10w==
X-Forwarded-Encrypted: i=1; AJvYcCX3jf2prrX5EpuZHfwnsf7Y4H492chYPJ0uToD4WQnjISyk+rRzXdWacgdgM2tOuH2FZbmSIU9lmT9jlybL4wCLJi0qQgy6aYYAF3v2AQ==
X-Gm-Message-State: AOJu0YxvykIihr+xqh4asE8B4TcVRuG+JSECggf8p/gDUxstIqweeKOo
	878v3mTkIBVGSNtK4mDKMGTRLxcXljRCwKVuYkUYFp+RAglTY4yZuqOmp0UnBHLsfZbUCKCUur+
	B
X-Google-Smtp-Source: AGHT+IEmVpurGUd31yZyHxSu4mjLVka0+r+yTrQMWzelFcoJ23tJQXn1JppRqRT3evd2Ke2EuGrRpg==
X-Received: by 2002:a81:8784:0:b0:608:290d:9f1b with SMTP id x126-20020a818784000000b00608290d9f1bmr14538562ywf.49.1709755197926;
        Wed, 06 Mar 2024 11:59:57 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id r13-20020ac85e8d000000b0042f02284578sm1888194qtx.68.2024.03.06.11.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 11:59:57 -0800 (PST)
Date: Wed, 6 Mar 2024 14:59:56 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] statx: stx_vol
Message-ID: <20240306195956.GA2420648@perftesting>
References: <20240302220203.623614-1-kent.overstreet@linux.dev>
 <20240304-konfus-neugierig-5c7c9d5a8ad6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-konfus-neugierig-5c7c9d5a8ad6@brauner>

On Mon, Mar 04, 2024 at 10:18:22AM +0100, Christian Brauner wrote:
> On Sat, Mar 02, 2024 at 05:02:03PM -0500, Kent Overstreet wrote:
> > Add a new statx field for (sub)volume identifiers.
> > 
> > This includes bcachefs support; we'll definitely want btrfs support as
> > well.
> > 
> > Link: https://lore.kernel.org/linux-fsdevel/2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq/
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Josef Bacik <josef@toxicpanda.com>
> > Cc: Miklos Szeredi <mszeredi@redhat.com>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: David Howells <dhowells@redhat.com>
> > ---
> 
> As I've said many times before I'm supportive of this and would pick up
> a patch like this. There's definitely a lot of userspace that would make
> use of this that I'm aware of. If the btrfs people could provide an Ack
> on this to express their support here that would be great.
> 
> And it would be lovely if we could expand the commit message a bit and
> do some renaming/bikeshedding. Imho, STATX_SUBVOLUME_ID is great and
> then stx_subvolume_id or stx_subvol_id. And then subvolume_id or
> subvol_id for the field in struct kstat.

Sorry I had my head down in some NFS problems.  This works for me, I agree with
the naming suggestions you've made.  Kent, when you send a new version I'll
review it and then followup with a btrfs patch.  Thanks for getting this ball
rolling,

Josef

