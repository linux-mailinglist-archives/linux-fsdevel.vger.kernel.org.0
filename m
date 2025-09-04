Return-Path: <linux-fsdevel+bounces-60263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F2DB4394B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 12:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830FC3AA4E8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 10:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBC62F6182;
	Thu,  4 Sep 2025 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BdGcDrcj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13AE2EE294
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756983306; cv=none; b=ViGKK813Do/4GTZkx0pjNjZYE520LA28/bDIfptwBOfi/TWjo6XvCx7YP2CBrqgsSebsD+0/wqVBinNfKuufDSFLNgJ1tPlV6k3VthMOpzvkD/q46OXBWFFNIYpaDuGiQvovxZLKHuDkd+4oCv1Dz1EX7Kn10rkGWjt682n7HFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756983306; c=relaxed/simple;
	bh=koa1d70J4fs6qjFiv+KNlFi803r09SFuvM0jOjLmnNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKDcfvZ7rAi6FhVdMQ8Nuz53C2BVp55xaSvjGforiLRBulCg+2gZZ7+fKFyOM9eZqO7Z4FNDxDhirlDTiyhzkczc5L4UswBQL6tV/bRpwwQN2MHb1Hjf8RrsYQghBSyZFgPp12yptIXoFe+MdyrwMB8d7VKuno2gtGd10YC4KZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BdGcDrcj; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b30f73ca43so6241921cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Sep 2025 03:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756983304; x=1757588104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QwvISlQC9YUfgazi+9U/aynpWyfCO4IPqljv9FteMkA=;
        b=BdGcDrcjfFnXi22nsc/7y4UhznwXmjqXRzUHna6Ycsl+uvB6Q4xfFKuJxcRQNaer5N
         BO1yUP1lEB5XGNRHS3Cog3IAQ4sb1NpTNDCdauoPhEsLch8tDulNM5VF4eWOKggBHAa0
         UtDUxfcqwc+q8vUkYKuIYhJFCbrc0rUJ6IZlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756983304; x=1757588104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QwvISlQC9YUfgazi+9U/aynpWyfCO4IPqljv9FteMkA=;
        b=nJ1lrxMfcRx7VPXhX8eHbEvuE8yHpnDApTigwDkCnWNkpZJNSvkojMKMW40V7coGDh
         m0dp/uQXPKpvNgu3mYJ3mS5rkxyzkZRC6x71zI54NW+tTm+R8w+RQPGWVNDiSmw6FzdL
         tIfRPJnyMkr3oEwTC9csarlEhiiRUDTrx0JwZC97Py/xCji+6/9tUkgWoHFAIFqOnRxj
         IG7GQH0yaFWNPXy+/A9U8XUcwUrfamAIdx08QsNjomqIKTgUGdCQ76JZQ+rEKLhHIefI
         czHvPkk/CYOMCD2n5mo8vfRkXwf93RgqJQq1KqzX0Kq20O2OjQhWpc3mQyqBDUohD+mJ
         3/zw==
X-Forwarded-Encrypted: i=1; AJvYcCWml5SFLjGBt4vw3dGXTf+/e2i0PWFN3rOUk/JXZj3dxqPDJHMT4Bskifd4EMfVvZAeTQqD5Pp3fXv2hut6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw66lVvnYGe9p0PEGReLl5VU8eOptpvR9nCy0sqs9usK4Y4+0va
	+L+RYNsVZXVqQzFiE2GTlWA/6pgZzZb7iM+tjP3ClUFO8Ica9mufGqp4z8jdak+fwpUnU/eZkYQ
	4zHgC+1Q7todcbQprriZdjhVM/8aOd8kkUjaD4swzsg==
X-Gm-Gg: ASbGncsDJcQe9Tvrr0UkTDdIUmuGPMMRXUPx8HoHGUe10EB7v9P6NNVMYCzBhS81nQK
	ZNGy+PS6MR2cSh1Zdw+4AQ9WmanBKQguVm573RhY6+jSASBP2DC/M42hqMqaL/XLORVBSw7d6eB
	KJrl+2wQHiBQNz/oOhPjj32F1x06A5GpBl8HR1i5+IyW/JTbyux4QbZh0c8WgOOg2J8qdQdBvqB
	it5CeckmxdflMPpCtsI
X-Google-Smtp-Source: AGHT+IFuY7Re5xLdXAeeJI28PbWe2JkMe11+O5ReZXzO1BEuD0lMUQT9VZ1jhMaVSx7MvJJo0aYktFRsrdPdGJ+Oy5E=
X-Received: by 2002:ac8:5982:0:b0:4b2:8ac5:257a with SMTP id
 d75a77b69052e-4b31dc93679mr203399511cf.65.1756983303899; Thu, 04 Sep 2025
 03:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708588.15537.652020578795040843.stgit@frogsfrogsfrogs>
 <CAJfpegu3YUCfC=PBgiapcRnzjBXo8A_ky6YiGTYaUuxJ=e1jmg@mail.gmail.com> <20250903174921.GF1587915@frogsfrogsfrogs>
In-Reply-To: <20250903174921.GF1587915@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Sep 2025 12:54:52 +0200
X-Gm-Features: Ac12FXwEM0Lj-LZuKiWW3bZu6MEXLjvWe3AwUOJ-nBUEGuCT33Kxfzb5XJrLuzQ
Message-ID: <CAJfpegv5hWfx4eEgeC5AiPBOQVkWSY_AB3gjDFNYQ5_sWLQYaQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the connection
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Sept 2025 at 19:49, Darrick J. Wong <djwong@kernel.org> wrote:
>
> mn Wed, Sep 03, 2025 at 05:45:27PM +0200, Miklos Szeredi wrote:

> > Thinking about blocking umount: if we did this in a private user/mount
> > ns, then it wouldn't be a problem.  But how can we be sure?   Is
> > checking sb->s_user_ns != &init_user_ns sufficient?
>
> I'm not sure we can -- what if you mount a filesystem in a private mount
> ns, but then some supervisor process adds another mount to the same sb
> in the init_user_ns?

Right.  What I don't see is whether this scenario happens in real life
or not.   But I guess if something can be done it will be done, sooner
or later, so better not tempt fate.

Thanks,
Miklos

>
> --D
>
> > Thanks,
> > Miklos
> >

