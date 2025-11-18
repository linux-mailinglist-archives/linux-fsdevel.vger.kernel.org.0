Return-Path: <linux-fsdevel+bounces-69019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 33499C6BA26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 21:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32C4234FB5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 20:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43622DF156;
	Tue, 18 Nov 2025 20:32:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE834370310
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 20:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763497927; cv=none; b=NZ9StNfp9EKKDSCVmQSpWgLwu4Tgm++0pJjGZqts7NgYGD6SbIrP96X6RO9MQafldj0TFx3aO34xMzzDmdZkxl/tv2B+3wbHts4wLyHeMzWDf+1z2DblYACYIeen8IP4K4orQdDfd05mxE9BbUpvcH5hxYeMWtqihBYyQB4Eevg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763497927; c=relaxed/simple;
	bh=MIzh6zIjPvHzjsgakTwBT2NBiPV0mXtz3BNO62HJEww=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R1iDGEhA1lRMAfShGjkVcYk60NKyAut1golQWDvXim9G+CZoFKKfmBeO8dxxans/Pi4UIGaEalbgQv7s7BwRZNLQ4CJaE63wQC7F/vKdqZsWEa8lLloEPMjjZM5PkPTn1vq1tmYcwqI7YxNxSSDkSIV44X8/FsRctHcWQjMJgRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4337cb921c2so64311355ab.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 12:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763497924; x=1764102724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Rasht1Or9F6qCMTb+IR40QgXjV7x0Rp7VmV+oBOsbo=;
        b=jl3J/6kfF+QEZZqS/38vfyf0nxeTJfHq+xknA3mIyOVuWKHklYHaDlb0ZcHhf3r/Sp
         gDUrD7WGm4zB/pb8A/o+DgCZu5AFiZSN8vBis5dy0bawoSN5oNcshQ+0unCYSV1g3Xre
         retmKEBX6uFsvDHdZSnzgZrcs6UqgYne4qn3tBuLRLOrcojM8bTVh3T+2O+91/hQiRrb
         VWmpo3plO4I9h0MbiomCW7u1SMzucams6r9Gmn6Ue5XTd6cKEHX1IQVttUa7vqkQeKWI
         TlAry6qRXF1weALZRIAagc1Hll6JL/HTXOINZLnYBcFRdd9WUSYYeM/sNlsyguEB5PQe
         KJOg==
X-Forwarded-Encrypted: i=1; AJvYcCWbwsEHmoZLYw011G0ETDrcUCa4CGyCRdk1SFCXq4j/SxbgWHpZoXndiNRLM0rZqWx6/Y12jNw+HzCglMWi@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6enRZTQs50l72g+vyhwUL6oVz2VsUsMQB7Zj5QU2sNeDP5v9m
	p0HJJ/jNuJBDp51a3rSJy3oOGbJyQ/Da+kUIamlU8bRpuwJng9PSn9mq5xcOt8Aj3EkrTmbxb3p
	uOMHxtPqSnHGMx5p0KrRm2vb7LGl3CgNzn8gnAr6qYfkVMbLMpfCFCACpgFY=
X-Google-Smtp-Source: AGHT+IEhBpZXOPxFSr5qRnjCBToakDi3kyNgVps+a7Kh4FPsx4obXRNGNqE7ezFpy8YABqnw+uMBzdypn9GyFbj8w42djVH5MAU3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1887:b0:430:c491:583b with SMTP id
 e9e14a558f8ab-4348c8e7a31mr208389905ab.14.1763497924095; Tue, 18 Nov 2025
 12:32:04 -0800 (PST)
Date: Tue, 18 Nov 2025 12:32:04 -0800
In-Reply-To: <20251118192209.70315-1-mehdi.benhadjkhelifa@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691cd7c4.050a0220.2ffa18.0003.GAE@google.com>
Subject: Re: [syzbot] [hfs?] memory leak in hfs_init_fs_context
From: syzbot <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mehdi.benhadjkhelifa@gmail.com, slava@dubeyko.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout syzkaller repo: failed to run ["git" "fetch" "--force" "--tags" "8408054c2e598e2818e3e31f22aefcbac3668c43" "4e1406b4defac0e2a9d9424c70706f79a7750cf3"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb128cd5cb439809
dashboard link: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15693212580000


