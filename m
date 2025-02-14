Return-Path: <linux-fsdevel+bounces-41734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C52A36324
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 17:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D7E1896F7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 16:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7107C2686B3;
	Fri, 14 Feb 2025 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0r+Zgi2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5167267AF6
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550505; cv=none; b=qcW1hROeoBUthKF4Xj+jNFmGA0sAKoapXzIb32rXpLztdGz+26i5i91/iSIwoRVYZz9Fw/kL2l+76rneh6ExIb0lWz7LqPT3Cx/YSX6f04LgviffoSPABdOMv8ku9Tz+pazmhjmdrueX4bR9cY3pj2iGJ5ZTxePBM6NYjVWV/8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550505; c=relaxed/simple;
	bh=bRW2tZiOarRYjp7vGRonRNqiV9GyGyAdi2T8WIX1NpU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P9rXnw6c2JliVRv9BrKCdFkmvFjF5QYDzKDLHJWuIchOyrmcu2gd6lkJ0lJ0U7SCA1A+vw68DD2BkDOFy+ILxmKX/UXdIIbxtnfyntm/SoifJgVMmhfVvVUCoi9B3yzh0iO0kyDFPDdl4lfasfjMn5sJErWsnM8MNYUzww5jBiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J0r+Zgi2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739550502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8C96FLb238uSkdzEFAlBDPlpQBsVMl/ufOvdc2HUfw=;
	b=J0r+Zgi2VvpX8hZ/g4gV9+mUwWabv8NQeabeDgjDYiseyBYKfCyae7yLyGMfBRjD2BtvYI
	GVzZ9mCEWZuW0hKqdvN4kHq2FKMA1Q267TW7hyG+RJtgENUGgQE2rW1ILX79fJeYOMkb2+
	QjkDLVcYAVSCdPwb0R4R1Ry4/ugy5Yk=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-jYkjkjGlM3ajbxx80ywVLg-1; Fri, 14 Feb 2025 11:28:21 -0500
X-MC-Unique: jYkjkjGlM3ajbxx80ywVLg-1
X-Mimecast-MFC-AGG-ID: jYkjkjGlM3ajbxx80ywVLg_1739550500
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8555c86cd64so391655739f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 08:28:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739550500; x=1740155300;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8C96FLb238uSkdzEFAlBDPlpQBsVMl/ufOvdc2HUfw=;
        b=vv3BjUK+JG33Ndw7OmMitF4fW0a+SF9T+kYa+cnNLTmD74ANkfWlBUN+5iTgnrLMvZ
         DAC+f9o++mzmHMEz/bDRsvHAbYc02KvLs1y0rzX5F7PS0QAFdpbF4qwrL7jv/xwMSFe3
         Tnt+NCkro8GItm0FriVRBX6V9/OlCRlfZ9gVMALG2Zpi9mv6E1yXnkZBTt0JDAC1etHC
         Fz/wFguEh8nP0dCgrTATVijAmV72bsEyFAsETuFIm8XtCTt8YR6gSR/fXqUqfkaSUW3a
         +UEB6Q3aVjb0qAIPMuNsoF6p/cUKrLz2SAM5QfLMtpb3oQ4/Rpi/nyvDymKsUOcDsy9Q
         Mv4g==
X-Gm-Message-State: AOJu0Yy/pon1Xe5vLfNC05ONHoPM3h5M52P3e1/i7oXPPUCLzwxS2js4
	+FSCF+X04GR7Rf296ZFkcta6O3FhDKzDCsV1vAGyKRkBKvhhml6IcIuEoPMLWtwxtrDn2ALXH23
	zuqGaGg3TFeilapm564RSQ7Cmt8q+gqizRLtltqVsEQhx6zYDXhqixZz4TFmB2LlfP42E0j93QS
	oepAh4XaURL+uOxeF4Px+FF23hZFSEGYB997DO5rEXCIFbnV4r
X-Gm-Gg: ASbGncu+PoVqLW7knPDc04Ecwa+Be4wvqeXrl0UgLMrUoBLTNXQApAfRYddBm0ZWUyf
	HZC5lmAFF4bI8UZKtXeBryBCNh+Wt+sq92eGVJSyCYYcsKYlWh4ws+BaTzSnFDHyNdUgBhJbmAz
	0hqirKoIS70DSGNqxCmZIYnkERvxMb+aWoizdwbEQEaLMJIJUcAi2XeMWk3r8DzvptnfmS10aOn
	VGEQqia8tBDNNV6pH7LdUXUJndunirQLgNgsSxKcZBjNeHIOK9z8VRaI+DKg75qi2czdqADjuPF
	sAnQ/Eo2iGho35afR92CvMRmS1PZkofBclUJC7v+AF0h
X-Received: by 2002:a05:6602:1489:b0:83a:b74c:800e with SMTP id ca18e2360f4ac-8557a17bea5mr6285339f.12.1739550500240;
        Fri, 14 Feb 2025 08:28:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEz3blCH4IOmyw+/qHyWeu8o94FMXsJkdQqyDYRbzQ5ZgUUp5y54wjBOryypAKFjLXYGsl4QQ==
