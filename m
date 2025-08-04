Return-Path: <linux-fsdevel+bounces-56630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E8FB19EE7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 11:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3370A168BB0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 09:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9533D248F6F;
	Mon,  4 Aug 2025 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QirBR6wx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7254624678C
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300492; cv=none; b=vGuiDPAOlCBLnrp6ClbD3XbVYgclh5h6fIDvrCYz4GdWM4uEeBtvN/S8mO5nlGayoWp/IDx2rmMdDqWxeoTAHbZcMBCRXn3rUKvR6JGTDhE8nX1z5hbcLxtCq4ra62B5y9EcPLRgBR4RVAz5f2LC3cWG59KJdYznGR+hgV0DQAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300492; c=relaxed/simple;
	bh=9BeJjzIV7PW1mD3wJFcUMB2ahYXJpcnJUi1SGTLHl38=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H5yUdv8iOhYfGNyeLKRxT+KzOOxVnos5fQog4Uw2MdHN0jxKrL38oK2OyUj65bCEt+hBouEHGc3BaOBWdC2p8jiWgxikNbph0sjGrXeG1tD2LMHeZFsaTpRJuLq26dHn0RqyHItoiBOk4+RsDs0yGgHKT7eaalIuiTheKY1TPQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QirBR6wx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754300489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=2OCYWrc6BHgvKuJJ5vVnAAScgqOfEJ0zjxiiRv3CRcQ=;
	b=QirBR6wxM7B40UUz+gTx/mEjR6J9XMWdwZMXUPielLaTDs/QFYzLc7VqmzfcShXL6Qmjo5
	U1lYJ8c5cMySxYV+i33tIkmzC1tDE4rZJxJkAsFeOe5TesAxce1dbM6OugHpd2xjP3UT0I
	NThUSfH9EBkgJRFIxzs2dtg4+RKtu1s=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-pclK-NvQMMm__chp9JdPSg-1; Mon,
 04 Aug 2025 05:41:24 -0400
X-MC-Unique: pclK-NvQMMm__chp9JdPSg-1
X-Mimecast-MFC-AGG-ID: pclK-NvQMMm__chp9JdPSg_1754300483
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86C0D1955D48;
	Mon,  4 Aug 2025 09:41:23 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.224.14])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3DF91800B4F;
	Mon,  4 Aug 2025 09:41:21 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: fuse-devel@lists.sourceforge.net, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: copy_file_range return value on FUSE
Date: Mon, 04 Aug 2025 11:41:34 +0200
Message-ID: <lhuh5ynl8z5.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The FUSE protocol uses struct fuse_write_out to convey the return value
of copy_file_range, which is restricted to uint32_t.  But the
copy_file_range interface supports a 64-bit copy operation.  Given that
copy_file_range is expected to clone huge files, large copies are not
unexpected, so this appears to be a real limitation.

There is another wrinkle: we'd need to check if the process runs in
32-bit compat mode, and reject size_t arguments larger than INT_MAX in
this case (with EOVERFLOW presumably).  But perhaps this should be
handled on the kernel side?  Currently, this doesn't seem to happen, and
we can get copy_file_range results in the in-band error range.
Applications have no way to disambiguate this.

Thanks,
Florian


