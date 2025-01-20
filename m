Return-Path: <linux-fsdevel+bounces-39677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7396AA16EB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 15:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7F8188248E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 14:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB01E1E500C;
	Mon, 20 Jan 2025 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWAlrYfW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D09F1E493F
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737384258; cv=none; b=aJiF6388u5GlhYtwa4brMoN+KRCDx6ChEYXZmOTVXRJ3jtaLJU++WJzUSKZmpOXAlS/UtnssgU2ntyx7b4HJdZDfAfZqRF8uHKDVlJbmWMk4B0MPzXkElyy3Pykn4w1+ELNrN+/NrgrdVXQKVtBvU5kyzDaqr4FvrIx72/99OIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737384258; c=relaxed/simple;
	bh=gROTbni+M8gwxpHDPaPMyGoaAQV5BZl3k8BCVpraGt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzVzkTXgaDd22qiVsjca+MdE8cVGaDo1KXa20wu9jL1mpDMrgC5/ZDgQ6Kvh+Dq73LqzbMOQckM7Jz4XNN+xtONjONeG+VQ946nDv18/lbbpP8EMCVsrmD6Rvw6yG1JFUQjkk0HA7ToeUCgvYfK9FMl0ssax/YCLrK5F9wDnOp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jWAlrYfW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737384255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+C9wHaY+wGka9yWDgVpMApTjF3kwH8GQpQyEqhleVdM=;
	b=jWAlrYfWjqWk9lwgMFDOPGzN9qJj/bY5eft7n/w+1Il2cRvoVdbWTJuaATt3ixTBxpXiLd
	J581C0cwLsDI5mX0odw6G7vI+lViNH9LqHOMM8pj+9EsNFo+xwSKBRc6Rbj31wAC3SdBld
	5oXKDeRyD0AXb9XEyPglG8TcKC4d/X0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-L3EBYPfuN1mAsMpQ9T1AJA-1; Mon,
 20 Jan 2025 09:44:10 -0500
X-MC-Unique: L3EBYPfuN1mAsMpQ9T1AJA-1
X-Mimecast-MFC-AGG-ID: L3EBYPfuN1mAsMpQ9T1AJA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38F941955D97;
	Mon, 20 Jan 2025 14:44:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.104])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 361911956053;
	Mon, 20 Jan 2025 14:44:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 20 Jan 2025 15:43:44 +0100 (CET)
Date: Mon, 20 Jan 2025 15:43:39 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Christian Brauner <brauner@kernel.org>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [linux-next:master] [pipe_read]  aaec5a95d5:
 stress-ng.poll.ops_per_sec 11.1% regression
Message-ID: <20250120144338.GC7432@redhat.com>
References: <202501201311.6d25a0b9-lkp@intel.com>
 <leot53sdd6es2xsnljub4rr4n3xgusft6huntr437wmaoo5rob@hhbtzrwgxel2>
 <20250120121928.GA7432@redhat.com>
 <20250120124209.GB7432@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120124209.GB7432@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/20, Oleg Nesterov wrote:
>
> But I'll recheck this logic once again tomorrow, perhaps I misread
> pipe_write() when I made this patch.

Meanwhile I wrote a stupid test-case below.

Without the patch

	State:	S (sleeping)
	voluntary_ctxt_switches:	74
	nonvoluntary_ctxt_switches:	5
	State:	S (sleeping)
	voluntary_ctxt_switches:	4169
	nonvoluntary_ctxt_switches:	5
	finally release the buffer
	wrote next char!

With the patch

	State:	S (sleeping)
	voluntary_ctxt_switches:	74
	nonvoluntary_ctxt_switches:	3
	State:	S (sleeping)
	voluntary_ctxt_switches:	74
	nonvoluntary_ctxt_switches:	3
	finally release the buffer
	wrote next char!

As you can see, without this patch pipe_read() wakes the writer up
4095 times for no reason, the writer burns a bit of CPU and blocks
again after wakeup until the last read(fd[0], &c, 1).

Oleg.

-------------------------------------------------------------------------------
#include <stdlib.h>
#include <unistd.h>
#include <assert.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <errno.h>

int main(void)
{
	int fd[2], nb, cnt;
	char cmd[1024], c;

	assert(pipe(fd) == 0);

	nb = 1; assert(ioctl(fd[1], FIONBIO, &nb) == 0);
	while (write(fd[1], &c, 1) == 1);
	assert(errno = -EAGAIN);
	nb = 0; assert(ioctl(fd[1], FIONBIO, &nb) == 0);

	// The pipe is full, the next write() will block.

	sprintf(cmd, "grep -e State -e ctxt_switches /proc/%d/status", getpid());

	if (!fork()) {
		// wait until the parent sleeps in pipe_write()
		usleep(10000);

		system(cmd);
		// trigger 4095 unnecessary wakeups
		for (cnt = 0; cnt < 4095; ++cnt) {
			assert(read(fd[0], &c, 1) == 1);
			usleep(1000);
		}
		system(cmd);

		// this should actually wake the writer
		printf("finally release the buffer\n");
		assert(read(fd[0], &c, 1) == 1);
		return 0;
	}

	assert(write(fd[1], &c, 1) == 1);
	printf("wrote next char!\n");

	return 0;
}


