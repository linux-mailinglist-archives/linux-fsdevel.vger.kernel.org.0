Return-Path: <linux-fsdevel+bounces-50811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2254BACFC48
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 07:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC87176AC5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 05:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8375D1E7C03;
	Fri,  6 Jun 2025 05:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaJfhICn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842D04683;
	Fri,  6 Jun 2025 05:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749188363; cv=none; b=RwewRTzmNIXkvlk4FARDI/lEGsHheJfU4SCprlhWqKp0FMdoND5fjvSpq+v0XxnMsCZU2MD4NsdyPLPF+M33xqCxoJrjE/9MIfSWc2wtBD+ISx546wLF3oVQ4Ej03caZ+VfJSdMKWdco29Qi5CsH424kR/qIXlgncaqsR3okwV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749188363; c=relaxed/simple;
	bh=o8RlcqjH020t6cnNSSuuuBu98bfVAoUiPLdHUxYqCh4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nUFvjapfI/wox0DdOx2G/GjDRFB4oJaoEwH93edVZt4OEU9ZxBc/BcZoVb3WrKnTmFedm5xZwwm4JWXFosI4//uIbx3O9Tjuf0Rm8NBul2zXnkZkKMr826EK6LoGvbaK2kOUNs/FsfcqsOZqORffenUlBobVbSg3ZPEMZFtIxOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaJfhICn; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d8020ba858so19124685ab.0;
        Thu, 05 Jun 2025 22:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749188360; x=1749793160; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ooi63Df6cKZmgkR5pcmfMZuFURKVHlT/9pTZXYzQVU=;
        b=YaJfhICn0bUyWXNE/3UEH1Gw5vGU15PZpMIw5dVg3nTaYeAA+wOEhOg3OZNVhQz2Mv
         7hlDe9bo+z+bGzzEyQdxM+5VbzN38bmu2dN2/fF57UE7IgxqFGdif2r7SMwjj4fmWIkI
         +Me6l49bA9usKUmg/M1HT6K+OPapb1wgyW7bVGkjxLxlUCvTw3Hx072yH0HKIerijJTb
         WxlP+d+SrJrCmj8nuiVu+zPRK+H7/ocvb1fHqrDQpqzfZJEKaADO/m+w5zJo1LYxr2oQ
         p/NygpbPC+6eDviA4S7XCoCxL4SyJ25w2j5H93rIqWcv3B3nwWSrLxm7kcKW92hOD6TY
         ej5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749188360; x=1749793160;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ooi63Df6cKZmgkR5pcmfMZuFURKVHlT/9pTZXYzQVU=;
        b=tWqfxhTiZEzseIBP15FLN6MfsiKBhlasbN6nirngprTFpIPZAmWpqZQKa0qDaqEtSQ
         QGOjZKGzWqrjHRTSPA3ymjWKn9Ne/FMzajHe//LxCcXg5sfssp1iyT321p6RojK52rll
         CS27wukwAjbT4nLR3MjxxWisqXeeeSKgEyIvMoebnqAgINETI94soefcsvP0UT00KmrC
         yr2b6IjXF8HIWbZQPslhHz4FzihvWpVO0NUm3B6nPmSKKD6KW3DY26cArla9q3SWofJ8
         62pBI5+7hyzO3PeYTl5wGfRLBIMWBh+DPHQK2T0cH6HQQsWUrXhruKolNdLgpLyvAck5
         ua+A==
X-Forwarded-Encrypted: i=1; AJvYcCU9YwpM0iDpRB4r8/EPsG1GwkL58OXPLPgJV0DhXbq4u0heiUoYpOG2wyLuOApQdbW/x4xcZeupYA==@vger.kernel.org, AJvYcCWOeBi4MiJEYLA9Gft3LXkNnFH9ecQ9upD5occXULaXJSJ8bpOw0eZ9s+daTZeOPZku9bK6yQxRV4cWGT7s@vger.kernel.org, AJvYcCXIvr3dSVzC7KMssixQZ7ldcAj/erHuHJeWKX2E8/SppHkuSHlded7PjIvK9tmRffdMWWm/2O+WbOpQJ/6m@vger.kernel.org
X-Gm-Message-State: AOJu0YwAHswQJekcgBhM+SW9lEGJsHUapJF0Ha3a0eHOJcoxeTwu1e0s
	l96BzfnT4E9bsZfbe9ElwEvANfrRsWKd1Rzcu+9HAaMeoaxW+dq7ujQhP8vZWA==
