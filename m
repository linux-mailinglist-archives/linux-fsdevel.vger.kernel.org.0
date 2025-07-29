Return-Path: <linux-fsdevel+bounces-56223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E76B14717
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 06:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416FE189F306
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 04:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E6A2253F2;
	Tue, 29 Jul 2025 04:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="okRV7/0y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9CC2E36E6;
	Tue, 29 Jul 2025 04:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753762663; cv=none; b=ZrwZWLRVwgHWZVm7D2cjr8gMcaPxjncuRZtuAgV5YlpdLPDtjPsaY2zQxIXTJW51uOVUyc2iamcT30yLjxTo0vnwKx1AJ0k9y0WOPGZxy1HuigRcPG4odc5bfo7bxq4RkVDXABa18jgU7KASqboZa6ErV6iNH937PCCfUn55fS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753762663; c=relaxed/simple;
	bh=N9sNQACNBRjYp42D/++67XBOenWpbNSZFS3iE/fM07g=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=iyjKvWdIau735toE7VlnAS5J2wWQC8B298xCtl8N2MxC+coGaCqMPiAdiAnrFYzfm4UBpTxkq+Xfyg3Hsl7bRbOJEeZo2VIQOmoLA/vv67RZEuCKppY9V/9BLxXzTdMgqdemxmYUf4zXZZ1+eVcI9aJrVBLRlz2fI+Bc5bOqUUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=okRV7/0y; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1753762643; bh=++GyHkPA6uNF+ogkISZH3UE9ot5HZgKZ8x2ulVwHSEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=okRV7/0ytku0ACrGlY8SDnoGC/Z3UdSHgTQqtftnXUWjpOzr/ZveLYYDgSUfiSIzD
	 UIC9WDr4m+sLz1Vz+A5+exoLnar23g8VMiuX32AFrUgg+BRksWuW7G2gMF0rQCyJnr
	 AKSfKFYwDG9xBjPfLQ63t21T9SLpbScok6WodoDM=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.231.14])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 454BBAA9; Tue, 29 Jul 2025 12:17:20 +0800
X-QQ-mid: xmsmtpt1753762640t81pdok2q
Message-ID: <tencent_3066496863AAE455D76CD76A06C6336B6305@qq.com>
X-QQ-XMAILINFO: MzNwb/pqyJTk1mrpoBGk9koeErbzOR6/GYwWqxVCCkQBwFv1aYrFWhC/fP7RJ4
	 LXn4aAIBI3nerGsWZqi42ZW6FHXHLGmt9uaSr6rQuQWOZA/HU4H3zz3JAiW0q6RvtGd2DQPIsnkx
	 eIWpVIP+q1+iTK6tiaVkByyKYFVXaqeP08dtaMtGxmtWoI3B0q2/q3yfmVFeUTBBHn3JCn+Q/HQ6
	 odimiyHvkxDWEXmFyZCjqkzVb/23r4VcDOoAX8sz6iDSFSXgHhY+qT7XqUUpSSeAEXN2ciI+vZBa
	 n92iUV/1hYsGQuL9aHoMuUiOlFLQY/psiqglzlS5jkhhYuXsHbLUaJIvkwiKszJs432DU6OYJnOQ
	 MnnPG8VUk3bKX/JzMe8wCht7eS9zfhPj+yHNFY7z7vz1djtzlXKd+sJpWH3UPXYjiz7dTj3iZ78e
	 m+UVEAxqnBecwIo9DXx9evRrbwGe6vNLl/wMWmj+Ji4BRYpsy3TudpCYvXpQh+4+vlYEutnBIt3q
	 OGR7aUItk+w7rBsagD9r9mje6mS+LGotNUX7NlssSf1Gb2TfX91lIJHl29HiG0CaKVdvC3qhVFjF
	 bFkT6dGLCc4JGVIfMV4uS2TwcPzdo4jdlpsJo8VzOeMNXSmMoReBNqekJE6xiXEyPoSbWmKXDDn6
	 ola1Yz3Cu/WxxAQSv5DuTAGUpWUs6jYZETkKtZ8l8mXU9dgBljGFZ85O0hLMJZNGHhvqeLpwmenS
	 dxH67IUTqxpU+8R8MJhCZnj6b2g9ok7JLXoY3OsyfpH4n8g0qJAzvQDqZUTHULOsgBVrWFXI4efT
	 XmZczXVvG52nR2geEf5N0qyBQ03Hh8HzJJu5LnwyOAk1FBYdL3exV2SEKhBGxUQWuzZ/m8mnNWIo
	 rY/ZhXYgvmovb5Bsoj2D4vyMXVgRrKSQI0RmYugjxLuH79T2LjOZxeS06hxOSZ+Tql0DNqYlJ1Wc
	 SxEHDCWSubdhqy1GaE8N4Fk/KrBRyLB6o8MNglap3lBNprgmlxKhX9r40jd81PyiZb0bhpAnGP+Y
	 WHMQId5w7rZ3AkqSMYXjOWMW/Y7Ja9IG8kO+BCmK7K9VhtzXY1mx3fOGSXfSU=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: viro@zeniv.linux.org.uk
