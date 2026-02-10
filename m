Return-Path: <linux-fsdevel+bounces-76835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDaNLMQUi2n5PQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 12:21:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C48111A120
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 12:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9C33304045D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 11:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3748D3191C0;
	Tue, 10 Feb 2026 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7CyOKTs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE2A318BBB
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770722494; cv=none; b=btudpxa6B1N/7dFJDht9uzR9EBV5nb7S65zBxCrlof9FxhIpQ5816J2LcZuZmcsvHZHaRt2XYCToDn7pWmUffFYxNc0KxJ4WUpHWaNZ/n0jqSy6UdRQ9bdPCXCvCMXnEb7/2SpMoqjWwfmJH/QUOfeWU/Mbd1M9CTy9G8aACf+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770722494; c=relaxed/simple;
	bh=0gWumBa1+w8eGSje3A+Cg+/1eZb+4y0/WoxZtfA9AAs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lR0JeOpNP/6N9EFq+KKyz03JW9apbC+TcIPy7aEa8a+xO/hEDVYN4ygVL0AXtRD5TvTEC99J+geg2xOt/qpUTrP8yif4n8+IyEus1m0PtVpQ9A+XjFSVQIeO9cnvepZUJhzYnleN/gYmZFpsJd0aUlXFJGU/KjKxH0rzYWP+Y7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I7CyOKTs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770722492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bn/HijK0n86aontJ/8a34jxCjGe7rHUwAe7Sv6H1oDM=;
	b=I7CyOKTsTE+p240WeogfWVcBTwu5s47U0ydGG/kcDjGis4vIlIphiMGsfic8FpNlFA+T9s
	4UqqvrptzyTW/KnurKUdkxbrxsRbisV//KhiUe8CuCRr6kZfPLyrmREN0xTPhSrLfw3d4c
	+cUbj+H5a9DDM+35DXt0/7+q5rRj/KU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-nGW1tG9COHa2WuOxV3Oq_w-1; Tue,
 10 Feb 2026 06:21:29 -0500
X-MC-Unique: nGW1tG9COHa2WuOxV3Oq_w-1
X-Mimecast-MFC-AGG-ID: nGW1tG9COHa2WuOxV3Oq_w_1770722488
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 550D31955E77;
	Tue, 10 Feb 2026 11:21:28 +0000 (UTC)
Received: from [10.45.224.59] (unknown [10.45.224.59])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAE0E1956056;
	Tue, 10 Feb 2026 11:21:26 +0000 (UTC)
Date: Tue, 10 Feb 2026 12:21:21 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-fsdevel@vger.kernel.org, 
    Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
    syzkaller <syzkaller@googlegroups.com>
Subject: Re: [git pull] HPFS changes for 6.20
In-Reply-To: <CAHk-=wjmFiptPgaPx9vY3RG=rqO452UmOAPb1y_f9GQBtuJVjg@mail.gmail.com>
Message-ID: <0a4797ab-07a5-11ef-074f-19ad637f84ea@redhat.com>
References: <6dd35359-3ffa-8cd5-a614-5410a25335c0@redhat.com> <CAHk-=wjmFiptPgaPx9vY3RG=rqO452UmOAPb1y_f9GQBtuJVjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-76835-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mpatocka@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C48111A120
X-Rspamd-Action: no action



On Mon, 9 Feb 2026, Linus Torvalds wrote:

> On Mon, 9 Feb 2026 at 09:01, Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> >   hpfs: disable the no-check mode (2026-02-02 18:06:33 +0100)
> 
> This looks like a totally bogus commit.
> 
> If "check=none" suddenly means the same as "check=normal", then why
> does that "none" thing exist at all?
> 
> None of this makes any sense.
> 
>              Linus

I wanted to keep the "check=none" option so that I don't break scripts or 
/etc/fstab configurations that people may have.

If you don't like it, you can drop it, it's not a big deal. The syzbot 
people will have to deal with it in some other way.

Mikulas


