Return-Path: <linux-fsdevel+bounces-18986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E40E8BF421
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 03:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DBE11C21CB4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 01:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE29944E;
	Wed,  8 May 2024 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Yen5rOD9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07A679EA;
	Wed,  8 May 2024 01:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715132034; cv=none; b=Or8SyhV6IJIRj6jtf/3p5XNR3L87KH7W8n0jdJlMMRZRgvH5+5q5t2yYGXpPTR5raQgc+Ha8L9dQBFtgkieWR8/xl7JuoadMHw1K9k1cuhMESvMcSH2NEr74NYHzAfkU25XoG9HninLZTaZOf/4hStHu1FkxSLxPS+m5jnR9dJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715132034; c=relaxed/simple;
	bh=YlFykGoxAiiJuRSGMaXz+r9CTvvsH71wleL5j7OOBK8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=pLXONj0OSxsKSEknJvUZYtEiJ2/1dnLyRTvN4jMErXws4MIkOeQVIDGC3BHJ24MeMDSKi8SDdgX4h9ugrJrtrUSLr7aM9MW5uMgJ97zTrXzP7Qapqq/IFXK2QdAp+dJKK200IYAGmy/stB4ZAD5YxPXg2TZdzeLLszAYhe9YqZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Yen5rOD9; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1715131729; bh=RpAApWwz9vkgICo+/HQ8lHrSIvkMVGTy8S0GeZrlgnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yen5rOD9cbZyWc/jSaTf3Z/6fAAfN+bHweFJbjzH08pU4J+E1dgMvXfEMS5qv1X3H
	 a/UmHUTFHSqaw7GGnzhpncrnes0VaIMhx5BjVlP1PV7o8o2SsI3juArSm4GKeyZpax
	 2Gztw2XvZu2H0e3lmp2oSBIenhHtYNgNZyroIAuk=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 72E20E1A; Wed, 08 May 2024 09:28:46 +0800
X-QQ-mid: xmsmtpt1715131726tzjvae2pq
Message-ID: <tencent_B063096003B044521770576F66D1336E2305@qq.com>
X-QQ-XMAILINFO: NKDEJ657lpu+DDn7E0qu1B5l9FJz1NUFydfhaK0WOb/m6BIuFtUYxkqaX89AzB
	 R90rmgs9QYyMVM31FNZjg3zY9Np0qiQ2zEny9CJidE5+8CJXK5GrV9EhpgP4Bx++KWMSDjtGmml1
	 dXPi0A1jFMLs2IqBZWHo1/tKtz6cm3G2yLh7W6JDIp1QeNrI91vgyLUIY4z3Md8kmTlPjboKcuG+
	 d5/HXtd3oQxi6+qwYclwIpjGfGeLaDLkXgjL+KW5K2UgAMvQM7b7I5IFcdkPgLdpyIg34y7pgGjE
	 yjsJ+tgx/HUAMPF+Nb89E2PjxdtzvpNXhJ4R35DwNKSt0Qg0Xr+0lg1+785j2AZQO6wZcZOyIsHt
	 CUT4V3fZD9mKwZ5tCOSowJlTRXYZFYyQKBf515wrrm8kndgR33aa7UTNH0JB0vBdOEVRmOEX6huh
	 zfWMQg8/slPUwzrW6IZ3Ogvd8pGYrQ2a4VW4CLk1TaI6Te2XJYIFgt3Zv1OIzF8g2TnlkXOZK+K9
	 m6CAlOjSFsWTfihoXn+Inmq5wcBFQZyyTodV9+3EXGbzDEZcqrUpVk4CoyITRGm9yxEKLwxpEP/X
	 3+FyoIQ/90nRIub/MNkHB9F1qwu6BbPe51OuGOEGfSAhWecWtSMtwVXCMqVJM/uZNTQ4fIUszS7n
	 j8NzV3SDcVmzPyb6JJGX530Pfs/g5yiPQoB/R6lGw32PKnUoyyKK9fc3ggWcXbKzWJ5uDYJ/x76T
	 3UGxGWn1GqKzCZLmh0Lxf+IRH03LlEAg9Q+4xoHUIdriSPX0bsa6Z8epS5yksR0b1OunTX6VnJ4W
	 MXyTg+wvF9TzHBpXr+Hez+9SqnoDqL7GnDYAlIMlJpNzqdAc/R7AakFkVqLfO/Im3FNTDJZfxIaP
	 PT7lSEUcs9wByl5MKu10l/6rZ8nJl6cakz/bT4+af2lGP0kMcFgSzHPg1vdLGKSS5hNCDwbPvp0p
	 XGGp9JMYi1xZyrA++LVqVAfdYtHWPgxdlP61OcTbSLyw2pEBQKZNrBxZIhnvJJ2e9K5pHcMPo=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: kent.overstreet@linux.dev
Cc: bfoster@redhat.com,
	eadavis@qq.com,
	linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] bcachefs: fix oob in bch2_sb_clean_to_text
Date: Wed,  8 May 2024 09:28:47 +0800
X-OQ-MSGID: <20240508012846.3244444-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <nq3ka3ovvksptfkl5c53c4yn54efhu6dtt356lrda2wg7xzwak@tutbtfe7eskb>
References: <nq3ka3ovvksptfkl5c53c4yn54efhu6dtt356lrda2wg7xzwak@tutbtfe7eskb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 7 May 2024 21:21:16 -0400, Kent Overstreet wrote:
> > > > > diff --git a/fs/bcachefs/sb-clean.c b/fs/bcachefs/sb-clean.c
> > > > > index 35ca3f138de6..194e55b11137 100644
> > > > > --- a/fs/bcachefs/sb-clean.c
> > > > > +++ b/fs/bcachefs/sb-clean.c
> > > > > @@ -278,6 +278,17 @@ static int bch2_sb_clean_validate(struct bch_sb *sb,
> > > > >  		return -BCH_ERR_invalid_sb_clean;
> > > > >  	}
> > > > > 
> > > > > +	for (struct jset_entry *entry = clean->start;
> > > > > +	     entry != vstruct_end(&clean->field);
> > > > > +	     entry = vstruct_next(entry)) {
> > > > > +		if ((void *) vstruct_next(entry) > vstruct_end(&clean->field)) {
> > > > > +			prt_str(err, "entry type ");
> > > > > +			bch2_prt_jset_entry_type(err, le16_to_cpu(entry->type));
> > > > > +			prt_str(err, " overruns end of section");
> > > > > +			return -BCH_ERR_invalid_sb_clean;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > The original judgment here is sufficient, there is no need to add this section of inspection.
> > > 
> > > No, we need to be able to print things that failed to validate so that
> > > we see what went wrong.
> > The follow check work fine, why add above check ?
> >    1         if (vstruct_bytes(&clean->field) < sizeof(*clean)) {
> >   268                 prt_printf(err, "wrong size (got %zu should be %zu)",
> >     1                        vstruct_bytes(&clean->field), sizeof(*clean));
> > 
> 
> You sure you're not inebriated?
Here, is my test log, according to it, I can confirm what went wrong.
[  129.350671][ T7772] bcachefs (/dev/loop0): error validating superblock: Invalid superblock section clean: wrong size (got 8 should be 24)
[  129.350671][ T7772] clean (size 8):
[  129.350671][ T7772] flags:          0
[  129.350671][ T7772] journal_seq:    0


