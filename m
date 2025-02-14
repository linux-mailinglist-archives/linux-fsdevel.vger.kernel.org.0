Return-Path: <linux-fsdevel+bounces-41720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83344A361CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 16:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2483A9988
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 15:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CC7266EE4;
	Fri, 14 Feb 2025 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fENZ50hh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E351F92A
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547265; cv=none; b=W/Ex/UqplNLIFYbdc/YJP5zvjp8m03eFhWd6HN+qSh0fL8nCGDBZ9dAEE44O9RUxvvhTKgz+o3hHXVPfzAKftk0+w3YhD8fmWTV5YEaTQAgCGd5rnjkdmB7+wN6VhE+ZlmMHGJRKlEOgHbg5TPuNoVoFznR52rkjmaYAVdV/a14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547265; c=relaxed/simple;
	bh=l5oBKlD76n1sprV9myl4/yr0p/vz1Z9D25i1/rndzBE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=g3CePYxONKWcx+AHCjB7s3iqN+L7z2bHA2K0YNNX7SnQtL8vFtiQ/loQJaalidxjg9xszzOJ8mBIJsklLIUjcHRKKQgkx84JOmvgpLKr63NEJo0Lxid5KB8Jq6zjUCSjbD8WBA3G/Tc+y4WVbgorrxSp7qgTwrQhqyx2/ycD280=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fENZ50hh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739547261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gjS+Qy5HRnFqD+pUe7EX7nuHzXaJj708+gCcVBQ0v44=;
	b=fENZ50hhEc6KEfWd8b6EiTVsAC7Yi86PK6v7RrKfWrdf1sxz9KFlPP1xzleUlMO+eByvRx
	QJNBGdPIncXAyK+mkPXPifl1OkRjxcDfyXTiBmGGYRSFF70iF/xpq8GriVOJsk14zVvZxG
	CZwLSIyCx/GqMmdV4aLwB9fzTfr8pB4=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-dpCHI0yIMri5l3r6kZsD6g-1; Fri, 14 Feb 2025 10:34:20 -0500
X-MC-Unique: dpCHI0yIMri5l3r6kZsD6g-1
X-Mimecast-MFC-AGG-ID: dpCHI0yIMri5l3r6kZsD6g_1739547260
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ce8dadfb67so17114545ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 07:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739547259; x=1740152059;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gjS+Qy5HRnFqD+pUe7EX7nuHzXaJj708+gCcVBQ0v44=;
        b=UL99DTAgh/naApWLxqhqNwg0mGy5Sa3DhL8TKdyC/HpgjoYG60dPwLYyNpy35Wd2q7
         uPdKcaMGrBstukBPXggqIsEsk413B8tRT+UQJWAGjo47vAd5nH/X23QRoPtGXADZqca2
         vKZF0/IQgYErvJZ146JjriGO1XQlqusF/RK4/PejF00uOHVcYXMmNpyaUej4wqOCbQIm
         HiIijjqwGFUi+EikNkHsmQwAUKMuzTEFu3XGQdj41D5aAuD2uzf9sOsHsella5nliK6y
         AVkYHm/uLRurIn1/cyhCByHu71d2uxhsEJLXqJUTrGaVhgoIIETB9aB76pDXNw4VcTUw
         82qA==
X-Gm-Message-State: AOJu0YwrogKBUVLeUAlr6pA+mnOECg4KyN7XPv+c0/9iMMGbdfqQm8Q6
	PmDIjaTyOIaI6+5hzAXhx/K4H6OQAIXPfjHHlsHC2iw7BhZ7LX1wHG8oJILBXxJFpYozEepSRYI
	GLQRHSOeydC3PVC4dEjLtYbtDaIi42/BSZpKBLSHIkKObppX1NiNf5YgAjSgaHu31WbNFZbnrLL
	swqbmgceR92oOYPuNDq3w0ZZq5YtUADhulneT88QjTVC4FOgaA
X-Gm-Gg: ASbGnct/fycSXbQv6HEsrmPdqCdnKuwGkA6MlLaf1ljcwL8jLgDi3M3RKcWavSYu9Lm
	gNkI6Lwau+kE1KYYKRWdAJWkCAxfCuE0/+zl23amvVUrgnGcx2vRih7qXbCsP4fc+0mQ2OGo481
	aNb54Y5gFjJ96dQvLYBIE9g8seuTIv3y46QkQ6UfIBAm0vjqHeK1E73Uwmq29UiGwZTMv+kmftw
	/UpTCmMCJye2mL0urCTS6uyEBapylVSAWo+U++gmGqgcWM9qgz7BSTzFVr6M08uYDivR0400Qve
	301OdjLp60fbO7kfblaOtlyWS24V40j/X+3BmsYulAUE
