Return-Path: <linux-fsdevel+bounces-61086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4F8B54F86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 15:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8C9189E742
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 13:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0069D30BBA4;
	Fri, 12 Sep 2025 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="p+Aq9tX+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0893628641B
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 13:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683712; cv=none; b=YpqRJ0vxDUJ/c3+JenoAN1a6UmwFrk9d20enxp5HNvkdf5+a8f9Omz5OLX6NaPtijo0E2d0EfrazBiKa+3RRk2Turcdd3jS9fR8rkuZcI+0phjGmt/vNU729eLiQ6GIWYhCIU/vgAtO1scXbYkDr0UrOtYAb7vrsgDZaovj5Ap0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683712; c=relaxed/simple;
	bh=pv64/YWHy/zsS140ZXZ/wlnIfA1wctc4wWGI/dfx5wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kj+m8fPjsK2B33BbRabSfN+B0Kvty0JcDjmaj/ondv9qHMhk4q065XKBK4h7i9OM5Ums8qt5weclWRbM0BTcl5qUvrVJj9X+vvRg0nk2Uz4oRiojoyWhfj+X/8MrVYI02NcDNrnSfWO3eciQCtmbCn8vO9x/GwoYFA/FN+vzvzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=p+Aq9tX+; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b5e35453acso23805791cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 06:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1757683709; x=1758288509; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lgzyzIdv2ELBltCZ9VZLRBdplBHDK0zHvEcAPiRzxz8=;
        b=p+Aq9tX+5nN00WaM7ePJAW85mKycB6Yg5y12FU2VIvmyPZ/+M1BYk8eVBv4K3Lj09T
         JJ+q2/eaonJGjdcC3optQOADdTgkmutpk6Z4p5R29FQ25a8RqUkHjDxx3O1rZC46AqLJ
         bTqsdqe0ttTHHhq06vTP3jt4HqrbLGXA6eHwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757683709; x=1758288509;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lgzyzIdv2ELBltCZ9VZLRBdplBHDK0zHvEcAPiRzxz8=;
        b=JjJxwTy0APPxzvdmT7hjDZz7FDshGrdsopxpu676blVptNL6DsBkBbDUX582EcDie/
         U8LwOJqUpCIXAwbxI3h0nB827fmfUxgpFVyxPaIemDcIANPKY4jIBOfhkcrcYE2kDLDK
         6JtCn58VBnlAbHRZEP+t7A3M7ZoFa6K8gR6XwUbSrkZA65u1LsbhiiCB+QbrnNfD10EC
         ZtI7pGiw/xSDmGpjkTLRKVw33047bSTQGjbOb+/RZvejm5pbxRaBg2+c+EohwJl3hU/3
         mukav86YKqLStkRRG33TstKNcGWZbx5U3shbcKm37qS5Eg5Uv8sI1hVVEaBeyMAOgTFg
         q1Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWwTswVfGBiod6Nph0Nq1MATNGtLrNZrGn2cIhfywEjNUt5neGkBqXcFeYzowsfJxKpWTXnHxQtQfH7r4uM@vger.kernel.org
X-Gm-Message-State: AOJu0YwqqJ945xCL2NZWdlguEdjTG0PhovOSg5Os+7NIKEwH0SJXD59M
	dxUQ4CQTll4hUW0pfa1e+VzARBeJFTkuFvqnzto001A65eU6smx9g7o51yrKdoR+SgURWEJZDUo
	tn7EdAqbbZjv3MhkcZpQ1KucwFiMNfSkJyy/yZx6FL49ySQdx9j4A
X-Gm-Gg: ASbGncsKYLlavyAGerbzJsY80kPZeZ+ZBd8pyXaoM0muSVKTsMPzQ9p/VuqEvj5TXx7
	We/lTE1+jtuEZaCTuSUDmVmS+FKGLmtdQ4ZZom8EXiC6PNeIDWQ+KqAlZeoLYIWidmocN7BHHA+
	6jY7Fhuby8EWYixGIr6jAEYCWysvBM5VyN8wZnIwTBKm8xrDcsIETYPELIObZK7n+FyHrQ7qBRh
	LD7PV/aJhjpAT47bmGJ0F5tqxJ2iIKxqZoh8eJmWg==
X-Google-Smtp-Source: AGHT+IG5zYq61r6XWskRLPzBRnhbKz+Lzp8k8Agkz3AtllVbNuyr3uo0JtlG8sXVhR3Whzdt0HzvF2hoH24s6K618oo=
X-Received: by 2002:a05:622a:1b1c:b0:4b5:f586:b122 with SMTP id
 d75a77b69052e-4b77d035f34mr30380501cf.43.1757683708491; Fri, 12 Sep 2025
 06:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
 <175573709157.17510.2779775194786047472.stgit@frogsfrogsfrogs>
 <CAJfpegsUhKYLeWXML+V9G+QLVq3T+YbcwL-qrNDESnT4JzOmcg@mail.gmail.com>
 <20250904144521.GY1587915@frogsfrogsfrogs> <CAJfpeguoMuRH3Q4QEiBLHkWPghFH+XVVUuRWBa3FCkORoFdXGQ@mail.gmail.com>
 <20250905015029.GC1587915@frogsfrogsfrogs> <20250911214527.GG1587915@frogsfrogsfrogs>
In-Reply-To: <20250911214527.GG1587915@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 12 Sep 2025 15:28:17 +0200
X-Gm-Features: Ac12FXyVDNTSZj8DoVe_wBesPB12IO-s7lAOPrgv_HQuEnB_9wL7NxqqY0VltME
Message-ID: <CAJfpegtenngnA2OxBmGTi1f2eFRq0Lvdv2ScM53mvd4vPwu-PA@mail.gmail.com>
Subject: Re: [PATCH 02/23] fuse: implement the basic iomap mechanisms
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Sept 2025 at 23:45, Darrick J. Wong <djwong@kernel.org> wrote:

> So I think the third approach is the way to go, but I'd like your input
> before I commit to a particular approach.

Okay.

I'm not going to rant against tracepoints, because I'm sure you have a
good reason to bear the pain of dealing with them.  I'd just like to
minimise the pain for myself and other reviewers.  If I can just
ignore clearly marked tracing patches, that seems good enough.

Thanks,
Miklos

