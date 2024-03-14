Return-Path: <linux-fsdevel+bounces-14384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 000BB87BA60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 10:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3128E1C2212B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 09:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF31F6CDC0;
	Thu, 14 Mar 2024 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZSEWrNwG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119496CDAA
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408447; cv=none; b=JzfT8eFxIuv+06TRlf4kEN+CFB34IpMVrY65Bw9FHEFPtg5odbWdleFlMEwQL6026osIAdDZI2rCZ1ktaYBJGniLW1Y0/xX8bEK9mY2s2PX1T8Kk8V8MlxU1IW71TJEaS7+gNNCcf/K4/D9W3xD7BUYetFAdH9scD/zy9gv5uE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408447; c=relaxed/simple;
	bh=OBMOgQm2JqMMB2lopZ6dLV4hKACv0lHz0FcYOf1y1Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0jV+KP0AU0QhCYO8GOCk+fTduJNcvS6+m7urPkTYNdBRp8lPFXo2Fpan9S3lnNoBSKV/IRlqZL4hxw1N7vt7U6nJSscdsdhQkgYsS91K4AqujyU/umLiYGA8ESgmzXChjqnCkGOFe0bnY8hgpfNPvw57FoPyFQpvK0NRsQo/G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ZSEWrNwG; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so326169466b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 02:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710408443; x=1711013243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jwIUIDarsV7ESSt3w5nAJOv8KAEl9jUo5NAlBXlY4TA=;
        b=ZSEWrNwGmkqgI2bPfXNWp2ba5/6qhjPW2oShv6cHkGPqRcgyiRI3OLluJLNslTPE8m
         QZLaFfdsqwBv5FknIywyNq9p7Uc7jfn+t+YysGxVUec5LkIqq1ZdsjIZgKI/6ZHuTBw1
         1CsfKJayEI4aP4g+LvSOOt3IeAPdISFJLokLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710408443; x=1711013243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwIUIDarsV7ESSt3w5nAJOv8KAEl9jUo5NAlBXlY4TA=;
        b=lE/q4mvAB6QaqDShDs8xmCXlrr1xlAIwq1FcfR1h9T8Txw2D2WHNRV7yAnzBsEccUK
         /n9p/8THXVi418V3O3c0tbtMJF+hzKArjnU/Jl4Q/jPC0O7VWn3B8Zqz0Hcg0lyD4QO+
         y+ZeGuMxC2i8WahZTE4GHDN/fX9LZ1b41W8T090MVsX7nQTIt3rR2sU+9q8cuIe3xdKv
         Hrn1CZ81KIXOfuqbBhwlGH7FyGshapesvDhbzlyus6nphxdGzkBUopTBq40joHPP0eV2
         u0JQ1dZn04Y9/IY8daJC7PO+rCkcz+Y5ywPb8vSHQNBQJ6lllBeoJqMrX6mrQOQs3a4e
         TOoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ6x0/PshLMc90NiW2gtQbv9eYtMoXxaM2DkeXy5B0epNdnzs9aLISGDCufSmnthZogUirdCQWWPWzg4t/9oNuMjs1pxiupEe5lvD5Nw==
X-Gm-Message-State: AOJu0YwKlBU8HChvw7sHyRTxMiM75bEOsJ/3qzoUigEjXiddhAh6nX9W
	LAc4rx0XKH361XSDw3KhC+eV63618Sje6kEfvI9PQqvbs64tJtugPwYLCob4HL8ixBk6H6OjU2B
	WWKBp4rUGAopvD+Pbtg2cGRgebrx0Yr7e18owwFAOIXnEcVoWIs0=
X-Google-Smtp-Source: AGHT+IG9tD8CTtuCAlV6cIOBe248EyyGlWLXTZiDIe13U6BkGzprg3jxR3h7gCKqYLgyibmLVEujy2gDWnOYr+xGuvU=
X-Received: by 2002:a17:906:fe44:b0:a3e:4d7c:9ce1 with SMTP id
 wz4-20020a170906fe4400b00a3e4d7c9ce1mr1156151ejb.21.1710408443295; Thu, 14
 Mar 2024 02:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000bb26fd061392e1a9@google.com>
In-Reply-To: <000000000000bb26fd061392e1a9@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Mar 2024 10:27:11 +0100
Message-ID: <CAJfpegs9LQqzMLPc7Urw15sj9bHUmMe1CES6iPADrF-YP-_amg@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] possible deadlock in iter_file_splice_write (3)
To: syzbot <syzbot+e525d9be15a106e48379@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 00:10, syzbot
<syzbot+e525d9be15a106e48379@syzkaller.appspotmail.com> wrote:

> -> #3 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
>        lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
>        down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
>        inode_lock_shared include/linux/fs.h:814 [inline]
>        lookup_slow+0x45/0x70 fs/namei.c:1709
>        walk_component+0x2e1/0x410 fs/namei.c:2005
>        lookup_last fs/namei.c:2462 [inline]
>        path_lookupat+0x16f/0x450 fs/namei.c:2486
>        filename_lookup+0x255/0x610 fs/namei.c:2515
>        kern_path+0x35/0x50 fs/namei.c:2623

This is what ultimately closes the locking loop: doing path lookup
(taking directory i_mutex) with kernfs of->mutex held.

#syz dup possible deadlock in seq_read_iter (3)

Thanks,
Miklos

