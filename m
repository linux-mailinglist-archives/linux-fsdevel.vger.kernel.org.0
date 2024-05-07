Return-Path: <linux-fsdevel+bounces-18890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB008BDFF0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 12:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4960B28A07B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 10:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4FB14D6F6;
	Tue,  7 May 2024 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="B1nGfjxu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06077828B
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078466; cv=none; b=jMbOzI9eUtf/b98zZAjzPwRSVAdE9lqqqWR2Uvc68ea5ukKLHiJpA9oNoM/RKtuGc+LlJOlTikXa6g/J/bKzN7wcoisqopp4ZSfnOGU+0aseB4z0s6LkYav2YdV0abtPjW1E1nNCLYEhWHuHaowErg7iGOJQafN/13p7ptKuWI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078466; c=relaxed/simple;
	bh=EKAiI+ZlLc1pqfxaMWgZOurTLkeJ76AqMwSFltjADeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHqM2vYUS6YYKVv/mOHkWp1kFUF+Gmi9zsHxVPf9BfvCFirgUTdvKxAgQ4BCnTNJHc4mW0TCK2/YyLOHMMkzEBqXnG8IK5S7lhXBacr5aa29so+x7Nz+P0drroB86Xqa1WXgy/Yn94ZnxUgli+MkOF59IjY6h3ywgGY7T/FX6qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=B1nGfjxu; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34e6aaa4f51so372593f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2024 03:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1715078462; x=1715683262; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0hSlbkkH0RQlXAU1X1dSoZPgHGX61BgsqrXQhyEDSAE=;
        b=B1nGfjxunFxUpwR24sdrL7Sg9PTjNAkrwXENeAyGJwdIKI3LrIzug+86rshJK1oABo
         Ba1vlLSDSkOugiJTX9sTTvRLdZC8fjxR04DygNEA/OTAWr6A/Dmr3VUmrsHmfP2przpX
         ZyOBDqK/FeDDnCLIhxq/llDvbf7SL5nwHllKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715078462; x=1715683262;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hSlbkkH0RQlXAU1X1dSoZPgHGX61BgsqrXQhyEDSAE=;
        b=EoCPlumVnl33B2UX6sTOw8KZpZsus+YmgDIvsQKKCE0gGs/mLB7oSrCNwkxxRBaZkV
         hPU8c+jniigl0xkecpLz4Nzy/WGWiJkt1Z+Hu83I4ZOoFlAWZBQtlpaRXQMXcUwLIzBS
         9OYuEo08zkNb3pgY9mDw3KeuC9ZY0C6ZhvsTHD3YapualZUyfULI5kWsFHGIvsg0dd10
         mrI1YnxzTwaDDRRVAUPuDvsBNHLtQ7dVjlvWFzU/q6cjpftwaALA8hWdvWo57yqwS2fm
         YdwCfo18p5CxsRhYeXVovkisC48LExVHl5HfI6tSDJGwvcvs7QEc1bU4oUuU7tmqwIYR
         tY1A==
X-Forwarded-Encrypted: i=1; AJvYcCXw+j9EBdDyqEnei63ZjVNGPm192zfBYlI8i9Y4t9YSfd4ny21AoIziVCybBitq8jsixPwLm0MkqXmzK6XaEMvFFBxg+QPtImNfvSkMkw==
X-Gm-Message-State: AOJu0YzxgjoF9MrxgP19vK3yaEAR9P7qYPO5lKhA8O7Xp/oxhrv5yONe
	8O+BK5f9UNgAn0Sus/tkA2Tcjsi1g4rAOYDhO1oW8exgoDpVT4cI1BFly7TfILE=
X-Google-Smtp-Source: AGHT+IG2AAi7gOGQ+Sp+LWwfE0gNhj/CmpgLDACrQuZ6JTyFoqk4XnFfNnBaU/No4joOOaHM6+5IvQ==
X-Received: by 2002:a05:600c:1c2a:b0:419:f68e:118c with SMTP id j42-20020a05600c1c2a00b00419f68e118cmr9117779wms.1.1715078462174;
        Tue, 07 May 2024 03:41:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f4307ded2sm7253905e9.0.2024.05.07.03.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 03:41:01 -0700 (PDT)
Date: Tue, 7 May 2024 12:40:59 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Dmitry Antipov <dmantipov@yandex.ru>, lvc-project@linuxtesting.org,
	dri-devel@lists.freedesktop.org,
	"T.J. Mercier" <tjmercier@google.com>,
	syzbot+5d4cb6b4409edfd18646@syzkaller.appspotmail.com,
	linux-fsdevel@vger.kernel.org, Zhiguo Jiang <justinjiang@vivo.com>,
	Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Subject: Re: [lvc-project] [PATCH] [RFC] dma-buf: fix race condition between
 poll and close
Message-ID: <ZjoFOwPt2vTP1X-x@phenom.ffwll.local>
References: <20240423191310.19437-1-dmantipov@yandex.ru>
 <85b476cd-3afd-4781-9168-ecc88b6cc837@amd.com>
 <3a7d0f38-13b9-4e98-a5fa-9a0d775bcf81@yandex.ru>
 <72f5f1b8-ca5b-4207-9ac9-95b60c607f3a@amd.com>
 <d5866bd9-299c-45be-93ac-98960de1c91e@yandex.ru>
 <a87d7ef8-2c59-4dc5-ba0a-b821d1effc72@amd.com>
 <5c8345ee-011a-4fa7-8326-84f40daf2f2c@yandex.ru>
 <20240506-6128db77520dbf887927bd4d-pchelkin@ispras.ru>
 <eb46f1e3-14ec-491d-b617-086dae1f576c@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb46f1e3-14ec-491d-b617-086dae1f576c@amd.com>
X-Operating-System: Linux phenom 6.6.15-amd64

On Tue, May 07, 2024 at 11:58:33AM +0200, Christian König wrote:
> Am 06.05.24 um 08:52 schrieb Fedor Pchelkin:
> > On Fri, 03. May 14:08, Dmitry Antipov wrote:
> > > On 5/3/24 11:18 AM, Christian König wrote:
> > > 
> > > > Attached is a compile only tested patch, please verify if it fixes your problem.
> > > LGTM, and this is similar to get_file() in __pollwait() and fput() in
> > > free_poll_entry() used in implementation of poll(). Please resubmit to
> > > linux-fsdevel@ including the following:
> > > 
> > > Reported-by: syzbot+5d4cb6b4409edfd18646@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=5d4cb6b4409edfd18646
> > > Tested-by: Dmitry Antipov <dmantipov@yandex.ru>
> > I guess the problem is addressed by commit 4efaa5acf0a1 ("epoll: be better
> > about file lifetimes") which was pushed upstream just before v6.9-rc7.
> > 
> > Link: https://lore.kernel.org/lkml/0000000000002d631f0615918f1e@google.com/
> 
> Yeah, Linus took care of that after convincing Al that this is really a bug.
> 
> They key missing information was that we have a mutex which makes sure that
> fput() blocks for epoll to stop the polling.
> 
> It also means that you should probably re-consider using epoll together with
> shared DMA-bufs. Background is that when both client and display server try
> to use epoll the kernel will return an error because there can only be one
> user of epoll.

I think for dma-buf implicit sync the best is to use the new fence export
ioctl, which has the added benefit that you get a snapshot and so no funny
livelock issues if someone keeps submitting rendering to a shared buffer.

That aside, why can you not use the same file with multiple epoll files in
different processes? Afaik from a quick look, all the tracking structures
are per epoll file, so both client and compositor using it should work?

I haven't tried, so I just might be extremely blind ...
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

