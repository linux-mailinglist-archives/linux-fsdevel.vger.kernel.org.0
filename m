Return-Path: <linux-fsdevel+bounces-71705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F15CCE45B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 03:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B8BA3016733
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 02:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C86023C4F4;
	Fri, 19 Dec 2025 02:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iv/3YKUX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD46481DD
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 02:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766111502; cv=none; b=R3gHK+0q4let5fRzzSwbHC+sqn96KD9mwJFsHgl5zIagtD9Z6iTPUbtx1+2pWF5/mxpkdmZA23V62Hs0CuI3sigKkiCweCjvEW3woBNRKD5I1ZRtmzHS3lGjXdxdmSMo0W4ruvFptM9qBXKip3RYu4GGIqFgjIHvRnTm+Ds5ugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766111502; c=relaxed/simple;
	bh=80ua+D2RIvCPcXTVRwfsaPXe53yUh5Vxqmv+kgYV8HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZAvuf2s3LIYOxjz6/yw6N/KbmXM4JC/jvgCG0TyfLvXxN4kc+8XWXpSwreWpZSiCTojlheOUjBWQseUro/F/TqShVQ4D5ij+7hfvOU1Hc5PFJcwHaASMx661swO6FayTKSxQyH9dTysfJ2JXy2Oyi5w0QshpST2aVO6q/EzO7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iv/3YKUX; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4f1899960f0so13710031cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 18:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766111499; x=1766716299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s//N441lm6jH6EmR9jS1oCDzV4PumUKfa4KZaur//to=;
        b=Iv/3YKUX3QirMq+VPwhIZMForpJ4lUObvkVsOL6Y3m/HOgHFxCT6zB92k/uFJIhZdA
         SQLiOGqR/KdAiL9v1r6Vco+1dZ2LwYdNZMIPSb2wHNJC6L4co4Mq9x3Oe3/MvoCFmzvV
         iQwos6nLxHO73uB7XDU0KqsH9U+mLNv/LoNShhVWNwC2LK5E/fViOLaww1eXpRHAip7Z
         OAaAC/ZP/9sCMvJec3hiGSloY4WBwE3RUhiOCfx/s6QlltNW4xK05QD3b3wLCBGPPpxw
         wWD10btZRQWgkoxqjh2rxWtTkE10qXU8OjIAUWmX9Gg2PWkYUIDyk/QA2MV16wonYOdS
         siJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766111499; x=1766716299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s//N441lm6jH6EmR9jS1oCDzV4PumUKfa4KZaur//to=;
        b=RmGlmm+57uuNwOne56qX/KZGdSnz9waCFQjUM776twx47N04w4n/BR7wbZSsxRHywM
         fcD5pnp9uwUVyODGqn8vn5kX6/Y3ejbDXz6E1tWhrjcjLcUAphRoeqlrgZW6f6bKM8h+
         KrxDH2Tdxhgn90SYHiOC9/MIk85Ez3Q/H84Gz07lJGab3uaoSz8/WENSmgLmZxye2h0e
         aD9zWbVEbbNFli+FffWBLs9ERN2w5rCWjil15HZ13+fu/diRlBT3oHe9LzAX75JKSEoz
         X5c47ydbowW1F3ZCiqRrHeUljyoagnlo3D/2R6xDAsdIajTx7fx/PpsR+xvzw9PFSXZr
         BmSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKNKhHf8G9NpD4MceIV1+jbuZg8cTd6qEw46H6iGZDvOn1Pv0XTeP0vcpxqcbYVR9gLXamfe+n00Y8etGb@vger.kernel.org
X-Gm-Message-State: AOJu0YzO90ceJdRgV7EOAzkU1NrbOqYWHpC1plLq52ag6Z8Iffzi4lXo
	GE8QN003M9Mk828RnaDPAt0tl+LjqJVfyXWFi6oTRqBVU84yrn7u+3beR25/BJouFC9mBdfZXGD
	0omuIonvSzpiNuDSRsgl5OVzn3MJ4d5k=
