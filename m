Return-Path: <linux-fsdevel+bounces-36689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1E89E7EDB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2024 09:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D4B1886DE5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2024 08:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA00B13A868;
	Sat,  7 Dec 2024 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3BCsiM5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1C4179A7
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Dec 2024 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733558709; cv=none; b=LZXNSK7M92GySg9/NgquPTTU5gOZrje7oX0rvaTerLpiG2PioF9/cCQyXhG6TyCsdqSTdZdsXoTnsNP+vL1vuGmXQI0EltN1/Iap3EMk5pVuDQqJ63IxhmiZ1AmbGcFS4NqLEMZ7sqPjXlAULPCQpHLXyG746Lcl/eqOYVAISW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733558709; c=relaxed/simple;
	bh=PAhM07Qc7YaFwjuqfUenmvzH/reHcz3buscnthZUWX8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=h0SvQ9gqhS6RCHrSRdYquHkGdBUIfM+cWCYlwHepqRUqcyTtkJkE2gXILGw48Pfq/gRBFDwOyzaqcu7SV30YU6fDH3K8yEaiqYJpgWH81ViJlKpMz3SedbQAHQ1tw1WhC0HaxjZnGSfsZ7wFcTsxmae3tSbXtOmPyWX9ZsR03Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G3BCsiM5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733558706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFtTVo7qj7Zbkvdz2irO0cofpFinUnu6G9OsPRVU7YE=;
	b=G3BCsiM5wgwTITyMLY0JLiJ8ZsUeWOe3ejtKdUoCDtZrVNcpKjL/oFk9RE2mYBALPkbYr5
	0+wToWoxlaIBB00i9NBel1k35Cqlz+wggFk2pvieCJpK2jzzLS5eNfxcyvbQfzZrJ9kkOo
	d6fNCzmeBp2QzRc/uwjqkhONinSCQBE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-0VKMLTSVPX-mqpbMfXuGhA-1; Sat,
 07 Dec 2024 03:05:02 -0500
X-MC-Unique: 0VKMLTSVPX-mqpbMfXuGhA-1
X-Mimecast-MFC-AGG-ID: 0VKMLTSVPX-mqpbMfXuGhA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C07C41956052;
	Sat,  7 Dec 2024 08:05:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 908A61954200;
	Sat,  7 Dec 2024 08:04:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <69667b21-9491-458d-9523-6c2b29e1a7e6@gmail.com>
References: <69667b21-9491-458d-9523-6c2b29e1a7e6@gmail.com> <20241207021952.2978530-1-zilin@seu.edu.cn>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: dhowells@redhat.com, zilin@seu.edu.cn, jianhao.xu@seu.edu.cn,
    jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
    mjguzik@gmail.com
Subject: Re: [PATCH] fs/netfs: Remove redundant use of smp_rmb()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2011009.1733558696.1@warthog.procyon.org.uk>
Date: Sat, 07 Dec 2024 08:04:56 +0000
Message-ID: <2011011.1733558696@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Akira Yokosawa <akiyks@gmail.com> wrote:

> Are you sure removing the smp_rmb() is realy the right thing to do?

The wait_on_bit*() class functions, e.g.:

	wait_on_bit(unsigned long *word, int bit, unsigned mode)
	{
		might_sleep();
		if (!test_bit_acquire(bit, word))
			return 0;
		return out_of_line_wait_on_bit(word, bit,
					       bit_wait,
					       mode);
	}

now unconditionally includes an appropriate barrier on the test_bit(), so the
smp_rmb() should be unnecessary, though netfslib should probably be using
clear_and_wake_up_bit().

Probably we need to update the doc to reflect this.

David


