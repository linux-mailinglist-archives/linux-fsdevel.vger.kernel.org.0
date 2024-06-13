Return-Path: <linux-fsdevel+bounces-21631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D8A906A43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 12:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0DF11F22528
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 10:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCAD142902;
	Thu, 13 Jun 2024 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="N1TjR+pb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC77B1422DA
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718275457; cv=none; b=jL0TSY9x7p7BqOI1IsWE4FPHk0cI+OUdeYcWf2AEX36vx992FNiEx7o0mgmZjLnZzA/fsvkz2yFQenHMqvGefen2KGQd3KLdQDCkCHIA67BCBdJUoM1PbkUXdbKazt4nS9aDkh12ILuyO8noDzLYebPrt4FXNVj+rZmzTcSSzxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718275457; c=relaxed/simple;
	bh=t98d2hcOrmG+gBwD8a5DyCNMvtSGIPlvdKTgtnV4XgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxG10gGspyy3PpFTYk1StMQz9nUdHTffjMEeW5LEGtPG4B6hQSVwOtnFC7oNEiuCnLJw5XEhmJYgT3zx+4CD4fNkAjIiFCYfcWwWdTsxcIOQWG+RZZ6FwsP0nL/L2OunoQ9qNuFEF0SjDzuo7+237fzV4VRKG8YZ9jE94+FXb2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=N1TjR+pb; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c1def9b4b3so711673a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jun 2024 03:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1718275455; x=1718880255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KC0WEOCbeOn3xeFYjkoPmf4SR20pzkx2hnnF8x8VHJ4=;
        b=N1TjR+pbBXxu6oqhWgLU6HqtpHBQSFM2vt2JkC1EPHOjSovafYOTEZvbxH4yzjGgyd
         7GPWGvsk4ysjt4wsZhwwwBCrzSYfbp+p5KeIrWKnRXQmoCvzYC0LrhG9uGYC5rJ8MXOZ
         uzqnQZUNYAq1GGP7R62ie+POzeWC7SdrzNhDV+ehsqFiqEtFep9KN/dER115c6bTxItS
         2KBvBNImAVbVZZJYaW3AvcQ5CB8zNJ85m9zd6oLSp/gKXvEjA9yiB37kkXDeZkzuuLQJ
         FpgbQC9NABkyoaBn/nqfNra7tJEwkOBp7MqnZrra7BsbZ/4U73c6W0HWF7IsKzGVLMaF
         wUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718275455; x=1718880255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KC0WEOCbeOn3xeFYjkoPmf4SR20pzkx2hnnF8x8VHJ4=;
        b=kcFF5ZJ1MmCY+nrQct1CBvGshm5+I9CEk3zWsmvxqxH436khinGPijsDxohF87GZyR
         tgs3fPU5tBJOInU8STVUoEYShveI5cDCkHp9rd5RSPT1uNSvNcY0wzQa0zF2B+QFYHOy
         PIs9dOTMLaXmiQ9umUPCe4NlHY8IPt8zcZ7FCT0Lw3MKGVP5tUYZZORPyOG5i60oC4Uj
         0gUgdDR7LweAK8yRoRppERlF6XZ0CTfuXHVNMIG2QDs/laXRvS+ijKwUB8Z1r8L3qcoN
         84dzMuBse35Nj5EC23jUVIAOrN9wpxv6XVeIgRRYguuJdx4ucg8782L0HscfwVkVWodi
         ENNA==
X-Gm-Message-State: AOJu0YxNRAGd+fzwmhXaag9rGAMB3PmC8/AJEeOETPbFT3ca+R9q4y0z
	QtcKu+3se/nl65Nt9C9a0E29eK16WCjSpINxXE4XwbVXvMO1+v0pNLriP1QNVJrvgAuXNS0ZzzA
	i1WTb5A==
X-Google-Smtp-Source: AGHT+IGlpvPyAiGmESmFdDl6gD0NZ1PLRf93mXOdanpWoZd1AGVGVrKf+uFXs8r4KD3vp0PvvfcMOg==
X-Received: by 2002:a17:90a:de18:b0:2bf:8ce5:dc51 with SMTP id 98e67ed59e1d1-2c4a76d4e4bmr5106783a91.35.1718275455083;
        Thu, 13 Jun 2024 03:44:15 -0700 (PDT)
Received: from [10.54.24.59] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c45cc95dsm1322791a91.22.2024.06.13.03.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 03:44:14 -0700 (PDT)
Message-ID: <a8d0c5da-6935-4d28-9380-68b84b8e6e72@shopee.com>
Date: Thu, 13 Jun 2024 18:44:09 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] fuse: do not generate interrupt requests for fatal signals
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240613040147.329220-1-haifeng.xu@shopee.com>
 <CAJfpegsGOsnqmKT=6_UN=GYPNpVBU2kOjQraTcmD8h4wDr91Ew@mail.gmail.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <CAJfpegsGOsnqmKT=6_UN=GYPNpVBU2kOjQraTcmD8h4wDr91Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/6/13 15:55, Miklos Szeredi wrote:
> On Thu, 13 Jun 2024 at 06:02, Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>
>> When the child reaper of a pid namespace exits, it invokes
>> zap_pid_ns_processes() to send SIGKILL to all processes in the
>> namespace and wait them exit. But one of the child processes get
>> stuck and its call trace like this:
>>
>> [<0>] request_wait_answer+0x132/0x210 [fuse]
>> [<0>] fuse_simple_request+0x1a8/0x2e0 [fuse]
>> [<0>] fuse_flush+0x193/0x1d0 [fuse]
>> [<0>] filp_close+0x34/0x70
>> [<0>] close_fd+0x38/0x50
>> [<0>] __x64_sys_close+0x12/0x40
>> [<0>] do_syscall_64+0x59/0xc0
>> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Which process is this?

The client process is one of the processes in container. And the server process is lxcfs 
which belongs to global namespace.

> 
> In my experience such lockups are caused by badly written fuse servers.


In this case, if the interrupt request is processed before the original request is processed, 
for the arriving original request, fuse_session_process_buf_int（）which used in libfuse
invokes check_interrupt() can find the interrupt request and mark the req as interrupted, 
so the server thread which invokes fuse_lib_flush() will sleep for some time and eventually 
send reply to client without setting FUSE_INT_REQ_BIT in unique.

So why the client doesn't get woken up?


> 
>> The flags of fuse request is (FR_ISREPLY | FR_FORCE | FR_WAITING
>> | FR_INTERRUPTED | FR_SENT). For interrupt requests, fuse_dev_do_write()
>> doesn't invoke fuse_request_end() to wake the client thread, so it will
>> get stuck forever and the child reaper can't exit.
>>
>> In order to write reply to the client thread and make it exit the
>> namespace, so do not generate interrupt requests for fatal signals.
> 
> Interrupt request must be generated for all signals. Not generating
> them for SIGKILL would break existing filesystems.
> 
> Thanks,
> Miklos

