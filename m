Return-Path: <linux-fsdevel+bounces-28600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353D096C4A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 19:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A4F281818
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 17:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F149F1E0B7E;
	Wed,  4 Sep 2024 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dO4blEU0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8886F5464E
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469278; cv=none; b=KEEqnVvVlndLCkKkBAfpxcBZso/R96FiPl+jIyZ2NQyKX6oqN6GD7iwAp1CNiZYwNKrFHowmlE6vgPv4SCa9zF+EIStplWIROwJXAdfHYaz2KfLi9VBUE5ukiHDWkY/92R9yxsOfYm6s7XeXWPH9bm7FCpnSEti8Zj4SbiZIpZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469278; c=relaxed/simple;
	bh=SMwfMxRbhIejqPpvJ6rfUHRCXekvUWgpLlZca+d08ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXvESwIu8lWYJczHZny5sn3SQV3ByyW8FN0gN/1h7ZTYZotKarsVHfqXWd2n9HuhJMH/+zV/mxwbmIjrnM69AysTckj2k2A+YcnyiqD1qDqgBwqh6d7xIebj9nITfPbOqzuE3PYGohb0qFWHp+JpffhphP2g5QawmSpHf0UVJWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dO4blEU0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8a1acb51a7so332782366b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 10:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725469275; x=1726074075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=igjjJkRDnT4710DOt69t7RwKA+wIuknyStdIEfj6q8s=;
        b=dO4blEU0jtCIU+AAyn9ZRpBtu2hvJ4YfwLtOaN2XztckU2FAxODQPnONXiEs19lwny
         RwNQk0L6inXFmtPdersfCGobwWOXi7huET+cotTPvgVkaXBtmmL96103J/8OwK9dDB2/
         lESdTFn56i67Ghw0BNCNhkzeGt+tKGnSdGygpYPB2E2wo+cEzK/wUttfojFDH1a1G0wM
         JUj7//Bg6P+Q1bITXCzm1t53lQQSwHY5aFl6qRg3FkQ+9kmCHREgTmVuOQ6CPSOcay9K
         ovY8ZrUHoHWNFXhhW3g2Njd5iYXpIQieZyBuaT+0Bhx8dLg6+NXrzUCEV5R+rRi3Up4A
         ZdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725469275; x=1726074075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igjjJkRDnT4710DOt69t7RwKA+wIuknyStdIEfj6q8s=;
        b=sywwybs4oCBUF0nxtYWpkYh1QdK8/nxrnGJKQ4n8SQGL2LUN9HlHiHIGNVmvu7O0T7
         Wg+wZKYRBhh7MDebad200ICgRXerQFFI7s7TU/6GqXdt1bu8rhafSQGS6P3x1xBaWJnm
         UvtB+Vb1jRe72DIyM6TUZVa718eUdqGHPXbAj8h0ljp7q3VkMu6m3mswzWdOdYo5dc4f
         g+g2PhmMunyfkOCynIN2QE0gFsBPpPujtgeTsnRTXM2pxBr8GWlfX3dCoIQr3MPdc7Nq
         xYFT6mIax57Avg6b9qV1W6EjS7GW8EsBqbvQrT1n/1XBJgpSVHBno/84+9zfrBw2bwp2
         yXoA==
X-Forwarded-Encrypted: i=1; AJvYcCUuCjDMhzjVFbOMLGj++cxcw0FIBYkW+oMSqTJic1qn/A38qqdpSSJrb/gGaDN7Qp3FJgSkRyreif/oH9CG@vger.kernel.org
X-Gm-Message-State: AOJu0YzcZI2w3+fyWS70B9XVGNPo2i8bRrrXHRcncyvmHE0gsep4bK36
	FZH5iZ0bsavKcRjPnPp+K9VPF/huNuxiopqoim+WdXK1gY2p1wbmEM13e5zABoU=
X-Google-Smtp-Source: AGHT+IEdhO+6u5bQtS/Pjv4pVjqT1PHlHw58PSqoO2bfvx8uyhINdf+pDMVbe4vM0TqY/tHlEK8Ojw==
X-Received: by 2002:a17:907:7206:b0:a7a:be06:d8eb with SMTP id a640c23a62f3a-a8a1d4c2635mr725404566b.53.1725469274485;
        Wed, 04 Sep 2024 10:01:14 -0700 (PDT)
Received: from localhost (109-81-94-33.rct.o2.cz. [109.81.94.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623a6ca1sm14385166b.173.2024.09.04.10.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 10:01:14 -0700 (PDT)
Date: Wed, 4 Sep 2024 19:01:13 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz,
	Vlastimil Babka <vbabka@suse.cz>,
	Dave Chinner <dchinner@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] remove PF_MEMALLOC_NORECLAIM
Message-ID: <ZtiSWUxMQSBzN9cr@tiehlicka>
References: <20240902095203.1559361-1-mhocko@kernel.org>
 <ggrt5bn2lvxnnebqtzivmge3yjh3dnepqopznmjmkrcllb3b35@4vnnapwr36ur>
 <20240902145252.1d2590dbed417d223b896a00@linux-foundation.org>
 <20240903051342.GA31046@lst.de>
 <l3dngdjyglhpnlcmjxerpmiyw4euodb6sxsxe3mwtyd2z3uopu@amisj3chjfqe>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l3dngdjyglhpnlcmjxerpmiyw4euodb6sxsxe3mwtyd2z3uopu@amisj3chjfqe>

On Wed 04-09-24 12:27:04, Kent Overstreet wrote:
> On Tue, Sep 03, 2024 at 07:13:42AM GMT, Christoph Hellwig wrote:
> > On Mon, Sep 02, 2024 at 02:52:52PM -0700, Andrew Morton wrote:
> > > It would be helpful to summarize your concerns.
> > 
> > And that'd better be a really good argument for a change that was
> > pushed directly to Linus bypassing the maintainer after multiple
> > reviewers pointed out it was broken.  This series simply undoes the
> > damage done by that, while also keeping the code dependend on it
> > working.
> 
> Well, to be blunt, I thought the "we don't want the allocator to even
> know if we're in a non-sleepable context" argument was too crazy to have
> real support, and moving towards PF_MEMALLOC flags is something we've
> been talking about quite a bit going back years.
> 
> Little did I know the minefield I was walking into...

There is a lot of historical baggage and several people tried to explain
that things are quite complex and you cannot simply apply design choices
same way as if you were developing something from scratch. 

> But the disccussion seems to finally be cooling off and going in a more
> productive direction.

Reality check: https://lore.kernel.org/all/8734mitahm.fsf@trenco.lwn.net/T/#u
-- 
Michal Hocko
SUSE Labs

