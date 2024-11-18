Return-Path: <linux-fsdevel+bounces-35068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03AB9D0AA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 09:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFFECB219DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 08:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1F917B427;
	Mon, 18 Nov 2024 08:17:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC39B16F0FE
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917861; cv=none; b=neWB3z5cJ1oIImIcDW6+lJJPTYRIk4fl3m8k6xwA3QxgpE/WLaY35ijvJenOAapxr6eByW61ZqvUEvt8le5INyiYpb0ZT6MH/kb6xaXgpgxFmlyrwht8/gbjer/uZ4VzXTPEO4F5UcPxYqvX34CBYDoPpRisHYkBUm9VtfHcFX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917861; c=relaxed/simple;
	bh=u5RhTCXMLynqVSsvTrRysZOcrUWOJ3K+sfE2xOyauDQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ogQaLL9ksWvH4VJpsloF2ff4di90MoS20U7P8qdf7RVN2udfe25AQS6dRr81La00SJqsh41SOiwqH3iF/ug85WskTj9lijZ0/ud9piUcVPxLGDgBi2LLjD1XzwSFbhqzCCChFhpUI7uQ9YZyW9DSMuJ+/ZoN/kwhDztOJcEvGwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a75dd4b1f3so12651495ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 00:17:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731917859; x=1732522659;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5RhTCXMLynqVSsvTrRysZOcrUWOJ3K+sfE2xOyauDQ=;
        b=aER7FtQCEBzbUX8jvXDLELZ+VhF8dAZJmF6KJYzzfBr3YXdD3hdr0+66pS9AmdSIr2
         oyMzd3lWmmRB/CBOE+Bn42pBDUaRBQ6It4v7YkMD/9VeKvU8ID9s6vEwQuuBZ5/arzOD
         +Cxog3viho9ZNsNzkXeRUAxfPN6r9rms+LvjxzipkrE1OZcu1LgovWrQi9Ep9/YlgIlZ
         Bi9ZuxsEXyQWlEAU1feT8oipTXTxfKEG5UZbrqMoKvZUKxea58PUvm61qebL8gu4C43l
         C/7L8qBPkNlAeYekbiBPPhkkAha4PCigrPa1lbwweszZBrmjgehngiiMGpsgSAFZMUb2
         4llg==
X-Forwarded-Encrypted: i=1; AJvYcCVEtHtnG+UU4K5FODaydsqxFzhQbUH9p/juKWwoejRk5UL/1j4n2i5Vc7lTVYAQIm9YBiwUUfoMTUxBQDHQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwVG8fs6Hok3saEP0BMcSTs6m1ZXMijuGvFzXUKlYCjGF8Cg/XZ
	p4i67QdBmUf/0wlYvR0d78Dq88DJ/LVtOVhnOoFfhJhxYR8kMWGGALNY6qjE2Uhkl2J8gWEve9m
	TqtMfiV6SDl7eMuTds0VqItIfFuSD+UOs3Yoo0E4pFEETZMApxxA8aao=
X-Google-Smtp-Source: AGHT+IE4690Te8WI2VGqmxrZL+FjUqEVNMfKaVQ4G2ZI6d68A89Ihkkp8OCFYbu4EiSjKAyFHZBbsnlGbGt65ndisksXJl15aII3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4a:b0:3a7:6c6a:e2a2 with SMTP id
 e9e14a558f8ab-3a76c6ae540mr12489965ab.9.1731917859223; Mon, 18 Nov 2024
 00:17:39 -0800 (PST)
Date: Mon, 18 Nov 2024 00:17:39 -0800
In-Reply-To: <CAKYAXd-T3gnugL4MyvArK5dONRJsyN3X6skbZWFR43V=h5bOzQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673af823.050a0220.87769.0026.GAE@google.com>
Subject: Re: [syzbot] [exfat?] KMSAN: uninit-value in exfat_iterate
From: syzbot <syzbot+84345a1b4057358168d9@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

> #syz test: git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git dev

This crash does not have a reproducer. I cannot test it.


