Return-Path: <linux-fsdevel+bounces-3550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC377F6433
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 17:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3651C1F20DD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 16:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F4E3FB1F;
	Thu, 23 Nov 2023 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EfWDUK6w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F09D7D
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 08:41:57 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9e1021dbd28so138885766b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 08:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700757715; x=1701362515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hrJOVqWZyXV3tJNMbwk0Hktw++SEqtTU6CT36WDZi5A=;
        b=EfWDUK6wEttvnkRF1yPhC2U0mY/VhEYFlqf/Gr29i7TYv+QH134Jm0NA1MclDZcGSw
         SxFQfpUOgfnONqhd7EoiVXkNr1ApW67paO0/oqNoaxcVwWfysnG7xqVJ+B9dA8XPm7Ab
         9tyWV3pARXbHmtxS/zQZYtroATPEH3XaDksdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700757715; x=1701362515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrJOVqWZyXV3tJNMbwk0Hktw++SEqtTU6CT36WDZi5A=;
        b=DzN+BYazFWadcoB0Pqa9xon6K7jEwYU9KrnRW3+QsSMMzDgSM1juivoNE5El5KJPfh
         d7nXQ+uaQlj3WlcKkFANui3BMunt51J5bnjqBDzMQcWgjjYbMvAXavK2Mg7rt/s38XnU
         ljZXW4+YMJXLKlmjzfv9RIXHMULTjBr84s6ac4YblcMmbmvnZ1XR2pNs08wDpeaWmuvP
         AoP3Q89oLforfOwa3DmIvsdIxABvo4sMxXB5Pw0SQCFJmON/iWqtKDeBRM3LLv9tH2Vf
         6l1hMJLelst57ZPflUUEp6PAl6O+rRHPbZCMjdOBDOh4y6NpI2hEembyaP1TdUzFw961
         zHxA==
X-Gm-Message-State: AOJu0Yy5LpJ4+3MXHCCHK96Kqsl3JwipCeyoFlozcpSeYySY/fo82gb5
	XjaxFFgle1Gsp2mNLl+ZDQ/1Dt3NgQxpw65tOQIPzc1d
X-Google-Smtp-Source: AGHT+IG15Yv2mtUUU6VsARv0WxWeqHCi3UdF6sUQA8HkfEMwBcmmCNjrraTQ1cJqz8T1BiJTdntXOA==
X-Received: by 2002:a17:906:20d8:b0:a01:c0c6:1413 with SMTP id c24-20020a17090620d800b00a01c0c61413mr3856882ejc.12.1700757715123;
        Thu, 23 Nov 2023 08:41:55 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id j27-20020a170906255b00b009e5db336137sm978447ejb.196.2023.11.23.08.41.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 08:41:54 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-548f74348f7so1537375a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 08:41:54 -0800 (PST)
X-Received: by 2002:aa7:dcc4:0:b0:548:a0e8:4e51 with SMTP id
 w4-20020aa7dcc4000000b00548a0e84e51mr4040787edu.39.1700757714239; Thu, 23 Nov
 2023 08:41:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816050803.15660-1-krisman@suse.de> <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
 <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner> <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121022734.GC38156@ZenIV> <20231122211901.GJ38156@ZenIV>
 <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com> <655f7665.df0a0220.58a21.e84fSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <655f7665.df0a0220.58a21.e84fSMTPIN_ADDED_BROKEN@mx.google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Nov 2023 08:41:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgADgC_+Nmamrzei7JpRDa7ugvP8P_8zS2VxB5ksF9Khg@mail.gmail.com>
Message-ID: <CAHk-=wgADgC_+Nmamrzei7JpRDa7ugvP8P_8zS2VxB5ksF9Khg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, tytso@mit.edu, 
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org, 
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Nov 2023 at 07:57, Gabriel Krisman Bertazi
<gabriel@krisman.be> wrote:
>
> The problem I found with that approach, which I originally tried, was
> preventing concurrent lookups from racing with the invalidation and
> creating more 'case-sensitive' negative dentries.  Did I miss a way to
> synchronize with concurrent lookups of the children of the dentry?  We
> can trivially ensure the dentry doesn't have positive children by
> holding the parent lock, but that doesn't protect from concurrent
> lookups creating negative dentries, as far as I understand.

I'd just set the "casefolded" bit, then do a RCU grace period wait,
and then invalidate all old negative dentries.

Sure, there's technically a window there where somebody could hit an
existing negative dentry that matches a casefolded name after
casefolded has been set (but before the invalidation) and the lookup
would result in a "does not exist" lookup that way.

But that seems no different from the lookup having been done before
the casefolded bit got set, so I don't think that's an _actual_
difference. If you do a lookup concurrently with the directory being
set casefolded, you get one or the other.

And no, I haven't thought about this a ton, but it seems the obvious
thing to do. Temporary stale negative dentries while the casefolded
bit is in the process of being set seems a harmless thing, exactly
because they would seem to be the same thing as if the lookup was done
before...

And yes, that "wait for RCU grace period" is a somewhat slow
operation, but how often do the casefolded bits get changed?

This is not a huge deal. I don't hate your approach, I just found it surprising.

                 Linus

