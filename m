Return-Path: <linux-fsdevel+bounces-27818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68148964508
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B11C289537
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 12:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0327B1A76BE;
	Thu, 29 Aug 2024 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWWwkAHq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E271991A3
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935047; cv=none; b=MDlx0+2QHBYT1KWnpfckB4Ku2/I6w5KMqfhPOrtY9WmqhUFkJbfbBqYpOXIU0KZgSYbsz5DoZHOP/vkHtme+tQVw1UmfSI7/+aDeMSCEE4yj/pqrC9z7VsIhIt/zTScfkcqcYOGb7acfqZf7uEcyqg2ApYDfujibzsp3ShsEA74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935047; c=relaxed/simple;
	bh=X+w1PbvGz2LDLEeHz1yYzn6VqcBjoLRL+LJ7y270rXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nScHv7y0cMzmhNeCsY3hNYek/tt7nR3+ttzQd8SBuOIwZmJLfA2yUeCgZlvQzmkQceDeTP2c6a1DEti8e8f7RmUMtEDuud4Yb/BYpCxP96+bwSviI/l8S7kW6/vtOO7l3w4Ox+OkHFMNTGJCKBOytU2JFc97ToPrOZlHRvgpR70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DWWwkAHq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724935044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCZcbBXJUr2ekikCjElYG6Jp9gfYESYYzpjLYXs3oq8=;
	b=DWWwkAHqVMyl+YZp9KCE/LVxUYF69ujdUC76vqqmv2uyFignQtcj8zIXthf7D7K6cLc8TH
	LmHz1wkht59RJElqfosS9UnNQ5k1lAdzwoAwp12guALoashVxUzxUycqH7WR4zuAZc33Rq
	wDQrjZzOAhLIYgxKb9odGjMjsdOqTXo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-pXwF1MDNPgqs7PrcZeO3Rw-1; Thu, 29 Aug 2024 08:37:23 -0400
X-MC-Unique: pXwF1MDNPgqs7PrcZeO3Rw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-428040f49f9so6338535e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 05:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724935042; x=1725539842;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCZcbBXJUr2ekikCjElYG6Jp9gfYESYYzpjLYXs3oq8=;
        b=duj2C0X8HFk9bmEmxrCyqHFwFUizACd+aVCf+l4vKutbOBiltWYWcNBT3S0ZdVzXAp
         aPH03uZ6aTFXDYy18k5SCBhntoWs7kG4BH9QbcJX0oJX3y31dpJ2gEZexeJGw+ia53Lh
         H2IWiFkicrYOqwpVfjbfu/rTeNHaPrvSLYUwzzB6wSN+axOLy4i1shhsXXHdqkcCwl8Y
         3Y5niBaB1Eq+yIE/9TWUmcGBw/km8fQiCliKbyeP5TWNgs9S1WASI2BxdPUg9MCe1225
         Cs7teIRkO90qRjDITHlOAb/tI7KkFFbFGFzc1YjXXIpQ6KRlTiNev30tGP1GOCvcqyAJ
         tDGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtY/SsV1Fcaht9RlqcbBrkxlAqAlfXZCuuiV65fgAVlZwtq9PzzgR7bfIeK+uYcjP6x1MRQ/EHfUb3RpLW@vger.kernel.org
X-Gm-Message-State: AOJu0YyBFEjgw6LJjt68uHtYBPsmb9xA0tEX0BrHF20SqNgeuuVhj6Yt
	xPOrHr1uPKmanQ6IvPd0R3/MIU3+pzkiBuHGysH7OH62z4TL25sSqBGEYR4kDgPYnUnqQwXmZzC
	ZzV+fNGq1fRSNZBilRVvECdu32Bv7fzhZwRqQyHYu3e8+mWCNfz6TGEQ95M8zOjo=
X-Received: by 2002:a05:600c:3c93:b0:426:62c5:4742 with SMTP id 5b1f17b1804b1-42bb02c1d88mr19356675e9.7.1724935042306;
        Thu, 29 Aug 2024 05:37:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGunOLc7wncLVW9NHj7TP05XL8kLxSvLATcR5zU9zChtnQhOsW19BuJPFjBdEullMdhF6/2Pg==
X-Received: by 2002:a05:600c:3c93:b0:426:62c5:4742 with SMTP id 5b1f17b1804b1-42bb02c1d88mr19355785e9.7.1724935041470;
        Thu, 29 Aug 2024 05:37:21 -0700 (PDT)
Received: from ?IPV6:2003:cf:d748:138d:7ea9:6713:593a:3e11? (p200300cfd748138d7ea96713593a3e11.dip0.t-ipconnect.de. [2003:cf:d748:138d:7ea9:6713:593a:3e11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9ba8esm1326628f8f.50.2024.08.29.05.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 05:37:20 -0700 (PDT)
Message-ID: <19017a78-b14a-4998-8ebb-f3ffdbfae5b8@redhat.com>
Date: Thu, 29 Aug 2024 14:37:19 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] virtio-fs: Add 'file' mount option
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
 Miklos Szeredi <mszeredi@redhat.com>, German Maglione
 <gmaglione@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>
References: <20240709111918.31233-1-hreitz@redhat.com>
 <CAJfpegv6T_5fFCEMcHWgLQy5xT8Dp-O5KVOXiKsh2Gd-AJHwcg@mail.gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAJfpegv6T_5fFCEMcHWgLQy5xT8Dp-O5KVOXiKsh2Gd-AJHwcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29.08.24 10:07, Miklos Szeredi wrote:
> On Tue, 9 Jul 2024 at 13:19, Hanna Czenczek <hreitz@redhat.com> wrote:
>> Hi,
>>
>> We want to be able to mount filesystems that just consist of one regular
>> file via virtio-fs, i.e. no root directory, just a file as the root
>> node.
>>
>> While that is possible via FUSE itself (through the 'rootmode' mount
>> option, which is automatically set by the fusermount help program to
>> match the mount point's inode mode), there is no virtio-fs option yet
>> that would allow changing the rootmode from S_IFDIR to S_IFREG.
>>
>> To do that, this series introduces a new 'file' mount option that does
>> precisely that.  Alternatively, we could provide the same 'rootmode'
>> option that FUSE has, but as laid out in patch 1's commit description,
>> that option is a bit cumbersome for virtio-fs (in a way that it is not
>> for FUSE), and its usefulness as a more general option is limited.
> I wonder if this is needed at all for virtiofs, which could easily do
> the FUSE_INIT request synchronously with mount(2) and the server could
> just tell the client the root mode explicitly in the FUSE_INIT reply,
> or could just fetch it with a separate FUSE_GETATTR.

That would be great.  I thought it would be necessary to install the 
superblock before sending FUSE_INIT, so I thought this wasn’t possible.

I honestly have no idea how to go about it on a technical level, 
though.  Naïvely, I think we’d need to split off the tail of 
fuse_fill_super_common() (everything starting from the 
fuse_get_root_inode() call) into a separate function, which in case of 
virtio-fs we’d call once we get the FUSE_INIT reply.  (For 
non-virtio-fs, we could just call it immediately after 
fuse_fill_super_common().)

But we can’t return from fuse_fill_super() until that root node is set 
up, can we?  If so, we‘d need to await that FUSE_INIT reply in that 
function.  Can we do that?

> Why regular fuse doesn't do this?  That's because a single threaded
> server can only be supported if the mount(2) syscall returns before
> any request need processing.  Virtiofs doesn't suffer from this at
> all, AFAICS.
>
> Does this make sense?

It does!

Hanna


