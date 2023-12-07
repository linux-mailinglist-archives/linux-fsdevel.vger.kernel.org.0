Return-Path: <linux-fsdevel+bounces-5270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABD2809591
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 23:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B3F1C20A84
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B86B15AC0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiYCYvpf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FD11728;
	Thu,  7 Dec 2023 13:37:14 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-286d8f3a08bso1439757a91.1;
        Thu, 07 Dec 2023 13:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701985034; x=1702589834; darn=vger.kernel.org;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gBBC3+RnZ4D0MUX3ZqGqN8vGIaNXSQk0kKGYcAtYiDo=;
        b=UiYCYvpfwi+ZDuDgeWWqfiWfuyIBG3Zejdzhpiemxzoau9Sfq7LNJTEvXJ559eoWJh
         341lGCMfdchI3H4pR9KxwpR569zw/Jw8wMwOWQ0rC1D64CTU2oGSn3yTX3bk621o0ZoE
         SlhaMaPOkv3/Wgs2oN3LIqdALTEhs0fbzVWYL8LD5MXUQlZbautjNakULGWfORsdCSkL
         iUMA+lYW6tWlrNPkSqLphx9iHJ/ajeciLnv8GU8vzGMWDW9H3YW6/Xfo9i1XBbwfHVUH
         FMmW/m4fHC/tf21Yu44IjazXW2vcOeDckkea4ChS/Olclhe7TFy4ka7RoV4h7GqXI0Tv
         YoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701985034; x=1702589834;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBBC3+RnZ4D0MUX3ZqGqN8vGIaNXSQk0kKGYcAtYiDo=;
        b=on1lqLftS+Ag1pwHJ6h8YN9kU5QwUKte39Sdk+/vMf5F4SSUWL0F8lkjeOMOTmc+l3
         bktE/Gwj3pj8U1inpJgvsHWBwkQ+xakGuwk6NhJrS8v5e0WTwAsfbFzKj4T12usEDYWP
         K2uKVx3HDLUnb6f0w0qI2WP6ofQC/U0puxaoYX1cjhAvZmZ7hybC3v9AAe7XNMTyEYcx
         jyHO9+Cg/Vejba+Z0WF9pXZLSDLLi2zjLJR9C3jnVi1CcJrph1P4uQXM8Dwt7tbq3lux
         XQ1I82EhSlvin7/Mgj3O8qeGOZ3ng7xz3Zg3qWgLFF7prEISXE9C/xEalUv/HEcSmeTC
         xhDA==
X-Gm-Message-State: AOJu0YwpPsR1EhL1bbInTEmb8r3ZvT6p5htSF6KK7rQxsNpOLZailbwc
	p4dDcR4vW4JDZSsLcMcFwVk=
X-Google-Smtp-Source: AGHT+IElIp+cAHpNT5XZVbCct1KDG8EC2BtuKUTXw+pmvU+3AvJNfTkTV1K9c+dUQKpO/5jVtUv7hA==
X-Received: by 2002:a17:90b:4b44:b0:286:d242:2629 with SMTP id mi4-20020a17090b4b4400b00286d2422629mr3189271pjb.3.1701985034008;
        Thu, 07 Dec 2023 13:37:14 -0800 (PST)
Received: from jromail.nowhere (h219-110-241-048.catv02.itscom.jp. [219.110.241.48])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902c3d200b001cc3a6813f8sm273891plj.154.2023.12.07.13.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:37:13 -0800 (PST)
Received: from jro by jrotkm2 id 1rBLdS-0000Rz-2M ;
	Fri, 08 Dec 2023 06:10:18 +0900
From: "J. R. Okajima" <hooanon05g@gmail.com>
Subject: Re: [PATCH] fs: Pass AT_GETATTR_NOSEC flag to getattr interface function
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: amir73il@gmail.com, linux-integrity@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
    miklos@szeredi.hu, Stefan Berger <stefanb@linux.ibm.com>,
    syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    linux-fsdevel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
    Mimi Zohar <zohar@linux.ibm.com>,
    Christian Brauner <brauner@kernel.org>
In-Reply-To: <20231002125733.1251467-1-stefanb@linux.vnet.ibm.com>
References: <20231002125733.1251467-1-stefanb@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1733.1701983418.1@jrotkm2>
Date: Fri, 08 Dec 2023 06:10:18 +0900
Message-ID: <1734.1701983418@jrotkm2>

Stefan Berger:
> When vfs_getattr_nosec() calls a filesystem's getattr interface function
> then the 'nosec' should propagate into this function so that
> vfs_getattr_nosec() can again be called from the filesystem's gettattr
> rather than vfs_getattr(). The latter would add unnecessary security
> checks that the initial vfs_getattr_nosec() call wanted to avoid.
> Therefore, introduce the getattr flag GETATTR_NOSEC and allow to pass
> with the new getattr_flags parameter to the getattr interface function.
> In overlayfs and ecryptfs use this flag to determine which one of the
> two functions to call.

You are introducing two perfectly identical functions.
ecryptfs_do_getattr() and ovl_do_getattr().
Why don't you provide one in a common place, such like
include/linux/fs_stack.h?


J. R. Okajima

