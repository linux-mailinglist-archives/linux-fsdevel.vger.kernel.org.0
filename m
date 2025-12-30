Return-Path: <linux-fsdevel+bounces-72232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C455CE8F4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 09:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7DEA30206AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 08:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C013009D2;
	Tue, 30 Dec 2025 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nqd2PAMu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884EB2FD696
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 08:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767081652; cv=none; b=V2Zzh5+6cQr8qdtPSQ5p/BdIM97Biab5x6CVmAT5ePWtXzeThW5jravj4thc+JFv3agXtQNf0uIomZVYUzIUvMQh8fc1pWafymnfOhmsGlSxS9DTZtJdJ9YyMv0XJTF2WtpNyLNReElU2YzfTmHrnzLUhsaJ/w9cjyt97G48CbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767081652; c=relaxed/simple;
	bh=kUAtREP4r3Jk7ebNlE9iSefQ2TZkR4Wzn+pvU+AV0kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCCXbOx0sjeznHc7zFJ84Mnj7uvakH0ErUuIKTxclJmwih+znYutFyJwDnezsyplAwhIiwEw2Q328fv0lNCAkqxwSsyh5TupdBu4s0QCqTvY0wKpqmKHkIuzy+gIU1gfMdiL4GkKQ5doGCWFTyXE0XsOQW3QVl9mAbq06Hs60Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nqd2PAMu; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c95936e43cso3578076a34.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 00:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767081649; x=1767686449; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a/UlpwucLSO66ZjDVdVSo/Y9ecGsaVHciDAyRwmUx4o=;
        b=Nqd2PAMuRIoBA8ZitkA1YoHnAwoqKPkZlVAy5LIU0JzLhHd9Z5SNeJhpniN5m/hHCh
         PF/LTYmnkHPrN5s+wDaMSlDyc1g3buGohqAvVpHlEN24wn1VgUKK0W1lV3bu2V2X88ac
         jfriwsbW9XaKyLedFE0CVf0XiKpEt87aqvEdG6c8LmxXqQZfKzCJsYUaST1nC9+oJGCD
         hQCkhkJItTdu5LGlqDhs6tpYj37deBA2SLAOQHNSEBYj1bUD3kTLH9BAyip50ByjcUYP
         AkvOgA7Q+AJkzLbaWkws9eJO8dEY12ymjE22mOL7wiCh6pRSwhLJZAK4e9C/dIcWj0sR
         wAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767081649; x=1767686449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/UlpwucLSO66ZjDVdVSo/Y9ecGsaVHciDAyRwmUx4o=;
        b=Gs2uQFDQCJbqJAPy8liisUVhP/pL6riuLIeKGy0IpbaOv02MwJ/FvIDQQMnfEnB40x
         AOJiWWZhMJ1Uub1FaJ9SiRiAKMt66cNBWZVxWluy8YVNOMrisBLZ/+L7y98w9iGgOUd5
         nx0wXu7iLe1tsSz/d7VwJEKeNjxWLKDvVHO9shqSyhuQ6PE6kjYQqZ+/ObzbyNMC0McU
         5UcUc/4v7pojmww9wc9S2SFxYQOc2xW7RDFyMQmsN2cpBRuK5PjB+IJeo0DhtUUln981
         monQ7jwC/hrsveqazvZLPIRFFYcKXb2MTrYzU3SYPm+nE4JOK7Wexz6lATMuGLsjnO76
         h/ig==
X-Forwarded-Encrypted: i=1; AJvYcCWzuMKGC8D+ShERsvRpcEXvKaykTNdMk+1PuRV4EFOa2pBXnnR+hD3kKFc5/O1TXzDZ25UNBMCqf9niw2qB@vger.kernel.org
X-Gm-Message-State: AOJu0YwwD7hUEF8H2mw1OCKzChLKfb+OxJ3844uKMPS1PAlAfjf6qaSY
	mJ/NdHKqQCDU8s/5y/l0Lov7SPerld0HnkxayaZmvh6n4zYPkdcrTLmOIEQoxgKF8VbFQD76Pj9
	U19t/dEu3anUV4qjXmmY/0u+Lu9vJDGE=
X-Gm-Gg: AY/fxX733RP4ZuLxuKQc7yrwkXgczfgwBGL38Cifz9cpycu1vpznugCnbFaE+7zuPPD
	QduCDviI67Hg2fXnqmW8FBPgF9PuSQykRJx8VGDk7pe/C4NOb781UdiEkJj/Igjn2aMurfd8FGK
	02filzPV+kK7sFdQhqW31FHQgoj8CexOWvst+Yk7R99NnKrDQZzVsdjLOBkTmzJYNNMTu8xIJno
	CIP5Q2o+vk9fNTe/lQfojrjnFby4Ne5DUeObMvsK2A2PEL3X7kWEsRCklkR0W45EsDvEhiNe82P
	kt67
X-Google-Smtp-Source: AGHT+IHb0fYvJRqoZEe36uekaochiJBsMdE0Glt/mx4YysKA7uRP3tWcGd210l42P+1HUt2CPO0VR9+mcL3HxK40TGw=
X-Received: by 2002:a05:6830:91a:b0:7c7:63ec:b697 with SMTP id
 46e09a7af769-7cc6690bda3mr18231794a34.23.1767081648785; Tue, 30 Dec 2025
 00:00:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALf2hKtp5SQCAzjkY8UvKU6Qqq4Qt=ZSjN18WK_BU==v4JOLuA@mail.gmail.com>
 <aVN06OKsKxZe6-Kv@casper.infradead.org>
In-Reply-To: <aVN06OKsKxZe6-Kv@casper.infradead.org>
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Date: Tue, 30 Dec 2025 16:00:37 +0800
X-Gm-Features: AQt7F2qqdsoWtUlRsNGqtxoOoMPYaVcVXJOMjDDy-iJzM4sdhglL7unvH7vMtEg
Message-ID: <CALf2hKvSQiJTGP3MQJWyR+F+cHagB+UnNMSuKroQAuDcAVbR6A@mail.gmail.com>
Subject: Re: [Kernel Bug] WARNING in vfat_rmdir
To: Matthew Wilcox <willy@infradead.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, Jan Kara <jack@suse.cz>, 
	hirofumi@mail.parknet.co.jp, linux-fsdevel@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Matthew,

Thanks for your reply!

> Ooh, -1 is a real errno, so -1 or errno is a bad API.  I'd suggest just
> returning -ENOENT directly instead of translating it in the caller.

I agree with this advice. I can let fat_get_entry() return -ENOENT like:

static int fat__get_entry(struct inode *dir, loff_t *pos,
        *bh = NULL;
        iblock = *pos >> sb->s_blocksize_bits;
        err = fat_bmap(dir, iblock, &phys, &mapped_blocks, 0, false);
-       if (err || !phys)
-               return -1;      /* beyond EOF or error */
+       if (err)
+               return err;     /* real error (e.g., -EIO)*/
+       if (!phys)
+               return -ENOENT;      /* EOF */

Then I also need to re-handle the callers of fat_get_entry() as some
of them are still waiting for a "-1".

I'm willing to submit a patch to standardize the errno (though it
seems to unrelated to this bug), as long as it is approved :)

Best,
Zhiyu Zhang

