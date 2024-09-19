Return-Path: <linux-fsdevel+bounces-29690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE5397C4B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 09:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C90284EDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 07:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DFF1922E2;
	Thu, 19 Sep 2024 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwPGXseo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B3E191F74
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726730103; cv=none; b=Bf24tVHz4zHAs1nk3f4FXZLDmaBDufFf3KwuJXwG9hupBh/jdSPOvKZAkE+hWQhvAxHQbT+jmWiFx1HGglOvCa8V8tPLiR/oCPm4oyHtEznPTuGFlQApubgVqiMTS0c99w1RDoNBXGxJAKP2XacNjks4OQgiHjg8koLNL6iKRtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726730103; c=relaxed/simple;
	bh=3fu2R6VjCNf8S/hTyWiWirNIbRj+91Q4h3lKUDxGjFs=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=AsyyQyxXxSkyblwnNPep7YKANQooB76S4wYFf9mqKYu4qnI/eNkZxhkWEKl21L/ztG+l4zlrvg/KjLaNtkFawmESrh6eV4tHaxXO4TbIrrOJ2hjcOfMxNNx19OA70LFwc0UGy1S3SJEyjrh5jPncfS5GXNnOFW2CgGIwZx9/2a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwPGXseo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726730100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMqoWuobw5l9koUmoBCzrdvCUK0MU5ZKjXUbz06jGjs=;
	b=TwPGXseov059FB2UBod+agUDU0WbpEhPg9b5HL3IsRO7rdHFmow78wobcJbjyA8tQMH0Yr
	A8SpARt6JNMfh2ZarIinxQZyej/0jPZDqmu3i2syAT5Xcrv9Ndzw+vs/50anW9rWMyWJac
	tXC360uGi3axPsju6QSpUGa35uHwBmI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-6nnPfg1YO1yaBiEl9iKj0Q-1; Thu,
 19 Sep 2024 03:14:56 -0400
X-MC-Unique: 6nnPfg1YO1yaBiEl9iKj0Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D62C419560BE;
	Thu, 19 Sep 2024 07:14:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 65816300072E;
	Thu, 19 Sep 2024 07:14:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZuuLLrurWiPSXt7X@xsang-OptiPlex-9020>
References: <ZuuLLrurWiPSXt7X@xsang-OptiPlex-9020> <2362635.1726655653@warthog.procyon.org.uk> <Zuo50UCuM1F7EVLk@xsang-OptiPlex-9020> <202409131438.3f225fbf-oliver.sang@intel.com> <1263138.1726214359@warthog.procyon.org.uk> <20240913-felsen-nervig-7ea082a2702c@brauner> <2364479.1726658868@warthog.procyon.org.uk>
To: Oliver Sang <oliver.sang@intel.com>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Steve French <sfrench@samba.org>, oe-lkp@lists.linux.dev,
    lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
    Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org
Subject: Re: [linux-next:master] [netfs] a05b682d49: BUG:KASAN:slab-use-after-free_in_copy_from_iter
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2537823.1726730090.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Sep 2024 08:14:50 +0100
Message-ID: <2537824.1726730090@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Oliver Sang <oliver.sang@intel.com> wrote:

> > Can you tell me SMB server you're using?  Samba, ksmbd, Windows, Azure=
?  I'm
> > guessing one of the first two.
> =

> we actually use local mount to simulate smb. I attached an output for de=
tails.
> =

> 2024-09-11 23:30:58 mkdir -p /cifs/sda1
> 2024-09-11 23:30:58 timeout 5m mount -t cifs -o vers=3D2.0 -o user=3Droo=
t,password=3Dpass //localhost/fs/sda1 /cifs/sda1
> mount cifs success

Does your mount command run up samba or something?  This doesn't seem to w=
ork
on my system.  I get:

andromeda32# mount -t cifs -o vers=3D2.0 -o user=3Droot,password=3Dpass //=
localhost/fs/sda6 /mnt
mount error(111): could not connect to ::1mount error(111): could not conn=
ect to 127.0.0.1Unable to find suitable address.

David


