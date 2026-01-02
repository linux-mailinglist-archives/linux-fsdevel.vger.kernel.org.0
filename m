Return-Path: <linux-fsdevel+bounces-72330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73019CEF338
	for <lists+linux-fsdevel@lfdr.de>; Fri, 02 Jan 2026 19:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E66A302A119
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jan 2026 18:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DE72D0610;
	Fri,  2 Jan 2026 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/y69xK2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332CB2BCF45
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jan 2026 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767379433; cv=none; b=tA3nI+KLzbZyICnxvez47+dprDEpfVLRoIX58G79kyP56NCC0WuLWf4Q5fwxJqaLMaJeLPthR2cIU76SL/+L6ziOt5XIyfhcv8p1Q0MOVgRtWNqr2iMB2/TPa/FaHR33PK3bjx8LX37LlAo9eeDpxnHCKLgxHrtQARBybzaMHJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767379433; c=relaxed/simple;
	bh=xXFwLaJLVN0S3AO/xbklyFdgLL/H9ocBcD1lYUeNo80=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=UhZrymAL+v6yM6cQ4vWpzvB/QdhKakAtm74V4uRWNIXcHfr/JFHl+zS/hmcuSXGWkKB97LdF138pjDoKvkuc0H7yV/GBAGjHULKLsJyzy/MZyO+5iJEZX/F12AIJxZYsOx3ncu43kznrBMIakGTkWH7AbSASViFQTtlAB1c0FiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S/y69xK2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767379431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xXFwLaJLVN0S3AO/xbklyFdgLL/H9ocBcD1lYUeNo80=;
	b=S/y69xK2JluFZe4RXg6LGCpOmsSIUoGG6JPXQ1OtpYeHU7ByWfGeLaX83PAuyuIBuQMrtT
	8kVhmwYi9bPPGADHHM71CBl75c7GY3uFMCE6el2O67AmvcEI5SGNtAdpngwBzRVx/TACw5
	x2G0DkFkzlHNKkM80b1KozZq0ksZ+8U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-Bc0jOwyGPkes5HuU1_9Bdg-1; Fri,
 02 Jan 2026 13:43:47 -0500
X-MC-Unique: Bc0jOwyGPkes5HuU1_9Bdg-1
X-Mimecast-MFC-AGG-ID: Bc0jOwyGPkes5HuU1_9Bdg_1767379426
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF1EF19560B2;
	Fri,  2 Jan 2026 18:43:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4895030001A2;
	Fri,  2 Jan 2026 18:43:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <qvtkweac7g5ejiicsnb7cqxlxl35toi2ykdmguaszqkcnir355@zvaw3oxlxzex>
References: <qvtkweac7g5ejiicsnb7cqxlxl35toi2ykdmguaszqkcnir355@zvaw3oxlxzex> <1430101.1764595523@warthog.procyon.org.uk>
To: Enzo Matsumiya <ematsumiya@suse.de>
Cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    Steve French <sfrench@samba.org>,
    Shyam Prasad N <sprasad@microsoft.com>,
    Stefan Metzmacher <metze@samba.org>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: Can we sort out the prototypes within the cifs headers?
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1460703.1767379422.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Jan 2026 18:43:42 +0000
Message-ID: <1460704.1767379422@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Enzo Matsumiya <ematsumiya@suse.de> wrote:

> +1 for the cleanups, thanks for doing that.
> =

> On backports, I think points 1-3 could be done together, but in separate
> commits (per header file) to minimise conflicts.
> =

> 4 looks good to have.

Hi Enzo,

Could you have a look at:

https://lore.kernel.org/linux-cifs/20251222223006.1075635-1-dhowells@redha=
t.com/T/#t

see if you're okay with it?

Thanks,
David


