Return-Path: <linux-fsdevel+bounces-51263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B33AD4EE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 10:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EADFD3A681D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 08:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C87242D68;
	Wed, 11 Jun 2025 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exOvvAE8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D99E2BD11;
	Wed, 11 Jun 2025 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749632071; cv=none; b=AZ49OkXCKU8vzmoabxhlI0Fu/3VePa7+qtedqxtzRoAG/fw9oeDIs7Yv7RQ42wej2In0Yjwj75cW2qS7ERJvNR195WmArlvRYHmo+VbXcw7ETeNEdm4gNbJaJSKR4tHsKeLozjoedwBLhrrUKWMQT15Nmdrt3dS6qjcjvQkxv14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749632071; c=relaxed/simple;
	bh=1bV93nrz7FxAl5rV5+OlXjudwdNNoz/1PB+o6GG4rQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u67UZRGOd5bbb8EZ9J4FzYK+jZ9y1wPbtWyFxLeSRZDMEcf/UgevWZAUISfEsw3CyxaX3yJZky9ghvwY27BW1zsHtqKSy8BHNeT2xjKoHg3kGSVAmpn2nZ5RtzfOE2X5oKZbwEt8kItayH/X5Mw0LEV/ZPLwXZJWp6mO/xiVBu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exOvvAE8; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-adb5cb6d8f1so1031610366b.3;
        Wed, 11 Jun 2025 01:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749632068; x=1750236868; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1bV93nrz7FxAl5rV5+OlXjudwdNNoz/1PB+o6GG4rQs=;
        b=exOvvAE83hwxD0VpFqJQBzgS5XJYzip+yadF6E2vx+PCRJljqv3Sr80LlN03PTP9Oi
         Zeci2m8ktdOU+c7VB960xGV/XSmJ/GWGFHUI9b7DnZ+T9qmAXJ+Sg8mDLRDl79PfWo2K
         OgQKQC/5mjNt20jRelfF5iOPEurEMcx0Xc77iDl/yA7BYielpHnnoQepLjmvMtXm+4ho
         4tExbs4/phYb0A1x6P6KMpWz0Cw7KTE3LMec/6W6TUc1/2X9SHqk+4WCmaoQI+/AQ7AH
         RGpnivXvEHEfbVTXxnUKXywliboZp4/S5+ZlLSzeSUpK0YCgWX0EObhVQVLJQgC3jdaF
         U7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749632068; x=1750236868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bV93nrz7FxAl5rV5+OlXjudwdNNoz/1PB+o6GG4rQs=;
        b=T3pfy02zwZDFFeX+BGU9dM4K2fkIAUZeNuIuQoU97hBGZ7NfiP3ClLV//JVcuJFqxm
         8gGR8dDD0GsjappiGVKtRhmtSoiA0HOmMsX+uM/PJzWPoBA/cAE9lcHiY+ntW7aRawxN
         KObqXbrm2kXbgwnI299vvCBDYn7NNDyZqldw7/fnpla0l8vIGQhIALCI4Uopl1hywIGX
         kdDnAs1/Luvf9Ry7LFweMvHVtGD4eIdXHK+U3V4vQC9EyVzL0FGZJkSXx4AP1jnC9gOe
         BpfGvek9k8cGMvAZOp8bHGI6r9BFri72H57gYLCrAPi1PqVdKqWy6BeuMvjJfAgllW6K
         r2Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUIldYbU7egjcCs4tTrxsBdmXDN5H7C/zP9pcug8ur+5MbaDmU3aPA8QngH+xE4Uc+D1g5cYxcHsLpv@vger.kernel.org
X-Gm-Message-State: AOJu0Yz74AcKLSTn7fjwkkS3UNlP5bt/7SgOZX3uVotJqgXr2VAD4dSP
	OhOLLaWI9rAV5h9TWJMfmo5DcX5kVmYCFYzy9pqj/W1MfsxopbI+9/mJ280tKqRj+TwSIqnYoQX
	Vj2k9LQS1gxNKkRpmLpRg0rkVDNjWXkUd7S5uPzM=
X-Gm-Gg: ASbGnctAI1OWp6gmfzJ5aNphGZ6QBkfIn4qZm6y2WERbqtmQc0xWFDj5e/pbLgBwigw
	sWo/k5jNOLyVY6p9irP3VpOVEP3cZRrcwWktXcw2gmRsQQNgpMjwuSrM0OLjg/6+ZFijnnIzDsM
	P/HtzNUMlC7mXKqCq9qR5IZNPCVmttDy53yUsffuR30zNyg1klHrByeg==
X-Google-Smtp-Source: AGHT+IElTGYJ6SSWqMhVOosDTZSvZHz4crYNyGRIynttvzk3iJlIjWEZXTqsMSJtJdZjcYi5zGSLBGMqJIAbjHquIUk=
X-Received: by 2002:a17:907:c0f:b0:ac6:fc40:c996 with SMTP id
 a640c23a62f3a-ade8c7a787cmr185456866b.23.1749632067832; Wed, 11 Jun 2025
 01:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521235837.GB9688@frogsfrogsfrogs> <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>
 <20250529164503.GB8282@frogsfrogsfrogs> <CAOQ4uxgqKO+8LNTve_KgKnAu3vxX1q-4NaotZqeLi6QaNMHQiQ@mail.gmail.com>
 <20250609223159.GB6138@frogsfrogsfrogs> <CAOQ4uxgUVOLs070MyBpfodt12E0zjUn_SvyaCSJcm_M3SW36Ug@mail.gmail.com>
 <20250610190026.GA6134@frogsfrogsfrogs> <CAOQ4uxj4G_7E-Yba0hP2kpdeX17Fma0H-dB6Z8=BkbOWsF9NUg@mail.gmail.com>
 <20250611060040.GC6138@frogsfrogsfrogs>
In-Reply-To: <20250611060040.GC6138@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 11 Jun 2025 10:54:16 +0200
X-Gm-Features: AX0GCFuIV6RQ_ldojmYC_yaiOTPMv5df8q-ONaLTXses9_KOg9dpHcK0zyaSAjs
Message-ID: <CAOQ4uxg-HT9ZA4UdQsD40z4THp9wBJw=MPHBSnWUCbOA+Mc0hA@mail.gmail.com>
Subject: Re: [RFC[RAP]] fuse: use fs-iomap for better performance so we can
 containerize ext4
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net, bernd@bsbernd.com, 
	miklos@szeredi.hu, joannelkoong@gmail.com, Josef Bacik <josef@toxicpanda.com>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"

> > > Does the nodeid for the root directory have to be FUSE_ROOT_ID?
> >
> > Yeh, I think that's the case, otherwise FUSE_INIT would need to
> > tell the kernel the root nodeid, because there is no lookup to
> > return the root nodeid.
> >
> > > I guess
> > > for ext4 that's not a big deal since ext2 inode #1 is the badblocks file
> > > which cannot be accessed from userspace anyway.
> > >
> >
> > As long as inode #1 is reserved it should be fine.
> > just need to refine the rules of the one-to-one mapping with
> > this exception.
>
> Or just make it so that passthrough_ino filesystems can specify the
> rootdir inumber?
>

There is already a mount option 'rootmode' for st_mode of root inode
so I suppose we could add the rootino mount option.

Note that currently fuse_fill_super_common() instantiates the root inode
before negotiating FUSE_INIT with the server.

Thanks,
Amir.

