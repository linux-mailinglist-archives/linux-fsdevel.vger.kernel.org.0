Return-Path: <linux-fsdevel+bounces-38419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CF5A022CB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 11:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8E447A1D66
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 10:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956961DA112;
	Mon,  6 Jan 2025 10:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="AcdFyNZr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E38F1A2631
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736158839; cv=none; b=lFaQDscElJmE5j96PSWxvaTnhNpQ0y5iV3O8MPxXPODrzk40ZljAs/9s4wmMUzCADr1q4sdghnDmjF2RnKlBR2QABM72Uc+EBSsMG0ExDypPKwBxG5kgnCcguXOwE7MTfnqN+3iWQ1Iqodo4aPGVnOupqABCiJtYSLsOu6H4Dn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736158839; c=relaxed/simple;
	bh=o+kXTplRVUCUvhEajnIjUGWu05VGVRRba7eVIYEAOuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeI0SM6q9l5pOapK5DuIhEgohnSu+K8QeIaCoqIeU5WXp3q1iZ+fIrqrZ33FFX1fx9eFgzcfG3QWxzHKns4q0vzJN3UvQ0GvR0sZwbgg2/E3S/GoOymNwftSjoY31MHUDEjcu7nzKG4SbkhQKiKFCTlXNkGyXv97igebzMLzeAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=AcdFyNZr; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467bc28277eso119358751cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 02:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1736158836; x=1736763636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o+kXTplRVUCUvhEajnIjUGWu05VGVRRba7eVIYEAOuk=;
        b=AcdFyNZrtu8lXt9tTlauxGdJ8XJAtTK0no6W0wrUHN/bA837Qr5b5ktXaXHva280Zv
         0zfKItoXOxrJi0eirs2g6mVPTF7q+pbCJW5yb34xNOYInRv157PwPJU+Vm/Eqg9G4ulm
         IEvafQ0nB5L0jkSEWR8p0d2xTpYrE6O2SokwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736158836; x=1736763636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+kXTplRVUCUvhEajnIjUGWu05VGVRRba7eVIYEAOuk=;
        b=uR9bxyFBFgy0D6/f3a1gcPzZlwmFrhfs1t1AQ/vuChEoFNMQFC/cVEWxDomztkp6Yb
         s5C+F2h9T1BK2PKgTZIyyQgNSUrVT8HK2MeujLaPu9ToaqogHYA0pWORx+jqV27rBGFL
         4EjtAn5f4PpdVLiK/IaZn/yYeI0IJlsWIDcJhT/8wzKl7FQoxulDB5aid5PIJkNI2RXz
         YZjo803aR+OTnb8TMBWFJ++EuLemf3WDjH7bx9WXxYH/ppQdhtOI9QsLGBuIZ7ou4ilV
         rOw1CXvQmYJjqhqt/Ooc9A3gwwQVJL+vHf/u4DsWsstYiyxf3N/WHUGBRU0Izcz011pJ
         6NgQ==
X-Gm-Message-State: AOJu0Yy0S5LwzMt2GnIbMHW8lZddf4GL7FEmfF/OTebaMWeDmTCRcxJA
	AvAfnNDVmTmRLAV8QqNnm3r0mqTGd3qRpYn7bWZIv/naKvHbUw/3MDJbG9yj2HnY3vdotOVqgS1
	s8gY5Ps4k8oqfFbu0lpgjk6z1verkv7Gbgq+kZA==
X-Gm-Gg: ASbGnctTh2LmXuYSStiJI+Iv5wUR+0aRXUHpx4XVdCuzxvhUT9HWCqmkDQhL6KLoDsf
	wW/apcQrI5KxrHC96f0QsouqDXLxXtMCRdrbpmg==
X-Google-Smtp-Source: AGHT+IF6MA//IE4YFas5fvNV6OTvJR4cr6hnUT/3WgsZglvihj3FGgW2TBDi3YmdeDV7NoP2Spe4gNFL1W0UC5sRVN4=
X-Received: by 2002:a05:622a:30f:b0:467:88fb:4298 with SMTP id
 d75a77b69052e-46a4a9bce09mr907617311cf.52.1736158836335; Mon, 06 Jan 2025
 02:20:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegv2hgjB9xvxFY0+wN2P74kZSN9_w_mffdv=e6Vib1atJQ@mail.gmail.com>
 <677bacad.050a0220.3b3668.0007.GAE@google.com>
In-Reply-To: <677bacad.050a0220.3b3668.0007.GAE@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 6 Jan 2025 11:20:25 +0100
Message-ID: <CAJfpegsfsdEFgtU4CtXSu8zBEcLGPuDUurYVJ6c8zqpoVumDLw@mail.gmail.com>
Subject: Re: [syzbot] [fuse?] KASAN: out-of-bounds Read in proc_pid_stack
To: syzbot <syzbot+2886d86a850adcd36196@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz dup: kernel BUG in iov_iter_revert (2)

