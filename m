Return-Path: <linux-fsdevel+bounces-5207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3CB8095A0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 23:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89EE5B20B03
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E436657313
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDXzxEix"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D44E9;
	Thu,  7 Dec 2023 13:10:21 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-286d701cabeso1403864a91.3;
        Thu, 07 Dec 2023 13:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701983421; x=1702588221; darn=vger.kernel.org;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gBBC3+RnZ4D0MUX3ZqGqN8vGIaNXSQk0kKGYcAtYiDo=;
        b=UDXzxEixcsZP0AOw1m67vg70wH4Qj0tkkfVDXGIwGCo0fryMlyRAbM7hXdZnPEm0WQ
         tkZqX7+Deck3MAOnfZjw4zJGW1cfVfZSjt+voQ05wI8h2ZknXNr1FVa44uwDCX49DjBC
         H0Kkh1yPGpUydA+3P+X2AaIZaoQlaGTjNSE7gijegOcdwx1wQ3GEs1MU+tpBQvUlbRm2
         cLwFNGd5JtXWGMr79iojT4FJtjP5rCtw5i9VE1pu09An9VibRRjPasaz+SZtO/KBZJvY
         LEo2Wx/6EoNSTZYQQqGd81zGjs4wX2FwmdsOrVciFeW6GgSZliuRDD0IBOSLBStmzeNa
         r2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983421; x=1702588221;
        h=message-id:date:content-id:mime-version:references:in-reply-to:cc
         :to:subject:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBBC3+RnZ4D0MUX3ZqGqN8vGIaNXSQk0kKGYcAtYiDo=;
        b=bPodEdpu95GkrV7tuTle4J1n/0zEjbRmMMw9IZuaVIY4mtGFc0hx5IVsEjPjexjeDm
         LGoe+hCIdJoDjZ0QO8O4RMaYT5E6lEzgo9yWz+/aZ8CuSIqeQT1FxQAGqMVHw5527hnH
         OOZr1dOXnjnARrYqHkSp4VLrnGwcqcB2NpklITm1zvzG0gqg5aphvbYhoQnOCCjWhsKd
         Dnnq7vXtjmwFsoD29gLNEGiIumm8VQUeDmTw4FJZHWq3Gy4sSu+WaXSj1UAioW19F4Ub
         +6fZup5yYqklhUkoUS+4T6oJXmtgx4mSG3RkZCh8WmPInZZKD/9bLf8OtVlWKPq1fd+O
         LH+A==
X-Gm-Message-State: AOJu0YyyiOA2fOt7BvQ1AcgYwPP/EXl0kLPY7f1238P/EyIVGbGPiFRo
	qlPiAacF7MLh1DMG5wWEhVXb+KKYtnM=
X-Google-Smtp-Source: AGHT+IE05Lk5zs8mPCAK6fac/YqNLl5Pwmurtilp7IlFNhBJCfM42MDMeksTqB/agK4RcOyMTJD7vg==
X-Received: by 2002:a17:90a:4e0f:b0:286:818c:27a2 with SMTP id n15-20020a17090a4e0f00b00286818c27a2mr3592885pjh.49.1701983420884;
        Thu, 07 Dec 2023 13:10:20 -0800 (PST)
Received: from jromail.nowhere (h219-110-241-048.catv02.itscom.jp. [219.110.241.48])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090aeb0800b00286596711f1sm1852382pjz.19.2023.12.07.13.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:10:20 -0800 (PST)
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

