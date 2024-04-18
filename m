Return-Path: <linux-fsdevel+bounces-17264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788658AA54B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 00:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8829B218E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 22:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F0B199E97;
	Thu, 18 Apr 2024 22:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b="su/pnOa8";
	dkim=permerror (0-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b="oBT87Zni"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7227F180A67
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713478265; cv=pass; b=e/cAx1IXax9Swfq33IrlnumRQvz8NDIM869VXxVOOKdCF54lpq2uh2a96GCnZihGHzk163biObTPK8bF6ZQ0u3cuqL2CEdeYPapZt1f5ZIr857s57vaDemyjUL03Z/UhZJS5LXTjQVu+nKvPiu3ndOD3c6jKgIpUvPD5ISaCBLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713478265; c=relaxed/simple;
	bh=3pPQLD2CQTI5q45ZWM+Awv7vkOSfh79uWp6Dn98zn48=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=m8zmEr1dhg7pXhYfzw/hiRaGBOHmRbDW1knXS7KqTLVXrbHzc914Hv3OV4JgL5uQ5qP3S2s7Wp5NRW3MGlIq6gCV67u5HzmuYnZOrwN4ulr/fk6HeUet6e7ruhwunK8i5NKAzL8ofG9X6mcIllwKk078i4CSKOEu2KFnYuqwmxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infinite-source.de; spf=none smtp.mailfrom=infinite-source.de; dkim=pass (2048-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b=su/pnOa8; dkim=permerror (0-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b=oBT87Zni; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infinite-source.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infinite-source.de
ARC-Seal: i=1; a=rsa-sha256; t=1713478252; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ky5Ob+AWjm6pe1Ln5XhTcxvOFNigjRqQ9wl08jMaA1KrXOp4u8pfBGVFWOIz6U5LvJ
    y/dlWIZtaI7faJS5rhD/FOgCztr4NgNTyLznbWCD8ewBLPT9LOt7dCg/U74sMWStFOV4
    rYvzCje8ET6SSH/ZT2i2fHGK7Jjm6sT8IAJgrbs9PIb/h3L7shRHHRFCd/beFgmvjFIi
    MnkCVNtY1acf1eSh83xcx6dbusPxdGVSoB+VUbsyGQ/WFEK28LPJeKbKyV8kuxoAy+Up
    iK8D+01x5w0MuiEaSxBflXIwZyJDkVaNrH9nFsg6N21UGHP0iB6hvKEPJGF1mtz7GlKE
    pCnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1713478252;
    s=strato-dkim-0002; d=strato.com;
    h=To:Subject:From:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=3pPQLD2CQTI5q45ZWM+Awv7vkOSfh79uWp6Dn98zn48=;
    b=JO5+JMG4GBezCyfwApGS5EqCNQLWwW8xmX4yE/G4Zg/9Yoz35yDsnWiicYXleSOQMF
    K6u5jPh9Xqta4u5oyHmLkZxJJ4dv8kYkiqvpAOSHaMFxhpZmagZG1lyAaVgK7mYELe0u
    mlHU0jpemoNlMtr4zqeAwEOqZpk1r6f7lf7z6nrZHueplywaPhDjmz+tNihy4839DTNp
    7df2wDkt4U+HO7VStZGbQ2HWOWnxg2LnoPYtl0EWoNsyYPT5Mj9zCH5v0fZHyTXJFA4D
    t+mVS4kBIL+/r/eT0C/TYfctdnq0IC5/bHMOMd10peKkNl2pFEqRPDUJIl+8lBsWpS5p
    qOtg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1713478252;
    s=strato-dkim-0002; d=infinite-source.de;
    h=To:Subject:From:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=3pPQLD2CQTI5q45ZWM+Awv7vkOSfh79uWp6Dn98zn48=;
    b=su/pnOa8BGFqhkCLOcHOMnhvPouuCPRwfumIup1lVJsgfmILgR/DTm7fcEprj5INng
    qQtsxCQkn+/UM4zKbgIECRCti7EZuuaV/AHC9+moRHEnYbDu1p8ca6Q+he4sv1Bm1Ppm
    gddWuwFnZgsm9m5M36LHceUrHroHw1zytSQPrQ6uN4lqd+jgaRWYr8hIaVqsXPIVAh2R
    /jR+gnlb9py1mi0ZpsJ9noNISm+XZCkl2Tj871mDH1EmmX4vbOnckesiDqtUuPAWmg4H
    zBrlGsEdPWTTcVOtxbt7DNvpp2wETtvDb9nP0cvEumzc9rpD3NFt5yVQt5BR2H3d/cmi
    +xgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1713478252;
    s=strato-dkim-0003; d=infinite-source.de;
    h=To:Subject:From:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=3pPQLD2CQTI5q45ZWM+Awv7vkOSfh79uWp6Dn98zn48=;
    b=oBT87ZniTbIo8s67CsupW5A85CiT46O62ngbijC0/sJLDQrDsN9h5ErsqqB2LIlJ61
    QeEUd8znqPXqf/56nhBA==
X-RZG-AUTH: ":LW0Wek7mfO1Vkr5kPgWDvaJNkQpNEn8ylntakOISso1hE0McXX1lsX682SOpskKNgu1vdp7pXN2ayNAkRTwxScsWrIZdASFzw88cHHzK96qC1CAjaqVr"
Received: from [IPV6:2003:de:f70d:1100:ea43:633:7393:a801]
    by smtp.strato.de (RZmta 50.3.2 AUTH)
    with ESMTPSA id 26f4d103IMApvAn
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate)
    for <linux-fsdevel@vger.kernel.org>;
    Fri, 19 Apr 2024 00:10:51 +0200 (CEST)
Message-ID: <1b946a20-5e8a-497e-96ef-f7b1e037edcb@infinite-source.de>
Date: Fri, 19 Apr 2024 00:10:46 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: The 8472 <kernel@infinite-source.de>
Subject: EBADF returned from close() by FUSE
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello, first time mailing the kernel mailing lists here, I hope got the right one.

I'm investigating a bug report against the Rust standard library about error handling
when closing file descriptors[0].
Testing shows that a FUSE flush request can be answered with a EBADF error
and this is surfaced to the close() call.

I am asking if it is intended behavior that filesystems can pass arbitrary error codes.

Specifically a EBADF returned from close() and other syscalls that only use that code
to indicate that it's not an open FD number is concerning since attempting to use
an incorrect FD number would normally indicate a double-drop or some other part
of the program trampling over file descriptors it is not supposed to touch.

But if FUSE or other filesystems can pass arbitrary error codes into syscall results
then it becomes impossible to distinguish fatally broken invariants (file descriptor ownership
within a program) from merely questionable fileystem behavior.
Since file descriptors are densely allocated (no equivalent to ASLR or guard pages)
there are very little guard rails against accidental ownership violations.


- The 8472

[0] https://github.com/rust-lang/rust/issues/124105


