Return-Path: <linux-fsdevel+bounces-55713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8AEB0E318
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 19:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0D1564F2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 17:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DD46AA7;
	Tue, 22 Jul 2025 17:55:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F924279354
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206919; cv=none; b=TqgBIfB51lJtlNuNdaRJkG3wh4543MF9nfHetv7AKePU63Q/T94U6svfTgrmoIDNkgJ3H5h7AO06WRisvoPM1DJTRDjl+/MAWFu3g7pRvlHJPyvtaRgUUDUMgqUD0SCWNQowcquyW5W82hPGY4UtRuLCqVY9bN/NqDm0kFGNB1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206919; c=relaxed/simple;
	bh=+JUCvse9/Q0h83pSfOVoqRwPa3cwg92XlBECM4wBwMg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=i5WoiObaWzuk1ifkoAi+grwjlbxKgIV3UblTBIxEeu7yxyWqa3aCaOcSTcH4h2LshaI+WEmzHnMK8Hfb87kW3MfLhpeDSww85lipWLSrD2T+N2akGD7S7Uk0OFbIByL4sh8Qy3T3wx+RPJ5flWzqklhK/VzzUfT2bxVoH6Qa20I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c3902f73fso17944139f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 10:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753206917; x=1753811717;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+JUCvse9/Q0h83pSfOVoqRwPa3cwg92XlBECM4wBwMg=;
        b=FsFjDKLgGeU6J0iUDM5QXjClvuwNo4vxfnfZ5QsTS3a+IlcWYNh0gECUKRSukGtKUv
         YSeVcTVNtuInWjTma7M/LPMRQscHgi5kGLHJtDeYmSZeL9YUuERXV1kajOIJdxngu/VU
         5T7C8Xhk2/YKS6lMmGKVsrOzNL3jZwiS+802IpxUsGJIEucGhafW3ysZvlDmQfQ/3BG4
         nccthey89RbQXL+ZY7dN3fGkTRs2CSk200hlwyk7anUPzah9NCjM6xeDm0ZLpSti3gB4
         +jeZR7hIcbse3H9XEQzBFmIPEVrB8fpEKjJWwDgVfuxAIK4C2cVvS4U0j8mTOE/V0FdA
         tKdg==
X-Forwarded-Encrypted: i=1; AJvYcCXP2PCWV+0+y1IOGSzJIV6jBfDdsOPDVbdI7jsjFLRHyR5NXJE+4297QDRiGUcduf/1XrJdDn2h9WgqFiq9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Py4Gc88qZk05oXKD/TCIQp9/hZeqMBMRwsZNQgnKhrO3gHwD
	JKxLrPKL9mzSkl9lfkAPqPrJEjMtzPxmo/TqfYTvxfM6f99JBVnJjMTNDpbYbUFl0ah8pmXY6xX
	1st3nI9FPOt8iP/9axYCS3l1+jOBNkoRDqAxUUIlUwi9jMQcYFhFSK5xIc4Q=
X-Google-Smtp-Source: AGHT+IEnZCeH751BFdoEhmWWVC/2QU/u1JIWsR5UBGORLRUIn04iBieQDH4T7gcYQHSc9SnRnLic3XPmpo3B+yrD3wmrwVToKop5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4746:b0:876:b17c:dec3 with SMTP id
 ca18e2360f4ac-87c5389b0e8mr829314939f.8.1753206917538; Tue, 22 Jul 2025
 10:55:17 -0700 (PDT)
Date: Tue, 22 Jul 2025 10:55:17 -0700
In-Reply-To: <xq4a62ukblverdhefpn3e43dkhaxvk2brdytqonrbzy3mud76m@srllmpvcv4e5>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687fd085.a70a0220.693ce.0107.GAE@google.com>
Subject: Re: [syzbot] [block?] [bcachefs?] kernel panic: KASAN: panic_on_warn
 set ...
From: syzbot <syzbot+4eb503ec2b8156835f24@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev
Cc: brauner@kernel.org, jack@suse.cz, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

> On Sat, Apr 19, 2025 at 08:23:50AM -0400, Kent Overstreet wrote:
>> I'm not sure which subsystem this is, but it's definitely not bcachefs -
>> we don't use buffer heads.
>
> I think there's some incorrect deduplication going on with this bug,
> some of the reports do not look closely related, I believe they're all
> buffer heads related.
>
> #syz set-subsystems: block fs

unknown command "set-subsystems:"


