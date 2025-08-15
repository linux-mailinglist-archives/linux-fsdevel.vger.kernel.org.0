Return-Path: <linux-fsdevel+bounces-57978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B97B27649
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 04:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE2818824F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 02:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7C727FB30;
	Fri, 15 Aug 2025 02:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ah5CVm2Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE08E29BD9D
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Aug 2025 02:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225909; cv=none; b=WjsuV01nQ0XEhf76v8dWZLsKI6oPiwcD8qgsOTQCvZ/Sjxzei6sONQwFuZe9Ywid/72QtpG8EalFPF09Fvko+0z74iqsTw2I7NDvAnNVeZh+3eTs0xw/cBlnSEsgrczAyptfdg5/BkkKuIxcg+FBzk9ud10YLT326F1rFLbVfN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225909; c=relaxed/simple;
	bh=I4FD3v+VUZikNRwYd+gBHMrLUQ4CPjiLRoYKNpa0koM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnvMbPMt/3a3PWKuB311MiXvz9Ro4r3kZJMnixZ2Lw5w6iJTN8ZmwynyvJmdiE0iz7TCIDIxPiTW2A4575oOF2TZYD4einvJm1otSJ8rhI87C3pXfbF7qSUcHnfmG2J9RZD8o4m7ksuCmfpq+KogzOiym4vmNUV8sQLuZDrFlvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ah5CVm2Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755225906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0MkfgQ8bxQYxWpTPhXMKMd18J4d8CIS4VwAx8IBZF0=;
	b=Ah5CVm2YMQS86+n2CRwmBCAqo3byXU0m3vN8NeVfOCV0YXgoBLN/tifbzxu0bpx0NmSaD5
	mVQGLbGFYjF/DgKzmalxCt7KGDZeZqNZGBmuSEZIz9N45ZQsobbbQBZAMZNZxfcz9yLkpc
	61hT8fta9Z94OV6nwdPYTj1ksh0uV3g=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-9a7G9WXgMBqbJcrRwj8qCQ-1; Thu, 14 Aug 2025 22:45:05 -0400
X-MC-Unique: 9a7G9WXgMBqbJcrRwj8qCQ-1
X-Mimecast-MFC-AGG-ID: 9a7G9WXgMBqbJcrRwj8qCQ_1755225904
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88428cc6d2fso280210239f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Aug 2025 19:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755225904; x=1755830704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0MkfgQ8bxQYxWpTPhXMKMd18J4d8CIS4VwAx8IBZF0=;
        b=GOVRqOqO7JuFW5Huu49gqgiKXsiV1ET9hrxlyk48IuRrJyVLnA48qp47mL0IGMIuEx
         IM3VuBxmIeCdksC6r1Fm9lILO/ysL6iws1l+ieFp9wFZN6d3b8FVP/aV5/Q0KsWQum3x
         Y6gdb+7avxQyvxe6jWTjE5Vby8I80j/X1qLKXZXluSPljz1pEisecRNIeWO1GKZX6I2x
         TVhoH0H7XZ7Nfd1oALFycoB+yzH/opwpv4KiXwCeiqzn4+ju1em5/RuqsWvkZHY2rUbL
         eFB1DoMtbCSlmIzsJ6yDOT0gUSYxTQ203Sm3OikQwKk8JxTXmMJj3eXj9tdavM/zy6rf
         1Ogg==
X-Forwarded-Encrypted: i=1; AJvYcCUtvi42O/CeJXMuHUSS4QYkyib2P/WE01/2S6KHZRnwzs9ZfegS4WYuEZBPKpHbSF4/Pvha46OTnzLHG06c@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4jnL4WAI9x9Et2t5yh7414AhO+n7AreXAS/iUWlxQweuzV4jO
	Izpjc9crINFd6F/7fEMpTTj7eAYLJKc5xYSoIwjMDlDo2Q2+koZIA8CRy5726tnCv7KHgA+i1kF
	v3+b7I+D5RXgM2PbulYHK90Afi/DffuIbdGMfKdDlHmyXgV9bOvsVTgPWocMh0UtGsm0=
X-Gm-Gg: ASbGncuWdTnTOSCT18RVSzbqlrdVi7BgNGleYz+v35AFFL0ghFjaSPPPWxs3Lk8yajt
	9leNHrTZDK8oGR6mrRrbEcJ2s51+JSdPUWo8e3mfI1irJh8rlPlcmjEwloCO3heGHn9GScmUeCw
	dyYnIwqRiAAv8j7yNVPkU7JbBinM7nOcNaJWdaAabGSiq8uSCkJoE2Xxy38wLq01ddYBt1WJ818
	7TE6tcHFpNImooBlM732bY2v3t8EXj1XTeTf+Mr0KsQO/quBYF+QgNzTpCycIGN0Pg87etuJdjO
	JcWI9uiSjnHRd3qZMlsjSwzVZXzVr3ZqZuT90ZihbKTi24WEXb3/q/bDC6qOgtL9Y7NbPUJYcfv
	y