X-Gm-Gg: ASbGncsaW1eFZZf6PSsf8CL34l6GXiHPpHdZtpAFu2QjUc9wYCt5GPumTeSN9VtfC7j
	md7zVGKAQmKerzIkF/j1mr314QP4mK+UpBdUPukbLAlmx/i1BviA77ueAgmyVB020JN2IJng5fZ
	w8DYHcQR6sGUUwUU2G4vNsA9rZ9vJUYNPV399UP3pGGv/j/uvoKdjA1xZk1O1jm48yHulLPkwgm
	JsMdfwp6CjR98O7ecOseO05dk5G5sWQUz4D/5cV4hSP2K6I1XvnvSmFn4YfeVBCoJqi1RFc3JaO
	dE9Q2KspGX/vqdlF6y7scxBKYYt+eph0kaklD5A6kx8=
X-Google-Smtp-Source: AGHT+IHjvKIb+jmUvZ/4ixHeEKPXHLIp8U4t0v4kDP1vQRIWl9N4o6yKRPpMc0daawZJQrHDOZ+cIA==
X-Received: by 2002:a17:90b:56c7:b0:312:1ac5:c7c7 with SMTP id 98e67ed59e1d1-313472d0834mr3903892a91.2.1749188349923;
        Thu, 05 Jun 2025 22:39:09 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::9eb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3134b044d91sm523389a91.2.2025.06.05.22.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 22:39:09 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
  linux-fsdevel@vger.kernel.org,  brauner@kernel.org,
  linux-kernel@vger.kernel.org,  selinux@vger.kernel.org,
  eggert@cs.ucla.edu,  bug-gnulib@gnu.org
Subject: Re: [PATCH] fs/xattr.c: fix simple_xattr_list()
In-Reply-To: <CAHC9VhRUqpubkuFFVCfiMN4jDiEhXQvJ91vHjrM5d9e4bEopaw@mail.gmail.com>
References: <20250605164852.2016-1-stephen.smalley.work@gmail.com>
	<CAHC9VhQ-f-n+0g29MpBB3_om-e=vDqSC3h+Vn_XzpK2zpqamdQ@mail.gmail.com>
	<CAHC9VhRUqpubkuFFVCfiMN4jDiEhXQvJ91vHjrM5d9e4bEopaw@mail.gmail.com>
Date: Thu, 05 Jun 2025 22:39:08 -0700
Message-ID: <87plfhsa2r.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paul Moore <paul@paul-moore.com> writes:

>> <stephen.smalley.work@gmail.com> wrote:
>> >
>> > commit 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always
>> > include security.* xattrs") failed to reset err after the call to
>> > security_inode_listsecurity(), which returns the length of the
>> > returned xattr name. This results in simple_xattr_list() incorrectly
>> > returning this length even if a POSIX acl is also set on the inode.
>> >
>> > Reported-by: Collin Funk <collin.funk1@gmail.com>
>> > Closes: https://lore.kernel.org/selinux/8734ceal7q.fsf@gmail.com/
>> > Reported-by: Paul Eggert <eggert@cs.ucla.edu>
>> > Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2369561
>> > Fixes: 8b0ba61df5a1 ("fs/xattr.c: fix simple_xattr_list to always include security.* xattrs")
>> >
>> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>> > ---
>> >  fs/xattr.c | 1 +
>> >  1 file changed, 1 insertion(+)
>>
>> Reviewed-by: Paul Moore <paul@paul-moore.com>
>
> Resending this as it appears that Stephen's original posting had a
> typo in the VFS mailing list.  The original post can be found in the
> SELinux archives:
>
> https://lore.kernel.org/selinux/20250605164852.2016-1-stephen.smalley.work@gmail.com/

Hi, responding to this message since it has the correct lists.

I just booted into a kernel with this patch applied and confirm that it
fixes the Gnulib tests that were failing.

Reviewed-by: Collin Funk <collin.funk1@gmail.com>
Tested-by: Collin Funk <collin.funk1@gmail.com>

Thanks for the fix.

Collin

