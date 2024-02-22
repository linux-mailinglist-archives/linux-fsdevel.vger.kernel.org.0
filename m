Return-Path: <linux-fsdevel+bounces-12439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB8F85F597
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 11:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03CA71F2461F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 10:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354453D3A4;
	Thu, 22 Feb 2024 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="WnfM+8S3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C460039FDC
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597527; cv=none; b=DO1UQEaootgAreisTqML/sbx22uA1PsL5hzAkWnBrqkh+K1cBejkHwN3pcfYNXoYPcaAtQ97N2avZt6rkoextBLJWUSo9LL09GYBwOFjh57vLOM6/E3Rz+gxKy3KdvP1P3wVCFWQDV7p5dEuINio9HGBpBoEBEwOwKRSm2HDVjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597527; c=relaxed/simple;
	bh=Q13FOxl27CAz/cOTAlE9oo3H7aFDqQ5nK/tKyITOrFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5+SM1rTHN4xvdKamOeMhwNNp7PmlcEv2GjjgGUbUTC3a52QO92Co6p3tHmx/fRotXIa+HxSN83cT+cKaMuABz/Udkfm8eIG3PSIociF47NHOSOVawzegd24yAWr0WAXZMRrTxBZzP5hn9SBVEb2zdd7t+ZB2+YEvX1rIBUd3V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=WnfM+8S3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3f48422fb6so234364566b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 02:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1708597524; x=1709202324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LyfCMikxUhIuPNypfCt5bvQkByB+IHG2Wh6701iMNSM=;
        b=WnfM+8S3I+Dr88qLq4kCqj+X036LnuGPezrubt0xQ9wK+cM6RD/dS1U1Ai60s/2fgA
         Lst5hinMbtZOpeJLhoLOIjsvrBoHsE49GHWOC16Okii0zw8JMqg5Sta+AJAZLqOM4BXN
         lduMk3X/a164Ri8zqfbY1YEQ0kpQ0+mykI8lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708597524; x=1709202324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LyfCMikxUhIuPNypfCt5bvQkByB+IHG2Wh6701iMNSM=;
        b=Xrq4UQFfM1n5Rp9o7rdUFtKrZtOpzMxVNPYs8fXUUW446QZHPE9bWE9K+hT323Gg4N
         Qz+CRZ9WoqBYuBY8mJngJ4wbR5mlJW9fb/PyK1eLswhgcdmABuzn9uJ5ua3gIO1sNg0h
         IIJ+Q7i463Fqgt64B4D7FwOuuFtY2feHvdLWGZKKrsJFhWlBjnm/lSWpcJW2bGLF+BrD
         Zc200A4jcVAe/jDs1nYResvMyDFK9wVHT0MyyzocsHoKsBTdNIb6GtGtHSzXJpNW4Eg0
         LpgX9DtPUgDT04Jto6WaKxJIggRWVrb7PgQWyoBna1jDY7LaoYY1yIRfP7DdEOe0+RnV
         HHow==
X-Forwarded-Encrypted: i=1; AJvYcCVHyjGditlQj0YUrnJXwO+heBuL3hhcy95W0m6fdswUsPhslFzlZuL2sYzln1qDSnOrjFBOUzwa4qCx12rzDkVq5E2wElrZ3a9/7FWptg==
X-Gm-Message-State: AOJu0YyMcm/58Qrbm90vK2Ghrw9SxwIxRNCcx0oGBdJyCZnJ3VmcU2MO
	X/FjGGCCp8RlMS3e33XLV5q3QQpvNEAuu4/g/8eksf7TapI/AM0oP4SksdZTirhvfkhH92cX7r9
	x3MU2NNdfJeauSXy/UwOxTUOfLDzqSNAkHtG+9Q==
X-Google-Smtp-Source: AGHT+IGhZ6qvSWLNcOGjEpamFEzkA4AOa+ciP3VrCmvGNu7ABvFqOlp6DSlpe9k3SjFuI7QnlREU28iTFKQjuDGZnvM=
X-Received: by 2002:a17:906:cc83:b0:a3f:52dc:6a21 with SMTP id
 oq3-20020a170906cc8300b00a3f52dc6a21mr2403270ejb.14.1708597524017; Thu, 22
 Feb 2024 02:25:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq>
 <CAJfpeguBzbhdcknLG4CjFr12_PdGo460FSRONzsYBKmT9uaSMA@mail.gmail.com>
 <20240221210811.GA1161565@perftesting> <CAJfpegucM5R_pi_EeDkg9yPNTj_esWYrFd6vG178_asram0=Ew@mail.gmail.com>
 <w534uujga5pqcbhbc5wad7bdt5lchxu6gcmwvkg6tdnkhnkujs@wjqrhv5uqxyx>
In-Reply-To: <w534uujga5pqcbhbc5wad7bdt5lchxu6gcmwvkg6tdnkhnkujs@wjqrhv5uqxyx>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Feb 2024 11:25:12 +0100
Message-ID: <CAJfpegtxv3Omm3227c-1vprHYVTd1n3WoOxDKUSioNSP5pdeGw@mail.gmail.com>
Subject: Re: [LSF TOPIC] statx extensions for subvol/snapshot filesystems & more
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lsf-pc@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 10:42, Kent Overstreet <kent.overstreet@linux.dev> wrote:

> Yeah no, you can't crap multiple 64 bit inode number spaces into 64
> bits: pigeonhole principle.

Obviously not.  And I have no idea about the inode number allocation
strategy of bcachefs and how many bits would be needed for subvolumes,
etc..   I was just telling what overlayfs does and why.  It's a
pragmatic solution that works.  I'd very much like to move to better
interfaces, but creating good interfaces is never easy.

> We need something better than "hacks".

That's the end goal, obviously.   But we also need to take care of
legacy.  Always have.

> This isn't a serious proposal.

If not, then what is?

BTW to expand on the st_dev_v2 idea, it can be done by adding a
STATX_DEV_V2 query mask.

That way userspace can ask for the uniform stx_dev if it wants,
knowing full well that stx_ino will be non-unique within that
filesystem.  Then kernel is free to return with or without
STATX_DEV_V2, which is basically what you proposed.  Except it's now
negotiated and not forced upon legacy interfaces.

The other issue is adding subvolume ID.  You seem to think that it's
okay to add that to statx and let userspace use (st_ino, st_subvoid)
to identify the inode.  I'm saying this is wrong, because it doesn't
work in the general case.

It doesn't work for overlayfs, for example, and we definitely want to
avoid having userspace do filesystem specific things *if it isn't
absolutely necessary*.  So for example "tar" should not care about
subvolumes as long as it's not been explicitly told to care.  And that
means for hard link detection if should using the file handle +
st_dev_v2 instead of st_ino + st_subvolid + st_dev_v2.   So if that
field is added to statx it must come with a stern warning about this
type of usage.

Thanks,
Miklos

