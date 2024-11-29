Return-Path: <linux-fsdevel+bounces-36125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B019DBFB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 08:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66941282002
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 07:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D3E156F57;
	Fri, 29 Nov 2024 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="i9GGtstV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B56155C9E
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732864593; cv=none; b=atWyd3EZil8xpTr+g/Xuk3WBWEp352nfMcL+qNiFh8tXcJ8XpBvixJKy/DqeSJMcxyb5igKZ1wmf1Z/3vyXoTuCZBUSRBnMcv2qj5AygMJyP5uUG8GKHb6xhH4pPFWj0cCh2sTTypHzS1hdSbJ4wDJ1oOn6M7nIko4WWkTERevk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732864593; c=relaxed/simple;
	bh=lLewrT5vgWaCVpuz2vLacBP/k5qrHd1JN5TKydWAm9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R150cQD4GT2b0k/WLXcNEoON/JcQEXK3uKiz3uMa9X7xkWMxbAMwxAQAqFqcJVYBP0R29yI5DPa4/pB9H2XHMbs6hrLYIh4CJ9h0V4gOQbzXCrdjk9CzthnROMi7BQn5VsKkAfOZjjtZH+SDFI+y10GcJ0Tp7dU7fFcJe1tNB9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=i9GGtstV; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-466a079bc5eso11881041cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 23:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1732864590; x=1733469390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QCgkmwh+SGn5VXba1qB7RBSIYtColJ1DkbNClBWoQ2c=;
        b=i9GGtstVUXrfnoggRUzvUJOK3kWH+fkvLvviuzOEoi1+c6wUK1gctiU5f8CF8ZVMRp
         ApoMrHe0KAbMXwu+YetZekTk7qy9zvbTQUIKY0ggpcPQJpRiCjOjYMbtuRPNp8gQLBoY
         bDcIpMCIfT3jAMBvyjZkFLmbyekdqVnw4UlFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732864590; x=1733469390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCgkmwh+SGn5VXba1qB7RBSIYtColJ1DkbNClBWoQ2c=;
        b=PQODYi6YjBDAvMowdA/1K0QvtWeJpGnXj1lNOSFvmyIjenbBItTxqAHPqDDAC3DMLa
         a/V/XEdLBD33LniezGghcL8rdkanD2JDjpwZm+iSkLd7gj4aefOdgJyUP9CH8+HK/xIv
         RINcnIhEoGKOMYgdwWCqM5Lev0crrwYGQJhLa+wa17YftaAALSlppBLNBpCdadE0k4O/
         7qtIxf0hlkue4hN6SKjQEuBUYDwDZJONfVoo2NHBCHd6vyEXlEALELtnPe5CVIH2GaE7
         QkWEc2N4LugWJHSlTE6l5vW8ZhvOnNxzwlwxT537I4r0U3kkcbjZT3lEtgZN4X6Kvmub
         3yFg==
X-Forwarded-Encrypted: i=1; AJvYcCUmUzDeZSfefes7MSEI1nwruXmwM+O64WQbCu1YBFg/K4M2wCHHR3J8k1rsMdhZE1q3Ibv/gmEMd+kaCc9C@vger.kernel.org
X-Gm-Message-State: AOJu0YwzeK1RyiCCrmBrdwglyIVG0jMmfj6Q1aYxxFd5ReoubmT9HAtI
	nZJ/nPzgEufPI/Gc/WdGRMFdiu9sqLFt5VX9gLl3pOjstbrGMy5doF0G63aoGttNhYrmjWf7hG8
	osvF683h2ZxkMxFZSsjNupBXsk8Ny7pHcOgXu9g==
X-Gm-Gg: ASbGncs4Wol9M5i6dgeZswaEdyiMaGwgjLbN48vHhD8nDR5X8jLYwPm/x/JSJqy5Rot
	dd+50vW61Rco2ddK7xtNAk+hKW3ImrErJRg==
X-Google-Smtp-Source: AGHT+IEbmDUG9V6EyPceMIpc5D0d8VIYgA7MNV7LRs5yzflj0xUuc8UcBpDoVoOFqo1ShwgiIwnHDslgrj9uhoQk5m0=
X-Received: by 2002:ac8:5f14:0:b0:466:a06f:adef with SMTP id
 d75a77b69052e-466b35264camr162344921cf.23.1732864590482; Thu, 28 Nov 2024
 23:16:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128144002.42121-1-mszeredi@redhat.com> <CAOQ4uxjAvpOnGp32OnsOKujivECgY1iV+UiBF_woDsxNSyJN_A@mail.gmail.com>
In-Reply-To: <CAOQ4uxjAvpOnGp32OnsOKujivECgY1iV+UiBF_woDsxNSyJN_A@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 29 Nov 2024 08:16:19 +0100
Message-ID: <CAJfpegvaq5LAF+z9+AUXZiR5ZB4VOPTa0Svb33e-Y8Q=135h+A@mail.gmail.com>
Subject: Re: [RFC PATCH] fanotify: notify on mount attach and detach
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 17:44, Amir Goldstein <amir73il@gmail.com> wrote:

> This sounds good, but do the watchers actually need this information
> or is it redundant to parent_id?

Everything but mnt_id is redundant, since they can be retrieved with statmount.

I thought, why not use the existing infrastructure in the event?  But
it's not strictly needed.

> If we are not sure that reporting fd/fid is needed, then we can limit
> FAN_REPORT_MNTID | FAN_REPORT_*FID now and consider adding it later.
>
> WDYT?

Sounds good.


> You missed fanotify_should_merge(). IMO FAN_MNT_ events should never be merged
> so not sure that mixing this data in the hash is needed.

Okay.

> I think if we do not HAVE TO mix mntid info and fid info, then we better
> stick with event->fd + mntid and add those fields to fanotify_path_event.

Okay.

> See patch "fanotify: don't skip extra event info if no info_mode is set"
> in Jan's fsnotify_hsm branch.
> This should be inside copy_info_records_to_user().

Makes sense.  I was wondering why copy_info_records_to_user() was
called conditionally.

Thanks,
Miklos

