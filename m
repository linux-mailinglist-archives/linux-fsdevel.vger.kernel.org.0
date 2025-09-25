Return-Path: <linux-fsdevel+bounces-62766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40263B9FFEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 16:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4F74E01AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 14:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D3254279;
	Thu, 25 Sep 2025 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="oNUXayj8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAAD18C02E
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810367; cv=none; b=XXhkuaO/Zh5jNgXcflGKTLpgmCUkF6ro9+CLee8CcYVF2qakKsBhC/PzKJ0WVkIS2AWOL1r7bvRkbU/OIzCuYbE+0sjOltROeODwoQ5OEQL3ZGMq/h0HLvv+VRVfXh9UTSQynIv05/i2Wr6c7NGfQgjefCV1PNDdq894HH+68gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810367; c=relaxed/simple;
	bh=kLQwKT7CQRm1aVedVomGiHl4RkD5BxvZ6Uz8ZXvBO+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5OJKjFW0hQMEN4byX0ppSTe3UIZvxWPc+iZvmz3/Y1LpOp15UFCIamFrIN2Ui/b3TyyZIGA+IPKB7ocVnsk2Cllajm3CZmD/ZL1xFQ4uuJHSJNNxcXXeFmQC6xqWKoW6gMp0CtibQ3VKVB/0sEm2hugYsELz4Ag0zRfrOTdkX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=oNUXayj8; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-85630d17586so149140285a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758810364; x=1759415164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kLQwKT7CQRm1aVedVomGiHl4RkD5BxvZ6Uz8ZXvBO+8=;
        b=oNUXayj8uQ0Ru8NGu4sOa/i1394BtdWtFSc9k+alixlkvKpEDQ4G9bGuzZcLuKNw1c
         GvmfACcOJkAumhIau0F9EXurczmvrEuyy9odWt4nW4oIvGIli/xOhNg2n/6z3dQQhX1L
         /CZ38rMGo6lBNrZNgCaQ9UeZTgjYcopgjnTjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758810364; x=1759415164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLQwKT7CQRm1aVedVomGiHl4RkD5BxvZ6Uz8ZXvBO+8=;
        b=WLDYjtTZNfXuXFvkulvtSHDnNR2jY554H0e8ViT03mFTyvS34QM5rnk2mjWbcnSpYh
         e1SJASaNzzvrBQ9e3yEs2L7n61xznnFRj9WT5knnM0ql0yu2wJ/7gClHge/n2rm4hqTz
         RM98GNlm7CwaKAyuGWH3+0dS4W8fYqGGPJIH5gQWSCR9pNhAJ3b/quSeCYgFrPX+uudz
         0Z9P9toAZYsS9GWqrV0H6jketn/alkOZmXjYAqgOZtbQDb1zg8IdiNSIN0BIXXyV4Hl/
         V4gnrVHTyesqvY3aURrr7DQ6QGX8q4d30WFkIQHsLpWoHRZlgnPa6ZugeqregpjeVy+K
         VF4A==
X-Forwarded-Encrypted: i=1; AJvYcCV4gxsJlq/pR7fxl+FEdrYlXiFRmN4yjuyg8IUgw/64jOB4sSDzbdAnKSt3KcDch8Rp+Te3ooMQLDwM74DI@vger.kernel.org
X-Gm-Message-State: AOJu0YxtKfswlb+ZzYMXhtDOZ68QVnsvkq3gYHxtc4UIPHP3APZoAFud
	H9hFt/hJNC5t/JJ/FssXscK9Dnvhc4KlhOruDsAnu4hdYWabv+PzZojBeiCJ7XzIZ+IRSwDH0WP
	c5m/PzVxrvYykJGo5dR8nnuOalfwVzxQAQl0p3OmcCg==
X-Gm-Gg: ASbGncsKKni/Cs1MkIKvRhDSW5xd2OvltqyOUfIWPAr6XKTpIHVsOkk3zZix9LOgZ49
	wOnxr9QdnwpmzxO0eSglGDTWFq1+1t2BWJHLH7R8nlz6Q00OK8q46eAoCTJ7nSq50/Yxdc8mBK7
	qphsIzlwLJeWVmSJI3mpZoFHlLKtkXQvvfogQzukCR8hxddvASgi6/6ftLrZH5/7FELXERUWbVC
	MnIoqHPASFUkDZs7nbe3zM+s+Js3WrMLDy0H0k=
X-Google-Smtp-Source: AGHT+IEWEZUeqguxX1KmPZKfkWXxC/ABE/OYX1wAAb5sent2at3dsouQvLb+RIkaiW+zn60aorSoDGZZkURvGlr7neU=
X-Received: by 2002:a05:620a:3902:b0:855:24d7:5525 with SMTP id
 af79cd13be357-85ad85abd13mr455953285a.0.1758810364013; Thu, 25 Sep 2025
 07:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175798150680.382479.9087542564560468560.stgit@frogsfrogsfrogs> <175798150817.382479.14480676596668508285.stgit@frogsfrogsfrogs>
In-Reply-To: <175798150817.382479.14480676596668508285.stgit@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 25 Sep 2025 16:25:52 +0200
X-Gm-Features: AS18NWBFMThGopHRbA-o-UBQbTeBlGy3BGU5JkoxwQuiBz9uVdcGsyESsqGmqaI
Message-ID: <CAJfpegvLLOOwzgxbGgRMQrv2m+HhA=TPhKgA9v9QXJjCe1kS7A@mail.gmail.com>
Subject: Re: [PATCH 5/5] fuse: move CREATE_TRACE_POINTS to a separate file
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net, 
	linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Sept 2025 at 02:27, Darrick J. Wong <djwong@kernel.org> wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Before we start adding new tracepoints for fuse+iomap, move the
> tracepoint creation itself to a separate source file so that we don't
> have to start pulling iomap dependencies into dev.c just for the iomap
> structures.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Applied, thanks.
Miklos

