Return-Path: <linux-fsdevel+bounces-4898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78708061D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 23:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E2B1C20F60
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 22:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1953FE51
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 22:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b0PBwmWR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729821BE
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 13:25:30 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-67ad5b37147so10390646d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Dec 2023 13:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701811529; x=1702416329; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JqyDFnCiC9C9iaP1KCSgmfjfaCqCGpifT7WUKn8rGrk=;
        b=b0PBwmWRMGvYvkJoisONmNJ+3T+kkZQqj0m4xMPH8H4VUzuQuonEf/1qKMSlGcFODG
         xJ+T43gtLkRJgKMc86OTz+SAPB3wbKOJ9/Bnygiz1YyRsO1HljWY7NUgPjPS6nKO/0bP
         3UPjHn/vbK2xLjkYQZ4dctCMZCc1gaxE+MMH+xygPjyvPaIipzxqQ3QlLbGsMxlu9ELT
         cNx57Om0Erb6BkOChBEGoOacngBYq9Zv3RzZJR2+cb7YCK1XEzbU2pOM7feYRz4srtJr
         h59hSsZSVVl33yEDvFQi3BIIHFyrzJROvUYLH4T71aQVZlcadBtRPftckPnrtbDCkR7K
         mrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701811529; x=1702416329;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JqyDFnCiC9C9iaP1KCSgmfjfaCqCGpifT7WUKn8rGrk=;
        b=JpePN4iw4VnxydjsKuxyNz/1OwXt06HMX8diH05Hb6e9OVz0efqQtcTDHU15SSqxDx
         pvI9eKPqSDK+1ZGxCjOGJbCwLsriH0+kZJa9JNxPU4ukwAe+EFVeMyPMU5JFqam3HLBX
         8/H1ddpdnI3om40LQwgO279z8ftxca6KnCmferewY4bTQ/UIY+hbUpDqHKQuvtxW9s9b
         4fp27NUfHQv4ctA3DytKvBp+PGtVhJ7PQpXsY5JP2OknMG012EsCc4OPVRwxJump4257
         iVfLF+yLxXwDqlx/71lK/haX7yCZI5TcgnWm+sn2kLNAUmfxjPJs+CWMXOCQJzbx6+Ko
         dQww==
X-Gm-Message-State: AOJu0Yz4RcFIosnB3pT89Kb78J2mQurvGOEmYyBvOmxQGXAwU2VB7IBL
	/bJrIvEaimdlrq884nhCKFZw
X-Google-Smtp-Source: AGHT+IHfsAskPVR7qfeDFP1DBUM6Fip1xoU/6JP7KZknQGN9TMVHFQ/nglQSG33mxgd0O6bDYwfI+Q==
X-Received: by 2002:a0c:fccf:0:b0:679:f5c8:2462 with SMTP id i15-20020a0cfccf000000b00679f5c82462mr1507275qvq.14.1701811529555;
        Tue, 05 Dec 2023 13:25:29 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id c7-20020a0ce147000000b0067ae01ab283sm315639qvl.36.2023.12.05.13.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 13:25:29 -0800 (PST)
Date: Tue, 05 Dec 2023 16:25:28 -0500
Message-ID: <77e8575a68e862c5c0e64803bf2582b5@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, audit@vger.kernel.org, linux-unionfs@vger.kernel.org, "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Subject: Re: [PATCH 14/16] commoncap: remove cap_inode_getsecurity()
References: <20231129-idmap-fscap-refactor-v1-14-da5a26058a5b@kernel.org>
In-Reply-To: <20231129-idmap-fscap-refactor-v1-14-da5a26058a5b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

On Nov 29, 2023 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org> wrote:
> 
> Reading of fscaps xattrs is now done via vfs_get_fscaps(), so there is
> no longer any need to do it from security_inode_getsecurity(). Remove
> cap_inode_getsecurity() and its associated helpers which are now unused.
> 
> We don't allow reading capabilities xattrs this way anyomre, so remove
> the handler and associated helpers.
> 
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  include/linux/security.h |   5 +-
>  security/commoncap.c     | 132 -----------------------------------------------
>  2 files changed, 1 insertion(+), 136 deletions(-)

Once again, you should get Serge's ACK on the commoncap.c stuff, but
no objections from a LSM perspective.

Acked-by: Paul Moore <paul@paul-moore.com> (LSM)

--
paul-moore.com

