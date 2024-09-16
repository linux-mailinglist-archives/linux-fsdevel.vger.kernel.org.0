Return-Path: <linux-fsdevel+bounces-29450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ED1979F34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 12:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9571F213E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 10:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F052015350B;
	Mon, 16 Sep 2024 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9RpAMTw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6C214A61A
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726482204; cv=none; b=Yxy2RcdLwuMFHSLFW/+jRiCc+b5+o5sRSltgw64EW8FAiSiIUGFlDw3ia/qja2qK7ejlU5jCLGHSqmxF7gNGjcmgUtNeJI+VGZzuUnCOQqUAYTdj/3XFdaH6mZF7ThLPgA6kfJl20h/gBxadRrXf1rlTbK7RIPAxnNr4HT1h2QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726482204; c=relaxed/simple;
	bh=IDyHODyJ4j3RdqZbw6fIagiBbvuMbzpQTmpXdcLUqsY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=PyiU6Ng9ZdWepT9O1TBUHxV9wTXda02SgarMDOytUaJbeZmSnwNiR6P9yTpUS5fA6U6ahmAbvdNfYv/XfJkWSqMntJRZlOakKW4IjqQF3HjlVQ+CMa69kit52NMoeACOYsmVRgWdl3D+lp73Hhi+JzkHT1/wbB/N+EJEeTijWyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D9RpAMTw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726482201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yhcNOV+akvmlPEBsqDRaj33vSsYLiwBwI4YZtgYT9s0=;
	b=D9RpAMTwfLgqwO6nqHNupgzl1tWQ2bZjuyGMYfK3sXDmOo4tsetCa8Y6anDMBRoW1hCdnP
	TKS1xpX0W1TCoRDIvn8omba8KMNCVnJyyiCrLIRYNqcueBJYb623B19o2aO3rWRPNdqAiH
	Oiu7Oaxepxfz1f4Jz4A2Fstv2fV7hvk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-PweIc-PCNkaGCJlIzebK2g-1; Mon,
 16 Sep 2024 06:23:16 -0400
X-MC-Unique: PweIc-PCNkaGCJlIzebK2g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12841195422B;
	Mon, 16 Sep 2024 10:23:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D5DB030001AB;
	Mon, 16 Sep 2024 10:23:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <202409161629.98887b2-oliver.sang@intel.com>
References: <202409161629.98887b2-oliver.sang@intel.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: dhowells@redhat.com, oe-lkp@lists.linux.dev, lkp@intel.com,
    Linux Memory Management List <linux-mm@kvack.org>,
    Christian Brauner <brauner@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, Steve French <sfrench@samba.org>,
    Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
    samba-technical@lists.samba.org
Subject: Re: [linux-next:fs-next] [netfs, cifs] 73425800ac: xfstests.generic.080.fail
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1835553.1726482188.1@warthog.procyon.org.uk>
Date: Mon, 16 Sep 2024 11:23:08 +0100
Message-ID: <1835554.1726482188@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

kernel test robot <oliver.sang@intel.com> wrote:

> in testcase: xfstests
> version: xfstests-x86_64-b1465280-1_20240909
> with following parameters:
> 
> 	disk: 4HDD
> 	fs: ext4
> 	fs2: smbv3
> 	test: generic-080

What's the server?  Samba, Windows, Azure or ksmbd?  It seems to matter quite
a lot.

David


