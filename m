Return-Path: <linux-fsdevel+bounces-21560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEF5905B25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 20:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FED5289C90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 18:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A673209;
	Wed, 12 Jun 2024 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB7ayMRo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5312757333;
	Wed, 12 Jun 2024 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217408; cv=none; b=U3X5iIqLJlRCILXdoIEMHbPWbjpwTqkHwqkOSKV0EDvMz73hRgb8Tt6t435O8BzcsOwpYozcjjzyHKj3t0NTS4wsE9ONhlw5Fop8f0ahWRfSFPBHOKJowkeor7/dP+7OkaURakiNenbmDDoEcL3Wbkjffmq0HXk3ItwEJQ7nf0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217408; c=relaxed/simple;
	bh=b71fwzIPSPlgdbuN5nZbAHK4azblE8l4k8Di4n/cu0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E06PFMxFBTTYDW+i6EQRRLjlpxP3I2AN5Z6768Oy4mt0XMlStf2V9b8mRncTL5O1dj43duHt9FB960pGzOloaB5MVvZcWXOCSBwd8JxYiMF68LgMlZV79rLQJN8j8RfaINIrjw6dQbZruQeUyQtYLaNPxD+/ch9H3iIbFoFeCDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IB7ayMRo; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a5bcfb2d3so31898a12.3;
        Wed, 12 Jun 2024 11:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718217405; x=1718822205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uMC/w3FjUwG6Q9a6xAwuz81hVnsVAKpHaMKUF9+ekzk=;
        b=IB7ayMRoYAKLQAGEmxxYj23cwLqKs7AqpvJfjxqNYGSdJx7dc8N77iapdNkLz8M+0F
         5dgDNxDxJBIIQjgrrX3yxXZbONoCL9bvlS6dUxZk0xS3prut8u4SR4352xrbVbpTomMw
         mhxGcIJUGUYp1/dYJT/M3kVPKR3AX1sx6+nMLMld5XFCusSKp2NOVroZA/BPWCnUqsCR
         jS8tcFB6gH006KuEL5K4xehfnroOf+tl7eLfKy+926Oz0pctqwpXGktx5XcAvd801Us9
         foZNqpaHU/LjNc6LmtdkavRpCh9eZI+k8zMqYSWBPMBBNqAEy47Vsq9LesHKzkUtUeas
         b9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718217405; x=1718822205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMC/w3FjUwG6Q9a6xAwuz81hVnsVAKpHaMKUF9+ekzk=;
        b=HXgtdzkezw1hiys8n+HUpOPKcHlIijXQnOBKPL9I8+2MFPpUObYAk7ahq/bWBvfqK5
         VsMmJb/9MOSPUZbOus1ZK6N6dYRZ+WpCW+RWWWdick2Opv4f5cr13UJ8D+1LOFzKTGG6
         NPOpEFAqPdkXZFrggoyyltd7T9mm2IlCJ+aBBe8/kotThoLwO/3w0hV/RDdekj6z44Np
         W6DlD+EpQDHulGhYtKcQv7P1K1fHbe0D7azsCX6Hs+/8I+SF+/bPqDEmhUu+2o+7B94y
         MgdrcoVRHSuYDLwuOyIrMG087gxGw7IPnjXTBnsiAOfOcfl3PKfM5eMrn0d+mbBaB09k
         yqBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlO4rlRb40xtwVf8eL64qPyANjdG7SxOH1PYjA29dbVZvGVGBx7G3RUbWFdus2cBM4TUXhb/duyD6G0XBXLR3P1F0xwlUXTSvVyod2O3zKbQMMffqknHgmgX/Lvt4cyQ5ZlmbZhkVz9MFBwg==
X-Gm-Message-State: AOJu0YwVbqvWFWrA2djrYSGRQ13QiHrmK+0NV574pe6CZRZa2cPpZG31
	0y2IoQaVNxdWilKMZB0IFvX4cLnK7Az3xF220bTgVUJrtzRybEsRdQXEZRznAg4nDLrhln0ZSTw
	xQlSj1zBaKJDbQXMsGrRqmaOb8nw=
X-Google-Smtp-Source: AGHT+IEsrPC8zHclzC0eG6DaD/knGqAsM5DZktNSYW988ECn62nqF8PKNDGAy/S1xmjdC8FkKO4oM1Cnu8EkUQYDNfY=
X-Received: by 2002:a50:96d1:0:b0:578:6c08:88fb with SMTP id
 4fb4d7f45d1cf-57caaabd170mr2585434a12.12.1718217405369; Wed, 12 Jun 2024
 11:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jz4OwA9LdXtWJuPup+wGVJ8kKFXSboT3G8kjPXBSa-qHA@mail.gmail.com>
 <20240612-hofiert-hymne-11f5a03b7e73@brauner>
In-Reply-To: <20240612-hofiert-hymne-11f5a03b7e73@brauner>
From: Marius Fleischer <fleischermarius@gmail.com>
Date: Wed, 12 Jun 2024 11:36:34 -0700
Message-ID: <CAJg=8jxMZ16pCEHTyv3Xr0dcHRYdwEZ6ZshXkQPYMXbNfkVTvg@mail.gmail.com>
Subject: Re: possible deadlock in freeze_super
To: brauner@kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	harrisonmichaelgreen@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Christian,

Thanks for your response!

> > ======================================================
> > description: possible deadlock in freeze_super
> > affected file: fs/super.c
> > kernel version: 5.15.159
> > kernel commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
>
> I'm sorry but this is really inconsistent information.
> The kernel version points to 5.15.159. The commit referenced right after
> is for v6.9 though and it goes on...

I'm very sorry for the mistake in my previous email. The kernel
version is correct but the commit hash is not. It should have
been83655231580bc07485a4ac2a6c971c3a175dd27d.


>
> >        freeze_go_sync+0x1d6/0x320 fs/gfs2/glops.c:584
>
> That function doesn't exist on v6.9 and has been removed in
> commit b77b4a4815a9 ("gfs2: Rework freeze / thaw logic") which fixes the
> deadlock you supposedly detected. So, this must be from a kernel prior
> to v6.5.
>

Do you think it might be worth it to port the patch that you mentioned
back to v5.15?

Wishing you a nice day!

Best,
Marius

