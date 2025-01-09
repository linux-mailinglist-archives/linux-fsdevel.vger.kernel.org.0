Return-Path: <linux-fsdevel+bounces-38736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863CEA076E6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 14:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A8E1885507
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 13:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC747218EA6;
	Thu,  9 Jan 2025 13:13:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01A12185B1
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2025 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736428439; cv=none; b=h9giE1cwWXHehLrb4aQcZdWdcMAKcnOmBWBhh8OCbtE6d1du9gk467IYSGgN2JcRtgROynmlCcPOiHhRyFtRKNpgFwUovQF0i+FFDPJB8klnAd51g19GgaxNvskMcDVQasVT4A2nm4E+nntft0ft8PCvHy6G+ZjfDJRx1PpNQSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736428439; c=relaxed/simple;
	bh=z0+5c2RmuHTV+YPKMhF+ZXxB+Hexc2PeT0DRWwpdgAw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=bOvXnwMG0wIrhyyAswRPWNLTOpwrpzq3kUeUmYjbIQfIuVHv58yTlU0mEQuDLvXXOwPHiRFr8lXGsaXOVfWOSxv77vPSZW10lRjWg7MVJr+F6+Nw6YAopUT6pQoN3U6xRb9Uj101elaeTXLkKEMUsSPndzYCK66ZBZWxZBf8mAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3cdd61a97easo6869195ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2025 05:13:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736428437; x=1737033237;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0+5c2RmuHTV+YPKMhF+ZXxB+Hexc2PeT0DRWwpdgAw=;
        b=RecDgI2OYtOY+IFYtBKj3cmhpw3oeDdDnapaJoPcKIC51V/hp1c1zi99JWTAJ281Rd
         vfmHN77QnpTPc0AMY2toRhQRdW4yB7ZahUnHE5qrRIh6zqG0xYpmnE4SJCFReUd4PXFV
         SOkGMul0+IUvbuBUIFoHM72lA8VgbMFnUqcdsb7UISvIgZAfE7fd3YwstBsY1QqboQ3Q
         /YkXdHHh78uV3lAUuVAOjWcUmfPvr4KQ0advrW+hmhY8L3KXlagyW4nkdbtrKkdSJmlx
         Z1529TIUzHjLibLh/w0OX1yZez5oF7peQpKaO8xqK6/TtupGFjyFPU/BX15gnQ5iLVOD
         z+rw==
X-Forwarded-Encrypted: i=1; AJvYcCXMbW6dsYBR3qgUgG6spnA3deE+8ZmjIj/9jIbtFU+9xGpBm2r8qaICzerPhuqru30IlZCqMF59KUaAiKaf@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqudjo2zMhKDoE5uahfsk+U+84KGtaWaNOzMRBYxLRi3nEiW6d
	zFidXOmP+nPUrd2+23LtsD7ebZHVsMSbgXjAOfkN6+hIkUlj3yjq3PVmCTSlHBRS6jy3IBWf5B9
	VoluJt+Eo/HHmtSS5zPwyejPiI2J0ZxD7Ud7Yg2Ti+nu+wXeBjmFRuOg=
X-Google-Smtp-Source: AGHT+IHZEftS9yCEjOgAbOXZXKl4rH91/TEZKGoA12KPWHxP8RRDFPr6+pnVlgq1brJNb7suWyvYGt7rgCc4d4xxUBTT68/KO99K
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f09:b0:3ce:473d:9cb6 with SMTP id
 e9e14a558f8ab-3ce473d9f96mr24368585ab.4.1736428436988; Thu, 09 Jan 2025
 05:13:56 -0800 (PST)
Date: Thu, 09 Jan 2025 05:13:56 -0800
In-Reply-To: <CAJfpegsJt0+oE1OJxEb9kPXA+rouTb4nU6QTA49=SmaZp+dksQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677fcb94.050a0220.25a300.01c0.GAE@google.com>
Subject: Re: [syzbot] [overlayfs?] BUG: unable to handle kernel NULL pointer
 dereference in __lookup_slow (3)
From: syzbot <syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com>
To: miklos@szeredi.hu
Cc: aivazian.tigran@gmail.com, amir73il@gmail.com, andrew.kanner@gmail.com, 
	kovalev@altlinux.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz dup: BUG: unable to handle kernel NULL pointer dereference in

can't find the dup bug

> lookup_one_unlocked

