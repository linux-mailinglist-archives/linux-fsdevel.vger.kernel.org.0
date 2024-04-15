Return-Path: <linux-fsdevel+bounces-16957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B668A56DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 17:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C931B2845AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 15:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050D37F464;
	Mon, 15 Apr 2024 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMyj6PQ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1214D8BF8
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196773; cv=none; b=Ji2HRPfvt5N0HosYymTLt6Kmyd3U4DSDaMOt2OQGJQRumKq53+h9AHf4nC59iDX+B2lBREG9M4EMD28gtwglqMX56CXlI1Ekmtyrltkgzl9t+CI163uZ5gHBg6HPTvIYoV3hifKdQaAd4sloeSwwS9rw5AWKuC/xLW/wPiBHMwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196773; c=relaxed/simple;
	bh=gs6BlBTHOo5I4mCngOIQ4cX4RE8Dv2NGNd2CY60TgSc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=PF9dcQx9WxnGEHpN6RBg3eEB4n9KfzYMPA6ssT5SxOhdWm63t70i9yTiXPJyBlaDOuhqLa/7o8/v6BqHWq7RQr3soQpJKF+p/8lWSjJDyfp8AMoQoGhxemhLS3lAy6IlbNylq35iupucL4mIskNrPdvzw6w7a8e22y8rR2aClg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMyj6PQ8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713196770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gs6BlBTHOo5I4mCngOIQ4cX4RE8Dv2NGNd2CY60TgSc=;
	b=IMyj6PQ8N+jhV3w4jLl10aoDFCSiHKKQLBB60G0lvmoUDMOhhU3aFpYTkwt96DzdCq7rg8
	85lc8MPppP2PEvIKuNZs2mVHCkIDtAPw/P/nzM4wItQLU/sih+DKKqQjwmOEZQhIBXZxaS
	PAvOAFl+QRHjA4xVAIl+bQSgfP2Etfw=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-NwT1aKwFPzqmaphH2fQL3Q-1; Mon, 15 Apr 2024 11:59:28 -0400
X-MC-Unique: NwT1aKwFPzqmaphH2fQL3Q-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d663e01e24so365382639f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 08:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713196767; x=1713801567;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gs6BlBTHOo5I4mCngOIQ4cX4RE8Dv2NGNd2CY60TgSc=;
        b=wOkEBWYrvIlvsFmRZda9nbnjKPyToPqWHa1ZianuCoqJeBCYwr8+hOHaM+KRpSEvf2
         TCr5242tYt8p9/ZM9af5HxTZwScz7NKN1dOut52MDxHXH9H0UORDUcahHUGszS+R3GTn
         5JwIWYJ+mWcphBogIdkjMGKrI/ebWIRa9tCBgkvlS8CDr1VW0DhTiDGWw5368d4cCBz1
         7SqmmHyrhG1Rogy+SAtWa3/htd0ICN75tFM/jksM2tY+Dlbl/ssPjj6hk6AN8CklItwD
         TW7R/IAuka2NFK2ND+UaLW5yvxClzJFxbgZ2bl/5w0JS3bgGEO8NjHxtfF61dWfAIiLH
         +VUA==
X-Gm-Message-State: AOJu0YyAe+wfzoZrvg6nGZfyDucpBffYmyTF/D10zKdUBjzZ0/2SIyAG
	gFRx+KwJ0eu17frYl11fM+562k9vwkf4LKrauddPp/oAmYfGZc4OAo3qfQi2EfYZjmqzDorkKfI
	TrKnBp4yJF+aSu+DEAAQS4ljTI+hVvptUbV5fDp1GZFt77JrH/fIF3eKSfWRsjIPz+TMTHKU0sX
	YZnYXoCya13TQT51cXpbvqM336/zVmjqJn4UeTtirsrD/pMQ==
X-Received: by 2002:a05:6602:389b:b0:7d0:3e4e:242d with SMTP id br27-20020a056602389b00b007d03e4e242dmr14099656iob.5.1713196767318;
        Mon, 15 Apr 2024 08:59:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErKcOY4RISo9ufHy46goqGn2DftZm8n1pLsPEmd67bRwoRGWjGekjkEa+NDfCtywW2znA7pw==
X-Received: by 2002:a05:6602:389b:b0:7d0:3e4e:242d with SMTP id br27-20020a056602389b00b007d03e4e242dmr14099641iob.5.1713196766967;
        Mon, 15 Apr 2024 08:59:26 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id t36-20020a05663834a400b00482d033889csm2894421jal.171.2024.04.15.08.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 08:59:26 -0700 (PDT)
Message-ID: <12d50bb6-7238-466b-8b67-c4ae42586818@redhat.com>
Date: Mon, 15 Apr 2024 10:59:25 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org, lsf-pc <lsf-pc@lists.linux-foundation.org>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [LSF/MM/BPF TOPIC] finishing up mount API conversions; consistency &
 logging
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In case this is of interest to anyone I'll propose it.

The "new" mount API was merged about 5 years ago, but not all filesystems
were converted, so we still have the legacy helpers in place. There has been
a slow trickle of conversions, with a renewed interest in completing this
task.

The remaining conversions are of varying complexity (bcachefs might
be "fun!") but other questions remain around how userspace expects to use
the informational messages the API provides, what types of messages those
should be, and whether those messages should also go to the kernel dmesg.
Last I checked, userspace is not yet doing anything with those messages,
so any inconsistencies probably aren't yet apparent.

There's also the remaining task of getting the man pages completed.

There were also some recent questions and suggestions about how to handle
unknown mount options, see Miklos' FSOPEN_REJECT_UNKNOWN suggestion. [1]

I'm not sure if this warrants a full session, as it's actually quite
an old topic. If nothing else, a BOF for those interested might be
worthwhile.

Thanks,
-Eric

[1] https://lore.kernel.org/linux-fsdevel/CAJfpeguCKgMPBbD_ESD+Voxq5ChS9nGQFdYrA4+YWBz17yFADA@mail.gmail.com/


