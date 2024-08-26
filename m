Return-Path: <linux-fsdevel+bounces-27226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ED895FA36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32E61C221E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 19:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDB319995E;
	Mon, 26 Aug 2024 19:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LQzkH7Up"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC8E199396
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702293; cv=none; b=qO5yl5AP4lYg11+hjVWz/Xg2iXaQ2lKVdH/WX3gJ5ObESYW9SwZG+RaEB7RXMjkGeXvIAzxVKUGblnq5cWM8Bzc6hOhpgaV3BUuXZOJUhZFD8ZWzMu3A//zwio58nSuwF1mMieMHfg7FL60JVk2/t1yywZsPv7uXRvWZxXe1J4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702293; c=relaxed/simple;
	bh=bNvj7bgWyh7vEonATRHC/EAvCzNu3EdpeAkNK3jCDPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD/JANAPeVb0vMj51IF9w0PW4HiWkOczr+D0B2UM16ec/ypawzqcgVxFkKIQTede+5IiZkZOv79HWGT8bkj7n+xM+vz94vszAC1Xp7GuVOgU2TiyRcxkQDJw090Ifh2pj5dct9IsWxQrapKRN4NsWgBNJ+TDelQoIMvAxEPG7ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LQzkH7Up; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bec4e00978so4518896a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 12:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724702290; x=1725307090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xh14Sdlc2n6IxKjJ6RlYGRrhImnkQmnSBBa6O3qnYnE=;
        b=LQzkH7Upij0y1HqegxuGUK1QLMUWfJVj8+d7e4sbpJ11wRS3aEGYebhtTv8xdVmd9H
         u9LsUDqHC9Ym6/FawQYakWubVnIPyUZ2w8t6C59/1jGUmYHRUNDuSzpIO4DhUgFCeKdn
         ZiCANADj9F7DGAP4hDWJq8M/m2rw67ouoAzBasyVZQYmiqHr/jhsk/W6IIr8/hUdi0Dn
         7+QlDZ93wy9Ee0X/C8CjJo1ofTeIogYYMVBgySy8/bUb9b5hNDW1EZnE+/PIbSzxnuWI
         s8eSw5ndhSg841aFTDhEEavBqiZnKLXYCTFgYtcQnEfEk/+Gg3UMz7JFHMcue4N7cL0r
         Bd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724702290; x=1725307090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xh14Sdlc2n6IxKjJ6RlYGRrhImnkQmnSBBa6O3qnYnE=;
        b=UgGA5Nd/yoN4X07NjwRnoWpSGfFdwB4qRJ+fSoWT4o81lU2ddUa3PzEI2Oz7Fj3Kfq
         +YjifabemWqHH5aI0M/l+Ymho2RGonLgR2liB6iDjdcYXZh+0v5K6jq9exOjS+ijdlec
         uxAky5S1MLljAjU6rrJa2IMuzvRmijeKmQfI0gmIn8R96N+ACrA7UZz4gW/W4aOVBpdX
         XciNoJpHi8zUrNn1rqp2mMfnyMJLt/uPqGndfiPHffZdKxxiOwuHek3ssWAVWUu5nRfP
         FFZ5SvsWRdPVQ2U8yeYUq80+zD4ypjbLzx/RFqaUnmmriNcG0jmmkpanq+yQOqgPNvPE
         PcNA==
X-Forwarded-Encrypted: i=1; AJvYcCU8g5tGcph6dRthBxTGxsVy3gMqVVKYuyQp0Od5AVwWJKoSxt/4yV7rrBVHuTBiPRWuoTbf03CKHaeDxsyJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxWV9NBy5KDXpAohJnnG6YF0YJYqQywWi2kCtYfDwnozDug9YsW
	HsdsH0rWXwWDcBH2N2dr5qJ8FkGz9LjzyExrX6/FcRb/OXT3zwybA2MXhpfC7fY=
X-Google-Smtp-Source: AGHT+IEqLDw4bnaGQwfVtxUnt5R+nT/cvXOLGueUtNtCDMXl1cKCg9G27paLPy3+tFp8unGIxIOggQ==
X-Received: by 2002:a17:907:2d8e:b0:a86:83f9:bc1f with SMTP id a640c23a62f3a-a86a54de2cdmr683406666b.61.1724702289954;
        Mon, 26 Aug 2024 12:58:09 -0700 (PDT)
Received: from localhost (109-81-92-122.rct.o2.cz. [109.81.92.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e582d896sm13574466b.131.2024.08.26.12.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 12:58:09 -0700 (PDT)
Date: Mon, 26 Aug 2024 21:58:08 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <ZszeUAMgGkGNz8H9@tiehlicka>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-2-mhocko@kernel.org>
 <egma4j7om4jcrxwpks6odx6wu2jc5q3qdboncwsja32mo4oe7r@qmiviwad32lm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <egma4j7om4jcrxwpks6odx6wu2jc5q3qdboncwsja32mo4oe7r@qmiviwad32lm>

On Mon 26-08-24 15:39:47, Kent Overstreet wrote:
> On Mon, Aug 26, 2024 at 10:47:12AM GMT, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > bch2_new_inode relies on PF_MEMALLOC_NORECLAIM to try to allocate a new
> > inode to achieve GFP_NOWAIT semantic while holding locks. If this
> > allocation fails it will drop locks and use GFP_NOFS allocation context.
> > 
> > We would like to drop PF_MEMALLOC_NORECLAIM because it is really
> > dangerous to use if the caller doesn't control the full call chain with
> > this flag set. E.g. if any of the function down the chain needed
> > GFP_NOFAIL request the PF_MEMALLOC_NORECLAIM would override this and
> > cause unexpected failure.
> > 
> > While this is not the case in this particular case using the scoped gfp
> > semantic is not really needed bacause we can easily pus the allocation
> > context down the chain without too much clutter.
> 
> yeah, eesh, nack.

Sure, you can NAK this but then deal with the lack of the PF flag by
other means. We have made it clear that PF_MEMALLOC_NORECLAIM is not we
are going to support at the MM level. 

I have done your homework and shown that it is really easy
to use gfp flags directly. The net result is passing gfp flag down to
two functions. Sure part of it is ugglier by having several different
callbacks implementing it but still manageable. Without too much churn.

So do whatever you like in the bcache code but do not rely on something
that is unsupported by the MM layer which you have sneaked in without an
agreement.

-- 
Michal Hocko
SUSE Labs

