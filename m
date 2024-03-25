Return-Path: <linux-fsdevel+bounces-15201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA6E88A41F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 15:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FAAD1F3DA0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 14:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69FD12F5AC;
	Mon, 25 Mar 2024 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzaHL2Fq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CC418636A
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361706; cv=none; b=IGuYjy0RvhE+QJXTit7qSq3BGAJyeCbf12XbTzdBydTqDROVFMcEZG+FS5sK+9MurGSFNO2M/wbkkOvfBuyL8o7/4T4jaZE7p0xPU2uIFtT/0OUtfkXPNZnn+UaHwG3TFL8h247j0+9p1Hj+oKlxqlm0oGb62tUwR64/JMKJSHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361706; c=relaxed/simple;
	bh=mc4Lnybpgo7YwTNAV87sNRJmVnsWEZN5R3sPvnmYmE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrbAgfPQfQt69s3/+PVLmN5rZLXJnnbBrk1jEWBkTB9bC6QXQWbUowTD7wdTfNGEg0EnKTMsXCPSz7oBy+3fOe2oRgVclT47WBX6ctghT2GuJCfW2G64d45Ma74X0H1ukKGMJoYSP9gHkVC+FH/1Sa5xld/Co5iUe8VuSh4krkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GzaHL2Fq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711361704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MK5Neka5+TdFvpBbcIvxKEkZ02U684q5i0+EZeGEb+k=;
	b=GzaHL2FqauXfST/IPH5iKNmb1taVOU+VPCkjfHyebljDlMwGZYyPFEmpI3zovNOZD/B+uQ
	Lfn5FxZsUknO3FQH58MfYtUCA1efiP2v81nFudaITFdmMF5Mka00ayFxjN5Lyc11t8M0ky
	b2s+IG+qgzWl3CF71W/Wp6NYl9jlDR4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-3aYisXBRP7iY8GdfXgyugg-1; Mon, 25 Mar 2024 06:15:02 -0400
X-MC-Unique: 3aYisXBRP7iY8GdfXgyugg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50e91f9d422so4032717e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 03:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711361701; x=1711966501;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MK5Neka5+TdFvpBbcIvxKEkZ02U684q5i0+EZeGEb+k=;
        b=JX1znz3PRSbnUo+OF6fFgcfGU6jiunpNj80jAGb+Cqw4uh1sNjqp8T6n7h2nN5sKHY
         P/ZVaSQmPLv4cINi9JFWf6jmVBXyZW+6Qr+Z/rsWITgAazupKJ0Pxp6YY7L3F/aOplm9
         20SWBi2frPeIkGluv6XKsnDV0wdHo707Ad8GuOf8Kukq1m3BZTjoiR/eIdUSusr6Fxda
         a54B642ZU+j/baggj6q1ViF0iMiF7CcwGkustjFAZZK1lR5LI4ar8xZhqjTCC7Ab2S8Y
         U9yRytBqCQtGx29uI7kktmXCfeXHW7TnkTBDbTvmHb5/RlTeupIaoP+gpkqGznnv3/is
         GXPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqjaRX82uAjXaojyeQQdBHA4TzDKkWE8cOew4PUvXTeiNDFM0cLeECwQX/1D+WCO6UH5R5lF9Vf6jOTHK73JqfXMZ/U5TjLW5fPvyjjQ==
X-Gm-Message-State: AOJu0Ywqx9QvQNHjerb9KTvRVxb24tC5wJcMRKuEU61XtgTZ6jroCTAl
	FpgIV6ULi9M8Fn8/c/kQ/RCMbBAZ++PhMiRWTqllvTqtW4iR3in38WLUbuaGvMkGyqsMIO+Vqbk
	TqFY8x9kQUpfklpU6HbT5kQ87qvyinJgXYC31poICXzJcLRfA19O6QGlBVOl3DlQbMOqn2cE=
X-Received: by 2002:ac2:4421:0:b0:512:bf99:7d80 with SMTP id w1-20020ac24421000000b00512bf997d80mr4330190lfl.1.1711361701079;
        Mon, 25 Mar 2024 03:15:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaAgvB4iFm85tc79NggwOF9MoZ55s+EirHWVzX+L5dqXAriTuWHE3bE33EsemD+AZ9GmBvRQ==
X-Received: by 2002:ac2:4421:0:b0:512:bf99:7d80 with SMTP id w1-20020ac24421000000b00512bf997d80mr4330175lfl.1.1711361700610;
        Mon, 25 Mar 2024 03:15:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c738:b400:6a82:1eac:2b5:8fca? (p200300cbc738b4006a821eac02b58fca.dip0.t-ipconnect.de. [2003:cb:c738:b400:6a82:1eac:2b5:8fca])
        by smtp.gmail.com with ESMTPSA id dw1-20020a0560000dc100b0033e3cb02cefsm9160367wrb.86.2024.03.25.03.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 03:15:00 -0700 (PDT)
