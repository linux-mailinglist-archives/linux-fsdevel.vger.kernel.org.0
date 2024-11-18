Return-Path: <linux-fsdevel+bounces-35110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5239D1573
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 17:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9351F23594
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 16:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4065E1AA1E4;
	Mon, 18 Nov 2024 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+ZgNer4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317581BBBC4
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731947740; cv=none; b=RzmWMd9Xzzq5pn2TfA19URUPppr5Dhyh9Xf2ySmKVjlEcORi18YZGdC1/D9H3fooyL32o6j9OMD0vCRoa9P+hTRJ5hNR896vME1KaD0O866mLPxj2oKoqqLouv1au7iEDUUXazEfMYRy2s9XGKA8h2V+vrqa1GL5mWQz5BexzDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731947740; c=relaxed/simple;
	bh=wwmrSMmvUtQxOnWoWMX94ibGfGj/+431cg0WAd2Ud6U=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=spVXHUty0mkcmbKfw17QQJooigd9eqGvkcIY82W+hX/d2mCBkL1frHxidE7ISUq1311BBnQEPxFV9lQDKs7MShgpxIf4LjyCvK7bkAfn1EXn6zMCO3CqFTCAZ6ifo5BrAoLqE6nmxFUSn14VCWJBRVHPSQSSnehezMyh0yLotQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+ZgNer4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731947738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F48vEQ6V/tDlXaOtinAU3DdgDvVmHs2S/fGlg/NOvdQ=;
	b=C+ZgNer4hKOeHdJEBG/l6jXUewb3GN736uG8q4K4/NF8RzEYX/ixS5TCkMfD/cdt+Xct8Y
	MKVk2ifwKjV6qHboJL65bnLN0aow7LdWt8Hs/+sDR6naIxDDZlqlrLNacPsmA5TLIqJT62
	F0F0Cu3nbjXKcvtoR6R9kiGO9Jinitc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-HpCdFzANNgKaFZmQE0YgOw-1; Mon,
 18 Nov 2024 11:35:33 -0500
X-MC-Unique: HpCdFzANNgKaFZmQE0YgOw-1
X-Mimecast-MFC-AGG-ID: HpCdFzANNgKaFZmQE0YgOw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5300197731B;
	Mon, 18 Nov 2024 16:35:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.207])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 710421956054;
	Mon, 18 Nov 2024 16:35:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <17eb79fc-ccd9-4c85-bd23-e08380825c41@ijzerbout.nl>
References: <17eb79fc-ccd9-4c85-bd23-e08380825c41@ijzerbout.nl> <20241108173236.1382366-1-dhowells@redhat.com> <20241108173236.1382366-24-dhowells@redhat.com>
To: Kees Bakker <kees@ijzerbout.nl>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>,
    Jeff Layton <jlayton@kernel.org>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 23/33] afs: Use netfslib for directories
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <941498.1731947719.1@warthog.procyon.org.uk>
Date: Mon, 18 Nov 2024 16:35:19 +0000
Message-ID: <941499.1731947719@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Kees Bakker <kees@ijzerbout.nl> wrote:

> > +	iterate_folioq(&iter, iov_iter_count(&iter), dvnode, ctx,
> > +		       afs_dir_iterate_step);
> > +
> > +	if (ret == -ESTALE)
> This is dead code because `ret` is set to 0 and never changed.
> > +		afs_invalidate_dir(dvnode, afs_dir_invalid_iter_stale);

Yeah.  I posted a modification for this in response to someone else.  ESTALE
needs to be set if iterate_folioq() returns 0.

David


