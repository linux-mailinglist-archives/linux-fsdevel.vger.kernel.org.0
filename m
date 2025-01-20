Return-Path: <linux-fsdevel+bounces-39671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 036DAA16C66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 13:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15A1188994A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 12:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063591DFE11;
	Mon, 20 Jan 2025 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fy6+23Rt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE24B1BBBDD
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737376357; cv=none; b=YSu2sGtwaOOXl+wH1oQHWBeF4pSvT9lEu9WufJ26ix1GOuSY0SWVdDnrQcBkVAX8sZfiqUWgHRnxZyaS0OH6l4Dgtxlyn7GTUN+qJBmcbiIpOnGEakEiIvp9m1pvPgvfGiSJ+ZkpZM2RqjACU8YlINTACZswLJIzEagR9s4EuIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737376357; c=relaxed/simple;
	bh=+LwCxqVRPS+wr+2Tv84R2MAyCpcbym4LbR2Ue/sGWOk=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=PDPEgHUNat8mr6rMFZ9q2C+w3lHyJDMSS5j11l+plV3QiSs0/EIDmNXN31vb40B3gc3jFUXwkWRROaNk4PSRXIL+5E6mMP2fJ+Z+KklYW9CvQnHRkSQ3WgfTWeCA5Z7lQENwZNagg0GG8roEjxnxxog4XH9gG/JsD/lrjGaF+BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fy6+23Rt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737376354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=opcTe4i6eDAWBVL9dz77gDa+ZjIgR8GU9Qdfcu40y4s=;
	b=fy6+23Rt7TeCoSOpm9dM5BFgqNfJWqqK2sWz9BI7BWUdN0BnXDpnXmN4kioetPzWPzhk9x
	wrILwQuaawTFlJjEtnjY0JipqGzet2hpFIlEKLf/b2jRfMjtfZR58zV/6XywsrLj+4BKPg
	V91q6baJ3yRjcOjnaAJFKxBCpUGOARE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-OqGN2ih8O6a1pGYi9oKy9A-1; Mon,
 20 Jan 2025 07:32:32 -0500
X-MC-Unique: OqGN2ih8O6a1pGYi9oKy9A-1
X-Mimecast-MFC-AGG-ID: OqGN2ih8O6a1pGYi9oKy9A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE62719560B0;
	Mon, 20 Jan 2025 12:32:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9972A19560BF;
	Mon, 20 Jan 2025 12:32:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Eric Biggers <ebiggers@google.com>
cc: dhowells@redhat.com, Alex Markuze <amarkuze@redhat.com>,
    fstests@vger.kernel.org, ceph-devel@vger.kernel.org,
    linux-fsdevel@vger.kernel.org
Subject: Error in generic/397 test script?
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1113698.1737376348.1@warthog.procyon.org.uk>
Date: Mon, 20 Jan 2025 12:32:28 +0000
Message-ID: <1113699.1737376348@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Eric,

In the generic/397 test script, you placed:

	$XFS_IO_PROG -f $SCRATCH_MNT/edir/newfile |& _filter_scratch
	$XFS_IO_PROG -f $SCRATCH_MNT/edir/0123456789abcdef |& _filter_scratch

but neither of those lines actually has a command on it, and when I run it,
I'm seeing xfs_io hang just waiting endlessly for someone to type commands on
stdin.

Would it be better to do:

	echo >$SCRATCH_MNT/edir/newfile |& _filter_scratch
	echo >$SCRATCH_MNT/edir/0123456789abcdef |& _filter_scratch

instead?

David?


