Return-Path: <linux-fsdevel+bounces-11556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (unknown [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EE8854AD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 14:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E8C28CCBE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 13:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131E354BF3;
	Wed, 14 Feb 2024 13:56:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D801A58B
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707918967; cv=none; b=nBOhF8xdZAmVafcJTob+2rJ3UK25S5NukKIEUHsmMTymNbS/RViN/i97Bui3b4LTDvXriVicXth/6aK9wnRvOo6HRzDMMwBv9LXLyM/+M9fB4iVelcDjJG1zhA66igLo2vBeJj8O03MDeb5qCgeVB+0xWRLNdIm0hwSblaN2354=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707918967; c=relaxed/simple;
	bh=ESItTY8rGLypdYjH2TX6e6yq8+jXEkAipVzyTXkpfzI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SVZl1R5zPTz9xXNElkcnl2DRwK1N0TIBsxoWfe2Qiq9myEbPzYxa99Hhc86he1mS55CoMg/aqeqTUZZActyCTt2urd7E6qzMU0YBPzZ4eOSshlTsRjJcc0E/oIAfbLHuRdnI9jatCttYs+r6XnFTB8bLdEBnHujWqITBbxSvltk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36424431577so11334495ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 05:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707918965; x=1708523765;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2NkSnFdfTg3k6qXaH8jjKH3xj9mYZScwsPomNA2RDyw=;
        b=OZFuSg/5Sr6VvDpii+hlFlsichMvGEJ4G3yxB3l9EdyHRs1p2Ac/HxMq0cugSIbkNx
         CJZEQHWZR4UmDKVciA/6G6Uiy+CHBticX3nSu+bOgvblkR/NC1rPf7WritqyGvLsKZdW
         SmxMdSPsA4CaRGZD8Z2wigfLtwVpGeoA7xBlDFP8V1ZJxMkq882f0LapGoonE3XJDp5f
         l5zs1G6HIM8biHrwMqAkLhpJW2UpAR08zRpvRe/ZoXPEkgbZvC02HsMH1RoEOCYqSwrI
         d0mRIj5NyYkTwuV7Xkaw1mbUnpIRSLPBzpTPyDZ0QHwG8EAX9k4liF3pDVrl6iNNggho
         sUJA==
X-Forwarded-Encrypted: i=1; AJvYcCXxki0sxeCUKElVcRlbvAh3K/YTjeoNjCRKl5TpRvq377xS9mqrXRl1z7HBci/0yttxlQtlEr/aDj9r2uO2mpYeaZ/FWm95ux7HAo5Fcw==
X-Gm-Message-State: AOJu0Yy0NlG0eVYvEeNpsl2gCQSG2pZoFP+vfaRt8K5zIrUJz4TTkEc/
	PPWgUWpZrJjB59lAU2C9edg4rFqQ3gZnICZLXs/O9+aIuZItVZJiVCTD1o0NGyUJI5aMSFa3af1
	ckKOfOLFRij+oRJ7ftSNiK4ddsuUvs6fQvPNYZI3ugDf3K95b15OJlBQ=
X-Google-Smtp-Source: AGHT+IFxcJylbxa8Bs2h3EmJ/upKGDFEcx83aXQKgk+rd32iYX84gtPFYvaBRqbWFdZrx7nxf3Y5KKK69B457j+KQHQSFen8gdpq
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ba8:b0:363:c002:719f with SMTP id
 n8-20020a056e021ba800b00363c002719fmr221351ili.6.1707918965336; Wed, 14 Feb
 2024 05:56:05 -0800 (PST)
Date: Wed, 14 Feb 2024 05:56:05 -0800
In-Reply-To: <000000000000e190b405f79d218b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003bf562061157df75@google.com>
Subject: Re: [syzbot] [udf?] KASAN: slab-out-of-bounds Write in udf_adinicb_writepage
From: syzbot <syzbot+a3db10baf0c0ee459854@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15458262180000
start commit:   e8d018dd0257 Linux 6.3-rc3
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d40f6d44826f6cf7
dashboard link: https://syzkaller.appspot.com/bug?extid=a3db10baf0c0ee459854
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159fa1d6c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bbce16c80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

