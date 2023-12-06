Return-Path: <linux-fsdevel+bounces-4919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D6A80637E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 01:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ADA81F2132E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 00:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5F023CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 00:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="aVtNw5Op"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227641A5
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 16:22:01 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1faf56466baso3488167fac.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Dec 2023 16:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701822120; x=1702426920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WTn+v+GKlLUQg8fJn6ige+MxBInKYc740geNUOepq6Y=;
        b=aVtNw5OpnCAF8bLrNrg0nXoywfL/VF9UXj0g54pjxBkay0l/w8OdJdNcsmJiYot/Rm
         HRaAMvtsZ6QtWs3Cpzbm1GqA2ceoaMurhaOpybXg9aggWtA8sZwHQz+qZ/P+rL6WNLxi
         L7ArGtj9fEerpPD3rqc/50YKDGFm5PpSARFXcsPKcbrhXIlcqvBNgUmqVAvG3JrUqZFG
         5E3VICF45D9HpI4wlMBdn1L+i91SRtO3sscIXuE6sPh1d9+Yv/Q9NiwFnHqZkNNA+Els
         JHaUiNtgHDtTGEsBzEcR5u++VQwVul/RetfGrSf4XUctpuaQhitnhmMgJP9tsKrvns9T
         2W3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701822120; x=1702426920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTn+v+GKlLUQg8fJn6ige+MxBInKYc740geNUOepq6Y=;
        b=Lg/Bz4jfcruFHT3/NelUbUBUs2xPEpg+bYxV/HVS4RluUsyNHZSgXiVvZzykReyKa4
         KPdpcu/t+J0xHaFikWauorARpENsjC5U0h80fhQf8illIJDwhD8sOcmNgpPMhD0IW+yk
         SSCmjcJTuXcLtohYORkXRvEXI5AHsy2S7Izmtem2mSvvZyYO3JzYCUjvyaWg9sx1Farn
         E0jGDhPVjIJcE/YwVAsI80HXwKoFJw4EtKHXxLV9Ppe8nFbTEhlbLZpAEZe48mjK+qB/
         jHkYnN+nsD6IolyQNPT5RolA1OY1+owlxWHlxasyOAlk2LnSFPz6JERXCiScGjP4GiAj
         bDEg==
X-Gm-Message-State: AOJu0YwOyAPSo/o1b601h0LfGWN0fk9hwLOtOjflju3bP7NE8Ngf/yUT
	yVE+NeiDbN2R82XUQ/3DTfZBTA==
X-Google-Smtp-Source: AGHT+IEoqLzCem6jGF+DdIz2L7pGMZ7r07MIKLiuTT5p7WR7wzXVOcHhMrUPADMDUQWQYXqvSmihow==
X-Received: by 2002:a05:6871:829:b0:1fb:19b5:4065 with SMTP id q41-20020a056871082900b001fb19b54065mr4590oap.88.1701822120387;
        Tue, 05 Dec 2023 16:22:00 -0800 (PST)
Received: from localhost ([2620:10d:c090:600::2:f5a])
        by smtp.gmail.com with ESMTPSA id l19-20020a639853000000b005c2422a1171sm2883627pgo.66.2023.12.05.16.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 16:21:59 -0800 (PST)
Date: Tue, 5 Dec 2023 16:21:58 -0800
From: Josef Bacik <josef@toxicpanda.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fscrypt: move the call to fscrypt_destroy_keyring() into
 ->put_super()
Message-ID: <20231206002158.GA89404@localhost.localdomain>
References: <20231206001325.13676-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206001325.13676-1-ebiggers@kernel.org>

On Tue, Dec 05, 2023 at 04:13:24PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> btrfs, which is planning to add support for fscrypt, has a variety of
> asynchronous things it does with inodes that can potentially last until
> ->put_super, when it shuts everything down and cleans up all async work.
> Consequently, btrfs needs the call to fscrypt_destroy_keyring() to
> happen either after or within ->put_super.
> 
> Meanwhile, f2fs needs the call to fscrypt_destroy_keyring() to happen
> either *before* or within ->put_super, due to the dependency of
> f2fs_get_devices() on ->s_fs_info still existing.
> 
> To meet both of these constraints, this patch moves the keyring
> destruction into ->put_super.  This gives filesystems some flexibility
> into when it is done.  This does mean that the VFS no longer handles it
> automatically for filesystems, which is unfortunate, though this is in
> line with most of the other fscrypt functions.
> 
> (The fscrypt keyring destruction has now been changed an embarrassingly
> large number of times.  Hopefully this will be The Last Change That
> Finally Gets It Right!)
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

