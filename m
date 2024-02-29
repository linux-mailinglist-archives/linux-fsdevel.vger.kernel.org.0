Return-Path: <linux-fsdevel+bounces-13157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A3686BFF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 05:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36EF1F2596B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 04:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A08C39840;
	Thu, 29 Feb 2024 04:46:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEF437700
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 04:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709181965; cv=none; b=N2QctIzjBbMsqcc+hdXdA7I1B32DaPEvbpPKmXRIwdVpwJE61GNr5Gw/C8VhVXcgkK7GVRKG4Gw5yl9AOmD+RGexfzfVi5QAvCGSeQzhBhl0+BusUBkwuhmpi0EEZ4ovMirNv/wRbWm1LqnJL3hHqWc5EFRVmzJ5iauIvQZn18g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709181965; c=relaxed/simple;
	bh=uyjOIENxq69Mlcc4mc+sqUi2mtkubLj29ms1NoSVQk8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qGd7N+LCeUFr7XWeU91RIS8/XG7xRMzARGVeNJ/nqqBenFLl2EdJu9yUe7vpgd05LiWdQittuR94xl4i7BTOJ4r1IX6Yobt+cV4NkOVtdlL+KYxw2WE/QrumtFxCo0MVBhXDI7fUjgNvayR5Ztm5u3nvBVa23GT7aJe1RkZp2hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3651fd50053so6857185ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 20:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709181963; x=1709786763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FEjUJh9OkG09y0YRlfLvgKOC1GUAUaQDR1N3zpLExVA=;
        b=EgA3DveDmFZI6LEI1/8MT1bCTsi0IVotK3Iu6R5GLCWjzJX4f8Pw9/LZXbuJ6dzv5u
         V6ektkisUR9lP/0vMn48GEvCjWas3IInlSX9wJqP4l7yGQv5bruxb4psc65Tqg5NXEwa
         9xMTSXe2p6UJ4NtQxgf4CFruDh+EeF2e9WF+/Uu6q5ONiYh6VwWLUvLp+u3a0JIXCnyk
         tG5rffa43rUuva/C+7H55XbtyJ/v8JXzAw+dzXk4m+aBpRgmCdXJIfryNNnkqzlVtbpT
         A1cuo2qWaA34QYfM6OEgUhJd2+SgesZvJLJU5GAdwwrJdQM9ud27Rvu4dE7mCVhugQex
         91VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPp6dKVB/wfVctYGPHyrKLZTuIJVjfQd/5Yfz6/7Wc+QvBX05ZN+LNcCvn9Mjw37jVoRsds9eLy7gm6QW6d69nePDOFlsVLHi0PnIttg==
X-Gm-Message-State: AOJu0Yz2TbKkPY9E99TUVBX2e2QJxOfa3d3QJe7kNXXEgR9AcGWt/AXU
	QwP7pD8tbG1EHhlz+RhjOmz/ACepW0O14ijOarCNt4MLJI4gFSkuaWC75CGUR5nzB82Owy7P9nj
	wwwYYuL1B5BX6ds6NJNDL/y3NPos2qJoZuL3/eswO9K/GZs++mqBJp7Y=
X-Google-Smtp-Source: AGHT+IEdCtFwvSTo9IsVW4KKbhjExbFAmwCruc2QMMuLHxCBRQbrllGS6/9TC1/gdsUCxxkl5OaeSLKpXGOdphGqQzZ98gXSHGHl
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cad:b0:365:1f8b:d103 with SMTP id
 x13-20020a056e021cad00b003651f8bd103mr66821ill.6.1709181963802; Wed, 28 Feb
 2024 20:46:03 -0800 (PST)
Date: Wed, 28 Feb 2024 20:46:03 -0800
In-Reply-To: <00000000000029b00c05ef9c1802@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf2d2d06127def32@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING in gfs2_check_blk_type
From: syzbot <syzbot+092b28923eb79e0f3c41@syzkaller.appspotmail.com>
To: agruenba@redhat.com, axboe@kernel.dk, brauner@kernel.org, 
	cluster-devel@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=108aa9ba180000
start commit:   861deac3b092 Linux 6.7-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=10c7857ed774dc3e
dashboard link: https://syzkaller.appspot.com/bug?extid=092b28923eb79e0f3c41
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1440171ae80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b1205ee80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

