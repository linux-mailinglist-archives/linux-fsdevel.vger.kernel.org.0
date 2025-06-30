Return-Path: <linux-fsdevel+bounces-53371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B11BAEE23D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 17:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A6016CCB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 15:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1145E145A05;
	Mon, 30 Jun 2025 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZcqGJVO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CBA282FA
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296808; cv=none; b=ExwpCroEP9NFBVjZTUwt+OwMlNebhgmDPpJnIRrObl87pwYFyAuFEsmGAbpgYZwx6lcec7mIrv1NWc3R8D8x0Nls0iqctGl0MY3ckELKnZnVGW68u5DpnMnolbIMoybenyRrfzEuVY3gWB1d19BAIe+C2RPfyKION6tgPJxfWJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296808; c=relaxed/simple;
	bh=ya7wcD5yfsiXCm55GFY8eie48QajbOjJa0OeploAzHw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=YfofOOc8D5zQ1iG6goZsAwPkIfeMww4LhZrN138+OJkyX0YKjpQpC/E7WbfCWle6qLE1V0/6rIoKVVKmelEgHNyQfEbtYXDpMaqMp9vO2EOGwd7eC8mBNo8lDBzUUcAyAiMQSpv8xYcsXoJosFD8nexEa84peJvUlDfynFUQJxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZcqGJVO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751296801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeJejenb3ZKRAuQ++TIJa8SnjDhxsEyhgjt8xl7y/Ec=;
	b=cZcqGJVOnvLLpxFzveDhVL8rVt0iFIBkxjwOMIjBg7JiOpmTbKer4jVC0yFBw9NOLxI2rM
	Ck3wknBrSQc1pS71HeFFRpUVLeSf8MMH82QZm744IVKHeqoG1a5oMxrivk5DqJpJgFFo0y
	tZm+PDH0tdS2XGqpZBFY5a6LAJYNmqI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-BoFHmpyNNWeY30Rvj17yxg-1; Mon,
 30 Jun 2025 11:19:58 -0400
X-MC-Unique: BoFHmpyNNWeY30Rvj17yxg-1
X-Mimecast-MFC-AGG-ID: BoFHmpyNNWeY30Rvj17yxg_1751296797
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D8D11944A8D;
	Mon, 30 Jun 2025 15:19:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 48A3A19560AB;
	Mon, 30 Jun 2025 15:19:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250628075849.GA1959766@ZenIV>
References: <20250628075849.GA1959766@ZenIV> <20250623044912.GA1248894@ZenIV> <20250623045428.1271612-1-viro@zeniv.linux.org.uk> <20250623045428.1271612-17-viro@zeniv.linux.org.uk> <CAHk-=wjiSU2Qp-S4Wmx57YbxCVm6d6mwXDjCV2P-XJRexN2fnw@mail.gmail.com> <20250623170314.GG1880847@ZenIV>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: dhowells@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>,
    linux-fsdevel@vger.kernel.org, brauner@kernel.org,
    ebiederm@xmission.com, jack@suse.cz
Subject: Re: [RFC] vfs_parse_fs_string() calling conventions change (was Re: [PATCH v2 17/35] sanitize handling of long-term internal mounts)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2085735.1751296792.1@warthog.procyon.org.uk>
Date: Mon, 30 Jun 2025 16:19:53 +0100
Message-ID: <2085736.1751296793@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Al Viro <viro@zeniv.linux.org.uk> wrote:

> Frankly, looking at that stuff...  I wonder if we should add
> vfs_parse_fs_qstr() for "comes with length" variant and lose the length
> argument of vfs_parse_fs_string().

Um - why use a qstr?  Does using a qstr actually gain anything much?  Why not
just, say:

extern int vfs_parse_fs_str_len(struct fs_context *fc, const char *key,
				const char *value, size_t v_size);
static inline int vfs_parse_fs_string(struct fs_context *fc, const char *key,
			       const char *value)
{
	return vfs_parse_fs_str_len(fc, key, value, value ? strlen(value) : 0);
}

Is any arch other than i386 limited to fewer than four register arguments?

David


