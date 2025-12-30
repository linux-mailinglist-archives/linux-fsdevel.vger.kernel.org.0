Return-Path: <linux-fsdevel+bounces-72256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6F0CEAC24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 23:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFABD3006990
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 22:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203A528489E;
	Tue, 30 Dec 2025 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6zgYslp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EA228469B
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 22:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767132304; cv=none; b=g+zBhuBlQWWAwOq2K2TFhzuS41BL7Z/rKAROGlzBU/TN2n6DAquLR2uMjMrpWipIkM7hdyNqdHHcaY3Ds4ea8bwOH04u8yLybZt82VrFGFn49PVDrN+yDQIlyvkM9joAwB9duBk1/wY8Mu2zfniIi8QfN6/+hXA7sxXcwatVgQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767132304; c=relaxed/simple;
	bh=ciEnuCD23jowJ/L+XGQbb7pSaDpfH4eCH7oImwf2d0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6PkvAiMpxM1f2e/8vxbp9eS1KSeFBxXJeoDJgoPic9UciCXrZH1lRUQIq/St5H49G0nC1p1Gcf9otqhGSJKgrl5hzc9FbJyl4gb8FcowvUzPGlyZyEhgVRFZ3Hqb2BwW0vdG5ZqV4llNzdE2d8hwusDDa1yzclH0w2u2ekrsDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6zgYslp; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-64d02c01865so13325803a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 14:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767132301; x=1767737101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iL9oUwPK6pMmNAMWI41vZfP4nRtVQLFCd6SfZyUQxgg=;
        b=R6zgYslp5lbcmAd3i8vca/Dq8PTNAo7Lj4IMNk1n2/Nr9YfhQUSubfGadW/VO3ucTI
         o0fkTvRvMYDYzXi5XblRWF+bGSYmdm6cZY33Co+Y+52iZS2H5DH9PgER9vb7nh3LVb4h
         wLW/Woa8lgczK0acXDksj0q+ZQgu+roI3TGFWoc3d8GlPCiPosIk8sL1hVpL3T650GBM
         fe25QLnEQldsXD7/GVaZi1O+4YRH8oSPzXHjrG44c8yvHIiw2ofmRuMi2LHnwUQMc+eB
         779q9vbcHEtFoH8RIZpyac6w9PRUTqxE7mXUTVdaU2TvXFgPWqbtiSKtaV0LOoRJRbd1
         8HYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767132301; x=1767737101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iL9oUwPK6pMmNAMWI41vZfP4nRtVQLFCd6SfZyUQxgg=;
        b=XAGlBjoaoDi+A3Tw7bNCFP8Hy7g02imfYLkkjscE5CGLWLrKeUeNLy1BscJHhW26AT
         CvzcZEW/NLU2yLxKVUHFpxv4W4YVen5dfPOo8uEPVXseFHfc80y/UcyL3I3Cy09STzMa
         24SSwchsqw4Le7bStoczefbTXyL2Mm4K73cCrPiW9VFEKUfazalzuNH4dQSsK1ZI/zj7
         oxaQOGQVaM2T/T2j+6/66h2ays28PhM8Zva89PoHyNUzpX/1aoikC8MJg2ufINexsru5
         DU/S7hxoWB8/cnEHcLJlZVledAjNBFHfwPzvlBmH5SZdggAd35lmnuku4nKgwEzVt5pp
         QpaQ==
X-Gm-Message-State: AOJu0Yytu5EnynkrqQq830+vXynDN4GYD576IemEfL18hTtUp+ZGMV7I
	uCCDgJKNO1GSDAKVsxwvgazG+Ezg66leOpP7heCcGMaj7QVu/bzFvt23
