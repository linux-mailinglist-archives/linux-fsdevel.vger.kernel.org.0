Return-Path: <linux-fsdevel+bounces-23209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E55928AE3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 16:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830C71F2437D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 14:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73903168490;
	Fri,  5 Jul 2024 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="sVN/8k52"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F341BC43
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jul 2024 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720191150; cv=none; b=VsFuV+epg2YLPAM5OXzrkZwu+s9DJZoeZ48l4LuSH9blB+tanWporzOTviKTGvF76LuiEoAGtX0g8nvO2g/zWADjv3/eK6FyVnrCXoWmcP4tQqSeP8T8fnpAALJpat9XM5UmBSieqEQ3PUhGnfPAeovKukl6GGgAcKr9Y5wKjh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720191150; c=relaxed/simple;
	bh=Cl714NzMIa+kX2c6zt+5FrrMaV95GBw+5lyJhZCRXsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqkzcpfP48MvdQpTtBrZXgiZRVFfnQNoB7qQlApYbhkJelDz7TX+TPLPukeBiggxAqti8K3Btig5PkQ2fEVC0vI4aCHkKURmIkliNFSkDeDdecW05KOyijZkFqZpdhaDTPgHlKYEjqdbUjGDQgwQbwgqSP+b7mhPRUfSI08e2EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=sVN/8k52; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b5f90373d4so4953366d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jul 2024 07:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1720191147; x=1720795947; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OEbb0pkWNXxPYbDy9xDK4A6PxBSjxFiyLraknK9GPMo=;
        b=sVN/8k52DW5qdDyPvXo//ahj+goOFOSZVhq+MD9+jA2GWfu2dyKYJldewgJIv9CS9b
         yb/4W5A8nAXg6Qyatsje61ojhzRgr/eswhdWe5LP94Upjjx1+fspEqfNOjEKKZCFBFVh
         ZV89QX2rTO90QAVNxiUqJCkMmtJkKBWtl/rdyi0UOnDDj4WDRHuYUxA845fQlc7U6EVp
         cgK6Yr3uEyjyECQsQNR8mMnMUu7FuK635iIYFXsvX8svi3iEwzHTLwV5yI+ZfAuY0j7/
         NkICvmaXKHAHCxbDPzmt9vwSpTXvC7XbEUgddblcEmaTLWjei8Mh3/0v2G3/coVMmaHD
         yiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720191147; x=1720795947;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEbb0pkWNXxPYbDy9xDK4A6PxBSjxFiyLraknK9GPMo=;
        b=XTz9h2uk+/H+BcmXnLHLnsNr+k8RGa14U8wOZCEdQ7gwj7NTZRP//rEdsVOfllwIDQ
         pTYihgefs0R3aNQ7Cu1qteWJcOD63LM7GW8EpKyyyfPHu1RLYjQnFFWw/MoagDORKIyd
         jDRxfm8D6leLlckqUhvdzeAhbKMWEwOWVbnZLyhObxP11g3oqQ4CFyrbNQ8p2FPafSI5
         eZWzMCntqu8ouCII2Y5P0USGfxYtLvutTZQ0EhBBt2Rl6GguhzHGkIb+Vcfa//qASMn9
         orKb5t53BSnttR0Z82sHltcwc0mW8LXeez/HzIbx66Ha+hXaQcHrNqU76IFlEgMWLCiw
         dC1A==
X-Forwarded-Encrypted: i=1; AJvYcCVdMQK+DlSV8rAltoEP8EcnghSaR6qQDMeGX7RK27I95Tw4VRdhD1uo4Q1QPg+Ex72afwl7AsXxCmIQRY9JvcuV2qo2q1oPAb3HwgvZEQ==
X-Gm-Message-State: AOJu0YyK5VmIscwTq2oBsbgRbSrV4KUdFAMUmBup46mQmasIMEewnuMD
	qdX5ZHfLTPzPDFVg+GyACY2BRzjU0eL5sD7pe1hl9/UA7P9qlS6zkxcbxBGX7hE=
X-Google-Smtp-Source: AGHT+IEIWWwR9IYxgW4ZDzZkAuJanj+INhoy1mHpphrCLtiujAt/1MiEuhXKw5rrlxXpAMh9oDFKAw==
X-Received: by 2002:a05:6214:4006:b0:6b0:6e81:9ec7 with SMTP id 6a1803df08f44-6b5ee6db67bmr47924576d6.31.1720191147648;
        Fri, 05 Jul 2024 07:52:27 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e369dcfsm73486486d6.27.2024.07.05.07.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 07:52:27 -0700 (PDT)
Date: Fri, 5 Jul 2024 10:52:26 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][RESEND] fuse: add simple request tracepoints
Message-ID: <20240705145226.GA879955@perftesting>
References: <fc6559455ed29437cd414c0fc838ef4749670ff2.1720017492.git.josef@toxicpanda.com>
 <21a2cfee-0067-43d1-b605-68a99abd9f53@fastmail.fm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21a2cfee-0067-43d1-b605-68a99abd9f53@fastmail.fm>

On Thu, Jul 04, 2024 at 07:20:16PM +0200, Bernd Schubert wrote:
> 
> 
> On 7/3/24 16:38, Josef Bacik wrote:
> > I've been timing various fuse operations and it's quite annoying to do
> > with kprobes.  Add two tracepoints for sending and ending fuse requests
> > to make it easier to debug and time various operations.
> 
> Thanks, this is super helpful.
> 
> [...]
> > 
> > +	EM( FUSE_STATX,			"FUSE_STATX")		\
> > +	EMe(CUSE_INIT,			"CUSE_INIT")
> > +
> > +/*
> > + * This will turn the above table into TRACE_DEFINE_ENUM() for each of the
> > + * entries.
> > + */
> > +#undef EM
> > +#undef EMe
> > +#define EM(a, b)	TRACE_DEFINE_ENUM(a);
> > +#define EMe(a, b)	TRACE_DEFINE_ENUM(a);
> 
> 
> I'm not super familiar with tracepoints and I'm a bit list why "EMe" is
> needed
> in addition to EM? CUSE_INIT is just another number?

This is just obnoxious preprocessor abuse, so you're right this first iteration
of EMe() is the same as EM(), but if you look right below that you have

/* Now we redfine it with the table that __print_symbolic needs. */
#undef EM
#undef EMe
#define EM(a, b)        {a, b},
#define EMe(a, b)       {a, b}

so later when we do

__print_symbolic(__entry->opcode, OPCODES)

OPCODES gets turned intoo

__print_symbolic(__entry->opcode,
		{FUSE_LOOKUP, "FUSE_LOOKUP"},{...},{CUSE_INIT, "CUSE_INIT"})

it's subtle and annoying, but the cleanest way to have these big opcode tables
that are easy to add/remove stuff from for clean output.  Thanks,

Josef

