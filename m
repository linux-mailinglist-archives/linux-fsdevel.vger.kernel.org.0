Return-Path: <linux-fsdevel+bounces-68995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF6AC6AE58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 18:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 2E1452CD78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 17:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4568536655A;
	Tue, 18 Nov 2025 17:15:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05271349AF5
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763486112; cv=none; b=GeUSvuJN58D68QII9HAu+KGQmZk0O8BL6Es2HJTKTcsb9kdX508/gC6JO3Lake+zinirUzyJ+cYVpTKYPUpAGFG5et31u5HiToTxHoASuu/wv908bnYs6UCfRNkf0fR1lhEYeSiBiNwuWxFWU/1t3Z4E9/dOQgEkdPqBG4/qalw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763486112; c=relaxed/simple;
	bh=TJOoXWfdWISSgte0Zb1439/CweogRMYewVWICNfMXUU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Mc8X8MznAJXvjrcq8kxyqgQbNXJY/m48NBJWfxVjB9BpQcXW/lZ2oj53dPFqFyt+GeJkrzbKECJaINUgnFAglmz643lUZ+vO+lwmACIjldkNXHXb+eFmimHCCpBeiL0RUufdUQsdt05NAYdo19hqXW+stC8VChFon0sypxWyiJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-43322fcfae7so65896465ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 09:15:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763486106; x=1764090906;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yygKX+KG3sPMlFABupBX+NHmKiEncOrcjStqbD3HKHY=;
        b=CbeCxCRHtwXjqCh8mcKhTtI9k/jrz6OYtIPFAMa1vi66BQQFeDIvT2jvWnu9vzelEO
         3KNWRyOW0Cth8WlB84wJ22yswSkcCaLdyqNGvWS1GjYpt4s+t59tSJJcnJY4BP3DhZ04
         bsru+7v9654t+i/rvESnTrujDo6Cy/wc4zuVV+hXaqvb7odeEATwuvWVfeVgAR4HJjRW
         ZtzsvZ06e7jbouKFsohTMTeFf6ipEzM7rUwIHylcTJQdJgl+RkrFyAhgo3JvKm1FAR0J
         /j63PUdLoo1edLk6xpKdzp4ija8lqCBNAEIyTvQXwIl8DiR4ywhaPq2Wa5MYY91ATRa8
         tXuw==
X-Forwarded-Encrypted: i=1; AJvYcCWjjNv4YNAJGEolKE4GhHEUCFl5MRQ9PfQbWZfESSsrz6AElEFOoi4gGmAByzcGce6YAL7bHcFas7uBUEJw@vger.kernel.org
X-Gm-Message-State: AOJu0YwYxq9kAKJDCR3K8EpVwU6t9Hrqrxg2CBT3qYKDVLqHPfApUlOc
	yayVgENqlvrk0BWbg6FjcH3HYAGw1qerrNYRcKtWxiaDd/3yQJokeEYo35IApA8mUgA2Ur7PeGe
	0cNHMlDRljvZKMMZYhJNNPjuXY+Gm8eHqrKsV0i3wEGWMMHFQHez1zO9Da7c=
X-Google-Smtp-Source: AGHT+IFzhEXd4FWm0yLDu3FyzcUrIrrbY5IAD/2eiVRffBQOWmT8KOK6w/v0qI8Pw96OJ/CQmfjNNc9ch6Koh4MXIMdw4abwL0Tu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1608:b0:431:d7da:ee29 with SMTP id
 e9e14a558f8ab-4348c940e5bmr236623535ab.28.1763486102538; Tue, 18 Nov 2025
 09:15:02 -0800 (PST)
Date: Tue, 18 Nov 2025 09:15:02 -0800
In-Reply-To: <20251118170023.111985-1-mehdi.benhadjkhelifa@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691ca996.a70a0220.3124cb.00d3.GAE@google.com>
Subject: Re: [syzbot] [hfs?] memory leak in hfs_init_fs_context
From: syzbot <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mehdi.benhadjkhelifa@gmail.com, slava@dubeyko.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
Tested-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com

Tested on:

commit:         e7c375b1 Merge tag 'vfs-6.18-rc7.fixes' of gitolite.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b63914580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f30cc590c4f6da44
dashboard link: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13851658580000

Note: testing is done by a robot and is best-effort only.

