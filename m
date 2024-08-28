Return-Path: <linux-fsdevel+bounces-27511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6631961D69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 06:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E4D1C22050
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 04:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF94314883B;
	Wed, 28 Aug 2024 04:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="zU1dUMbe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63181459E0
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 04:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724818308; cv=none; b=RCDLMdmTI6iZ/YQs0DhuWSg+vGjzcKLcJFzV1YsS1q8i+3Gh9LsNtCteg8zJIee4AVccXG1gHILwDqdMChLB/4sclbxm216z+pydJIArbj0lp7DYeAiDij/RSImQwylBbrXJ0qUhwAlsVyBkZ/8H8JosPmW1y3QWHITJa/A+njs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724818308; c=relaxed/simple;
	bh=pzeoG0rGlcrMy0uwS6ASDe/iLtJVTfCYkQ0364ipMj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfSd2SVwRYVmkr8aORsMQwowdh46AtpJSKPkJ4iOmEGAvZbb+AZZro6oUDNlqb63+14Ddm0bIYJrXWb2YuBMW7CEsxKUpUJn5IeVQrA/zaHr7hpXQt/p3dn4IUQQ6Q8osBAPMx4+RJwV1ekES/jxf9g5P7zdegyHG0Q2PESsAWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=zU1dUMbe; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-201ed196debso56151125ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 21:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724818306; x=1725423106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QyONyGAsfyIYBth/dRKW+A3KYVHfTY8AXbPDXDua9oY=;
        b=zU1dUMbe34rV2B98hA9Qj+Kdw2Prcp/nT0OYYfgi4vU0lsVfOf01HkRm5U7tcNxkW1
         GyMmyazwfS3f5+ubWlR6UDCcQJ5RN94SVxtEZRLJ0D0WCCZgnuDRcSU1Fg/hG96pXsyr
         zFdvEDhYL+qMW3QfWcI4BWgv+GwLT2gtPCyDkya8kTbHw/qGNZDZUClEy09sTgidxesz
         x75bAOodPqUonz/7jLW69QV2CWeO0F6+LRLoNRrH0rJwa9dvAjkoeqZAUQ+xrcAQHOQV
         MB0lBUAMx/1yexkQtw7IwuZgRJpJcdr/nUbjw3Yscwiy25tGzPLkrlyDZbc1skdudLxu
         Dfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724818306; x=1725423106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyONyGAsfyIYBth/dRKW+A3KYVHfTY8AXbPDXDua9oY=;
        b=Php3RbaYCaQbgWjuzluuH4IZOug3e+QdZixB3Nc/Wiz7PsfHLqDC3b5h67GBOCzFbu
         BOSzUy/qzFYm2xeaQwk1/bjVBvxRUKq29c43X2zj2ltiCGm1X7nljo9GSSLRs7zc5btu
         h9wl03m7VgxuVnf9COgGLfyf2OiO88L9XVV/1USitRwoLsNbHoNH3mZ3c13B+OdOgzri
         PLF0OMZYYuT5BRS47FpvyCcUSXdRUfj26XkDCQioraYAc6hSGAtjzCCWTxMmUuH530QX
         uWKnSzfIcpNiVHz6BnK4e+bfNwMUq/bBkwUuk1L6XGEDa8zqvd5u0MB/w1lHTYufx65i
         D33A==
X-Forwarded-Encrypted: i=1; AJvYcCXteY9HDHhDvaIUx23/lCFHNNJ/omTHGyFPgYQN2Ej3Fz/k6wcDxUUUC4gVSM8hMIPqjVBokB5laZfj+UaM@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg5lAFE/syJ/ahJTKZTiJZ6VTsY/HDdvAWVy33ZBSa5eGGWbZM
	0bUnt/SWuAUJfqnew5rwcG+Fvk8llqWjHCnW6IeW/71FfPPTsILxigTXwTnBKiQ=
X-Google-Smtp-Source: AGHT+IHm6WjwDbR9jtAJuUU7LlUIPXWdDZCgm3DSqdlOs82lwk7RhW7LXL4hVMztYI1OEuh4ZaU3nw==
X-Received: by 2002:a17:902:e5c1:b0:1fc:f65:cd8a with SMTP id d9443c01a7336-204f9b7978dmr10468715ad.18.1724818305827;
        Tue, 27 Aug 2024 21:11:45 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385fc6c26sm90399215ad.297.2024.08.27.21.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 21:11:45 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sjA22-00FK14-2a;
	Wed, 28 Aug 2024 14:11:42 +1000
Date: Wed, 28 Aug 2024 14:11:42 +1000
From: Dave Chinner <david@fromorbit.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, jack@suse.cz,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: drop PF_MEMALLOC_NORECLAIM
Message-ID: <Zs6jfv2MrubpIckX@dread.disaster.area>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-3-mhocko@kernel.org>
 <ZsyKQSesqc5rDFmg@casper.infradead.org>
 <ZsyyqxSv3-IbaAAO@tiehlicka>
 <ZszAI7oYsh7FvGgg@casper.infradead.org>
 <ZszU6dTOJYmujMPd@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZszU6dTOJYmujMPd@tiehlicka>

On Mon, Aug 26, 2024 at 09:18:01PM +0200, Michal Hocko wrote:
> On Mon 26-08-24 18:49:23, Matthew Wilcox wrote:
> > On Mon, Aug 26, 2024 at 06:51:55PM +0200, Michal Hocko wrote:
> [...]
> > > If a plan revert is preferably, I will go with it.
> > 
> > There aren't any other users of PF_MEMALLOC_NOWARN and it definitely
> > seems like something you want at a callsite rather than blanket for every
> > allocation below this point.  We don't seem to have many PF_ flags left,
> > so let's not keep it around if there's no immediate plans for it.
> 
> Good point. What about this?
> --- 
> From 923cd429d4b1a3520c93bcf46611ae74a3158865 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Mon, 26 Aug 2024 21:15:02 +0200
> Subject: [PATCH] Revert "mm: introduce PF_MEMALLOC_NORECLAIM,
>  PF_MEMALLOC_NOWARN"
> 
> This reverts commit eab0af905bfc3e9c05da2ca163d76a1513159aa4.
> 
> There is no existing user of those flags. PF_MEMALLOC_NOWARN is
> dangerous because a nested allocation context can use GFP_NOFAIL which
> could cause unexpected failure. Such a code would be hard to maintain
> because it could be deeper in the call chain.
> 
> PF_MEMALLOC_NORECLAIM has been added even when it was pointed out [1]
> that such a allocation contex is inherently unsafe if the context
> doesn't fully control all allocations called from this context.
> 
> While PF_MEMALLOC_NOWARN is not dangerous the way PF_MEMALLOC_NORECLAIM
> is it doesn't have any user and as Matthew has pointed out we are
> running out of those flags so better reclaim it without any real users.
> 
> [1] https://lore.kernel.org/all/ZcM0xtlKbAOFjv5n@tiehlicka/
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Looks good to me.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com

