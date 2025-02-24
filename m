Return-Path: <linux-fsdevel+bounces-42409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B19AEA42163
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 14:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49FC73B8202
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 13:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278C3248878;
	Mon, 24 Feb 2025 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZecWuJRU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDAA244190
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404191; cv=none; b=HVMljRAdLt0bTn+JCtL4JVBLG3X+GESyOpTarbsTtNnBuvqogcJoBOsKqtD2D6ezICP2lOyYZ8xubqF3uFUhLrQgaWaf/B9xygDrqXP1dBBmnpMZi1iyLaWScF2W6NAYDHi/5CEAvc40B2Js9g70SSPF6bLB4w+TDzMQUTQP6dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404191; c=relaxed/simple;
	bh=mQ/E9GJHlsbL+anTuSZ6BQz3/aW5axOVMMuBQiddEJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqdl5GeEJ1UQuxns1frBJuP+hjldG1Vjl5g1ASaVs43Js1XyNllqCkt3ksBXiIp9nFu5SNvwa9JEhUoscYXCHWjv8+7pNRZtvgnmBjHhZM9Pz1pppW4qFAplAaY6QCOlVwiDA65K9LlyEPsa7qi9nBua1cJocf/jvwM8G/lZalo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ZecWuJRU; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e660740061so39187096d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 05:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1740404189; x=1741008989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pX15D6Bceu4RJAPP2hZ7qecAD4Jjx++qSJOO1ZCwVUg=;
        b=ZecWuJRU7qxjiEFZR9/rkkxTLiAlum7vg/g3X/hgERSabO05RmqJ/ml3AhV9/Bjlfa
         D3dpi/otYOsTDTuP0ukQcm4iHmkMro8zMFvP8iS4oI1+vjQj9ff7X4Cct7yLeYwXiQ0x
         uZxWx+2p0Hel/LHU53vL72D/IqNJj+jKB572I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740404189; x=1741008989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pX15D6Bceu4RJAPP2hZ7qecAD4Jjx++qSJOO1ZCwVUg=;
        b=MaPD7qylJMvh4yEz87cguU4wt3VrFMnF3PzedsmBuZRJejqRUjQXUkcRETES7wkG/A
         QBzmNVBPuTxp7zvcW8JM53ziugrivigD6nlchvXgA5UEeRAfFlHovU71z2/64LyN41Ru
         81kHNBjWyd7/JWw1yVFkNbUSAVJ5PBPq+w0KVmfEaWzvVbv4rqQpKwE5KpUDKuwT3lui
         gUOb7yUAaTgjfGDpmcIgK7H47K2VnaiF3ql7SvkBl4PhdPhTXusBm5LpSc2Eln8cHgbJ
         YT7x+c7x4kVmWrEOxdta9IA9kXZE/HRlQliaIcXXUqLHG43XFZq6Id2OIydW+a711/5C
         6FCg==
X-Gm-Message-State: AOJu0YwGqiHQGxQvNEIBS5x8J0/MmB6qJbFBqT1gScIQLD8tRHmSWPYD
	tyqCinqmqN1GwTdooPIdaGtZutyaY2/44hbtujbRqrHcJabYRYX48h73w0Iz2+Re4Nc2+zpCZ+2
	Tp0wmj2mzpb456qR8NmQ65VGaCHXJtfGsBT3AAA==
X-Gm-Gg: ASbGncslWDqmpXEQ1FAHZLof0a88gHkCnuYBbTYaJeSUpLa1sQrQ9uo0UrRvqsdS+eF
	9qhV0eHvutH3KdA/kD3dAgQrbvM1zozUhCGsFPS9ldgFYh9Fz5hEIpsD//EP1csbX6HuCRLzpLo
	QHlkKAK/tR
X-Google-Smtp-Source: AGHT+IHEguL2LQC+mE/wN2ZbrNSS9mGqTel4hxm0Ns+rj0C3I1UDfr222KhMLimcBgeKtOSbiaXheQP3swC7hn9oWCc=
X-Received: by 2002:a05:6214:29e1:b0:6e6:61a5:aa4c with SMTP id
 6a1803df08f44-6e6ae98e884mr171019236d6.31.1740404188955; Mon, 24 Feb 2025
 05:36:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130101607.21756-1-luis@igalia.com>
In-Reply-To: <20250130101607.21756-1-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Feb 2025 14:36:17 +0100
X-Gm-Features: AWEUYZnExmcNkU3GwrJRJQ361As8l_tN3AphejCDo4zDTsYm2hrPSZCA-Nr8ou0
Message-ID: <CAJfpegsrGO25sJe1GQBVe=Ea5jhkpr7WjpQOHKxkL=gJTk+y8g@mail.gmail.com>
Subject: Re: [RFC PATCH v2] fuse: fix race in fuse_notify_store()
To: Luis Henriques <luis@igalia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bernd Schubert <bernd@bsbernd.com>, Teng Qin <tqin@jumptrading.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Jan 2025 at 11:16, Luis Henriques <luis@igalia.com> wrote:
>
> Userspace filesystems can push data for a specific inode without it being
> explicitly requested.  This can be accomplished by using NOTIFY_STORE.
> However, this may race against another process performing different
> operations on the same inode.
>
> If, for example, there is a process reading from it, it may happen that it
> will block waiting for data to be available (locking the folio), while the
> FUSE server will also block trying to lock the same folio to update it with
> the inode data.
>
> The easiest solution, as suggested by Miklos, is to allow the userspace
> filesystem to skip locked folios.

Not sure.

The easiest solution is to make the server perform the two operations
independently.  I.e. never trigger a notification from a request.

This is true of other notifications, e.g. doing FUSE_NOTIFY_DELETE
during e.g. FUSE_RMDIR will deadlock on i_mutex.

Or am I misunderstanding the problem?

Thanks,
Miklos

