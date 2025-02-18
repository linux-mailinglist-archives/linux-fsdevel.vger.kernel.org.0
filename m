Return-Path: <linux-fsdevel+bounces-41980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC8AA3994D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 11:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86FC5189A739
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 10:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA92F241124;
	Tue, 18 Feb 2025 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="EkFPl5E+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726381EB1A6
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874907; cv=none; b=FK1c/agpcJ4QNHH+kdT8piT+8h4dqUH847eK0Ed/toarhaMHTX3ZoPL2F+ex/FKjdQE33kiNrg0IaZEDUzRylmTPT1OQBreQ15HLH23u1UYlUx2Tplwbu9Nv9dm2E2tZBT+V+T0Fv+deQ7C6JgTYTNHEBCq2HvdytoLay3VdRnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874907; c=relaxed/simple;
	bh=5rVqKyMcxcqdLy/ItiSD5rAI6C4AMSRB2IYrY+2LyXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oO10ZbtLNfk/CN3Lr15jNgCV4k/zT2ISPKZVIvVzl1PAsZ5rzFuThQubht+0umPl4keGL9L7teBTfY4OT6eAAjqCRaeDnjGVX6ITgR1obYmQO8ENqqanT5kaDE0KTRcfcrKBIS+b/dHaOv0LwZlJaN905TfDRvreF822TjRHArU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=EkFPl5E+; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46fa7678ef3so56940811cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 02:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1739874904; x=1740479704; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E/Z0qExHB4GnNF4mgGk1aX339Qt06BNhHNrDyWrDNuc=;
        b=EkFPl5E+rCJE6IfFs/oZAUYxPfZ4JEtKRwZpSibx4AVYbOsI7rBei9boiZ5hch4ohm
         3LWV13xAIEFKCV1YhbIfWsctZhYvimpJA0EjU+9ftAx2dTZmJWRdO6n0zc6FApX+Fa7i
         REBt+goEZZU6WntXba9yDNq8407ZuqoEhixh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739874904; x=1740479704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/Z0qExHB4GnNF4mgGk1aX339Qt06BNhHNrDyWrDNuc=;
        b=GeVemVVmoV0MOnO27FlyhG0pz0U9YFB6oQhg8I6QbunfxL1vRfU7fABd7nYUd0SU9B
         Yu3pdIX0UNXA0944EyIc0njfTfy8QHiHwSE8IIktFOCrpk6GzpElGn1FDtcyvM5I22zG
         mdY/q9tlTHw3I99NjLNbBk64NcO5FwDKKp9hcHB35zAdPbZLyvUBssUiPrVgUOv6RM33
         z56YLFgWnSykGfgvGFEDgSpJ0C0Hyq6+alby3XVk1SzMExYCAlbmXQvCvacaFTk+bwHt
         da+1O2BYxHvIB039ivXAkuwsYZ8Xt2wRGvV5z0pr+rfbdzbV06EzChrD1iH59peTeQr1
         BsLw==
X-Forwarded-Encrypted: i=1; AJvYcCUG/Fllb2mVclnrbBIhGpTVQewLadiohCaHVB9NTc1fj1NcSFv6qhXddqttU2CK5p/3RR0zB1fHaU/Uwdet@vger.kernel.org
X-Gm-Message-State: AOJu0YxJxPCVe2CtooS6PQMze82MA/ejBcaPRvRO15ozaTXPu6eQeJ9i
	c0Tdb/gmwXd45EtCLZylYjmwiHiPrZ4W8afj0XckdyxFt8y4ZActOw55WBYnTe83zYw/NIiOack
	CwXrh4mFZijtuTp+q6n/FV2KOjt9M4DGEwyTBhA==
X-Gm-Gg: ASbGncvVUzXUOajaKRPHDuIM/yOZ+64bJibwNEnVonsaopRxct0fFUl8SfZoc3enZ4i
	75Db3AgjkShH/ZfKNebPDHCjbS7xmRWklu3Zo22tG20l7jjrB6/ZTNsEzJjhQLkMLIkkLC6k=
X-Google-Smtp-Source: AGHT+IEpiwSZX4vRhJbDFJ1X30VOuKKiT69jv9pwa/7/xaXy7HKIP1sTQTKwyHkROyECd2XtP/LxfpUAt7HLKX1xnSE=
X-Received: by 2002:ac8:5a82:0:b0:471:bb6f:5799 with SMTP id
 d75a77b69052e-471dbe7c15cmr179985471cf.35.1739874904391; Tue, 18 Feb 2025
 02:35:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217133228.24405-1-luis@igalia.com> <20250217133228.24405-3-luis@igalia.com>
 <Z7PaimnCjbGMi6EQ@dread.disaster.area> <CAJfpegszFjRFnnPbetBJrHiW_yCO1mFOpuzp30CCZUnDZWQxqg@mail.gmail.com>
 <87r03v8t72.fsf@igalia.com>
In-Reply-To: <87r03v8t72.fsf@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 18 Feb 2025 11:34:53 +0100
X-Gm-Features: AWEUYZm174Vtkg8CGi97zDvZOoF7lSynxrUSzinYaOe0zIR4ksp5V1ftEBvZ570
Message-ID: <CAJfpegu51xNUKURj5rKSM5-SYZ6pn-+ZCH0d-g6PZ8vBQYsUSQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] fuse: add new function to invalidate cache for all inodes
To: Luis Henriques <luis@igalia.com>
Cc: Dave Chinner <david@fromorbit.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matt Harvey <mharvey@jumptrading.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Feb 2025 at 11:04, Luis Henriques <luis@igalia.com> wrote:

> The problem I'm trying to solve is that, if a filesystem wants to ask the
> kernel to get rid of all inodes, it has to request the kernel to forget
> each one, individually.  The specific filesystem I'm looking at is CVMFS,
> which is a read-only filesystem that needs to be able to update the full
> set of filesystem objects when a new generation snapshot becomes
> available.

Yeah, we talked about this use case.  As I remember there was a
proposal to set an epoch, marking all objects for "revalidate needed",
which I think is a better solution to the CVMFS problem, than just
getting rid of unused objects.

Thanks,
Miklos