X-Received: by 2002:a5d:87cb:0:b0:883:f98c:d346 with SMTP id ca18e2360f4ac-884344a12f8mr663499139f.8.1755225904411;
        Thu, 14 Aug 2025 19:45:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPO2/dpIhfW88S7AVny5BTqTTrhXRStv9g3Vy3tFeK3kWPbXDX/MhOKhT4XvAfrxexA31dhA==
X-Received: by 2002:a5d:87cb:0:b0:883:f98c:d346 with SMTP id ca18e2360f4ac-884344a12f8mr663494839f.8.1755225904012;
        Thu, 14 Aug 2025 19:45:04 -0700 (PDT)
Received: from [10.0.0.82] (75-168-243-62.mpls.qwest.net. [75.168.243.62])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c94999fe0sm79448173.57.2025.08.14.19.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 19:45:03 -0700 (PDT)
Message-ID: <0d8d55ab-f21c-4e4f-8951-87398f382112@redhat.com>
Date: Thu, 14 Aug 2025 21:45:02 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/4] 9p: convert to the new mount API
To: Dominique Martinet <asmadeus@codewreck.org>,
 Eric Sandeen <sandeen@sandeen.net>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, ericvh@kernel.org, lucho@ionkov.net,
 linux_oss@crudebyte.com, dhowells@redhat.com,
 Christian Brauner <brauner@kernel.org>
References: <20250730192511.2161333-1-sandeen@redhat.com>
 <aIqa3cdv3whfNhfP@codewreck.org>
 <6e965060-7b1b-4bbf-b99b-fc0f79b860f8@sandeen.net>
 <aJ6SPLaYUEtkTFWc@codewreck.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <aJ6SPLaYUEtkTFWc@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 8:49 PM, Dominique Martinet wrote:
> Eric Sandeen wrote on Thu, Aug 14, 2025 at 11:55:20AM -0500:

...

>> Any news on testing? :)
> 
> Thanks for the prompting, that's the kind of things I never get around
> to if not reminded...
> 
> I got this to run with a fedora-based host (unlike debian siw is
> built-in):
> 
> - host side
> ```
> $ sudo modprobe siw
> $ sudo rdma link add siw0 type siw netdev br0
> (sanity check)
> $ ibv_devices
>     device          	  node GUID
>     ------          	----------------
>     siw0            	020000fffe000001
> ( https://github.com/chaos/diod build)
> $ ./configure --enable-rdma --disable-auth && make -j
> (diod run, it runs rdma by default; not squashing as root fails with
>   rdma because of the ib_safe_file_access check:
>   [611503.258375] uverbs_write: process 1490213 (diod) changed security contexts after opening file descriptor, this is not allowed.
> )
> $ sudo ./diod -f -e /tmp/linux-test/ --no-auth -U root -S 
> ```
> - guest side (with -net user)
> ```
> # modprobe siw
> # rdma link add siw0 type siw netdev eth0
> # mount -t 9p -o trans=rdma,aname=/tmp/linux-test <hostip> /mnt
> ```
> 
> I've tested both the new and old mount api (with util-linux mount and
> busybox mount) and it all seems in order to me;
> as discussed in the other part of the thread we're now failing on
> unknown options but I think that's a feature and we can change that if
> someone complains.

Super, thanks.

>> As for "waiting for you," I assume that's more for your maintainer peers
>> than for me? I'm not sure if this would go through Christian (cc'd) or
>> through you?
> 
> Sorry, I wasn't paying attention and confused you with another Eric
> (Van Hensbergen) who is a 9p maintainer, so I was thinking you'd take
> the patches, but that wasn't correct.
> And that's after seeing your name all the time in #xfs, I'm sorry..

No worries! I don't mind being confused with awesome people ;)

> Christian is "just" a reviewer (for now!), and none of the other
> maintainers pick much up lately, so I'll give this a second look and
> take the patches.
> Linus just closed up 6.17-rc1 so I guess this will get in 6.18 in the
> next cycle, unless there'd be a reason to hurry?

No reason to hurry. This has been a long process, and a little longer will
not hurt.

Thanks!
-Eric (Sandeen)

> Thanks,


