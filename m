Return-Path: <linux-fsdevel+bounces-62512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBA4B9678C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 17:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9E33A3CB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 14:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A441F5846;
	Tue, 23 Sep 2025 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="d2yb99Pd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B75C1917FB
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639464; cv=none; b=osr6JVAJ7/g84SZa04LJO758xOvyfQX5s9zMRzXd+JYTDceGjyUIWY76cTKuTYNmvF2LFef2wfy8ue8MV0wfC/Udi22N43+6kwTjgvOhT6TTEHvtLwXLAaRotqRmVK+l2Zg7ifzrEjddizfINeOTTaCF7M3HPoH132tdCm9zdsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639464; c=relaxed/simple;
	bh=ado0gGMNGkne3XnnLVKZD75EJqaXJcCVpV/965Q2kqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lORBFhgA5m0gOb+c7RUpw/Du08sUqc1xCjReDm5XnTJ7FnBqRAhObIQCNRRqHfg1gWskU0Y+ZlFV1NKtX3DTGmIHZ9zzdVc+aH7JAzlAJKPiYq7FoBoFjq5wuaqA9q/0m1UsLN15axn6jMTE7/LMhLDazd9EasCo1mwMVQyronI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=d2yb99Pd; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4d46af01e95so6437531cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 07:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758639462; x=1759244262; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S/1Ra3b4AxJkZwWUJJmBUWhCQcrAccc9TuqzrD5b54U=;
        b=d2yb99PdNM8yv2FIKwXObjYYTO4DGwtSceXqyFrb0+GKhSqFw/WomWP1DOmhyGMGg2
         VU8KPfMQI5gXsMfpcZ7sBL++FPFGe7KLlTrRQW73u7iL8+LVSqM1MxPM5skv30/wORM8
         TiqBKw16XLF/tdQn+HxWdRnIXJqOMsNNMYnjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758639462; x=1759244262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/1Ra3b4AxJkZwWUJJmBUWhCQcrAccc9TuqzrD5b54U=;
        b=J4gbcDwLsdySMfwYgtHmdIIAx2cpTkVB8TbKJWsNJ7J1uzZcDq4kBg5kVP+AAghdx5
         SWTQx1S7EYcZhUjfTcAn5w3fhnASoDfu9Vz3VSqUjHKkKCQLLGG0mcFv9X+iu0rgvM7Z
         0AdaXJ7ymUoEgxDOOrDF11lI+bk5xI9lplV9zT6igcvNDTVcyxAOnDjkA44u9gBFhjmJ
         q670zAmN70W68gFlGUkCnbsI8XHvyvoID2tEWEa80i57DX8O2XPkcmRtLdGqi++yzHs7
         owy8l1B1F1VXGDWnlYxdon1ye9aohF33srfL7q+iBlhsCJcvMXoTdgA6je00iz8Oc5yy
         Z9DA==
X-Forwarded-Encrypted: i=1; AJvYcCVc64ry6mKtgN9+F1gmajj6HMWX/6u2zeZ9A9QS9eRGnti9hKSWNARh8GT5GlgXN0E7CuGc9mB0n94p2GPj@vger.kernel.org
X-Gm-Message-State: AOJu0YxVdYt+S/HtYvueJmaldo3f42CsHTAM/q+Br9U0hEiCFw5MnPSi
	MqgOVBr+3+U2r2icBDJdccmV9hkQGMTkXRSPs5qMisN7lYq4cUR4kJu+Vxdc52PDpXY2DylNwV7
	EAE8eFHKbgKilSvBI6RhEchDZuSIQPfd1JzjEAq7pBQ==
X-Gm-Gg: ASbGncslJfayY1sNLMdn0zLfedpi/p+eQYftIzvZ5hVmdvkiMKHMbtWl0Daq38KAjvr
	ITE7uygck/4loJAqwxkq6ikU8QHvX0EZVZG/BcOqX+uroh3DQ4fgVh8XeJC1G1fxxzRHEdQY0j3
	Ywc6/mioSQRGhT84gp6v0VQDVjF1QgHx4AKlpd/NF2iQ19YWkWzDT7fce8QjmYv2+MOdob2CVGN
	RYOKiwsEQyw0sUHEdCQ/pMgHtkMbYCIf/d1X1E=
X-Google-Smtp-Source: AGHT+IH0eM92WwCDRahzcw/O4eqi/MmAUuqF6p3lIqnlhgVoCsqGzUctXBm/mnNB75hLW/j3SDqa2DEtFDBpHTUWSYY=
X-Received: by 2002:a05:622a:2b08:b0:4d1:9467:dbb7 with SMTP id
 d75a77b69052e-4d36fc02d24mr38698411cf.38.1758639461660; Tue, 23 Sep 2025
 07:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
 <175798150113.381990.4002893785000461185.stgit@frogsfrogsfrogs>
 <CAJnrk1YWtEJ2O90Z0+YH346c3FigVJz4e=H6qwRYv7xLdVg1PA@mail.gmail.com>
 <20250918165227.GX8117@frogsfrogsfrogs> <CAJfpegt6YzTSKBWSO8Va6bvf2-BA_9+Yo8g-X=fncZfZEbBZWw@mail.gmail.com>
 <20250919175011.GG8117@frogsfrogsfrogs>
In-Reply-To: <20250919175011.GG8117@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Sep 2025 16:57:30 +0200
X-Gm-Features: AS18NWCQpKJJBOwPqVorO2NGt-XmlZBAK8wWQiyLzvCGZrc4s0l4d18vx3t_7WU
Message-ID: <CAJfpegu3+rDDxEtre-5cFc2n=eQOYbO8sTi1+7UyTYhhyJJ4Zw@mail.gmail.com>
Subject: Re: [PATCH 4/8] fuse: signal that a fuse filesystem should exhibit
 local fs behaviors
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, bernd@bsbernd.com, linux-xfs@vger.kernel.org, 
	John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Sept 2025 at 19:50, Darrick J. Wong <djwong@kernel.org> wrote:

> /**
>  * fuse_attr flags
>  *
>  * FUSE_ATTR_SUBMOUNT: Object is a submount root
>  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
>  * FUSE_ATTR_IOMAP: Use iomap for this inode
>  * FUSE_ATTR_ATOMIC: Enable untorn writes
>  * FUSE_ATTR_SYNC: File writes are synchronous
>  * FUSE_ATTR_IMMUTABLE: File is immutable
>  * FUSE_ATTR_APPEND: File is append-only
>  */
>
> So we still have plenty of space.

No, I was thinking of an internal flag or flags.  Exporting this to
the server will come at some point, but not now.

So for now something like

/** FUSE inode state bits */
enum {
...
    /* Exclusive access to file, either because fs is local or have an
exclusive "lease" on distributed fs */
    FUSE_I_EXCLUSIVE,
};

Thanks,
Miklos