X-Received: by 2002:a05:6e02:2485:b0:3d2:1206:cab4 with SMTP id e9e14a558f8ab-3d21206cc95mr5391315ab.16.1739547259431;
        Fri, 14 Feb 2025 07:34:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7TL8isYAhjy0mzJNa1Kk+JoCN6cQm69nKoIga2XsYTmMlD9spSSprdtp3wOmPreDxT9WgGQ==
X-Received: by 2002:a05:6e02:2485:b0:3d2:1206:cab4 with SMTP id e9e14a558f8ab-3d21206cc95mr5390945ab.16.1739547259045;
        Fri, 14 Feb 2025 07:34:19 -0800 (PST)
Received: from [10.0.0.22] (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d18fb575b1sm7269575ab.58.2025.02.14.07.34.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 07:34:18 -0800 (PST)
Message-ID: <b34d5d5f-f936-4781-82d3-6a69fdec9b61@redhat.com>
Date: Fri, 14 Feb 2025 09:34:17 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: David Howells <dhowells@redhat.com>, Lukas Schauer <lukas@schauer.dev>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [RFC PATCH 0/2] watch_queue: Fix pipe allocation and accounting
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

(Giant disclaimer: I had not even heard of watch_queue.c until this week.
So this might be garbage, but I think at least the bug is real and I think
the analysis is correct.)

We got a bug report stating that doing this in a loop:

        pipe2(pipefd, O_NOTIFICATION_PIPE);
        ioctl(pipefd[0], IOC_WATCH_QUEUE_SET_SIZE, BUF_SIZE);
        close(pipefd[0]);
        close(pipefd[1]);

as an unprivileged user would eventually yield -EPERM. The bug actually
turned up when running
https://github.com/SELinuxProject/selinux-testsuite/tree/main/tests/watchkey

Analysis:

The -EPERM happens because the too_many_pipe_buffers_soft() test in
watch_queue_set_size() fails. That fails because user->pipe_bufs has
underflowed. user->pipe_bufs has underflowed because (abbreviated) ...

sys_pipe2
        __do_pipe_flags
                create_pipe_files
                        get_pipe_inode
                                alloc_pipe_info
                                        pipe_bufs = PIPE_DEF_BUFFERS; // (16)
                                        // charge 16 bufs to user
                                        account_pipe_buffers(user, 0, pipe_bufs);
                                        pipe->nr_accounted = pipe_bufs; // (16)

so now the pipe has nr_accounted set, normally to PIPE_DEF_BUFFERS (16)

Then, the ioctl:

IOC_WATCH_QUEUE_SET_SIZE
        watch_queue_set_size(nr_notes)
                nr_pages = nr_notes / WATCH_QUEUE_NOTES_PER_PAGE; // (8)
                // reduce bufs charged to user for this pipe from 16 to 8
                account_pipe_buffers(pipe->user, pipe->nr_accounted, nr_pages);
                nr_notes = nr_pages * WATCH_QUEUE_NOTES_PER_PAGE;
                pipe_resize_ring(pipe, roundup_pow_of_two(nr_slots == nr_notes));
                        if (!pipe_has_watch_queue(pipe))
                                pipe->nr_accounted = nr_slots;

Two things to note here:

Because pipe_has_watch_queue() is true, pipe->nr_accounted is not changed.
Also, pipe_resize_ring() resized to the number of notifications, not the
number of pages, though pipe_resize_ring() seems to expect a page count?

At this point wve hae charged 8 pages to user->pipe_bufs, but
pipe->nr_accounted is still 16. And, it seems that we have actually
allocated 8*32 pages to the pipe by virtue of calling pipe_resize_ring()
with nr_notes not nr_pages.

Finally, we close the pipes:

pipe_release
        put_pipe_info
                free_pipe_info
                        account_pipe_buffers(pipe->user, pipe->nr_accounted, 0);

This subtracts pipe->nr_accounted (16) from user->pipe_bufs, even though
per above we had only actually charged 8 to user->pipe_bufs, so it's a
net reduction. Do that in a loop, and eventually user->pipe_bufs underflows.

Maybe all that should be in the commit messages, but I'll try to reduce it for
now, any comments are appreciated.

(This does pass the handful of watch queue tests in LTP.)

thanks,
-Eric