Cc: eadavis@qq.com,
	hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sj1557.seo@samsung.com,
	syzbot+d3c29ed63db6ddf8406e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fat: Prevent the race of read/write the FAT16 and FAT32 entry
Date: Tue, 29 Jul 2025 12:17:21 +0800
X-OQ-MSGID: <20250729041720.2513812-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250728163526.GD222315@ZenIV>
References: <20250728163526.GD222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 28 Jul 2025 17:35:26 +0100, Al Viro wrote:
> On Mon, Jul 28, 2025 at 05:04:45PM +0100, Al Viro wrote:
> > On Mon, Jul 28, 2025 at 07:37:02PM +0800, Edward Adam Davis wrote:
> > > The writer and reader access FAT32 entry without any lock, so the data
> > > obtained by the reader is incomplete.
> >
> > Could you be more specific?  "Incomplete" in which sense?
Because ent32_p and ent12_p are in the same union [1], their addresses are
the same, and they both have the "read/write race condition" problem, so I
used the same method as [2] to add a spinlock to solve it.
> >
> > > Add spin lock to solve the race condition that occurs when accessing
> > > FAT32 entry.
> >
> > Which race condition would that be?
data-race in fat32_ent_get / fat32_ent_put, detail: see [3]
> >
> > > FAT16 entry has the same issue and is handled together.
> >
> > FWIW, I strongly suspect that
> > 	* "issue" with FAT32 is a red herring coming from mindless parroting
> > of dumb tool output
> > 	* issue with FAT16 just might be real, if architecture-specific.
> > If 16bit stores are done as 32bit read-modify-write, we might need some
> > serialization.  Assuming we still have such architectures, that is -
> > alpha used to be one, but support for pre-BWX models got dropped.
> > Sufficiently ancient ARM?
> 
> Note that FAT12 situation is really different - we not just have an inevitable
> read-modify-write for stores (half-byte access), we are not even guaranteed that
> byte and half-byte will be within the same cacheline, so cmpxchg is not an
> option; we have to use a spinlock there.
I think for FAT12 they are always in the same cacheline, the offset of the
member ent12_p in struct fat_entry is 4 bytes, and no matter x86-64 or arm64,
the regular 64-byte cacheline is enough to ensure that they are in the same
cacheline.

[1]
345 struct fat_entry {
  1         int entry;
  2         union {
  3                 u8 *ent12_p[2];
  4                 __le16 *ent16_p;
  5                 __le32 *ent32_p;
  6         } u;
  7         int nr_bhs;
  8         struct buffer_head *bhs[2];
  9         struct inode *fat_inode;
 10 };

[2] 98283bb49c6c ("fat: Fix the race of read/write the FAT12 entry")
[3] https://syzkaller.appspot.com/bug?extid=d3c29ed63db6ddf8406e

BR,
Edward