Message-ID: <f453061e-6e01-4ad7-8fc6-a39108beacfc@redhat.com>
Date: Mon, 25 Mar 2024 11:14:59 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel BUG at mm/usercopy.c:102 -- pc : usercopy_abort
Content-Language: en-US
To: Xiubo Li <xiubli@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
 Ceph Development <ceph-devel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
References: <e119b3e2-09a0-47a7-945c-98a1f03633ef@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e119b3e2-09a0-47a7-945c-98a1f03633ef@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.03.24 08:45, Xiubo Li wrote:
> Hi guys,
> 
> We are hitting the same crash frequently recently with the latest kernel
> when testing kceph, and the call trace will be something likes:
> 
> [ 1580.034891] usercopy: Kernel memory exposure attempt detected from
> SLUB object 'kmalloc-192' (offset 82, size 499712)!^M
> [ 1580.045866] ------------[ cut here ]------------^M
> [ 1580.050551] kernel BUG at mm/usercopy.c:102!^M
> ^M
> Entering kdb (current=0xffff8881211f5500, pid 172901) on processor 4
> Oops: (null)^M
> due to oops @ 0xffffffff8138cabd^M
> CPU: 4 PID: 172901 Comm: fsstress Tainted: G S 6.6.0-g623393c9d50c #1^M
> Hardware name: Supermicro SYS-5018R-WR/X10SRW-F, BIOS 1.0c 09/07/2015^M
> RIP: 0010:usercopy_abort+0x6d/0x80^M
> Code: 4c 0f 44 d0 41 53 48 c7 c0 1c e9 13 82 48 c7 c6 71 62 13 82 48 0f
> 45 f0 48 89 f9 48 c7 c7 f0 6b 1b 82 4c 89 d2 e8 63 2b df ff <0f> 0b 49
> c7 c1 44 c8 14 82 4d 89 cb 4d 89 c8 eb a5 66 90 f3 0f 1e^M
> RSP: 0018:ffffc90006dfba88 EFLAGS: 00010246^M
> RAX: 000000000000006a RBX: 000000000007a000 RCX: 0000000000000000^M
> RDX: 0000000000000000 RSI: ffff88885fd1d880 RDI: ffff88885fd1d880^M
> RBP: 000000000007a000 R08: 0000000000000000 R09: c0000000ffffdfff^M
> R10: 0000000000000001 R11: ffffc90006dfb930 R12: 0000000000000001^M
> R13: ffff8882b7bbed12 R14: ffff88827a375830 R15: ffff8882b7b44d12^M
> FS:  00007fb24c859500(0000) GS:ffff88885fd00000(0000)
> knlGS:0000000000000000^M
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
> CR2: 000055c2bcf9eb00 CR3: 000000028956c005 CR4: 00000000001706e0^M
> Call Trace:^M
>    <TASK>^M
>    ? kdb_main_loop+0x32c/0xa10^M
>    ? kdb_stub+0x216/0x420^M
> more>
> 
> You can see more detail in ceph tracker
> https://tracker.ceph.com/issues/64471.

Where is the full backtrace? Above contains only the backtrace of kdb.

That link also contains:

Entering kdb (current=0xffff9115d14fb980, pid 61925) on processor 5 
Oops: (null)^M
due to oops @ 0xfffffffface3a1d2^M
CPU: 5 PID: 61925 Comm: ld Kdump: loaded Not tainted 
5.14.0-421.el9.x86_64 #1^M
Hardware name: Supermicro SYS-5018R-WR/X10SRW-F, BIOS 2.0 12/17/2015^M
RIP: 0010:usercopy_abort+0x74/0x76^M
Code: 14 74 ad 51 48 0f 44 d6 49 c7 c3 cb 9f 73 ad 4c 89 d1 57 48 c7 c6 
60 83 75 ad 48 c7 c7 00 83 75 ad 49 0f 44 f3 e8 1b 3b ff ff <0f> 0b 0f 
b6 d3 4d 89 e0 48 89 e9 31 f6 48 c7 c7 7f 83 75 ad e8 73^M
RSP: 0018:ffffbb97c16af8d0 EFLAGS: 00010246^M
RAX: 0000000000000072 RBX: 0000000000000112 RCX: 0000000000000000^M
RDX: 0000000000000000 RSI: ffff911d1fd60840 RDI: ffff911d1fd60840^M
RBP: 0000000000004000 R08: 80000000ffff84b4 R09: 0000000000ffff0a^M
R10: 0000000000000004 R11: 0000000000000076 R12: ffff9115c0be8b00^M
R13: 0000000000000001 R14: ffff911665df9f68 R15: ffff9115d16be112^M
FS:  00007ff20442eb80(0000) GS:ffff911d1fd40000(0000) 
knlGS:0000000000000000^M
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
CR2: 00007ff20446142d CR3: 00000001215ec003 CR4: 00000000003706e0^M
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000^M
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400^M
Call Trace:^M
  <TASK>^M
  ? show_trace_log_lvl+0x1c4/0x2df^M
more>


Don't we have more information about the calltrace somewhere? (or a 
reproducer?)

-- 
Cheers,

David / dhildenb


