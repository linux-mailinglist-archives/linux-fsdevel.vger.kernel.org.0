Return-Path: <linux-fsdevel+bounces-62056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 862A9B82708
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 02:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AD11C2481A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 00:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7951DF748;
	Thu, 18 Sep 2025 00:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzGvJlF3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9D1E572F
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 00:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758156379; cv=none; b=fC6NcFSUtB/NPLOJuxw520NDK9+GHmE0JyIGYgYaN5C8Hn1PQnqdP1n9/BO8tfcg8MiWDFDWEGF1/P4r8wjUfSczGw/8G/hJvve5dRpsn2iU0B6QFSqijx1U323CSIjoTGm1y1fQCy6DS9JXzEZLxm0YSUZsCCwx1SBP9acT5Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758156379; c=relaxed/simple;
	bh=UIo7RA/G/xDD02JBTiyBlQlJJd9IfyisvvvnbSKMNJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHyA67E6b1rMtxLMPplWxk2MLUI40OxdF32GNNT4jn6OSVik0Xj9AJHJoViVB9Ff5tMjINKcDfNRtEONKzhvcBGRneMYGLh1w2Gx3XdpMkngAGxLJhSZfaYrBVfI21EsTn1r1JT3o+h8ZqJ91lOOlxI878Oda/53qJTmaktyiq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzGvJlF3; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so52637266b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 17:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758156375; x=1758761175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScdSoNWwYp7Lx1FqF0sJinLc5HuMMzMbeEOteqLeKGY=;
        b=KzGvJlF3KPV470aj9p2+WGc+dHQyYumQ/n1JBBocmuZJA49YLeiUqmwy+/yYPZgQZj
         ssXCb7z6YgYiOutrT3AfsrRikN0B83+7ruvziWNhCwsz2ELTIiizmfls7PvsFdkvcJLT
         qpJdXp6xZhBTLS5nekg+F1LDSdhm19EysHMtk07fabj1P6oLuOyCMfvOGen6jT1eBwbP
         6pMnjF6KJT+0XEj91pCTwQujjt7F6ghOtnCnJ+EU2+tXugoJTsFgk+QsjwfhKOKRRjgu
         d9FePQZs61kpvgUTD0qeflLnFiVK5p7eAvAv3yf1sOrJiE6TsrG+zJ2UIlYBCl4PmRtc
         hKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758156375; x=1758761175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScdSoNWwYp7Lx1FqF0sJinLc5HuMMzMbeEOteqLeKGY=;
        b=V8Jlu8mWQd73Ru/bN1PKT9rTS7ba4cZYSScMYyYSOuCo6nUtM4rZrhA1wAblFbTz0j
         c39aP0PYjFnG7GobicuQVeFZq7GrJc1O1wIQD9c7zgvMYMtBHQoKHhwdl1xwGQgq9iFN
         f7oZlu9KLcU+PSYMAZz+WE0nqavc+HH/HcoRFjugELSyCfrXqyyK64N+LPukyHVuX3w+
         wpB3DwBkIXH98nNSElGQjZ7NHAj8O+R3/h8NPl47uJPGq+1pXWXDClr8LwqJ9FktIEd3
         LHYuekl/hi33Yf4GxyQsrKQwcNIf4jVD6PubhUSecJOaQKdNFRcgHctZkGvjuvEQ0hGo
         ciRw==
X-Forwarded-Encrypted: i=1; AJvYcCWpi99EWadPJzrzm1cNoXGtY5rzbj8NSH3BXkZPlvPHDo5FEocVIIVfiiIrsUzf/E0oAdVresRnTLmUneIf@vger.kernel.org
X-Gm-Message-State: AOJu0YzZIC1x2O1vIDcDR9X9XlftnnTlESg5ulM1sWaQjsnEdXoZQ9xB
	F+cuM0Tf0v0RlmKHxIVACZBo9AY4Cclj0Pr5v1Y1wiNi0ognEzlH7KoU
X-Gm-Gg: ASbGncvt9JTCkm4GDc3a70S1MWGzhlM1thQHMJiP+26Us9ZxB332ORiQdkmNX0uj5sm
	GgQgmAfJXCjbVVus2281PpZNMtaA5tfErJqxr9oKEn9rGdLNlkmEfqHAPaICwyekXEvy0TuXKwU
	FaN0HtO2/+HoF/bBHASDnIS/bvbdQ0raoFo9U4LOZOgWwiVc3PMg5DnNfEtJRFYnT5JxsN1Uv9C
	Fi5jeuYz924booJmyWaPz3zGv2QECaojMEFe3tcWBZzWK8ax2NrO1nPtU1bNI6IYxgGw2eIkygK
	JkBKO2xLCKFmrC9zy3Xs6KGmsc2k20meQ8/qiogeYQ9JFP+EzqiGcBR7hcLuRkjEIB+rEMimf4F
	sxzUSsV+vfGvIciNYPtqvh7thqKYf9mSMM4Tnbg==
X-Google-Smtp-Source: AGHT+IGtolM3WpmMOfPkC5aQN2+QGXojyD9zctBgGDhejOP10KXv+fVObxP+zNTcUHL0l2vGVmYa+w==
X-Received: by 2002:a17:907:7291:b0:b07:c28f:19c8 with SMTP id a640c23a62f3a-b1bb7d419c3mr514517266b.30.1758156374473;
        Wed, 17 Sep 2025 17:46:14 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fd271ead3sm73266366b.101.2025.09.17.17.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 17:46:14 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	axboe@kernel.dk,
	cgroups@vger.kernel.org,
	chuck.lever@oracle.com,
	cyphar@cyphar.com,
	daan.j.demeyer@gmail.com,
	edumazet@google.com,
	hannes@cmpxchg.org,
	horms@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kuba@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	me@yhndnzj.com,
	mkoutny@suse.com,
	mzxreary@0pointer.de,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tj@kernel.org,
	viro@zeniv.linux.org.uk,
	zbyszek@in.waw.pl
Subject: Re: [PATCH 17/32] mnt: support iterator
Date: Thu, 18 Sep 2025 03:46:06 +0300
Message-ID: <20250918004606.1081264-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250910-work-namespace-v1-17-4dd56e7359d8@kernel.org>
References: <20250910-work-namespace-v1-17-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Move the mount namespace to the generic iterator.
> This allows us to drop a bunch of members from struct mnt_namespace.
>                                                                       t
> Signed-off-by: Christian Brauner <brauner@kernel.org>

There is weird "t" here floating at the right

-- 
Askar Safin

