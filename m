Return-Path: <linux-fsdevel+bounces-20937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B048FAF85
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 12:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F721C2202A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 10:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3F91448E0;
	Tue,  4 Jun 2024 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="S3w8LXbq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A3712DD9F
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717495377; cv=none; b=Cb0YMozhAIgAX186jmrZWT4uvN4OVGDaB22jRS62X5iEOKtBU9NdS0TskFykMVIcYFRAG2uFO/ELiSDbt3/d0qVY/cpSBGJS4VneFM3wnSQAA3IrlgZqJFadnwoaC85tesSIEvGWB/cajjYiT0NjIrPSVmaDpfmP9gEVkVV0aY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717495377; c=relaxed/simple;
	bh=KmFXORb2yt5DuY/K2IoFpc+0VDLo4L9lk+l/JXxqBHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmFLvHqLvBNEz4t7+xigTc913yyvHnWqj4J0I27j7l+LmISCeguuhff8n4PWxX4W9p6pqMKGo8wLDLygyYwuuJzFZ4gnmxYYRgEvgfbjdS4qqCZux36DcT4lxz5JFVhT1Fyc2EM4uf4tDBkuzau8wmSRR/F6w8HDEWTwdBdDMao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=S3w8LXbq; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a634e03339dso588062166b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 03:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717495374; x=1718100174; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Le/ddYXHWhX53i9qIi9hulgRRWo7gp0FcrSDy4OJL6E=;
        b=S3w8LXbqp2dOuWm8GSbzRrjE/aVeq1ouhnVW1IC/4BDXEoEud5SOZ5s9+8C2DHKRpy
         DZT0k947t7MB3trmXZZ1jksFr3m3CsboeJBuodxBevpdfoDMukGSxauFGVBdDMkBJini
         Y1njkUVOfH2qqOGPkNKy0Cfo+D5f/YbCxuwPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717495374; x=1718100174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Le/ddYXHWhX53i9qIi9hulgRRWo7gp0FcrSDy4OJL6E=;
        b=TKBfS/s8hIlwEEhlHLXyFa7Y5AtQ2K9aURlMOf2miHc4UBnVPGeS5p+aH6AfGXtfqY
         HsxVWuS+fR7hxy4oOR0Raaz9XdgmQLq3L7ZJOyTLMd1lVxbe5qJRtzeMhFlt5VV6+AIv
         wWRSMNVPhZHkeW9w5RSnTr1/XHYCpNLzjmHgU6S1jD7/xngOo48CL6FTqcGRwoSrO0H4
         sCHj7GKhI42yetRtNuZpmy0XkdS4aDt6/eZHTvL6MLHrexbaaHd3iwgnU1yOxghv8zEE
         WTzqYmgh4oSatU9KkxPcNE264/xXyLVUz0FDZjvDUCWQhXI2RKsIZ0j4aVrd+tW5viDA
         sNXg==
X-Forwarded-Encrypted: i=1; AJvYcCVgh4ni2pJ7tr1GpT5EogxmkvJ0sVwfxXYxcNV6MOwZhYIUAfG3LA13uJ0ZNOTN3bZzn1/ILx/i/1F1OXbJbyKpVF/3XkU/AUHgcWQI3Q==
X-Gm-Message-State: AOJu0YwYRhesqzBRHICxPFAVqv9b8mpmTFGQR8ZAQ5Y21J2PcZw7YWis
	EKbH8h7D/A4YJ27VGJQp5hET2t8FYGodQUVLc2oPSM1iRLAItwXcFaVwJsrVMDMAsoODcg0rKGJ
	HSN5mLU2WBxxC0S6Xc36bZsFKRzvynLmNs1H1Jw==
X-Google-Smtp-Source: AGHT+IEydtpbcQ3+TaA0iWlzJhJL0iIGS1Jc2F5dm0s3zwbofudHPfZLYiJf5Va09F6m9a/kI80mbXTFZt5MKzATyJM=
X-Received: by 2002:a17:906:b0c6:b0:a67:7d34:3205 with SMTP id
 a640c23a62f3a-a68208fe45emr768858166b.35.1717495373577; Tue, 04 Jun 2024
 03:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <495d2400-1d96-4924-99d3-8b2952e05fc3@linux.alibaba.com>
 <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm> <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
 <bd49fcba-3eb6-4e84-a0f0-e73bce31ddb2@linux.alibaba.com> <CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZtwFeRuYw@mail.gmail.com>
 <ffca9534-cb75-4dc6-9830-fe8e84db2413@linux.alibaba.com> <2f834b5c-d591-43c5-86ba-18509d77a865@fastmail.fm>
In-Reply-To: <2f834b5c-d591-43c5-86ba-18509d77a865@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 4 Jun 2024 12:02:42 +0200
Message-ID: <CAJfpegt_mEYOeeTo2bWS3iJfC38t5bf29mzrxK68dhMptrgamg@mail.gmail.com>
Subject: Re: [HELP] FUSE writeback performance bottleneck
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, lege.wang@jaguarmicro.com, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Jun 2024 at 11:32, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:

> Back to the background for the copy, so it copies pages to avoid
> blocking on memory reclaim. With that allocation it in fact increases
> memory pressure even more. Isn't the right solution to mark those pages
> as not reclaimable and to avoid blocking on it? Which is what the tmp
> pages do, just not in beautiful way.

Copying to the tmp page is the same as marking the pages as
non-reclaimable and non-syncable.

Conceptually it would be nice to only copy when there's something
actually waiting for writeback on the page.

Note: normally the WRITE request would be copied to userspace along
with the contents of the pages very soon after starting writeback.
After this the contents of the page no longer matter, and we can just
clear writeback without doing the copy.

But if the request gets stuck in the input queue before being copied
to userspace, then deadlock can still happen if the server blocks on
direct reclaim and won't continue with processing the queue.   And
sync(2) will also block in that case.

So we'd somehow need to handle stuck WRITE requests.   I don't see an
easy way to do this "on demand", when something actually starts
waiting on PG_writeback.  Alternatively the page copy could be done
after a timeout, which is ugly, but much easier to implement.

Also splice from the fuse dev would need to copy those pages, but that
shouldn't be a problem, since it's just moving the copy from one place
to another.

Thanks,
Miklos

