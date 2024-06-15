Return-Path: <linux-fsdevel+bounces-21760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C498909849
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 14:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13981C21167
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 12:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9388745C1C;
	Sat, 15 Jun 2024 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="WKqokBrW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E062F3C062
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Jun 2024 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718454065; cv=none; b=JtEjVcgcapU5UiXV+XlcysrHIaIRnLyPmr/rxzkAq52OeYHZXokyAf1Fv4m8v5x10jp19n0MkHN+p8FZQDGvjInrTVrov4O8RxJqIXYixNq23F3AYyMmVmH7COoDhLf3SIBh7xAz7iOSv+YtIBRrR9R7iiScPxa9+oIYRC+qGJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718454065; c=relaxed/simple;
	bh=zp6HAHqQzS4bpRHupIiKdAIU861FIU+seO8c8aTOcQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M0uabmmCkzLCPN819n6XqDUk9JLYY/y2hZSEZLKV+bIOJCkE6NRMO591vlJtL8Sq6Z4G6KxiNS1AV4NPi2ucvDh5YyjQRPpxo5ENlqbQiKcNuxi57S0uF4FRks8Va8+QPkqykwLwn+EIQwbZdyLBBWin7Q9000k+bREJyd/FXL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=WKqokBrW; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6c4f3e0e3d2so2382022a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Jun 2024 05:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1718454061; x=1719058861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QT0csZvkAyZvRyAkGZAf6VlXj1JNmiQ7p0AcD9y7g2g=;
        b=WKqokBrW0VHb5KAYu27LiHllgJUyLGLnuuuZZI3gXC27GN5/ghh1ypVZ034x9wegBA
         CMi9MfqorvoRKGS9+yuhCMtk41BUixN/PBV1tL11uvyhWiSU2MhaLSBuSw5kXx5HHLAe
         5RKpdWVFWsOMRooWo4CZr+rTGf/doHVlsd8Gi1mZ/03N30d5csW9BLT467Zyru6Uok7I
         sXKXSGVMsEev6Ge2wyWT7naAzXQlEl8SqEN5nBQndNJdlIwIt5ieK38m2/RbvghDEuHL
         PqJDK1kadvlwCGm+C5Hc+t3bUH1qDa9DCXm6UsmPJOlfjHfjVx4Zxg4s1aHygLcjIWAT
         xgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718454061; x=1719058861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QT0csZvkAyZvRyAkGZAf6VlXj1JNmiQ7p0AcD9y7g2g=;
        b=MjIQma6XYMzPvkGvpjVk1Cm2VnfYTCSJp41BgceQscGiesd0fpF1DOJnAch9c3llLJ
         NuVa07W+kIylc3U0B5Tlr2zql+Cl2WoI27Idw+mKxDmD9SPJihL39EpNGMMA7ClauFrw
         DqpMxotq0H5kV9AR6cEwJxTJ4uUf2dEzCz+hF00ObtFEoVCJgAe/jvlrM3ElOwRg0DPc
         xrSo/fRH9rV3PCn2KWDjDT7h31CRhDQAXaZlUw7FZV8OPefhWOe4lc1j5/RIXW2DH/sp
         K2TM88Jw8LRb0e+w6rI4SjRz6ppO3BT5HMI5pUhHG5vw6yK7pCIS1uGkXr3uyA9S+9h3
         cKWA==
X-Gm-Message-State: AOJu0Yy+CLZLXyj01MZEUqVb2hdGR0nI5QKRllqZn6jPIX9TPSn3lnRj
	Nxa8yUAaWS90tNpNv3Aj8/2Bm0hCnVY48A52UqTe7882M21h2ygHvFJf3Re2bn8=
X-Google-Smtp-Source: AGHT+IEzu79iKc3+5Cc9cOE0W0brtv3+RnstpaijdqFQTe1Rd1BQ+Wa4C56+pHSK/H9VUqeOFQ1iJg==
X-Received: by 2002:a17:902:dad0:b0:1f8:6bae:28f with SMTP id d9443c01a7336-1f86bae054cmr36156385ad.9.1718454061117;
        Sat, 15 Jun 2024 05:21:01 -0700 (PDT)
Received: from [10.12.168.35] ([143.92.118.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855ee8354sm48657745ad.149.2024.06.15.05.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jun 2024 05:21:00 -0700 (PDT)
Message-ID: <3ce68249-c2f1-4407-8415-f08fc30bdeb8@shopee.com>
Date: Sat, 15 Jun 2024 20:20:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] fuse: do not generate interrupt requests for fatal signals
To: Bernd Schubert <bernd.schubert@fastmail.fm>,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240613040147.329220-1-haifeng.xu@shopee.com>
 <CAJfpegsGOsnqmKT=6_UN=GYPNpVBU2kOjQraTcmD8h4wDr91Ew@mail.gmail.com>
 <bb09caf0-bb8d-4948-97db-9ac503377646@fastmail.fm>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <bb09caf0-bb8d-4948-97db-9ac503377646@fastmail.fm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/6/14 18:31, Bernd Schubert wrote:
> 
> 
> On 6/13/24 09:55, Miklos Szeredi wrote:
>> On Thu, 13 Jun 2024 at 06:02, Haifeng Xu <haifeng.xu@shopee.com> wrote:
>>>
>>> When the child reaper of a pid namespace exits, it invokes
>>> zap_pid_ns_processes() to send SIGKILL to all processes in the
>>> namespace and wait them exit. But one of the child processes get
>>> stuck and its call trace like this:
>>>
>>> [<0>] request_wait_answer+0x132/0x210 [fuse]
>>> [<0>] fuse_simple_request+0x1a8/0x2e0 [fuse]
>>> [<0>] fuse_flush+0x193/0x1d0 [fuse]
>>> [<0>] filp_close+0x34/0x70
>>> [<0>] close_fd+0x38/0x50
>>> [<0>] __x64_sys_close+0x12/0x40
>>> [<0>] do_syscall_64+0x59/0xc0
>>> [<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> Which process is this?
>>
>> In my experience such lockups are caused by badly written fuse servers.
> 
> 
> Btw, if libfuse should be used, it now supports disabling interrupts
> 
> https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_libfuse_libfuse_commit_cef8c8b249023fb8129ae791e0998cbca771f96a&d=DwICaQ&c=R1GFtfTqKXCFH-lgEPXWwic6stQkW4U7uVq33mt-crw&r=3uoFsejk1jN2oga47MZfph01lLGODc93n4Zqe7b0NRk&m=tF8m9nGSWX4QZ_jfhLnEAE5bia1XekX0a_EojRtTFs2ZqfhKCrhY4cwO6K9UrW8x&s=X5dxXdmPhGVwknoinaLMbPYdHeOnrfVdOXs8HPCLT0A&e= 
> 
> 

OK, Thank you for your reminding.
> 
> Cheers,
> Bernd

