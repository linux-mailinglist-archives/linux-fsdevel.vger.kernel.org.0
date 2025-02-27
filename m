Return-Path: <linux-fsdevel+bounces-42759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BEAA4818D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 15:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E833A7E3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 14:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25376235BF8;
	Thu, 27 Feb 2025 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="eN3cSKZr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7202356BD
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666854; cv=none; b=hO8cYZKWlZyOjew0m7lOH5e5wstbx/77Ma+RgWkHm1t0khwRAhwd/6sQqZppVe12GeBnt2TuZ09t/R3vxTBBpLTupKPSqBU5/43z0WfJp3eHTQKmmys/XPOPBYNC/ajZoOeOSE8S2Br/16mBI4abnZbPLFK1z+8+eYRRijlEekI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666854; c=relaxed/simple;
	bh=OJr7vrHI4Hd8unZglLa0mCh6j7WF1X+C49dnAmbORSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uV/JmClFnTAmwRP2Dj54qYb4d25w0PO7Z62k0KpEW68TpDNO9rG/Q+gSNuzyYnGa/yVMwCrZ3UVk4+zs4ibj3GKzL7uQQWQiVFhG2kw1yF+lTs5Fb5FLkZrbSEwUACdqSnEDBKwnxWZnqNbZFrtCdDABoIuBqbSxVL5cKyxhKkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=eN3cSKZr; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46fa7678ef3so10299921cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 06:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1740666850; x=1741271650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OJr7vrHI4Hd8unZglLa0mCh6j7WF1X+C49dnAmbORSY=;
        b=eN3cSKZrwx6yGkweDM177zySL1hGTTjL4Aht8o4dg5WDyQ0EPed4raqRqT9MQQlRNQ
         lGwtwFALRRbaBbwSc/8Pankz1J7GPNkNmglcw/p0BxOCCgG0YbwBJLdLZE/WTfXPXOsc
         Dl8x4ujWN4aUeRtAbLx5ZqxduLYY98ChuL6EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740666850; x=1741271650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJr7vrHI4Hd8unZglLa0mCh6j7WF1X+C49dnAmbORSY=;
        b=plVI0xBsxz29Q5wbgo5m7PR/wHBmHjCOqKIKVnOCwS+o7ta6yf41e4zGCDEk1hBWmd
         /vhQLtH3R82qAlzU27Ovrsp7kblCgEjJLHOnVuu+CRm/8RtdnqXdHiArMTQBhoA9sGa9
         7Lt4EvUdlT1EMxjR/DEJNEd0u8zYrSulQO8q5d3wrKJsbMVV7Wnu9uOlU7npktoKjISG
         K4L8xGaQZVUWdEzSqKF2EX/5V6U9x2UOdoo8Gy5QKQl+/Ldya8AydgzZYapqmLmtE88j
         JZphO8+mdhsJX9AhLAIh1VVnZYNOZjLoZRhmB/Z9PXzPr90o9Hjopk6b1ww/byQ/Cd+y
         0DNQ==
X-Gm-Message-State: AOJu0YzZvcBo62HJ6r+7+fBAktP4AB1dIe/QgMOogQoPdxoCYwizlhkg
	FsbIkuOQ5Gy7GxjHaLfcMRmUcpJuVw4Ml8Ht4YSh6ciNKimuqO+uBQYzPdCe6lPUaEnRi1GOAoh
	Jz/7ofIOdkr6tIvDdFbZlo9rzXAtWItcfzIjMXA==
X-Gm-Gg: ASbGnct/4n5fY9GtmMCWOH1eQWrIMKngFHKE6XqIevX1/nFFEosMy3lVIw/GFqx7JPP
	f1A91IJ78RPGcndtypyKXWLhh4B1uvRKtCLjs8gvaRxwLgF0ePlwiStU3tOxsQBLm8EsY1C9QRL
	gxxeUst1kV
X-Google-Smtp-Source: AGHT+IE6sdw6KpvqE9AnsFJGDKNQMXRzPtLAxOkz9AcKdcDSBIrIWtyUj/9xtemkDcpBIyGrRVqWE81VZ3nXjHEAegw=
X-Received: by 2002:a05:622a:14f:b0:471:fb77:4545 with SMTP id
 d75a77b69052e-473813649f4mr112838701cf.39.1740666850371; Thu, 27 Feb 2025
 06:34:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224141444.GX1977892@ZenIV> <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
 <20250224212051.1756517-4-viro@zeniv.linux.org.uk>
In-Reply-To: <20250224212051.1756517-4-viro@zeniv.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 27 Feb 2025 15:33:59 +0100
X-Gm-Features: AQ5f1JpjXSrxGOgyhvEwcKfBOVSAZDInqoP8BXuWdW_wXsNO143vQR1v5TYIK3Q
Message-ID: <CAJfpegsXAdOH1unNxfh4+jbYr1YZs403AwG-QGRXPp119WPkbg@mail.gmail.com>
Subject: Re: [PATCH 04/21] fuse: no need for special dentry_operations for
 root dentry
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Neil Brown <neilb@suse.de>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 22:20, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> ->d_revalidate() is never called for root anyway...
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