X-Gm-Gg: AY/fxX7VgZFDBTw9ZkMyEUOsBE2U6VQm9tKachQ7hBdkOaIgh8qW/JZk2w47Hqr4w2W
	g1vcTmWQUQ7MtDnm1UfvmRTs2I/XPydriyu0kAbKMUtCZbjscYhOSlvYSnJkS165o+5ApX5Xx/y
	c4L7AecO2s00iRj0x/ncevIYHwV+QCtan65T9qHSzbqq6vW1KKRqIwK/0MDx6p3K00tkurMTP1x
	hWqcTbhSLxSK4oAAWPHveq66M0qiQ+P08c8hQyKxirQFOxDBSl6ElaKvD3N9aVJylFhmv5l95Fo
	ppvEaMftvZmloeY9v2l5y3O3v+BwpJ1ulCoDsCBZJ3jGfQuPsB5bwGPTH5uJwBlotmwTkmPGIoH
	Y8Zh5Bj3MPUM0HUjTsaLh4ngy6QqkaeTU8526oDOyj0QIEBQqVgFRD2ZuXIIg8/P3BLThvueb6u
	b45cDW8QTBLJJ64cnz2hIRHG+ZIc4RxUraFOwit4ps5ILSvS7Aah7I8M51j/0=
X-Google-Smtp-Source: AGHT+IFNqw3fHXA+0vU+KlB/nzXR38Cm2kP1GIXjrZY1/19S+eNMcf/p5//Z+VJzLtIGZInAPA2ybA==
X-Received: by 2002:a05:6402:2685:b0:64b:6e44:217 with SMTP id 4fb4d7f45d1cf-64b8e2a6a78mr34031433a12.0.1767132296212;
        Tue, 30 Dec 2025 14:04:56 -0800 (PST)
Received: from f (cst-prg-87-163.cust.vodafone.cz. [46.135.87.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b90f5400bsm35893748a12.4.2025.12.30.14.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 14:04:55 -0800 (PST)
Date: Tue, 30 Dec 2025 23:04:46 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	David Howells <dhowells@redhat.com>, lkp@intel.com, oe-lkp@lists.linux.dev, 
	Alexander Viro <aviro@redhat.com>
Subject: Re: [PATCH RFC] fs: cache-align lock_class_keys in struct
 file_system_type
Message-ID: <o6cnjqy4ivjqaj4n5xphstfnk5jznufaygwmfkm2gyixqgfump@7fc6c6h6d5if>
References: <9fbb6bf2-70ae-4d49-9221-751d28dcfd1a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9fbb6bf2-70ae-4d49-9221-751d28dcfd1a@redhat.com>

On Tue, Dec 30, 2025 at 03:07:10PM -0600, Eric Sandeen wrote:
> LKP reported that one of their tests was failing to even boot with my
> "old mount API code" removal patch. The test was booting an i386 kernel
> under QEMU, with lockdep enabled. Rather than a functional failure, it
> seemed to have been slowed to a crawl and eventually timed out.
> 
> I narrowed the problem down to the removal of the ->mount op from
> file_system_type, which changed structure alignment and seems to have
> caused cacheline issues with this structure. Annotating the alignment
> fixes the problem for me.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202512230315.1717476b-lkp@intel.com
> Fixes: 51a146e05 ("fs: Remove internal old mount API code")
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> RFC because I honestly don't understand why this should be so critical,
> especially the structure was not explicitly (or even very well) aligned
> before. I would welcome insights from folks who are smarter than me!
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 9949d253e5aa..b3d8cad15de1 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2279,7 +2279,7 @@ struct file_system_type {
>  	struct file_system_type * next;
>  	struct hlist_head fs_supers;
>  
> -	struct lock_class_key s_lock_key;
> +	struct lock_class_key s_lock_key ____cacheline_aligned;
>  	struct lock_class_key s_umount_key;
>  	struct lock_class_key s_vfs_rename_key;
>  	struct lock_class_key s_writers_key[SB_FREEZE_LEVELS];
> 

There is no way is about cacheline bouncing. According to the linked
thread the test vm has only 2 vcpus:
> test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

Even if the vcpu count was in hundreds and the ping pong was a problem it
still would not have prevented bootup.

Instead something depends on the old layout for correctness.

By any chance is this type-punned somewhere?

While I can't be bothered to investigate, I *suspect* the way to catch
this would patch out all of the lock_class_key vars & uses and boot with
KMSAN (or was it KASAN?). Or whatever mechanism which can tell the
access is oob.

