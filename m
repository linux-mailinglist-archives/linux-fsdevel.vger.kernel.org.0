Return-Path: <linux-fsdevel+bounces-17224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AA58A9215
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 06:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6CA11C20D8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 04:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E00954FAB;
	Thu, 18 Apr 2024 04:27:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17DB4F8B1
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 04:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713414471; cv=none; b=iGfCqAdHtGKR7P9FIdHOKqLLvkQnRzV6UFMKNSVNed1hEkQ/XH0ZGDpds6Ko3km+YlTPAJcm03+fspvPeutpJth3VtbzTBasCkIm7TElE0vomrHYiF67jxjtngacT9g+/VJZvehxVwlMBVtl7BRD5mWWuIZul+0L/tS6013zDBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713414471; c=relaxed/simple;
	bh=SfG1s1y1fbs4IRvRpyJEItMWdHRLy7BTd3xvVF3hb1Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=NBAmUq6y/cxOf+G3WdpnRK3AItVJ8H91qzivkNMi3Fg8ySnXc1iGui/X0jiTPOyHD4/pti4EuSnyP9yqxZ9/PSNS+3KWOPAusa78qi0O+OPd6O9+4JiDxPL9FRQUs5f+yHA3QVFrBuZG2D+qhihrfngigYebpIKy/oNpGnXm4VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c9aa481ce4so71246039f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 21:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713414469; x=1714019269;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfG1s1y1fbs4IRvRpyJEItMWdHRLy7BTd3xvVF3hb1Q=;
        b=D4J5UeyDQ32hbdkshgf8+Hh4Tvyt/qSI82gFovCPNvyrfIPYINxjWcAA6Gmi3Im5nJ
         O5Z/Rej+5WY68zacP6q5Svm1QSqqisavY2jqumFfwvLodhXhB8PUtPPmzpZNG5JMw1vn
         vjPyG3x4er5o2sM/ala1DsQzL5SzOCCnFf5KEhRoM05YUcSZzBnk1BvOQAv4sM2CJ2SY
         HXUMkGGK0vq3/EXqGq2oAHr4slf1oVdtzl/mhshCuNXHEe0OYqHohAQBZou95HvHTFG3
         J73VfHboIDv3TVUDzoI6KdfSQOkHzumQcVny9p+T4GOEZHEdWCoI+Yyd73bKlbjREcxW
         TePQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiSTlbY+gjaRXlNK9AFI2/Bfjct4eq3SdZ+kUPgKbgbsTc+fa3V/BDNjb6cKG5eQx1OrEQYBoGJFY+oKJQSvzVlbd9FVrm6wXFcT9CMA==
X-Gm-Message-State: AOJu0YyZVr44Bc5465bUJzbDeJ8lTvyPQY8EwBNzKuuYaCkDRGOGzJ/1
	3ftAssraB7HBepprNWtMJhZOoKPZ5znMa+m5mBwT03rvUicqtbmQzZWDvahZcRQPAqJH4heb2PP
	Q2sS77OzfzfkOB9Wcfhi5K6KBzT9wcvPRMfQSet/9AjuhBmwv+R5HvLU=
X-Google-Smtp-Source: AGHT+IFwL8qeN80Hv4nk9W+bxA3Mu/wX0/j/+lzG4a9AN7cCSGgQotKYvsLnIC5qQraEK1JJIlW4Sb3AG3WAp6IiyW2Ip0HUyaAR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8523:b0:482:e922:2823 with SMTP id
 is35-20020a056638852300b00482e9222823mr99129jab.0.1713414468938; Wed, 17 Apr
 2024 21:27:48 -0700 (PDT)
Date: Wed, 17 Apr 2024 21:27:48 -0700
In-Reply-To: <20240418042740.313103-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c63725061657646d@google.com>
Subject: Re: [syzbot] [fs?] [mm?] KCSAN: data-race in __filemap_remove_folio /
 folio_mapping (2)
From: syzbot <syzbot+606f94dfeaaa45124c90@syzkaller.appspotmail.com>
To: aha310510@gmail.com
Cc: aha310510@gmail.com, djwong@kernel.org, hch@infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> please test data-race in __filemap_remove_folio / folio_mapping
>
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

This crash does not have a reproducer. I cannot test it.