X-Received: by 2002:a05:6602:1489:b0:83a:b74c:800e with SMTP id ca18e2360f4ac-8557a17bea5mr6283539f.12.1739550499910;
        Fri, 14 Feb 2025 08:28:19 -0800 (PST)
Received: from [10.0.0.22] (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ed2831573csm858316173.142.2025.02.14.08.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 08:28:19 -0800 (PST)
Message-ID: <97f7f028-f0ef-45a9-bce5-bc1c263a343f@redhat.com>
Date: Fri, 14 Feb 2025 10:28:18 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] watch_queue: Fix pipe allocation and accounting
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: David Howells <dhowells@redhat.com>, Lukas Schauer <lukas@schauer.dev>
References: <b34d5d5f-f936-4781-82d3-6a69fdec9b61@redhat.com>
Content-Language: en-US
In-Reply-To: <b34d5d5f-f936-4781-82d3-6a69fdec9b61@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/25 9:34 AM, Eric Sandeen wrote:
> (Giant disclaimer: I had not even heard of watch_queue.c until this week.
> So this might be garbage, but I think at least the bug is real and I think
> the analysis is correct.)
> 
> We got a bug report stating that doing this in a loop:
> 
>         pipe2(pipefd, O_NOTIFICATION_PIPE);
>         ioctl(pipefd[0], IOC_WATCH_QUEUE_SET_SIZE, BUF_SIZE);

I should have specified that BUF_SIZE is 256, which is why
watch_queue_set_size adjusts the accounting to
(256 / WATCH_QUEUE_NOTES_PER_PAGE) == 8 in my analysis.

The maximum allowed in IOC_WATCH_QUEUE_SET_SIZE is 512, which won't
expose the bug, but slightly smaller numbers (~480, which leads
to < 16 pages), will.

Thanks,
-Eric

>         close(pipefd[0]);
>         close(pipefd[1]);
> 
> as an unprivileged user would eventually yield -EPERM. The bug actually
> turned up when running
> https://github.com/SELinuxProject/selinux-testsuite/tree/main/tests/watchkey
> 
> Analysis:
> 
> The -EPERM happens because the too_many_pipe_buffers_soft() test in
> watch_queue_set_size() fails. That fails because user->pipe_bufs has
> underflowed. user->pipe_bufs has underflowed because (abbreviated) ...
> 
> sys_pipe2
>         __do_pipe_flags
>                 create_pipe_files
>                         get_pipe_inode
>                                 alloc_pipe_info
>                                         pipe_bufs = PIPE_DEF_BUFFERS; // (16)
>                                         // charge 16 bufs to user
>                                         account_pipe_buffers(user, 0, pipe_bufs);
>                                         pipe->nr_accounted = pipe_bufs; // (16)
> 
> so now the pipe has nr_accounted set, normally to PIPE_DEF_BUFFERS (16)
> 
> Then, the ioctl:
> 
> IOC_WATCH_QUEUE_SET_SIZE
>         watch_queue_set_size(nr_notes)
>                 nr_pages = nr_notes / WATCH_QUEUE_NOTES_PER_PAGE; // (8)
>                 // reduce bufs charged to user for this pipe from 16 to 8
>                 account_pipe_buffers(pipe->user, pipe->nr_accounted, nr_pages);
>                 nr_notes = nr_pages * WATCH_QUEUE_NOTES_PER_PAGE;
>                 pipe_resize_ring(pipe, roundup_pow_of_two(nr_slots == nr_notes));
>                         if (!pipe_has_watch_queue(pipe))
>                                 pipe->nr_accounted = nr_slots;
> 
> Two things to note here:
> 
> Because pipe_has_watch_queue() is true, pipe->nr_accounted is not changed.
> Also, pipe_resize_ring() resized to the number of notifications, not the
> number of pages, though pipe_resize_ring() seems to expect a page count?
> 
> At this point wve hae charged 8 pages to user->pipe_bufs, but
> pipe->nr_accounted is still 16. And, it seems that we have actually
> allocated 8*32 pages to the pipe by virtue of calling pipe_resize_ring()
> with nr_notes not nr_pages.
> 
> Finally, we close the pipes:
> 
> pipe_release
>         put_pipe_info
>                 free_pipe_info
>                         account_pipe_buffers(pipe->user, pipe->nr_accounted, 0);
> 
> This subtracts pipe->nr_accounted (16) from user->pipe_bufs, even though
> per above we had only actually charged 8 to user->pipe_bufs, so it's a
> net reduction. Do that in a loop, and eventually user->pipe_bufs underflows.
> 
> Maybe all that should be in the commit messages, but I'll try to reduce it for
> now, any comments are appreciated.
> 
> (This does pass the handful of watch queue tests in LTP.)
> 
> thanks,
> -Eric
> 
> 


