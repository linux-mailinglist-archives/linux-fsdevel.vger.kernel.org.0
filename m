Return-Path: <linux-fsdevel+bounces-3499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163707F5537
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 01:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50CE281721
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 00:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FC6A3B;
	Thu, 23 Nov 2023 00:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EJky0xgk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC361B2
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 16:19:17 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5094727fa67so411425e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 16:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700698756; x=1701303556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/KrFqq6blt1lo7Kf9Cf57uU43ncdJqUq9kktaS62s5k=;
        b=EJky0xgk2GYWbBh5GeWhNGifrsZa+aw6znG5la1SOCQqVEpkEb4v3IMKgb+hdQcmVq
         7Ds/LPPcA9aWIVl5flUrRux+cXotIZ/8kAtSq7t1TCEVJdtK1HiF3/gmfp5Arc/Hg4Qz
         O2P35VKdqIRcGI7YCIB+IdXqXpDDUzhMHcJhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700698756; x=1701303556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/KrFqq6blt1lo7Kf9Cf57uU43ncdJqUq9kktaS62s5k=;
        b=t0DNHN1dbOE64Kt8ey9+bQHFhFkhUwo3FEkH8UoAyQJdBkJ4HbG4uOXHKPsYSKj1Py
         j2JE7SptNocuCaEdoCaiHUXhBt1Uckjh5rin5v97pWvdtCqjYhVzvIPgs3C/ud9Fwwrw
         kW7t6lYWH3Np6nG5AM3H89pmc4kxBF4lOBxw4oV0O5wpNIQ/1gUHmSjTphTkXKfPB8bW
         mWHMgaYMNu6dtaEcYdUsOwcX5fWznijvFeGNe2EV12FPJB6JHoQyrMOwvOsM3qV6tk4j
         FbLrGgLXRKhSUVVonboMc/4obYM3NpLqWhgX0j0T21UyUwUomsyb7XFbVcLCXnGhb49B
         smKw==
X-Gm-Message-State: AOJu0Ywk1ErRdfasF745OWVjqTM+oz8aUGFPpSUkzuGW8KRJf24751a4
	/xIvCl5gGx73Co1Faty2C0YfThOwb7VxvmNsLFUYhvp6
X-Google-Smtp-Source: AGHT+IFI0Hqu2+3+dO4wp8UCflaAuFBaiPO3oed123aKWfOD3byYee17c0+/1xfJ+U0awZC7niFBSA==
X-Received: by 2002:ac2:5110:0:b0:50a:6f8a:6461 with SMTP id q16-20020ac25110000000b0050a6f8a6461mr2414425lfb.58.1700698755582;
        Wed, 22 Nov 2023 16:19:15 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id d9-20020a50fe89000000b00544f8271b5fsm38349edt.8.2023.11.22.16.19.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 16:19:14 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5480edd7026so478470a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 16:19:14 -0800 (PST)
X-Received: by 2002:a17:906:cc:b0:9fe:3447:a84d with SMTP id
 12-20020a17090600cc00b009fe3447a84dmr2475163eji.23.1700698754069; Wed, 22 Nov
 2023 16:19:14 -0800 (PST)
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
In-Reply-To: <20231122211901.GJ38156@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Nov 2023 16:18:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
Message-ID: <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Gabriel Krisman Bertazi <krisman@suse.de>, tytso@mit.edu, 
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org, 
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Nov 2023 at 13:19, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> The serious gap, AFAICS, is the interplay with open-by-fhandle.

So I'm obviously not a fan of igncase filesystems, but I don't think
this series actually changes any of that.

> It's not unfixable, but we need to figure out what to do when
> lookup runs into a disconnected directory alias.  d_splice_alias()
> will move it in place, all right, but any state ->lookup() has
> hung off the dentry that had been passed to it will be lost.

I guess this migth be about the new DCACHE_CASEFOLDED_NAME bit.

At least for now, that is only used by generic_ci_d_revalidate() for
negative dentries, so it shouldn't matter for that d_splice_alias()
that only does positive dentries. No?

Or is there something else you worry about?

Side note: Gabriel, as things are now, instead of that

        if (!d_is_casefolded_name(dentry))
                return 0;

in generic_ci_d_revalidate(), I would suggest that any time a
directory is turned into a case-folded one, you'd just walk all the
dentries for that directory and invalidate negative ones at that
point. Or was there some reason I missed that made it a good idea to
do it at run-time after-the-fact?

             Linus

