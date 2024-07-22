Return-Path: <linux-fsdevel+bounces-24098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF09D9394E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 22:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25C7282134
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 20:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E7A39847;
	Mon, 22 Jul 2024 20:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Wi6DfehG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F588374F1
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jul 2024 20:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721681060; cv=none; b=sG2wR0vens39qVgfkXSXMunqxNWGs6Go93lL3Dx6l1Y2KcHZ1x1Srsik8E+u+OzB6Vj2zc3o41tYR8ilmKP4qNLf7DLTHS+Sj589OONfYoDJ+zvaIQmSwvGR6UMdciIy+tXmGaDNIfbp9ZSLXP249qVma24o+m1mjdrOGq3haJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721681060; c=relaxed/simple;
	bh=g2vVTGvUlZey3Q4HtJ2+ZNxrJKbuN+qKXvYQfKvt49c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Av2cEy3bn25VQpf9Bvd91OG7h3dmq7/y+5Qnd0pFL44C8YI2qF4mz4hHARotRNpekHVcsbu0r4bQ7NKU6BcofFgf4hjruT23W5eynjIkxL0jIshIUfPSxcZbAg8/91Tje33ZAMWQKrWd28DLKp4K+PZ1mWF4UuSnfxpbU+rK6Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Wi6DfehG; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-66ca5e8cc51so17211477b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jul 2024 13:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1721681057; x=1722285857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SV2iYGR1KM3dIkIpOoHEA7QZBsFJWDHQUZhMnl3YBGo=;
        b=Wi6DfehGAlGlPttgjNKbUWdokgpNrx0xbTymTwavH+f/pno3JcF8LZRgJOlkUAmUVM
         KOmWE5Zb0Tl4bj/+auhVTh54hZRCZzci/yYk1OPXyWH8/GlcAs8sxonRJnJ1W5FHzX44
         dyJtS6YtxPUXLsQN20EVZoVhRCju/4gi4LkHT8o5qoSByK/18CZnpgqcjFyJA/f28n9f
         0PYjTIugIKjy1esf0E1y9G8HzXmip/2hNHlSP2gOAZaUCpE1h1XcO3+eME6+S/nVrt4d
         fMw/HBRLFw0gFvyvYVfLbv5GZCuTz4NfQhUSP0FW8VQedTy/OIIIPeD7v/Rr60Fr9bWi
         mDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721681057; x=1722285857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SV2iYGR1KM3dIkIpOoHEA7QZBsFJWDHQUZhMnl3YBGo=;
        b=SyUB/FHtd/wgJRpUDgeQnk8oYu3DgU/2JIloR58/jjGlYISy1hQCvDWxrcm8iHUUFg
         X81uFud0nQ73zILAYPdCUWELc+GJpDcuLDIflaOohGyzyyEtNVGb0sDFtvz/tIuHuagr
         mIkcCl096Qw3jfiFQCYRpjShItlTKqZq/S7gJAya/gQbWSnzBHbkKB5BksV0c21aUPKT
         njKXxhNvnp/gnsaa2PbHWG0aUtRVFH9ojV6l+Hk3SccouZC5D02+/e4y6yZvE3cNejg8
         /J7sKwCL4oOxV0N7RF2+lK3p04COjoVSaSmxxaufiRnp5W9h0kUqbzm38zqzPdbK63wf
         c8pw==
X-Forwarded-Encrypted: i=1; AJvYcCXI89ODITEyDRiuP+23/HjZLZcH+4aWvLt9IedIRQFDidtJjdO9h5UrGzC/DbSxAyBUvNYPTy/YTe0y8En8B/Nz8bUDW1kNLp8fQ/BLfg==
X-Gm-Message-State: AOJu0Yyvn4bOYekTw22p9p9WgGfOV8UP0cXvXmY+WMIbGwtC4UcFJrro
	cH0yDeXxkUDULr0WwUV7N7v1gNa/DO1sHx+TAY0R+D7jD47QmuzGsEmrdlqL1Wo=
X-Google-Smtp-Source: AGHT+IEAaxw2OrTbAMMnIDl2AdKFb3zN9efMc+tbtwNp7csZO9lmx+ar8LdHRRkdGy6AcV1d9WkD8g==
X-Received: by 2002:a05:690c:3303:b0:64b:9f5f:67b2 with SMTP id 00721157ae682-66a6588e566mr95631697b3.31.1721681057196;
        Mon, 22 Jul 2024 13:44:17 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66951f728bdsm17620857b3.23.2024.07.22.13.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 13:44:16 -0700 (PDT)
