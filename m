Return-Path: <linux-fsdevel+bounces-54740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C41B02901
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 04:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00471C82E82
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 02:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5B91EDA02;
	Sat, 12 Jul 2025 02:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bD3T+j/v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80AA1E5711
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Jul 2025 02:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752288010; cv=none; b=E+61WImGvdg3LCfAIkTztz1KmU6XaOcMde+deIvM4G/lRFBiX+9hTlKJF9A4Ne5yy7PEOBR48kBG8aK37z4sSVj6Ob5XdL6SLoOFOF1D9gx13o8QFdhDjqOHmvwocBcVkfqyu1xOgkKduKqoEg7QatmWAstqY39Mko8nlweuDnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752288010; c=relaxed/simple;
	bh=zpLNea46eqilpaXHIo3ln75NHPKf5uwXU7dO1N3gFWY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RBib4Iywrtct3elTp4yh0awMJw7dhziz/F4uNxO3JuJHs4RL4D5YYlyaodB2MjoeYEqAm1cD3YUBBD9iSMkMWj7hghHeeUOmLPjt/yAaywRxspvb/EbOf82gLvDa+hTRgp/v2KCMD0ApYZj8yD24itPl6FWs0xhQNizmmFLBWIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bD3T+j/v; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3df303e45d3so8753885ab.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 19:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752288006; x=1752892806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4WImu2NtZSrJkqdjdhLHzSmNsrp14bAane9ntQopr8=;
        b=bD3T+j/v2y6zVjf5basTwu9vTyfO8gGAS1p6rFgBHVW+yw6535bl2frtNTYj+SmLNH
         O7oDpBHe+4uZ1d3NEZ3ik1z/EXPAgmzkibO1qZ2IazJuqk8N5W4Gpq0ddIYZ7iGBljMG
         S45Oh0/lNg+M60VjAMVuo1SccwcepSXm6aMzvK3Tf1QS/n1gm7A+VX6z0YFlC/JFSS02
         px2vnDrtHx2t2NZATHzRnzgRAPmioxQ7K3u3zQjI8S5cZCZquYAJf1a+ADxwyxSWeeQU
         fj3mRLAvKtWlaKFg01/UAJg+3Pc4UpRsRsB2I3Y39Hfnt1wUDSzgx+lyV/5bEyDYviGJ
         HTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752288006; x=1752892806;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4WImu2NtZSrJkqdjdhLHzSmNsrp14bAane9ntQopr8=;
        b=HVhNAqwcu+EBIMjegVizaAsuUKI+14Q0LiBe3a/+I8gNkylZdTnZCaYwLCj6fe+tH4
         ukgr/fLcZj2vTwlcTdm3hf/8xVyF2hkGU2t9yBrtZhVzBwj0JVu6++w1Wn15lr7EOmUM
         9CsPgxjuN65foZjYVUX/d8AF0F+VmUmtszuGm4gE8w8DI5k5sqFW7YQjlv/8DN7gp5yk
         f4iZPnr784H60KUWguCk3S4jNm5uiMlxsWjoIOAJSmWOOHtcK+35qwZzT40oXQEgw7m4
         aIndlJ0gae+yJyzP82543quWrMY9pOVJnTpDV77YaLg6mE7S1IK0slvPMuafUtssg1fD
         wCLg==
X-Gm-Message-State: AOJu0YzscgqJzNF6g8/zuqnof8ok5mY8HdzNutPYb7eGp5S4hCK4PXTK
	cT/79PruugnqQCRfbbVprFLGB175UNa9FtZ9PHzqVQBwX2L1EpLtGKlpOo2FvCpNMriNCQaN8wf
	KkdNI
X-Gm-Gg: ASbGncu0s4I4ZNmk8CtSfvDUejIn39KPib9YeniRtyV+vTmOHmt3B7ljnvn3HEH4yej
	ae3zyASF0Ty1CdmH3UloxG4xmNE+q4foMXv2hil0BhWMCKQRW2HqqIYob3HOBxEoLPQpBWwI4dd
	OZaiwh2qBulXfTTCqq8H6bPqelYfk/GT8mRS+eU7DXYptCGPIflx9cwxlCd4rPn3BgKViohUvEx
	/MHufrtCKxhygDSJ5K91Au6RhRzpxTPAhU13CXoEFgpi+3x+m6As7Q4/m+Sgv6rAl5lG03js/a9
	4hkJSVqWwRHL1Pd9c1koxe5GrYY6IXcSfEmr4VLs9FqOTmheWCKSGZeV94f5diMmE13fQsXUeMP
	rrKM6lPEqNYIVfQ==
X-Google-Smtp-Source: AGHT+IEpxYkdBcisV7HP3p3UR14Bkj/gzDXrJtNLWIvqBII+yXOz6A2rCxpTknGn2X7a/ulxOaJs8g==
X-Received: by 2002:a05:6602:1354:b0:876:d18f:fb06 with SMTP id ca18e2360f4ac-87977ea916amr685927139f.0.1752288006313;
        Fri, 11 Jul 2025 19:40:06 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8796bc34395sm126333739f.32.2025.07.11.19.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 19:40:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
 syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com
In-Reply-To: <20250711163202.19623-2-jack@suse.cz>
References: <20250711163202.19623-2-jack@suse.cz>
Subject: Re: [PATCH] loop: Avoid updating block size under exclusive owner
Message-Id: <175228800423.1597338.7519956192674264145.b4-ty@kernel.dk>
Date: Fri, 11 Jul 2025 20:40:04 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 11 Jul 2025 18:32:03 +0200, Jan Kara wrote:
> Syzbot came up with a reproducer where a loop device block size is
> changed underneath a mounted filesystem. This causes a mismatch between
> the block device block size and the block size stored in the superblock
> causing confusion in various places such as fs/buffer.c. The particular
> issue triggered by syzbot was a warning in __getblk_slow() due to
> requested buffer size not matching block device block size.
> 
> [...]

Applied, thanks!

[1/1] loop: Avoid updating block size under exclusive owner
      commit: 7e49538288e523427beedd26993d446afef1a6fb

Best regards,
-- 
Jens Axboe




