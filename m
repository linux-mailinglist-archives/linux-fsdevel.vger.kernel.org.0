Return-Path: <linux-fsdevel+bounces-45307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26823A75BF2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 21:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E328167E7E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Mar 2025 19:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7D11DB122;
	Sun, 30 Mar 2025 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cbIfXg98"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7443120E6
	for <linux-fsdevel@vger.kernel.org>; Sun, 30 Mar 2025 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743363464; cv=none; b=muD7YzXFMBYzpYoqyZPT7H1+B7NpeU4mH2BL4JaHkHwEvkl8WnMy6wA97oGSkamaOJ3rackHsNQSUYbvvLcW1avRjUjuog6JVfOA1gSSVlx8VtAoArqL0hGqdx3jVWeWoNUVcpXqclYNablxzx55xdM55jwwORN/+zpDbKDUjJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743363464; c=relaxed/simple;
	bh=FdSZJ7yjYtp0hGeVBZHMwHht2/XdwjBnyuoka0/dhxs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=N3cRglDDClzrq0E72iMtBt0culz4oXJ/I7VQeOCtlhTCSPbdmwB+9I4nijJj/cUPGZNwC8xU/uGp4TYhfOwy38566X72JHriH6KVQXImjCUu5By5FhkSammqcvASNZGcC/T7vCO9YFmREQKPfIrilCtrqI8XdszzjYgrCiBTkK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cbIfXg98; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743363461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g5Xk8LqCMuC0hbWLeWvLxITG+yRsd8228TYUU/9Egww=;
	b=cbIfXg98VbX7Ne9shOnfzw7K6J8Y39MwHK7DYdaMHzyfj6G/2Mu9uej8/L8L8eUxIiWF6V
	NAh0UwaY0bpvtPSMcYP6v4yPUbL87KYR80m3fUsEfkdETkqyaw4nBfEkEgOYkLKSE79gMS
	/F1ni+uhuGc3z4pscDOy47/YC/DrypY=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-e5Ex22KuPpm1S7noL2C6Cw-1; Sun, 30 Mar 2025 15:37:39 -0400
X-MC-Unique: e5Ex22KuPpm1S7noL2C6Cw-1
X-Mimecast-MFC-AGG-ID: e5Ex22KuPpm1S7noL2C6Cw_1743363459
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85b3b781313so793520639f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Mar 2025 12:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743363458; x=1743968258;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g5Xk8LqCMuC0hbWLeWvLxITG+yRsd8228TYUU/9Egww=;
        b=XwrjN+zyVLaiiMaIYL93I/5ISe4r16bPvibIVN0vV/zt+3M3ej5lMnK3YS7boqhf0B
         XLmdObLHv1Jqzk4I9sBXPF33iThuMyBDlXVelJtoSeXE1NyAlcM2RkcyeB+aucENLQtS
         hbgeKZGkqmIoNZnpvozAKlpCbN0pg2pgnFOUCxez/fWux0xzK5SY0RJLSjpUihf0xXd0
         NoHFJQOjmZRQCAm3Mwm3tIvzgaqgW64kbFBx6sUHhdXw2E/XGrp3xrJVfHfBIrXCOMFN
         NYFQNB1pNxrOxzPiDZpS7h0kd4aJ2MMdya7t0MMoEimoA13O5ko+9MXDyXwM+8wvyjff
         LGIA==
X-Gm-Message-State: AOJu0YyXjO/IrADiExmbPZp3pUKiZmss0ug3c3vjYSAuAoJN9P6l5aNf
	Ms0aMSEXbMvqiL3mTrHHxJ9L+HtzOxPvS9JSyoWzu/D7dZVwMqE3g1IvRaRh+J9cOHP0cN/drCo
	yOqyflgZKdsptEfsjhC15UV2V2paptiawAxgXbrc9Og74CbkFcMl3PDpc8MxJ7yZFT8fEJLw=
X-Gm-Gg: ASbGncu+bO58kaLrwXhF5la5io0J9tuL7u1EaC2LpMqkNr54QM+fu8L6jmoIWNS9h3e
	L0a17DdWccATjVXaZZXSwIB/dxubuLMzH8Ua3r8E83DUNh4kXNoZrvpIwQRMRw/5VbdhuTYRodM
	ABgbUA/tYbAv9unZjpF8BjaR//rAIr2V+kxNDEdOCTo+FonbyJGm98eleCrCCjQSjJyLIktX/UH
	Ga0m2VEiJ5s3fOrr84u8nStoM6KGbjpvmuqnlbTlCJ2sLLZZUHVryqKswpnUui3nSEnowQqZtNB
	uWPue/bfuAVGl1M=
X-Received: by 2002:a05:6e02:1a2f:b0:3d3:fdb8:1796 with SMTP id e9e14a558f8ab-3d5e08e988dmr74578995ab.2.1743363458201;
        Sun, 30 Mar 2025 12:37:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3WLRKEv2ZX784wP0IJWPmDZbDgTMMLUXHCoabKGYQvtdraGugN8X5U+NxP/NHUj6r1Pqwxw==
X-Received: by 2002:a05:6e02:1a2f:b0:3d3:fdb8:1796 with SMTP id e9e14a558f8ab-3d5e08e988dmr74578885ab.2.1743363457908;
        Sun, 30 Mar 2025 12:37:37 -0700 (PDT)
Received: from [172.31.1.159] ([70.105.244.27])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d5d5ae9d5esm17051095ab.44.2025.03.30.12.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 12:37:36 -0700 (PDT)
Message-ID: <64a11de6-ca85-40ce-9235-954890b3a483@redhat.com>
Date: Sun, 30 Mar 2025 15:37:33 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.8.3 released.
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

The release has a number changes in time for
the upcoming Spring Bakeathon (May 12-16):

     * A number of man pages updates
     * Bug fixes for nfscld and gssd
     * New argument to nfsdctl as well as some bug fixes
     * Bug fixes to mountstats and nfsiostat
     * Updates to rpcctl

As well as miscellaneous other bug fixes see
the Changelog for details.

The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.3/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.3

The change log is in
    https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.3/2.8.3-Changelog
or
  http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.2/2.8.3-Changelog


The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.


