Return-Path: <linux-fsdevel+bounces-36475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153FC9E3E60
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 16:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5874A282A45
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484D920B803;
	Wed,  4 Dec 2024 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvrljnZo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C141B87C4;
	Wed,  4 Dec 2024 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326389; cv=none; b=jzPhM0RBfLG98Q3CWRiZ6JTZNhxUMjVbilYSXDU1J+JwsbQn/368LCwg8XB0fRzFXEPhEKVbKUo6R6ji+IKul5pGCxVPJ3SR8GTYubpEDVfGMx/V+3Hu+87nrFQs63krSRyFe0FZYme8pYwxptZ7/1Yv7ApyY+g25rK3dfViIJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326389; c=relaxed/simple;
	bh=4IsxGONccTRWIBQiiSaihunLO6mDN5cfXJR2FLnzkgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZR9pDmf2mJQCNPHDK2zTY9Z/V9alx/3iCoUhzs70oJepvQXn7scNQmRiAnmvrODWL7thQqKDkdaUTOehCSWDYLXVjnzFl2dvuPMOvV/P9ks/Co9nJ4uoQZEFJvghsOeRWQG/NBBrQ/hvyfcnZrCQ380w22pX0Dxp9REDHndTvOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvrljnZo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21561af95c3so36958585ad.3;
        Wed, 04 Dec 2024 07:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733326387; x=1733931187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PU3OQZVUSvWFFgmgPiQmmq+MSi4BIan+FoV0Z++2j90=;
        b=fvrljnZo2jJSDAVJHEqDg9qAnBdsALUdtXM+EVa+2OcWxyjU1c4Pww5bmAy4dhyt8t
         LAOrGQJ5o3c0uj8i32m1ftagtt0MGTOJO5//KN512deQ4In8ZmLZmR/Fy7NCalqW7MUs
         xe4ECUGSXzFxC7KVVCQ/FfeYRA82bF3+9yxKrgKU0DysBmESt7gHIZI9SUzICDOVazSy
         4G0VOwJxxeLR4KOQAlCnjsWNit+Qcc/EM1ZSBwzk6gM332VZblN4G3PqklIMlkvDsmRH
         O4d8t8luTn5lrNnpGrXsS1+YTQS+7bb4RoPb5g8m6djz/1rAp+arTsPnXgNCfUcRPURK
         EmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733326387; x=1733931187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PU3OQZVUSvWFFgmgPiQmmq+MSi4BIan+FoV0Z++2j90=;
        b=vSC5euXHU3PcjAivMFL2CcPFgmDVm0adw0I/W885GdaRKreBSGwXhd5/IZihNaEFl6
         XAcaWQBHxhPAxL3rmu5XtViX6Ynv78dZrFghSN/NLXvHL6p8rTp+u5rj63lpuI1kf+5U
         bQA45iJrOYVg+/PSaCL61pWpnZ1ZelF/VeuObioOGLj04uOV16GMtB2uK4VHvbTi/lu2
         /n8BLFrDjF3dRBvXMaMgP8fqkHZtY6h4i2WV970lD/l/8r6Pc8es9iydE6I+pahHIpzI
         r0VNLF1aoVOEPVmdNVTcP4hNlK0micoCItC+vTVGUCp+3izPF7daH3oaAoARhFnb3Avm
         vkVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbunNwQyqakwTe3OFcwNdP/vn4jkfBk3Ek6FN6ODdB972y+VLYTO0Tl7/GMdpINM848BvgE9KHSsNx6pdc@vger.kernel.org, AJvYcCXsuH6dOh2Ht5CuOzhOpGctmZ+FrWmU/XfCWg72dvmqC24hLh83ZaSOzOcoyUIgjuSsQnfNhPmPMotS2Ban@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt9d4k565gpkkPql3nCga6X2Ys6Ry2H7dI8PdD34UVQQ+B182e
	xj8inQw1/LwOPkbIdTXghqHoOq81hPXyzfnuecveMTmgGhlxRBCQ
X-Gm-Gg: ASbGncuEO6t/o6cx/HGTRsK9Iz0IaimZK+vrNcvzKhvsR/VEoIEvbNENBsxB9Fm6ubh
	7cg2V7wX+FjWWkb/PjhMQ/EXDri+W4xS/pImkCtpPrJw6jjmoxFgAau2nlFMJCoACOU7TLv0zEt
	Mk+XiAg1VfgK9O5zvdUg3bhBazxUCnVsLGuFeGiHQ8h134qBat0hDstbe+JR8xvmcp1SPAsQ2y9
	43YZqHgxCIVjmL6z/YK9QjE7ECt4QE3bFNAfXRzjJWiEKx/2X/LEisi2HYSpk71z24=
X-Google-Smtp-Source: AGHT+IFU1cykT79NxOgiU5+nTldOdms9K9uBKE+fLP/WR6Rii8bf/vtOZN8XMpr5w425Ym31XSqlVA==
X-Received: by 2002:a17:902:e5cf:b0:215:bc30:c952 with SMTP id d9443c01a7336-215bcea0b21mr94941085ad.6.1733326387272;
        Wed, 04 Dec 2024 07:33:07 -0800 (PST)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:d6db:3ccc:88ed:bd6c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215908ab2dcsm54689725ad.209.2024.12.04.07.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:33:06 -0800 (PST)
Date: Wed, 4 Dec 2024 23:33:03 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, brauner@kernel.org
Subject: Re: [RFC PATCH] file: Wrap locking mechanism for f_pos_lock
Message-ID: <Z1B2Lxxenie3SA6d@vaxr-BM6660-BM6360>
References: <20241204092325.170349-1-richard120310@gmail.com>
 <20241204102644.hvutdftkueiiyss7@quack3>
 <20241204-osterblume-blasorchester-2b05c8ee6ace@brauner>
 <20241204124829.4xpciqbz73u2e2nc@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204124829.4xpciqbz73u2e2nc@quack3>

On Wed, Dec 04, 2024 at 01:48:29PM +0100, Jan Kara wrote:
> On Wed 04-12-24 12:11:02, Christian Brauner wrote:
> > > motivation of introducing __f_unlock_pos() in the first place? It has one
> > 
> > May I venture a guess:
> > 
> >   CALL    ../scripts/checksyscalls.sh
> >   INSTALL libsubcmd_headers
> >   INSTALL libsubcmd_headers
> >   CC      fs/read_write.o
> > In file included from ../fs/read_write.c:12:
> > ../include/linux/file.h:78:27: error: incomplete definition of type 'struct file'
> >    78 |                 mutex_unlock(&fd_file(f)->f_pos_lock);
> >       |                               ~~~~~~~~~~^
> > 
> > If you don't include linux/fs.h before linux/file.h you'd get compilation
> > errors and we don't want to include linux/fs.h in linux/file.h.
> 
> Ah, subtle ;)
> 
> > I wouldn't add another wrapper for lock though. Just put a comment on top of
> > __f_unlock_pos().       
> 
> Yes, I guess comment is better in that case.
> 
> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


No problem, I'll add comments on __f_unlock_pos() to explain for the
inconsistency then send a formal path.

But I want to ask what's the motivation of defining "fdput_pos()" as
static inline? If we make it "void fdput_pos()", we should be able to
write the implementation in file.c and thus can get rid of
"__f_unlock_pos()".

Is it just for the inline function speed up?

Best regards,
Richard Cheng.



