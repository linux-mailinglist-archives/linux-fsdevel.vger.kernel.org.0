Return-Path: <linux-fsdevel+bounces-32424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AFD9A4ED2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 16:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C911CB26B0A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 14:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50DA188704;
	Sat, 19 Oct 2024 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5AR/+ho"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A3718D63A
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Oct 2024 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729349379; cv=none; b=YHd8ETgGnLxGdX/AiwAc7AW+PSHxgyV6zF/3cTgL65fLdnS8cqMOUChZ2lcTNUnFMke5LQQbUKHyuZfFM7csRWlzXr0nowJzZoD9fsEirSOcdDgWXtLYVH8cQaS7f70uAAnRh2At4M5Wg2PmnGw9GzThM4PLwYHmHG1Fw+JCMzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729349379; c=relaxed/simple;
	bh=2VLaJyQE9+9yrltFSTQ7B/5OgPjybfChXfU1tWjd6oc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Uoff4vyUZlBRA8eA88cpZjR+kU4rCdV9nwKlM3UP5JuxE2/8X5dk4hiCcVW4ABtEiv1kvW2hxDfpvQ0o5HXr0XHKjs7hrKggHuCNN7dmgaOZlAGNM2Y/pG1HLNm+dGpQojh/iW6RaKGnxV2szq1S7K2IVpS0ZvqE3iDdzQkZUv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C5AR/+ho; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729349376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=httkPw+Y8CTgT3cQgVJq99l4VNeLqcFxUV61Rhrg63s=;
	b=C5AR/+hoQqinmLEbW2WIKCmKrkvoRvBJ8MhRDOPv7ZAmQZiQdSvMciHGHgsjybXfwhP6uY
	eL54ak2ODF9jJkpXBQ5MtdbP/LEhYFkuteQ5uap57f2hm5Rqx4mho4jxvDGqE4KexAPG7Q
	iwtjsljkQZ9L/WkjPqnXJg/nic0g6nI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-7c8voKBVMymGWaM8KvpxCA-1; Sat, 19 Oct 2024 10:49:34 -0400
X-MC-Unique: 7c8voKBVMymGWaM8KvpxCA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbe5637d8fso48693966d6.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Oct 2024 07:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729349373; x=1729954173;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=httkPw+Y8CTgT3cQgVJq99l4VNeLqcFxUV61Rhrg63s=;
        b=FvUcJoMu0wY3gsW0ayGRHDR4QHbbojS5BxkKJAXIqXOtRAx4w28A1pI2EFukTekr9T
         n/kfaQfdwypThoKdlTLjYZI6hJz6C+joE1JiTJUEnGbA6mkCIsnSFmR0qWrQbmF6BfsX
         Y68Iqookh4QY+tWpe5k59pWgx2vA/dRfpu60d9AOjE78460NhGWeOUJYt1F+zJchJ0Yl
         J1s7y6KM81IQNW4WmPmw2GG3I8lEHnHbHDx1HdU788NVj2qqeiKOHAK6EPwfDA6sYbZP
         KK/sdxftlD+A853089+2lv4FXb4QusKkv+5hhLvqmhJjO80oLwWTCqCaUmWOj9FvtDw6
         ZwFw==
X-Gm-Message-State: AOJu0YxArTrxSTO0Joq3hec6exwXSIGpXy0YBnG1OHCq5rbsRCKH7GnG
	Xc3BdbazxKEiQG5BN0S0cxQkQeRtdWe5aYc2br8Vm/Ci/2/+MUdP3m2/phfDFcImxM/dd6GYRXq
	88yCIWdldf0Nw6iiRrYdSz+rrxWT60aXlllU29RhBgtrI+4YnCvZQ9MflozmVMUMyp+CpELI=
X-Received: by 2002:a05:6214:5b03:b0:6c7:c7ff:958e with SMTP id 6a1803df08f44-6cde150789amr83780816d6.18.1729349373320;
        Sat, 19 Oct 2024 07:49:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs0/A4OGrhXpZifxynAeUNjGSdw+2vmetaVhUZWMc0Uw9E5uAtlVKwqkMZCmTmzv1y1iWKGw==
X-Received: by 2002:a05:6214:5b03:b0:6c7:c7ff:958e with SMTP id 6a1803df08f44-6cde150789amr83780596d6.18.1729349372983;
        Sat, 19 Oct 2024 07:49:32 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.244.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde122cab3sm19541066d6.103.2024.10.19.07.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 07:49:32 -0700 (PDT)
Message-ID: <4a86eea3-973e-4535-8aa5-f3b8b5f7934d@redhat.com>
Date: Sat, 19 Oct 2024 10:49:30 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.8.1 released.
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

This release doesn't have a large number of patches
but a couple significant bug fixes and a new
method of starting the server, via the new
nfsdctl command, which is the reason I
bummed the version from 2.7 to 2.8

Also with the new nfsdctl command the default
number of nfsd threads is now 16 instead of 8.
Another reason for the version bump.


The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.1/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.1

The change log is in
    https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.1/2.8.1-Changelog
or
  
http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.1/2.8.1-Changelog


The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.


