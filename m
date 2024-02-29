Return-Path: <linux-fsdevel+bounces-13166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC43986C20E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 08:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672F1287B8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 07:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E05535BE;
	Thu, 29 Feb 2024 07:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QbwcDjEI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7187D52F60
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709191267; cv=none; b=FKwS7SsRB7lx9Kx66161KDuf3+sQJs1dgE1SS/phy7MiNcfnEjMXtgm02UsZ1ZRnPt150K/1jzy8Se7Mq8fWdse7vZJdXoID1OrI8niONj29XdoxulDGx4WgmR8goQ5ew91XC9YFrhqso1VmqtbBwkxpxm0vOsZwTwKSgzyXTKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709191267; c=relaxed/simple;
	bh=4BWkix83xa69Td6GkY4u4awSoBX+UEzZGygqWJSpHls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uN2DWfa9jJStMkKks/ulxDg6IQXOEBwAgvUtk0kRNv5by9UP2oyfX8LqxiYn/zJJUI463gi3cPMTBZzx/00nSI9NfdL9T6PpciqKREKhWkHYoYHl70VcPgnn1mid5jPYFOmF5Vi+LslHh8dkd+BVbiZEDGKGlkyO3cedUCv3nNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QbwcDjEI; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so2818700a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 23:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709191263; x=1709796063; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GEAakXwp+X35NpPg8nElFXY9Bau6mxbRPajKEZaxeiQ=;
        b=QbwcDjEIBITPcuAGwuwCtVwcMv0cKekSfml+cTZPU9Rc6ZfHlWkGX0fSaaEAk9dJ05
         ZBYaMinD3R5ZYewVb41lqDjQ/RIuVyV/8VddIj7igDBmQtN1EZ5zSGNxpc48modOTJ6c
         B8QdeqQdv3OhBLbwKuxEc+/CgtwccMnukvkUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709191263; x=1709796063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEAakXwp+X35NpPg8nElFXY9Bau6mxbRPajKEZaxeiQ=;
        b=q3Zuq1aDAfNei8v2DjV2VMkeMbeQQb2uYgSXcT1W1PFV5+z7Uj5rtsZTvlUl7Y+ICh
         cHgi80H5FcqWlVL0fJR3hcQaGaTbgwaNzyP7GfX3nVqYenteMUB8fy2erVElq6szTy6Z
         Wwe19Fw6mcrNa90I19PIXHI6fwK706YFeVKNmqgoAELGRYJiKHVwfAASswo4j48giUjB
         SnI8eeKOJeHuiS5vedhE0WLJLnnH6goIH4C3WGC3R2+rvVbR09K8+n/h7/Z559H1bZAT
         4lAZRbpfS13+OCL+/rIRLpP7EPnDW9h88p7hFIOaRbjVZwCUdfyIpFd0C9dxCew24ehG
         TTLA==
X-Forwarded-Encrypted: i=1; AJvYcCW9xFpHOEWG/gYZwZf7frYv8+IRSG+Q+tSXV0bvG54jOwzGjWhYe9mmZvsFWZMVXXbiS6h3CjEmFzDS+qvKEshfaRkYqAf64k+d6lZO2Q==
X-Gm-Message-State: AOJu0Yx1f1kVHOqeNtxegF0ZMutLjiPdu6bpV6CqTLsUE1Rjew6N6v2G
	rYJrMNQuaR1sqm/cxJLgs4mcZffFCkLXUkDx1pBkeVpt5g2uvRHO0cpheJbonCVAl85YVhUQ17x
	e9hj9Fg==
X-Google-Smtp-Source: AGHT+IEX2YQU/MRe9U4Ei4OUxplDc0wss+h6mBLHtgSChez2rbDTbUnl2XhuL5E/GYj+/jCkymR9Kg==
X-Received: by 2002:a17:906:3689:b0:a43:e812:fbc8 with SMTP id a9-20020a170906368900b00a43e812fbc8mr850823ejc.18.1709191263505;
        Wed, 28 Feb 2024 23:21:03 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id cx10-20020a170907168a00b00a3cf9b832eesm380599ejd.40.2024.02.28.23.21.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 23:21:02 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5655c7dd3b1so3194994a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 23:21:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgJduUI665/kBWQzfDh78cVZu/zWfCIqI9jGIFKfXSyRyeWn9fBzcAYCkGMDNohCfmfGW3TOQEK/xFUZs6R/zWaZ3unV73B31Z6WehSw==
X-Received: by 2002:a17:907:aa9:b0:a44:2cc3:2ba8 with SMTP id
 bz9-20020a1709070aa900b00a442cc32ba8mr685150ejc.27.1709191261969; Wed, 28 Feb
 2024 23:21:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229063010.68754-1-kent.overstreet@linux.dev> <20240229063010.68754-3-kent.overstreet@linux.dev>
In-Reply-To: <20240229063010.68754-3-kent.overstreet@linux.dev>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 Feb 2024 23:20:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=whf9HsM6BP3L4EYONCjGawAV=X0aBDoUHXkND4fpqB2Ww@mail.gmail.com>
Message-ID: <CAHk-=whf9HsM6BP3L4EYONCjGawAV=X0aBDoUHXkND4fpqB2Ww@mail.gmail.com>
Subject: Re: [PATCH 2/2] bcachefs: Buffered write path now can avoid the inode lock
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	david@fromorbit.com, mcgrof@kernel.org, hch@lst.de, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 22:30, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Non append, non extending buffered writes can now avoid taking the inode
> lock.

I think this is buggy.

I think you still need to take the inode lock *shared* for the writes,
because otherwise you can have somebody else that truncates the file
and now you will do a write past the end of the size of the file. That
will cause a lot of issues.

So it's not a "inode_lock or not" situation. I think it's a
"inode_lock vs inode_locks_shared" situation.

Note that the reading side isn't all that critical - if a read races
with a truncate, at worst it will read some zeroes because we used the
old length and the page cache got cleared in the meantime.

But the writing side ends up having actual consistency issues on disk.
You don't want to have a truncate that removes the pages past the end
of the new size and clears the end of the new last page, and race with
another write that used the old size and *thought* it was writing to
the middle of the file, but is now actually accessing a folio that is
past the end of the whole file and writing to it.

There may be some reason that I'm missing that would make this a
non-issue, but I really think you want to get the inode lock at least
shared for the duration of the write.

Also note that for similar reasons, you can't just look at "will I
extend the file" and take the lock non-shared. No, in order to
actually trust the size, you need to *hold* the lock, so the logic
needs to be something like

 - take the lock exclusively if O_APPEND or if it *looks* like you
might extend the file size.

 - otherwise, take the shared lock, and THEN RE-CHECK. The file size
might have changed, so now you need to double-check that you're really
not going to extend the size of the file, and if you are, you need to
go back and take the inode lock exclusively after all.

Again - I haven't thought a ton about this, so maybe there's some
trick to it, but the above is what my naive thinking says the rule has
to be. Writes are different from reads.

              Linus