X-Gm-Gg: AY/fxX5rL9sP7ynZSejdC+448tTUJvzXm1Bl+mGI+7811DGaR35kHRMFDp4/54b/J7I
	DUNcvjjrlRu8O+60vjMJ24DOd7qUHSm2q7uc1IMnVViObtYcwpxDB5BjVflKv18cTmkqR/VZyG+
	Ftcnye/3j3RaN9vVLJFIJySjNmbaUnFPeBsqF8M6JnOmKqtC5MO/ZiSMU77qikLhTV7xCdBL4Ta
	moNx/0GZ60yjT+CyhLkpC7lxcCIOqZP06WbI6aaQ0ZEoFEVK0o2F+nbJF1/gRjgcooTov1RZkL+
	zUAz76yk2AA=
X-Google-Smtp-Source: AGHT+IHXEBT8Qm36Ez+9xaJ9V7MUqLAih0uxJQh6Y+Uofc8XIsPDlW1Z8j5x3GGujiztv80SsFvQTPB3eZG6aXNEZpo=
X-Received: by 2002:a05:622a:1e8e:b0:4f3:5889:2a79 with SMTP id
 d75a77b69052e-4f4abdcb97amr20315031cf.81.1766111499161; Thu, 18 Dec 2025
 18:31:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112083716.1759678-1-abhishek.angale@rubrik.com>
 <20251217135646.3512805-1-abhishek.angale@rubrik.com> <20251217135646.3512805-2-abhishek.angale@rubrik.com>
In-Reply-To: <20251217135646.3512805-2-abhishek.angale@rubrik.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 19 Dec 2025 10:31:28 +0800
X-Gm-Features: AQt7F2q3soHPHTmwec9YGk2esBaxzm0HplPKIY8Je6IoOtAr8n_jFmOP_DYtsDc
Message-ID: <CAJnrk1Yi-_x6w0f7w=xRBT7s4SDEJKcTm_f-hCZjdyBVtvxCzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fuse: wait on congestion for async readahead
To: Abhishek Angale <abhishek.angale@rubrik.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, Anna Schumaker <anna@kernel.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, NeilBrown <neilb@ownmail.net>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 12:23=E2=80=AFAM Abhishek Angale
<abhishek.angale@rubrik.com> wrote:
>
> Commit 670d21c6e17f ("fuse: remove reliance on bdi congestion")
> introduced a FUSE-specific solution for limiting number of background
> requests outstanding. Unlike previous bdi congestion, this algorithm
> actually works and limits the number of outstanding background requests
> based on the congestion threshold. As a result, some workloads such as
> buffered sequential reads over FUSE got slower (from ~1.3 GB/s to
> ~1.05 GB/s). The fio command to reproduce is:
>
> fio --filename=3D/<fuse mountpoint>/file.250g --rw=3Dread --bs=3D4K \
>     --numjobs=3D32 --ioengine=3Dlibaio --iodepth=3D4 \
>     --offset_increment=3D1G --size=3D1G
>
> This happens because FUSE sends requests up to the congestion
> threshold and throttles any further async readahead until the
> number of background requests drops below the threshold. By the time
> this happens, the congestion has eased and the disk is idle.
>
> To fix this problem and make FUSE react faster to eased congestion,
> block waiting for congestion to resolve instead of aborting async
> readahead. This improves the buffered sequential read throughput back to
> 1.3 GB/s.
>
> This approach is inspired by the fix made for NFS writeback in commit
> 2f1f31042ef0 ("nfs: Block on write congestion").

Hi Abhishek,

How does this perform on workloads where there's other work
interspersed between the buffered sequential reads, or on random/mixed
workloads where readahead is triggered but not fully utilized?

To me, the difference between this and the nfs writeback fix you
mentioned is that writeback seems fine to block because it happens in
the background thread and wouldn't block the application thread,
whereas readahead happens directly in the caller's path. It seems to
me that for these workloads the currently existing behavior is much
more optimal.

I'm also concerned about how this would affect application-visible
tail latency, since congestion could take a while to clear up (eg if
writeback is to a remote server somewhere).

Thanks,
Joanne

>
> Signed-off-by: Abhishek Angale <abhishek.angale@rubrik.com>

