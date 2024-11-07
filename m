Return-Path: <linux-fsdevel+bounces-33978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2AE9C11F8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 23:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158171F22C32
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 22:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DBE2185BD;
	Thu,  7 Nov 2024 22:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ab99os10"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103EF1DC04A
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 22:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731019763; cv=none; b=t82xIpe8ZDXPLOczOjwvNrD+NNPudUhygv1jjRqjXNgBwFcbBdSIoxTSUo/B4ew680rmSw/obXZ/OmG1J7IQ9a3E8XRB+W1opQxtyjqYmFH78nkfpS7/arKFStvD0KI5YFSmFSdxDDtybXLCLoiHimgXp0uL08F99poqU7OmRYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731019763; c=relaxed/simple;
	bh=s0x3rt33WDSR+usiS33tTIr6mn78P3rUOjr7li98iP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbSxHpqEfzpBD5V6R2kzJfLyu9KnBZW3JHoM6DS/DtrgJssyxGZ+FZVD4yelx7t42PmUcQGMYzQYabGmv4Uiu8x1/Nory/D8/B4RDP9TMO8q7BSpRsdsk7mRdkQ8qleuRqskOZqRR67aXSuQoupjrjx5xPl+Im33Ti4imbGyDGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ab99os10; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso590503a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 14:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731019759; x=1731624559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BAA/VUP5e6LryZlgi/idscybNAhe8o8oPSBRD7lZatc=;
        b=ab99os10t9YAeKyUSW8l6QW6JKfcZorykj+MFTC4aPnwGoe2eV5Y+uNIa+uxB0cpb5
         g0egqBPya7PLmwnUiDREVzfb/gWoZa5fATVbr+p+pP8SWYQgzGuZ/l2r675MdVlqiowM
         gyI9p3fSO7iSy+FfMV8xFWS/QcJSmUgMRjd9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731019759; x=1731624559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAA/VUP5e6LryZlgi/idscybNAhe8o8oPSBRD7lZatc=;
        b=BlLvohX2kcF8kpoggaUh374XtAtoC6u9fTyxt3nS626SBRrAggcC7ITZ2nPfjI9LKq
         oL6TauaZmNoB9KwN9cxMRl09CN1qw75MX4KOj9ikCRNMel2P/HZJf5hpSspMA80fALP6
         CJxxzNjXKsdCgWlKagub+D2YXcNGwAG23iczArMyd2V3qwwCl8+Pk3XVv+u8PQT1Wm5f
         ptgXZIvTNC/um9fAXFx+pEDqMjxgbMO0IAL/w7SVib2WNkkczPuA8cRELwkNQmLT/wNH
         YMgA4XhZECz4m6fLPwfekeJIRoMgCWP1HehToxoLwuTMdmLMB+CYJc97mbMxgGElrg1b
         XCsA==
X-Forwarded-Encrypted: i=1; AJvYcCXSDlsPn4u8ZWGUZhse3PWooUVQCJXMkFafuAtN4rYwmj3YBS//TnOSnvxtO25FGIRR1la2cXxfUlxowpZU@vger.kernel.org
X-Gm-Message-State: AOJu0Ywepqg6eFZKw9MvHY7C9ibEZMZSLu7noss473TJWm8nBC//hwa3
	P6at7N+oS0xVXjTNf1RB27t8jG2TuxrmdVs6+Y1NA6bPhldDPs3VyF5kg3/GoqyKFEq5gU0gabG
	PEIxHFw==
X-Google-Smtp-Source: AGHT+IGpK3dT6yAWIxou67i9tlvTd0f7lJrMQs/AvBbtqkyT1SFYDOL8PHqNi2SXNYe5wpLBo97TuQ==
X-Received: by 2002:a05:6402:1ece:b0:5cf:9f1:c53 with SMTP id 4fb4d7f45d1cf-5cf0a47612cmr512395a12.6.1731019759160;
        Thu, 07 Nov 2024 14:49:19 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb7fcasm1339547a12.52.2024.11.07.14.49.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 14:49:18 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99ebb390a5so481128966b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 14:49:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX6bOfP3/x1I3CspvRhdKcTYdyPgqJYPEJBgWT6O3qfTeIuYVv/2gal2WrEt6RteJVLjOEmi5LeOALrydzC@vger.kernel.org
X-Received: by 2002:a17:907:1c28:b0:a99:f209:cea3 with SMTP id
 a640c23a62f3a-a9eefeb2a17mr52320466b.11.1731019757065; Thu, 07 Nov 2024
 14:49:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
 <20241031-klaglos-geldmangel-c0e7775d42a7@brauner> <CAHk-=wjwNkQXLvAM_CKn2YwrCk8m4ScuuhDv2Jzr7YPmB8BOEA@mail.gmail.com>
 <CAHk-=wiKyMzE26G7KMa_D1KXa6hCPu5+3ZEPUN0zB613kc5g4Q@mail.gmail.com>
 <CAHk-=wiB6vJNexDzBhc3xEwPTJ8oYURvcRLsRKDNNDeFTSTORg@mail.gmail.com>
 <CAHk-=whSzc75TLLPWskV0xuaHR4tpWBr=LduqhcCFr4kCmme_w@mail.gmail.com> <a7gys7zvegqwj2box4cs56bvvgb5ft3o3kn4e7iz43hojd4c6g@d3hihtreqdoy>
In-Reply-To: <a7gys7zvegqwj2box4cs56bvvgb5ft3o3kn4e7iz43hojd4c6g@d3hihtreqdoy>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 7 Nov 2024 12:49:00 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgEvF3_+sa5BOuYG2J_hXv72iOiQ8kpmSzCpegUhqg4Zg@mail.gmail.com>
Message-ID: <CAHk-=wgEvF3_+sa5BOuYG2J_hXv72iOiQ8kpmSzCpegUhqg4Zg@mail.gmail.com>
Subject: Re: generic_permission() optimization
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Nov 2024 at 12:22, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> How about filesystems maintaing a flag: IOP_EVERYONECANTRAREVERSE?

It's actually just easier if a filesystem just does

        cache_no_acl(inode);

in its read-inode function if it knows it has no ACL's.

Some filesystems already do that, eg btrfs has

        /*
         * try to precache a NULL acl entry for files that don't have
         * any xattrs or acls
         */
        ....
        if (!maybe_acls)
                cache_no_acl(inode);

in btrfs_read_locked_inode(). If that 'maybe' is just reliable enough,
that's all it takes.

I tried to do the same thing for ext4, and failed miserably, but
that's probably because my logic for "maybe_acls" was broken since I'm
not familiar enough with ext4 at that level, and I made it do just

        /* Initialize the "no ACL's" state for the simple cases */
        if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR) && !ei->i_file_acl)
                cache_no_acl(inode);

which doesn't seem to be a strong enough text.

              Linus

