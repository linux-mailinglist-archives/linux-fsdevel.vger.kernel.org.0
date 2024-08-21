Return-Path: <linux-fsdevel+bounces-26505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F9495A364
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 19:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 737D31C22956
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 17:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B361B2526;
	Wed, 21 Aug 2024 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hP1innqI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E784E1AF4C9
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259729; cv=none; b=UJlosLHXChk87Ca5S6BAhlh9YLjp+xfchh020ovSSdacYRjIkBqC03JQ1WvYq8cZfHyryFIrodize8iZWrsKJ6+kZMc9+ThzaH7RExW7SvEgP6JQGuwbx0NIh42FVVCpaKZsYw+0sbQnDGUc4CCoekAaMn7GFoBeKk5bLPtgwNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259729; c=relaxed/simple;
	bh=huuAhWozPlYbTC2md/bttbT13Gnl4tvjhnikaX+WZGU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=RWBrzol7GKMBFxcEtIDBqEspKzczcRVhbczX4Vf9Pil7itBZYIh3jA4q7jUnJAVcE2wSpSvj5FeD3mXWQ32nzhjvUWdG53/EieWjaNKOakpbM+c1/+yS3qanyBOK4CNphlygeZR6kINCXPWLqn4UIYVK1ypzeY5MsegCkOSProU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hP1innqI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724259725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MKeKXCwsmTK1BKgQlQPiv496r6D3CysEhFtQeKSECUw=;
	b=hP1innqI3BRc0HG4krqdwKYqgqzbp7gh9ddEAyHK3sfdoBpNe+n+WZxQeOETDzOYpzJNSz
	v0t+HMguj5j9DWxTAyxUQDWr9+Qp1cPEwLtarpfCiP+xx1FVTmRFuC5Dq3W0IXcPxbqiWX
	9zyO9vJJfcTaSV6k6nowtvDr4aTEH80=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-gPcc52kBOTSAHxr30wlJPg-1; Wed, 21 Aug 2024 13:02:04 -0400
X-MC-Unique: gPcc52kBOTSAHxr30wlJPg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-451ce285418so65707711cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 10:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724259723; x=1724864523;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MKeKXCwsmTK1BKgQlQPiv496r6D3CysEhFtQeKSECUw=;
        b=mSwxBwQds/+on3q4SPiN77f+/DPJbayOu74uHWoegXyNgXPfumZrTr9bcZPkH/Xeio
         BaY5FVfmF1XBdr4Aua19rIFuNyhUuMsCf5tCtJleuUj0HAGCl6oQjy2/8dnJa0JkZ+R3
         JA7Nz8bnjHpGxp68HVhtI+bLUFfI1nefCcmrDqWtw4ns0inO8QurygvzetPK6NEWRM8v
         Oe7ryIDmypRUmPZQyCCgm8szOxATSf98YwADvC8TQIWjMCFdbyWl5+qdRLZz7QLU4NMn
         22NPGXe1lIYdq2MHoxhRQ6poxoXWsn3Rhp2mDwQPEcOFNPy1AwyVu2h88t5da16P8/vi
         aBKw==
X-Gm-Message-State: AOJu0YyHhUrgW6NDbHCF3EVGvZ330/bS4kMPBAvHjCUMJx+v4TYfpDRL
	t8EAdXueQVEoMyt+9/zErDx9YmHis99tudSqEWm1we32L85YRf8n2Pm5xQNKVWDvvv5/WF3mtTs
	u16m9pVZUdY7o0VMbbiLOWkd3nEFQ6cEy+aePlzQrIEUeV6FFUHpJocrfUJDfu+0=
X-Received: by 2002:a05:622a:590b:b0:446:41fc:3fb3 with SMTP id d75a77b69052e-454f224c989mr32720551cf.41.1724259723357;
        Wed, 21 Aug 2024 10:02:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC6y5Hecq6ScaG/sEuWumvwtSnqJRQRxj5VNmNhzR6DyNaAAv/zQLYfmUACd40zIVSbYVPlg==
X-Received: by 2002:a05:622a:590b:b0:446:41fc:3fb3 with SMTP id d75a77b69052e-454f224c989mr32720061cf.41.1724259722868;
        Wed, 21 Aug 2024 10:02:02 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:165d:3a00:4ce9:ee1f? ([2603:6000:d605:db00:165d:3a00:4ce9:ee1f])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a00a913sm61036991cf.58.2024.08.21.10.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 10:02:01 -0700 (PDT)
Message-ID: <c8a8f5ca-b9a2-4f5b-9494-0631303866ff@redhat.com>
Date: Wed, 21 Aug 2024 13:02:00 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.7.1 released.
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

This is a fairly large bug fix release... Memory leaks,
warnings, typos in both doc and error messages,
improvements to the junction code, etc


The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.7.1/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.7.1

The change log is in
    https://www.kernel.org/pub/linux/utils/nfs-utils/2.7.1/2.7.1-Changelog
or
    http://sourceforge.net/projects/nfs/files/nfs-utils/2.7.1/

The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.


