Return-Path: <linux-fsdevel+bounces-59616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF648B3B3AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 08:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE4D7C8165
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 06:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E7425FA2C;
	Fri, 29 Aug 2025 06:53:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1604913AC1
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756450385; cv=none; b=JpCyZflx4B6ZGk+ZXAwOih59ASWXx86H2gA/OY1vTpLQIjz1vGw07h7edET8GPS8NhVFc8jH7YrJt4OUV4dSkoFezUrvKd+9gcvMYjnJTlTWiUo86fPlwomMfmU+BKxkK3hmyZJedkdo9HBTWdxNKZRS6b2MKWipM7WFXd0+aO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756450385; c=relaxed/simple;
	bh=515v1XVWw9Gx3Elg9gOugbk3ZtW2xlgnlHrw8troDfc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S522oVJFAyquXbDsX1VUYNEG2KIlzfY4sixfLZ24VmhG5MmezeElSrYLAiv0G+hnDyRJPGH8AwTZkle4zLf9xk2qVcsm3zp9qayKQZHWyTQtQ1htFwP4Rtlm12i7u+tt26kXU6YXa3nYKTcK0enmvZA/CMIkg7n47QHmmKaoe8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-886e347d2afso158759339f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756450383; x=1757055183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PbZ2TTyQvIjbFD78j5eXpHav+1/7SVT9tTZrs5+tgvw=;
        b=g5O8Mkxwhn2G3Dl5yvL2Na3sSqdPhKsER2WHIA17gOxpMgMihRIds+zO9NeuPVcxvR
         LGMoCLp4JQAeyom26/wNcvzZbimvQC9FdGg6x/4o2B82BA8PmMSG6nmiX6DFXA0Oags1
         nOrAxco2/Xs7dYCnswDJlA1y5Ema93LaIKxf95wnI7ewvkfEWgyJaOSVXZ7Wum7IjG9I
         hcde9R8K6UBDZv27GBB2X+wycHon+H3bW75v/Gm0HqztvZC2kboV3wSA/hUW5ZapJ/hJ
         BwIVg4a12Cd1hLYqn9vrBzNtX3tkx2RsE82gO86NKYsjBdY2c3pNKKVe+mMK1DYRxvyU
         Vudw==
X-Gm-Message-State: AOJu0YxqjqCPXNzEKYDNm6YFwWpq9l6rru0ZvFTEEx3PazYtRPQdMxJ/
	6K4YOd+CEZ6AGJmmWb82qoeLo90Z71855ql8RaY8S29YGwKGRSuukp3zg6elD+JJAtxcr5gAQcg
	yWduGdqpTYGpxEkwcRS0KzsKabgO5o8qyPqAom8MsECOqzvravOwdYph7c4Y=
X-Google-Smtp-Source: AGHT+IEiNboYxt65F2g9X9DArjfAWKS4IpTbIPiaMRP69qh4h0hmvviSQggi4E76fn4qQgxdzN8fH2M2ELiQCeOhOeJHIHiy0K8Q
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148f:b0:3f0:78c3:8fc5 with SMTP id
 e9e14a558f8ab-3f078c392cdmr120467105ab.5.1756450383255; Thu, 28 Aug 2025
 23:53:03 -0700 (PDT)
Date: Thu, 28 Aug 2025 23:53:03 -0700
In-Reply-To: <20250829063046.514229-1-yang.chenzhi@vivo.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b14e4f.a00a0220.1337b0.0013.GAE@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfsplus_bnode_put
From: syzbot <syzbot+005d2a9ecd9fbf525f6a@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yang.chenzhi@vivo.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+005d2a9ecd9fbf525f6a@syzkaller.appspotmail.com
Tested-by: syzbot+005d2a9ecd9fbf525f6a@syzkaller.appspotmail.com

Tested on:

commit:         07d9df80 Merge tag 'perf-tools-fixes-for-v6.17-2025-08..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b97ef0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
dashboard link: https://syzkaller.appspot.com/bug?extid=005d2a9ecd9fbf525f6a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13897ef0580000

Note: testing is done by a robot and is best-effort only.

