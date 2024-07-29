Return-Path: <linux-fsdevel+bounces-24403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EDA93EDB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 08:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB1B1F22144
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 06:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C408786267;
	Mon, 29 Jul 2024 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qd/0Xo5F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD5584A5B
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 06:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236158; cv=none; b=tGkPvnmIo7td6iiI4+7oB9Mlu/6vp2BnaAWe6xoFcM1Pa5soe6Zzh/Ai53LyUITXbLGtSP/3bmATDlgxDwcYBD0w6sMNxwl6e7FiOq8zw8g3Bz6M/nKWAKAwFhjQiY2W6xTEPrHIKsGSp9S4FF5Rq9glQNSZ9Zj3IYD8xyCWrwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236158; c=relaxed/simple;
	bh=o2f/k3fbOpy78TNOpxriyb94GrXVBTxBCSOf7g2Gy5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t5swfPfatMMmpwNemmXaavCjgbf6Px8RK35QE1VtghJ3cMghSvApKuXSG48BZWGS91r/W3xLqcdVu/twn9yD0Vdha0uQaP8rQc+3mcpWKl6vEuqMp8xbjdq+2qrdaklCcyv3y5n5WChy7wwMUh00+XCillhWmImQegyBTVZuLMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qd/0Xo5F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722236155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=7AWP/0qHqZ7Y61Eby5XenXroJ56XWtIdeweoRPAf8bU=;
	b=Qd/0Xo5Fhpfvndm8v0ePQmsqP6ZhiozeNKWk983rdtEF277s7ILEEjswtPO2BvAJNIgTS5
	8kX5AwKxTZVxRTqJZVCWa+N98h9+iySW+6L37Hjd6ZeU8fG2S57KwGHrurcR1jeTdGkyLp
	gwNCnnX5Y6bJ3/VbVJZy5CNyZnyay+Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-ZuWaro6hMICjUhdJNh-ZdQ-1; Mon,
 29 Jul 2024 02:55:52 -0400
X-MC-Unique: ZuWaro6hMICjUhdJNh-ZdQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B61419560B1;
	Mon, 29 Jul 2024 06:55:51 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 404B51955D42;
	Mon, 29 Jul 2024 06:55:48 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org
Cc: Dave Chinner <dchinner@redhat.com>
Subject: Testing if two open descriptors refer to the same inode
Date: Mon, 29 Jul 2024 08:55:46 +0200
Message-ID: <874j88sn4d.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

It was pointed out to me that inode numbers on Linux are no longer
expected to be unique per file system, even for local file systems.
Applications sometimes need to check if two (open) files are the same.
For example, a program may want to use a temporary file if is invoked
with input and output files referring to the same file.

How can we check for this?  The POSIX way is to compare st_ino and
st_dev in stat output, but if inode numbers are not unique, that will
result in files falsely being reported as identical.  It's harmless in
the temporary file case, but it in other scenarios, it may result in
data loss.

Thanks,
Florian


