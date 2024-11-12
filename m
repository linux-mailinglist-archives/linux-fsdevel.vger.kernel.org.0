Return-Path: <linux-fsdevel+bounces-34494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7174F9C5F7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 18:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3730D2845FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 17:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B99E2141A4;
	Tue, 12 Nov 2024 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="JcjeBB9J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871DB212F05
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 17:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731433894; cv=none; b=p7hB07U4EPLHoHTU/5HRJmFYjc4VqMokLj3fjyFWI7iDjkgA59HCFugabjqty0quBi5BXFb8ZwvV2JZYlYh+fPxdjNwyw3AMEc1qeLkJAVeeLvxeEEvx3HryTaan2OCSHYh2cbjaRIWVGdTyVh95awKqtqA1MgmDz5imPxWbtz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731433894; c=relaxed/simple;
	bh=MD20xtr08ASAShkZJ/SiEeacv8NuBjRp2s6hjqiONvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZe0/30XXHGhobIpxLzz5r9mgb7EKcNOVgDjrrpw6gtqxWfrZ9W+cYPYoYPPXEfkyCrGPPtPYtHiH/K5xiXusgenhb+OtlyQN42/sWfYpWWaJrF1lhYkoxZIGvJ6i17FHsNlD7BdHhZ+nW6EUNqLO8qzWwf9YdHLSqU/rvtHpRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=JcjeBB9J; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6eca7391be2so11019047b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 09:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731433891; x=1732038691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0a2xcjcKeQjSbt4z24XLQy0BplrS72X/6Q6PWx5aRlc=;
        b=JcjeBB9J5AguigNl+boQknRAd/kbUHKtz0dYNc/wSAFfQ+c8FsSubEI65SQl/n4p2m
         CFv4iZ/1S7iks1yZlkQRa5w+pQrrfKA2vNClWSM55qNnkP04Rf4S1XZ/Eoql+Ar7Fhxr
         nZw6+qtFwmH3wIJ6NQNHQTZ5YpjoyKBfbjsrpRey0KZi5pHPHEsC4XIVP/UQ5OmpYWqL
         vCx+LGhKF5OgN839bL+AZ6p+IW1uaVJFfpBydBxQRFSsVdU+cK6YzqnCBmv9BMI4+aJj
         f2jw+1h9zp1v2mzgwIIPBYhjy3MWsRfeXgH5pT8dEJTpgjwHyJQLbDvm/qxfhDhcDuG4
         ZBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731433891; x=1732038691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0a2xcjcKeQjSbt4z24XLQy0BplrS72X/6Q6PWx5aRlc=;
        b=qhZni8oVp8qQCeJLb0ic0/uj1myM+VKj1so1O8zCirTIMdONa+7W+NHe3Ptvj3J5PB
         /dgEoI12U0o2xQRQSu3j0XLxJL8gbYCGTU/r166KOynUcTPT9xDq16Wg4oEs9lZT0wbR
         8Y4JvlmwN2r+8ZvU337PnQlmEd2EvptBaaZE/IZqr4D9GmtExai3lFKL0XjJpMrAGbvd
         o7kPrrwO0tsetxhCqj7do7qcPNxvBUmKxq6vpecWNj2jcVgF5CKXJyMkn4HLXii9b1xV
         elIdx8OMTq9wBTLIIysVWhv/K9A6JueH+bIsqNohhAKUiIseg3+i6lq825pwW79JqOsQ
         hXWw==
X-Forwarded-Encrypted: i=1; AJvYcCWlI72gwvFjzafl5sU7IrayBpCExRWhdlfbMq5/WysMLxj8lzhfiWM5XkPHpPHL/SnINhzPOEEshANzU1aa@vger.kernel.org
X-Gm-Message-State: AOJu0YwyBYdMgG/KJWhvnte8zX9VYHBezpaX3KLZmnFgFIFRNy9szaym
	VLVnYFMYXVp5qKuwseZv6u+T9ie8JMuygXKqk3hYUJSa/BM8U8whgMVawxzjG5A=
X-Google-Smtp-Source: AGHT+IHZF/Z/y4l3zjZ3VRnF/3dYyilYLN7Bx72Oup/9hNKPzgfjClG/8GjB0wnNB+D0ARExFTRp9w==
X-Received: by 2002:a05:690c:6111:b0:6ea:c928:7a3 with SMTP id 00721157ae682-6eaddfbf106mr133772187b3.40.1731433891467;
        Tue, 12 Nov 2024 09:51:31 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb7a36bsm26950147b3.105.2024.11.12.09.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:51:30 -0800 (PST)
Date: Tue, 12 Nov 2024 12:51:28 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: fix sending inotify event with unexpected
 filename
Message-ID: <20241112175128.GA910900@perftesting>
References: <20241111201101.177412-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111201101.177412-1-amir73il@gmail.com>

On Mon, Nov 11, 2024 at 09:11:01PM +0100, Amir Goldstein wrote:
> We got a report that adding a fanotify filsystem watch prevents tail -f
> from receiving events.
> 
> Reproducer:
> 
> 1. Create 3 windows / login sessions. Become root in each session.
> 2. Choose a mounted filesystem that is pretty quiet; I picked /boot.
> 3. In the first window, run: fsnotifywait -S -m /boot
> 4. In the second window, run: echo data >> /boot/foo
> 5. In the third window, run: tail -f /boot/foo
> 6. Go back to the second window and run: echo more data >> /boot/foo
> 7. Observe that the tail command doesn't show the new data.
> 8. In the first window, hit control-C to interrupt fsnotifywait.
> 9. In the second window, run: echo still more data >> /boot/foo
> 10. Observe that the tail command in the third window has now printed
> the missing data.
> 
> When stracing tail, we observed that when fanotify filesystem mark is
> set, tail does get the inotify event, but the event is receieved with
> the filename:
> 
> read(4, "\1\0\0\0\2\0\0\0\0\0\0\0\20\0\0\0foo\0\0\0\0\0\0\0\0\0\0\0\0\0",
> 50) = 32
> 
> This is unexpected, because tail is watching the file itself and not its
> parent and is inconsistent with the inotify event received by tail when
> fanotify filesystem mark is not set:
> 
> read(4, "\1\0\0\0\2\0\0\0\0\0\0\0\0\0\0\0", 50) = 16
> 
> The inteference between different fsnotify groups was caused by the fact
> that the mark on the sb requires the filename, so the filename is passed
> to fsnotify().  Later on, fsnotify_handle_event() tries to take care of
> not passing the filename to groups (such as inotify) that are interested
> in the filename only when the parent is watching.
> 
> But the logic was incorrect for the case that no group is watching the
> parent, some groups are watching the sb and some watching the inode.
> 
> Reported-by: Miklos Szeredi <miklos@szeredi.hu>
> Fixes: 7372e79c9eb9 ("fanotify: fix logic of reporting name info with watched parent")
> Cc: stable@vger.kernel.org # 5.10+
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

