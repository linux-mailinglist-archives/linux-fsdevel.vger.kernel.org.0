Return-Path: <linux-fsdevel+bounces-14801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F28E87F744
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 07:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD151F225DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 06:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803997C081;
	Tue, 19 Mar 2024 06:26:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AD75B1E3
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 06:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829564; cv=none; b=RR0o/XODNZHy2sVKnvQEu8kkY/JVDvQ8INHYDd4s9e8Mg1S0RJE+rpgwigawd3qCK4SpC8kKBeGZt0ErJ9NwbtJG/2B49SCHj2XRLhUQcPI9iv+kGi4rPhuyCjbuBNf9iMxt5FFozyfnkBBBQQypI9k4CLvGd50i/9hznmzd6MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829564; c=relaxed/simple;
	bh=Vdnf5nY/czOnJuaGBtdc0SPAtrzeEIXDsmcxSs4q/hk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qR36gZrHF4Ft4QCNu6pTxhtc0jRDmgU3/M5qMlKyhhRLWUkqBNQ+BkL+8ff0vc/AnQAs0NPiRk3h3FYtjikebDiW+Fs3zqEykDpdIY/fYONzKR7SShveVb2W+K2lpVS6nvK1VtBn71gJ7WulM2AuXn2gQ/+pr2gkNdGdyJjydAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c874fb29a3so364266639f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 23:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710829562; x=1711434362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGyIYPow4NlrefKnKPQPE6bAcLRxnsVwIJ5cTlLJan8=;
        b=vfZLgx6HAX7tGpLh1A1lSPnk7yyafX2Su2l6DgI+WHU0OrsD6fh9U6oG+P7RCVi0Zv
         teiKnQm17lL/pC6SfLjg5fZm9NRwCUYmcSbMx013i959ylQUXaCPEqRDcWzSDeW7hUrR
         1iD5CUMfMW9LXR0IGCXA8yUWirv1nb3ygxyo2B2vBwYVr4TN5VAcJaIP/x48LEuMTiw5
         ZT/TyVMz1lgwrSP16j8aY0s7Ysw0ZKuQzixC8xQgjuU6C0DWC2bpUIsWQKHhWAXN7RKI
         05quC9ywK189XAx7OaU9jl6JKog093DEo4S5r3KHl1nOJmmQrOdRVG2PU61MwdGrGbij
         qCYA==
X-Forwarded-Encrypted: i=1; AJvYcCUuJjfVVIytLBOW4fXy7TfD2y+8Ld+fDuFa4qkFJHpdnqhMvCLpQX6yUBIkmiDAPDvQo5LFuNXxLgDyl+Db++60gYubF2dpH1I7hN79gg==
X-Gm-Message-State: AOJu0YwGJcwh4Bgk17mHZqzc/cnc8PIYrkOUVx35QdSoefNDc7o2xfnM
	NzmSAtPyrR1A1FsUOqa/esbU+OJ9uEZly/5BY7sK3OZGdi1SVjJb7Py62vF/DW2ROzM964JNFmv
	Ef85jW7t7Tc/5X5Wj7kxN/6d9nacDgAAmga8koKCJTM98QuYk8KHE6Ng=
X-Google-Smtp-Source: AGHT+IE2QD0gDlbEx3Hy3y/Bkl9ZHnqqTTwLra5wel1Aa+fBhvD4Qk670jJxAR1r48q58RoFOTHF+8ak7zpqJ97cuZoc/2yby5Dw
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c7:b0:366:b696:e943 with SMTP id
 r7-20020a056e0219c700b00366b696e943mr559353ill.5.1710829562024; Mon, 18 Mar
 2024 23:26:02 -0700 (PDT)
Date: Mon, 18 Mar 2024 23:26:02 -0700
In-Reply-To: <ec51cc1d-beaa-4aa1-a54d-e503223dd365@posteo.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050e6310613fd8ccd@google.com>
Subject: Re: [syzbot] [v9fs?] KMSAN: uninit-value in v9fs_evict_inode
From: syzbot <syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, charmitro@posteo.net, ericvh@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/9p/vfs_inode.c
patch: **** unexpected end of file in patch



Tested on:

commit:         b3603fcb Merge tag 'dlm-6.9' of git://git.kernel.org/p..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=48bb382b96e7eda7
dashboard link: https://syzkaller.appspot.com/bug?extid=eb83fe1cce5833cd66a0
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13a5fe81180000


