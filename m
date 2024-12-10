Return-Path: <linux-fsdevel+bounces-36957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 435B39EB68E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 17:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB5D162E6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 16:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA2A22FE12;
	Tue, 10 Dec 2024 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyckgEE5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9475422FE04
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848492; cv=none; b=tb3ypFf4u1e+uf4IJW/84aTtB7abTfGZyOrbH2JKK17whnGolIIrx8bWTCqbsKUhcJcKdVHeHIHLJ1mFzFeVV11VJX68HWEcCSp2sPg7oUDqrrwstuWICG11rzpXhob9FksEQEXN7DnhZQ1ouP9j5DnOrP/5orNK/ccbSziKIeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848492; c=relaxed/simple;
	bh=Lpo2vZaBFZ9IfUboO+9t7CHFBfsidafSj7ecseQdVf4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=EtDF1gtk20GfUnwXZH0f231W841cs4BfHPAO0mfoSUs8Wa8b7veC4hyVWqq0Uhe9VDVOW1DJvli1MfGB5mmUYu/LO1aW8MyUphMHaoZ7nR7pHYdL0HQXF7GxwojM3fiqccnUAH3k+rVT8n9SrvNfgku8Z+q8kH/rEMFDXP0XdaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JyckgEE5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733848489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LWq1R5t7u/uGdOKCQ+B2EHAR2OWt6/s5zTLeb/gvY5k=;
	b=JyckgEE5EshTmuY8YetF8P/PPdDeXIC14qubZC0LXiwwXVus+syxL78Sk/SM0y8QVQHvbD
	6a0+LdZ8uR4AA3WdgtpExr1aj/xfmV6oTjaL9rLf1Q6MSMsK0jnl6KkPywPqO85GTnm0Fl
	8dSbuzU9/7nVMh6wMGxdA47Y+yl8OpM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-QiduKZqEONyRAnR9whxWrw-1; Tue, 10 Dec 2024 11:34:48 -0500
X-MC-Unique: QiduKZqEONyRAnR9whxWrw-1
X-Mimecast-MFC-AGG-ID: QiduKZqEONyRAnR9whxWrw
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-844ba409e5cso98452239f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 08:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733848487; x=1734453287;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LWq1R5t7u/uGdOKCQ+B2EHAR2OWt6/s5zTLeb/gvY5k=;
        b=I7Vm0LgMohdBS9E9hbsVtW2HJa3zsIkMG48cXD5v6juFGcgYLMf+/7LP5Iuk8jDadz
         t1B7ef+5Iga6SnvLEqrTjOzBm0F6SsmRqKZvUxw71ihRQXJe7/2JWIxszDUK7WUkcaXQ
         NKrQBbW8gJFkzmgq0H5IUbC3sspyCNZjcBUrr1KLnZb6yA3EZt0d33Ue91dMWSYUZz5p
         EMiZxkw4pelLU+XVwfiHDofaBLBEqRtvWJU5rLVZb9gylkzSJjJjA2H8qxUgkGjHcs1e
         m8YxPgwbfgt+l4/VZJfEZXmBNgjcboNNb0gqVW67VgXtrLbpHFQCrc4LSg0Lk58Soglk
         w2sg==
X-Gm-Message-State: AOJu0Yzgf7Hng7UkJM2ILlGqJMosbt3inhx86EKTl2nc8hXk3ADdJaz0
	U6F25awflDGKKTATo7sNNYa0oQDMnk770lT75l5pONYGYzgxPOJpeaz5ZeWs0uH/FNuhwsUv5GQ
	DjhaiomS8PU47usDOllVioY/n0QBpFL3CL/d/2vPhwK8YiupBhHuESumW0u/6wZ4=
X-Gm-Gg: ASbGncvP+2Tl+XddZMp0XdjiAu8kBOCv4MbhvFt8SN8rDOFuUWVKRtuw99P0D4Zda2q
	G+cnK10LTc3jkfIEuIa3NQ/xUY9+O9P1AEEM4k/6y++6Nx7iVH9P5J0yxVlADgctcXb52m2aA6z
	zppg/fMrMDRfU/b6/aRfRe5LuV0YEScANJ3Qw3IKCcCn41FH9RonLCTXe6BaapMPt5y8sYXVjBc
	gp2KY4Cf8TmfNNYD3bqT1ZADCDImH5d0JYW0Auysvnu1DKmSeWhkw==
X-Received: by 2002:a92:ca09:0:b0:3a7:e592:55cd with SMTP id e9e14a558f8ab-3a9dbacde30mr41004615ab.14.1733848487453;
        Tue, 10 Dec 2024 08:34:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5uarxXy/ATe+aoFypuvD8esVgeX96VRA0wKFAPIyTQ35TL8LZ6TXYQMK5hHtLZpUR35Xb+w==
X-Received: by 2002:a92:ca09:0:b0:3a7:e592:55cd with SMTP id e9e14a558f8ab-3a9dbacde30mr41004505ab.14.1733848487113;
        Tue, 10 Dec 2024 08:34:47 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2bcb00135sm1257730173.106.2024.12.10.08.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 08:34:46 -0800 (PST)
Message-ID: <84536b3d-5a1c-4f47-a08a-ec49cc977176@redhat.com>
Date: Tue, 10 Dec 2024 11:34:45 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.8.2 released.
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

This release changes a couple of defaults:

    * nfsdcltrack is no longer compiled by default.
    * The number nfsd server threads are bumped up from 8 to 16

This release also has a number of bug fixes including
a regression to referrals and addressing compatibility
issues with musl.

Note: If/when we add the URLs interface to mount there will
another release in the near future most likely 2.9.1
since an interface will be changing.

The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.2/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.2

The change log is in
    https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.2/2.8.2-Changelog
or
  http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.2/2.8.2-Changelog


The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.


