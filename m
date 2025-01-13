Return-Path: <linux-fsdevel+bounces-39084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D79B9A0C0D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 19:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A903D3A2E4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 18:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7733B1C5486;
	Mon, 13 Jan 2025 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBbJ+bCP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289BA2B2DA
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736794413; cv=none; b=oGoegqq/wqzHhl6EQIavIuenR+BTgn6Vzp4jDC4WW+fHEAisElD/IBq3YJCb0bJDydkwsbMrm96GoC8Vz+MaXHYKI5QNN2zdjo6x8lHmQtvduAZZ3Y5JEKZfMr00q2u7497QDyDXRb4l6341ShE3THwknkZu875eFE920d9w72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736794413; c=relaxed/simple;
	bh=2dkygM1+F7ng0CXJhY9rw5Uo2Gm1mS4UHZYlkhW+6JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fANa/oBY+wEGytPbCSh24eoQrZ+N1Cs10YIH+iBAVS0/PE508EsIYsTvNQ4FwWmZK7FN/B2mBsA/TDVn4o8nYCUV1b7oaWuH0h84WIEsLp+4l46BSrlKMsH+b7oDMbdn5E5Y+GnHe+44G97WFsJgECGsdtfSjfH26f6WSm2VFMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBbJ+bCP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736794411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tN6TnFm2Xr2+2MnjTv8L6Mquqv9TtlwwwWgfBy/a+KM=;
	b=PBbJ+bCPrIkAYaol7WSC/p4O51mnxK7h0xPczsl5g6UfyyO3qaU4WdnOyhL6BW4F3bln5h
	TVkWSh3iJoOXS0iYgoyUbzBgSTO3dH1HZXfis8xrGQ9S4YfBm4MZAAA+PsDzjaF+V2Xd/s
	44+7bAaDB9Er71Yad2pK2V5CWAm4rew=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-kmv7AmIpMjWz73eOauhPwA-1; Mon,
 13 Jan 2025 13:53:27 -0500
X-MC-Unique: kmv7AmIpMjWz73eOauhPwA-1
X-Mimecast-MFC-AGG-ID: kmv7AmIpMjWz73eOauhPwA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 40CB719560B7;
	Mon, 13 Jan 2025 18:53:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.5])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 753B6195608A;
	Mon, 13 Jan 2025 18:53:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 13 Jan 2025 19:53:01 +0100 (CET)
Date: Mon, 13 Jan 2025 19:52:57 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
	Christian Brauner <christianvanbrauner@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [brauner-vfs:vfs-6.14.misc] [pipe_read]  aaec5a95d5:
 hackbench.throughput 7.5% regression
Message-ID: <20250113185257.GA7471@redhat.com>
References: <202501101015.90874b3a-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202501101015.90874b3a-lkp@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Well, I guess I need to react somehow...

On 01/10, kernel test robot wrote:
>
> kernel test robot noticed a 7.5% regression of hackbench.throughput on:
>
> commit: aaec5a95d59615523db03dd53c2052f0a87beea7 ("pipe_read: don't wake up the writer if the pipe is still full")
> https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs-6.14.misc

Hmm. Not good ;)

But otoh,

> In addition to that, the commit also has significant impact on the following tests:
>
> +------------------+-------------------------------------------------------------------------------------------+
> | testcase: change | stress-ng: stress-ng.tee.ops_per_sec 500.7% improvement                                   |

So I hope we do not need to revert this patch?

-------------------------------------------------------------------------------
I am looking at

	https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/hackbench/hackbench.c

and I don't understand how can this patch make a noticable difference.
And can't reproduce,

	hackbench -g 4 -f 10 --process --pipe -l 50000 -s 100

on my laptop under qemu doesn't show any regression.

OK, in this case the early/unnecessary wakeup (removed by this patch) is
not necessarily bad, when the woken writer actually gets CPU pipe_full()
will be likely false, plus receiver() can wakeup more writers when it does
the next read()s. But 7.5% ?

Perhaps this is another case which shows that "artificial" benchmarks like
this one are very sensitive... Or perhaps I am trying to deny the problem.

So, Christian, et al, unless you think I should try to investigate, I am
going to forget this report. If nothing else, "500.7% improvement" doesn't
look bad even if I have no idea whether the stress-ng.tee.ops_per_sec test
realistic or not (I have no idea what does it do).

Oleg.


