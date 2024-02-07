Return-Path: <linux-fsdevel+bounces-10679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CAD84D5A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 23:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999FD1C21E64
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 22:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CF16BFC2;
	Wed,  7 Feb 2024 22:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Hw1eNxGL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF3B6BFBC
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 22:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707343587; cv=none; b=ScD2Gf/za2d+E/boGUVGWuOaHmumit/ff+MqdZqq6nvZVlqIKbVAVcFKPY40veN/htIpf14RoTg2ePmqB7g3MMwY4wus7149O5ONgxQCJ5B0gTeeMdnbBmtHpt5sgZix5bonlqWvA5vIPO8q3Ks+bnfbOtKM5lwl74JkL2NHyMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707343587; c=relaxed/simple;
	bh=biGiqT1l0QFYXMIaYo2XtLzf7q4ntlc3YaIsGTidqpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDQCNLXHLnmChtl7vMIy6T8cU9DzOcA8NmZOvZmSC6watqmZNYV3Kb7ijisai0aZR0mhnSmp4ATZJC4vWunBNLkupl+UJBSyfXM7GaLu/yHTbrcl6yHiDMHnvuqkbONsgZicylIq8WiQ96O8DRxF8TGkuKfeS5q7szECVprkcLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Hw1eNxGL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d51ba18e1bso10677275ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 14:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707343585; x=1707948385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0HPlTRrq5XIK4MU9sqi2YJQ/4Dwpwv3sEVymNXTSZPU=;
        b=Hw1eNxGLIe22gsHmyVzWKzr5+0LjchZdFf9BIRLk1ai4QASWp8tSh3iJTVoUNqJsi+
         BoRTblKZ04iIPCMgfurZ7nAmFc2n6NdI6hP0n5RWHyh92r67Jik67h9TVJlk4xcJEPPZ
         /IJgoiO+UXcCJFFhxNzLfEk5k6Nn0XyZfALHnpWFS8qPdlJ5a8owkEQBO9KlHdLXUWQ8
         XIbF/Tv54RiI4E3gBoNiF2TDOLBzIhreshpyE7H2xHi71A7gdFXFpgz4zuzwX7jt/IqN
         bP4hLZh1JNNJ0CfLEwS54JXpOSq9aEzDtKOQapgEFtQOuKI/9l+Ph9CQUiLpJ+IzlHqT
         sRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707343585; x=1707948385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HPlTRrq5XIK4MU9sqi2YJQ/4Dwpwv3sEVymNXTSZPU=;
        b=wcOFQdUTPNx5H9+BwvKC3gyediUk7FNbv+5IWZPUtzhfe4kKk6D+vxmhqgRRuOBosf
         6zgiZRtEYHRb4zRtPDqYuqpkPYhsQ3t95ZqkRHv2hxkr6avPwFh11+bLAOkK6LCTnraV
         7uXUmr0wzDKMnHjo8sGAkJh4jBltYZgLWZ1OaWceKYgW9nn25X6TOqaxIFxV8M3E8+K9
         mCi+iLPIyFYq2iXYuvCGtw9NH3yI9gnmMk/QmxJu0Cs8nOfxtvsOwh1YymmepcufxVHO
         FCJ0ZJ28403a8dqF4BTjKFYcOZmOYpTlrvtHvhq02LzyM9CsTehW8g63OJdyekGw0M49
         PUNA==
X-Forwarded-Encrypted: i=1; AJvYcCUAw4rav6kpZibUa9lDOPB+kdv/9wTZfJHMCbiGogiuIIdIsabcEVgCoMkRk2YXqqKI6zJ1oZkRWOkYTtIHoVRtCUYp14RRb4A2s1/xzQ==
X-Gm-Message-State: AOJu0YzKQHq+kDEQtH//aPkjUHxtFMvNJmMMR08nYReHliaepI99pdSA
	2hwICw8QTZV/jXqFb9QkW4RIeg+sMo3VPHgji3KXkgloiEa+4Sg7GzgaH8EGPCI=
X-Google-Smtp-Source: AGHT+IEhyFU20nP1sR3Yrh/yUbO6pPsFF41j8NLc6rl7iWSz6JsuuaD5fOr42NFka2JUonH8lt7c1w==
X-Received: by 2002:a17:902:f815:b0:1d7:48ce:2046 with SMTP id ix21-20020a170902f81500b001d748ce2046mr5308980plb.29.1707343585277;
        Wed, 07 Feb 2024 14:06:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWxBOfCoZoyhAAVBl7YO6vgH2TPG9O2ovCytRQD2OgJK4As5anXrg2jua6y8RajQO0oHThSkhIPNyM343hWaIX+C6dn/JV5NPgwrLlineDTtfAaofZQySQ5ZvsjnPV+0KLN0aU5JiGSfKTYpILL2nGzm13eockgurE=
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id jz4-20020a170903430400b001d8fe6cd0f0sm1954964plb.150.2024.02.07.14.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 14:06:24 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rXq3i-003SAa-1k;
	Thu, 08 Feb 2024 09:06:22 +1100
Date: Thu, 8 Feb 2024 09:06:22 +1100
From: Dave Chinner <david@fromorbit.com>
To: Timur Tabi <ttabi@nvidia.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"michael@ellerman.id.au" <michael@ellerman.id.au>
Subject: Re: [PATCH] debufgs: debugfs_create_blob can set the file size
Message-ID: <ZcP+3gqQ+LDLt1SP@dread.disaster.area>
References: <20240207200619.3354549-1-ttabi@nvidia.com>
 <ZcP4xsiohW7jOe78@dread.disaster.area>
 <6f7565b9d38a6a9bddb407462ae53eb2ceaf0323.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f7565b9d38a6a9bddb407462ae53eb2ceaf0323.camel@nvidia.com>

On Wed, Feb 07, 2024 at 09:44:19PM +0000, Timur Tabi wrote:
> On Thu, 2024-02-08 at 08:40 +1100, Dave Chinner wrote:
> > i_size_write()?
> 
> Thanks, I will post a v2.
> 
> > 
> > And why doesn't debugfs_create_file_unsafe() do this already when it
> > attaches the blob to the inode? 
> 
> Because it doesn't know the size any more.
> 
> The 'blob' in debugfs_create_blob() is this:
> 
> struct debugfs_blob_wrapper {
> 	void *data;
> 	unsigned long size;
> };
> 
> When it passes the blob to debugfs_create_file_unsafe(), that's passed as
> "void *data", and so debugfs_create_file_unsafe() doesn't know that it's a
> 'blob' any more.

So fix the debugfs_create_file_*() functions to pass a length
and that way you fix all the "debugfs files have zero length but
still have data that can be read" problems for everyone? Then the
zero length problem can be isolated to just the debug objects that don't
know their size (i.e. are streams of data, not fixed size).

IMO, it doesn't help anyone to have one part of the debugfs
blob/file API to set inode->i_size correctly, but then leave the
majority of the users still behaving the problematic way (i.e. zero
size yet with data that can be read). It's just a recipe for
confusion....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