Date: Mon, 22 Jul 2024 16:44:16 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com,
	kernel-team@fb.com
Subject: Re: [PATCH v6 2/2] listmount.2: New page describing the listmount
 syscall
Message-ID: <20240722204416.GA2392440@perftesting>
References: <cover.1720549824.git.josef@toxicpanda.com>
 <2d72a44fa49f47bd7258d7efb931926b26de4004.1720549824.git.josef@toxicpanda.com>
 <54hz2cqibnocv7jtv6sxk3dta36bm32i7f6tzdqcjmtf4cmfyt@cv2g25p733y5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54hz2cqibnocv7jtv6sxk3dta36bm32i7f6tzdqcjmtf4cmfyt@cv2g25p733y5>

On Mon, Jul 22, 2024 at 10:27:23PM +0200, Alejandro Colomar wrote:
> Hi Josef,
> 
> On Tue, Jul 09, 2024 at 02:31:23PM GMT, Josef Bacik wrote:
> > Add some documentation for the new listmount syscall.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Thanks!  I've applied the patch with some minor tweaks:
> 
> 	diff --git i/man/man2/listmount.2 w/man/man2/listmount.2
> 	index 212929fb6..8f7c7afaa 100644
> 	--- i/man/man2/listmount.2
> 	+++ w/man/man2/listmount.2
> 	@@ -4,7 +4,9 @@
> 	 .\"
> 	 .TH listmount 2 (date) "Linux man-pages (unreleased)"
> 	 .SH NAME
> 	-listmount \- get a list of mount ID's
> 	+listmount
> 	+\-
> 	+get a list of mount ID's
> 	 .SH LIBRARY
> 	 Standard C library
> 	 .RI ( libc ", " \-lc )
> 	@@ -14,15 +16,15 @@ .SH SYNOPSIS
> 	 .B #include <unistd.h>
> 	 .P
> 	 .BI "int syscall(SYS_listmount, struct mnt_id_req * " req ,
> 	-.BI "            u64 * " mnt_ids ", size_t " nr_mnt_ids ,
> 	+.BI "            uint64_t * " mnt_ids ", size_t " nr_mnt_ids ,
> 	 .BI "            unsigned long " flags );
> 	 .P
> 	 .B #include <linux/mount.h>
> 	 .P
> 	 .B struct mnt_id_req {
> 	-.BR "    __u32 size;" "    /* sizeof(struct mnt_id_req) */"
> 	-.BR "    __u64 mnt_id;" "  /* The parent mnt_id being searched */"
> 	-.BR "    __u64 param;" "   /* The next mnt_id we want to find */"
> 	+.BR "    __u32  size;" "    /* sizeof(struct mnt_id_req) */"
> 	+.BR "    __u64  mnt_id;" "  /* The parent mnt_id being searched */"
> 	+.BR "    __u64  param;" "   /* The next mnt_id we want to find */"
> 	 .B };
> 	 .fi
> 	 .P
> 	@@ -45,7 +47,8 @@ .SS The mnt_id_req structure
> 	 is used by the kernel to determine which struct
> 	 .I mnt_id_req
> 	 is being passed in,
> 	-it should always be set to sizeof(struct mnt_id req).
> 	+it should always be set to
> 	+.IR \%sizeof(struct\~mnt_id_req) .
> 	 .P
> 	 .I req.mnt_id
> 	 is the parent mnt_id that we will list from,
> 	@@ -69,7 +72,8 @@ .SS The mnt_id_req structure
> 	 .SH RETURN VALUE
> 	 On success, the number of entries filled into
> 	 .I mnt_ids
> 	-is returned, 0 if there are no more mounts left.
> 	+is returned;
> 	+0 if there are no more mounts left.
> 	 On error, \-1 is returned, and
> 	 .I errno
> 	 is set to indicate the error.
> 
> Would you mind adding an example program in a new patch?

Yup I can do that, I was going to follow-up with a patch for the new extensions
that have landed in this merge window, after the final release has been cut.  Is
it cool if I wait until then, or would you like something sooner?  Thanks,

Josef

