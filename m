Return-Path: <linux-fsdevel+bounces-61085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CBDB54F31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 15:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47CD618947EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 13:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212983054E8;
	Fri, 12 Sep 2025 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3HAKQak"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E197296BBF
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683024; cv=none; b=mFrrb9z9lmb9JKBFzfv8878kgvQTEoinO7EpKokYvj67zrsOY/a+uIbji41xhGcK/puzOiMzOd6JhMcPs/NdZEFKCeYCLwMkYVTwl454L/WTz6FZ/4R/te22sfXIikiXeBPbyasDWEF0PqvReXqkZhMeZX8J3xCzv/WttIC59zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683024; c=relaxed/simple;
	bh=HUotpdxSABv1lyYQxUIX2UPM/oLyxUnuS2uFxCWtHeE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=I7lRmz1d84ETGz+oz0fUZc55RZ319atAo+cDZh7uc+f68ZwTRFBo50tEy2BQ5Pj9azaMcbvxUeMzR6IHOu3FvVQYaJTO8Qr525PCS7A/XP4qVpWWT688k/mLVIArkHXHKbNXcIQKRabC+7J0lZ8A29ICvnl2v4UeCG+jsHHQcXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q3HAKQak; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757683021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xekp7EDDzr0m2PAiQg+EXramAasisk4ChofTFwXbhdM=;
	b=Q3HAKQakK29dqKQJMQSfgXvCQ7EUddOyshpHdseVrD7yP9h1aN6AdAWG7scQNOARpMaXMX
	y04/PN9lqGRIDqWO8XoEJBKv1cUG2S6g1Dnf6bhjYtpMNMyWfiHNNywLav30T3sgBkxx4u
	F1/KPVndtMb1Dn8OA0JtMz4QbNGveHg=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621--SbYGyIuN2O5jOaCco6wuw-1; Fri, 12 Sep 2025 09:16:59 -0400
X-MC-Unique: -SbYGyIuN2O5jOaCco6wuw-1
X-Mimecast-MFC-AGG-ID: -SbYGyIuN2O5jOaCco6wuw_1757683019
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-52b51898eb7so677531137.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 06:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757683018; x=1758287818;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xekp7EDDzr0m2PAiQg+EXramAasisk4ChofTFwXbhdM=;
        b=bSju+BUA77kmCFMBZFHJagAeMMsSPMuJqCxL/yB/sSRG1Gt+5FYZtKPhzU0uJW3GN7
         HuVMiinmNrww5E9z0gDqWcIPJzYrdPEraDDzGSBG52cGTz3eGWeeqGxxxoEWl9SMjIvM
         FOfOqEIg/H/dsgFqhJtHUpr93n8Cm4aVIFxL3Zbrj4XHHXQcJGGb1gCMRXy6/5eQVC/y
         v66gd8q+MnNK4FMRxFQpyT1P7YQ2eZ3y7XI8GR+gPcCAjifcgx11/6RutAcrogxni5Ra
         Kf0e4nkjgL+Dk5sVBpr5LBcuL/cFUkCGoYPTugTk/n6d635nefXQxu5whvhhbWQ4RkwK
         UZFQ==
X-Gm-Message-State: AOJu0YwLf0RGuBw72xb/kUz17D9l7phwkgCvjaQPe6yn4J0n0Kxc/9ky
	enHM47jc33W+cF3l3AEgRGg+Ypw+JRtazpnorQq6A88CMP9XIuGcGt1evPK4mXc+DgHYsaeY3nk
	I3Fqg242prP6qNTCM9JYfkvDQ7BaBbzaIgbv7c+Dxtr2vCtdoHb5ATQ7Wx110sexNtBwGLGnzbB
	8=
X-Gm-Gg: ASbGncvHFqziZy23bMwnpg2JUm0QmDIPMUnVeNTw8g2EgTXYcUN8G6WdkaMPBjfz9xE
	Bc/u1Vk6arrhskJXOJHuYZl6HQkVwFZ38ZDPivglcs37akgpz+3NyPO+gMpevoIbs+45P/66YQX
	Gl0PL3CUupu7RtyTZ85tUn7UtCko+tWBsiPfsXIqRCNo7+o0HypXfWvGWOWq+jsRHCicwXJpOsq
	bWoancSYlkXqssdQIdi4RqCv18u99LPNqfmxOdXz+H7l0RxGbNBG+M7G0uZaaDuuqaJCBmhOsQh
	wUXS1vMr9TWDx8H+KLJGtxBxmhjmDgo0gKJW1v8a69HrgIN/DvCxTjsUYvtyDaEJgp1v3/AuvO/
	Q6hiqHfKlIeKP
X-Received: by 2002:a05:6102:161f:b0:520:c9fc:4cd6 with SMTP id ada2fe7eead31-55610dc11bamr999734137.31.1757683018013;
        Fri, 12 Sep 2025 06:16:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy5p9XVJyrKpSYkBmYux9zpNWbBN4mg8XJyO3zO3aD26LTDabBnfSqlm86j2Hh8UDjM3J5cA==
X-Received: by 2002:a05:6102:161f:b0:520:c9fc:4cd6 with SMTP id ada2fe7eead31-55610dc11bamr999652137.31.1757683017483;
        Fri, 12 Sep 2025 06:16:57 -0700 (PDT)
Received: from ?IPV6:2603:6000:d605:db00:e99e:d1e3:b6a2:36ac? ([2603:6000:d605:db00:e99e:d1e3:b6a2:36ac])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820ce386b67sm260230585a.53.2025.09.12.06.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 06:16:56 -0700 (PDT)
Message-ID: <6f271c01-cd4b-456b-80ac-77a96b99a1fe@redhat.com>
Date: Fri, 12 Sep 2025 09:16:54 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Steve Dickson <steved@redhat.com>
Subject: ANNOUNCE: nfs-utils-2.8.4 released.
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

The release has a number changes in time for
the upcoming Fall Bakeathon (May 06-10):

     * Added new support to rpcctl
     * A number of systemd updates/fixes
     * A number of bug fixes to nfsdctl, gssd and nfsrahead
     * Warning fixes for the latest compilers

The tarballs can be found in
   https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.4/
or
   http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.4

The change log is in
    https://www.kernel.org/pub/linux/utils/nfs-utils/2.8.4/2.8.4-Changelog
or
  http://sourceforge.net/projects/nfs/files/nfs-utils/2.8.4/2.8.4-Changelog


The git tree is at:
    git://linux-nfs.org/~steved/nfs-utils

Please send comments/bugs to linux-nfs@vger.kernel.org

steved.


