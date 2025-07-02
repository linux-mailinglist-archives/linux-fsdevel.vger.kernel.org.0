Return-Path: <linux-fsdevel+bounces-53640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35693AF159B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 14:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C715A3B13C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 12:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849CB241676;
	Wed,  2 Jul 2025 12:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vVIolfKY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755E3229B16
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751459233; cv=none; b=rnfN2NVgalOUt1CTNDzsSYCt4X/VK5NVXG4WKhSqfTDVV9My+ZFIX964uUrGCZMbpb37xCgjjCrtBEN+W4Rt9uvOGu4iVFOtc1/R10XO5GuucrkMWREdWIF4oMaYn+U2FYs79/4YpHwPnJaIdDCdco2/8Xn0xXLlcxHU+NAX81g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751459233; c=relaxed/simple;
	bh=yE8z01TChvByZMzIySfnpkClAxvHEDkEulb2GaDSJ5w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YYTZS+PBtW5gc3bM5c3RjWvRuR9CZCObTsJRLQT4ZZcK3SAhmN0yQPb/z7j1w1rdxWzfm53HFcnaTLWkHlIiJn+OjtY9X8yCw5049qc9NSj164w401kC5FWW0NUZ50CrBk5ZetxhYZQL2yJEOdu2lyQd0trWRzbChA+P/2QlrrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vVIolfKY; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4e9b26a5e45so2692002137.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 05:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751459230; x=1752064030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yE8z01TChvByZMzIySfnpkClAxvHEDkEulb2GaDSJ5w=;
        b=vVIolfKYzBFbNHYDSHPWRP9GOVGR2+Y0xsxLf0EvPMZOj1HrqzDOQEDKZ9NXdl2/rA
         EXpgRy8NtHUHCCEf1QHS9eyibAGsjs9CYkzi3KFbFs/nSN0NTeOtj15JFWigdqbxUGOA
         dzGMWQJ+23f+yGV/vKnPWKK5iJkj9anNuTz2K05KH3lOMfxSmvKPIONmo39wT/SPtema
         Za5vT20Mq01Ej8GupF5QRJWbiTj27/LCJ3OgE4xTcq+fRymDwwQ0BwC0+kBSC22IbfPK
         UHK7BbUaYeV1/FjFBybzv0ZYTHajLs9rXSl7LMlTfAfR975iHxLqpmJire6ZpU5m8wVu
         899g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751459230; x=1752064030;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yE8z01TChvByZMzIySfnpkClAxvHEDkEulb2GaDSJ5w=;
        b=u3m/eso8O7uvJH6g3nTc1W8LZUbVb2ziqJNW9YkhADZ3j47Ludl9QpgnuOUHIcr6qw
         SL7eM/Q35U0fEAIChW5LOmKj5dIGjlczbfLzgZhAvwmoTSTnrZdZDa9OIfMxFLUqy2xP
         9LwL4gDrnyJjLJOfhQRYh+o/Z/FiR0H9TIjlTodE/YsOPrecOOTIsO/BQiz9V8vYhW2S
         vqxkW9hfUfc/C4Ly5gfmptru+w953NipxpzvVtnqM3lyC9YtiNDAHODiuqR4avX2LhHX
         blcF3MuHkWT6l5ptk+ChmRgIA/Qz+QGz/rjoa5OrIepfSl/GoMniDUhgUMTs3Wd8wlDu
         v15Q==
X-Gm-Message-State: AOJu0YzZEUrfixjlQAVcIscDuOLq+d1CsZhMW2jUs94DbxMt6Ljtu6Nu
	z1vubFk8zs+jI0WYS9syqBZ9M0rXSGqf4XSYy484ONGUVGLSIGp/AnomTf9ZfKG0fzz6WjRmvO4
	O1ARB2QsaEufMl1LrvnbMyPMs4J+NhLrFraVlwg/dYrL6yScAv9gDR7qQLTg=
X-Gm-Gg: ASbGncvwhDmuhOkrdi+D2PbaYF9017g9Y0TeY4jbhDgkuy0gZjOrycWOl6Lg1jlXdd+
	vf+GCu/ad3w050grLUA4eWDqf5BzMD9vVi/XkW/DT8iCa0Zsc9iEsP2hlSUQWjJs8uHZgjwQMUc
	rGdW2RjGLSvC3nLw8aI9CjYcLthUmWbrreiYa5yPc6xEHzH8dBXsbAxNkbyzdG3v554f7oxQ+uX
	U4=
X-Google-Smtp-Source: AGHT+IHzNYrrBrYxxBoljbKLNdATn0BYpK2biUFqWLSS8Op6kBmpVNuyDQb5N9xiAeuZIk/XccMTZEbONvoMfJRxGh8=
X-Received: by 2002:a05:6102:8097:b0:4eb:2eac:aaa0 with SMTP id
 ada2fe7eead31-4f160fe0f0emr1273981137.19.1751459229965; Wed, 02 Jul 2025
 05:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ashmeen Kaur <ashmeen@google.com>
Date: Wed, 2 Jul 2025 17:56:58 +0530
X-Gm-Features: Ac12FXzqALhHn8A1GPyQZWFbXK0bE3_xqQFCTLA1olBa7YVuow_UJPdxRhJ-7dY
Message-ID: <CA+AidNeR+_SZPQjD37JcibOoQEwtDEYz6bBef1O3PfboS0BJtw@mail.gmail.com>
Subject: Query regarding FUSE passthrough not using kernel page cache thus
 causing performance regression
To: linux-fsdevel@vger.kernel.org
Cc: Manish Katiyar <mkatiyar@google.com>, GCSFuse dev email group <gcs-fuse-dev@google.com>
Content-Type: text/plain; charset="UTF-8"

Hello Team,

I have been experimenting with the FUSE
passthrough(https://docs.kernel.org/filesystems/fuse-passthrough.html)
feature. I have a question regarding its interaction with the kernel
page cache.

During my evaluation, I observed a performance degradation when using
passthrough. My understanding is that the I/O on the passthrough
backing file descriptor bypasses the kernel page cache and goes
directly to disk. This is significantly less performant for my use
case compared to cached I/O.

While looking into the kernel source, I found a couple of references
that seem to confirm that bypassing the page cache is intentional.

1. The FUSE driver appears to explicitly disallow the FOPEN_KEEP_CACHE
flag for passthrough:
https://github.com/torvalds/linux/blob/66701750d5565c574af42bef0b789ce0203e3071/fs/fuse/iomode.c#L162

2. The passthrough feature uses the fuse_file_uncached_io_open
function. This function returns an ETXTBSY error if any cached file
handles for the inode are already open:
https://github.com/torvalds/linux/blob/66701750d5565c574af42bef0b789ce0203e3071/fs/fuse/iomode.c#L97

Could you please share the reasoning behind this design choice?
Additionally, would it be feasible to implement support for using the
page cache with passthrough in the future?

Thank you for your time and any insights you can provide.

Best regards,
Ashmeen

