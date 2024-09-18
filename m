Return-Path: <linux-fsdevel+bounces-29635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7D597BBA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 13:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9868F1F270EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 11:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2FB183CB7;
	Wed, 18 Sep 2024 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNLOU90P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C4933F9
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726658882; cv=none; b=Am7wcOFan9fM4OF3aGEejLiZFFBXiZfdr3QDXOsfzbKAvIyjhpm6s4HyyNZhxDTEPEwSOtLWr+f5my5q8oiFYAi6HiKIDo1/+O4g5S2/pQvc64ZiAGJMN9wUhEKTpaBdYD+BaZ7R9h1sSFI7oh0K2HKmlIqT+eN5ZxMpAhPbhpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726658882; c=relaxed/simple;
	bh=h3PxtgG18fRNrqR5ZxmHQwbqbTlcCW0ZMTWQUWQxVcg=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=f8VROzUZI5sJ+rgPM9htuOpIWhGQMSDVaSYDVasjruGb+OAK9hesGNDPddeF+96lz/vjWfoj8DGb/0HYuNKoK7LSVBVPJDu50nJo+sjBI53B8vv2l2mCqLmc1YXTAV3cfal8/bFy4qdFXdLg9XXpPxUUoxXOP+kfDn+jT81Yx3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNLOU90P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726658879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+UGEvbKyesbbUFBcxjG6xHerzuj7QJo5Vx5xmFlkpNA=;
	b=GNLOU90Puis//M32dj2BGsWkkqLSyqO7ChszDaTEEAP1cJjHW/BfK5COZ5Q6q6lYjhU9UH
	7Pj6nFp2y/rJwNy8/eUNu1pXHU/AQ2xmmPuYsrLNlQNsMKLu7ZXKjebETj6Olqj9I8D8p4
	eVMFOkUBtR0eLf2TPyrabwSWOPEeMvY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-Mai1MHWNPOWT7kJbAjDSSg-1; Wed,
 18 Sep 2024 07:27:56 -0400
X-MC-Unique: Mai1MHWNPOWT7kJbAjDSSg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D464219560BD;
	Wed, 18 Sep 2024 11:27:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5772219560B0;
	Wed, 18 Sep 2024 11:27:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2362635.1726655653@warthog.procyon.org.uk>
References: <2362635.1726655653@warthog.procyon.org.uk> <Zuo50UCuM1F7EVLk@xsang-OptiPlex-9020> <202409131438.3f225fbf-oliver.sang@intel.com> <1263138.1726214359@warthog.procyon.org.uk> <20240913-felsen-nervig-7ea082a2702c@brauner>
To: Oliver Sang <oliver.sang@intel.com>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Steve French <sfrench@samba.org>, oe-lkp@lists.linux.dev,
    lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
    "Jeff Layton" <jlayton@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org
Subject: Re: [linux-next:master] [netfs] a05b682d49: BUG:KASAN:slab-use-after-free_in_copy_from_iter
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2364478.1726658868.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Sep 2024 12:27:48 +0100
Message-ID: <2364479.1726658868@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

David Howells <dhowells@redhat.com> wrote:

> Does this:
> =

> https://lore.kernel.org/linux-fsdevel/2280667.1726594254@warthog.procyon=
.org.uk/T/#u
> =

> 	[PATCH] cifs: Fix reversion of the iter in cifs_readv_receive()
> =

> help?

Actually, it probably won't.  The issue seems to be one I'm already trying=
 to
reproduce that Steve has flagged.

Can you tell me SMB server you're using?  Samba, ksmbd, Windows, Azure?  I=
'm
guessing one of the first two.

Also, will your reproducer really clobber four arbitrary partitions on sdb=
?

David


