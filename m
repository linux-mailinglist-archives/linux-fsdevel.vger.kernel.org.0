Return-Path: <linux-fsdevel+bounces-12033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF4985A864
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 17:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795A82871EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 16:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3CA3D562;
	Mon, 19 Feb 2024 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIQkq6OO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA1F3CF53
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359142; cv=none; b=bUbcEJOLUjRg9JeHI4QuG6UyyVNM+129FY8T7BiZKppgMDTjPSoH3uiAL9XTeXRpi5uWUantuDd/RaSmYlzFnSAgYF/m0QgEml/Pc+QzvO/BKiUPW59OkAaDbiuCpPmKjJ75MwfI4HixaJTcZwMSQOY7yctij/Y708kWE/8sAKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359142; c=relaxed/simple;
	bh=6KnJ0wJsYP4PPL5k3hrJckmE7GZOMlUN8YoSAyFXLQA=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=YQl4SuTQ++qZe0UMlASInH4CL+U9ZG3Ga9LcRWWiNdy0+dwFKvRj4VM2jO1yodxqM3HmKZFEj0FDC0/OVzPS7fJzyOCTNXPiJIgktCS08bUVUXXSc+chKNm56joZN7cAzgMCgbLgc9Y5SbPi9VJJ7SZWeOiFW1dSjAnm12lZQC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bIQkq6OO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708359140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6KnJ0wJsYP4PPL5k3hrJckmE7GZOMlUN8YoSAyFXLQA=;
	b=bIQkq6OOcuxq1dLdZTTieatMm2Ljc6hXXrWJaAxle3jrmO9g3UE+i9HodzPSPEErUPecCo
	VkNC4Azc0bSMZ9xpLTq9csgcJPgX/qe7VtetoUIzSVSmp4oqFjO57/NB2K46ki6ppkKJW8
	LmijYtb8siSn/x7oaZpMbHKhsN+ZvWA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-dv6PHkUGNxe-PkviZ87TXQ-1; Mon, 19 Feb 2024 11:12:17 -0500
X-MC-Unique: dv6PHkUGNxe-PkviZ87TXQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6AB2185A781;
	Mon, 19 Feb 2024 16:12:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 01DEB492BC6;
	Mon, 19 Feb 2024 16:12:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <187507.1708357334@warthog.procyon.org.uk>
References: <187507.1708357334@warthog.procyon.org.uk> <187136.1708356611@warthog.procyon.org.uk> <CAH2r5mu0Dw7jVHFaz4cYCNjWj9RFa76pRTyQOEenDACHDgNfyg@mail.gmail.com> <20240205225726.3104808-1-dhowells@redhat.com>
Cc: dhowells@redhat.com, Steve French <smfrench@gmail.com>,
    Jeff Layton <jlayton@kernel.org>,
    Matthew Wilcox <willy@infradead.org>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Christian Brauner <christian@brauner.io>, netfs@lists.linux.dev,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/12] netfs, cifs: Delegate high-level I/O to netfslib
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <229264.1708359134.1@warthog.procyon.org.uk>
Date: Mon, 19 Feb 2024 16:12:14 +0000
Message-ID: <229265.1708359134@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

David Howells <dhowells@redhat.com> wrote:

> so the reversion is probably unnecessary.

Removing the iov_iter_revert() fixes the problem.

David


