Return-Path: <linux-fsdevel+bounces-43347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E43A54A1B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 12:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2011188B49F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 11:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D5120A5C1;
	Thu,  6 Mar 2025 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PctWb+aW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40EE1EE03B
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741262044; cv=none; b=ru4Tk0GeLQizAU7/Pv8U6IKaL2C8QIPqa6r6q/IemTeFJ01BrgpghvlFA9orLO4mmqVZ/oFLooQtfvF4ghBJJg1+4fR3AHapT4Fmuic+mNp7UQIK8IruLWMHUk+tM89epErM0KH7VXY4fB8L29rLV/KNGKCPPlO0fwRUQgbRE/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741262044; c=relaxed/simple;
	bh=VKqgIxMnZqaDhI884XJ6RPXbshJDFlXkWCM9B65EeSo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Fs+LDqkEzUl4NoAoF1HYeHC1DnM4JD5hVGrIBJkosmx1X+fA2HMjTajVqennn4+kg8R/KdtlCXY4VX4IXNCyqpnv6l6JJw8DWc6D9oGit1ctyO0iBZ3DcRril/DOWMy44hsfQfGjafKMIJ8X0cIuDuevC03hemhfZ2My+jVu5PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PctWb+aW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741262041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=VbDwloGI3pR8CEEcBlzxPvYiwRf7jT1t5V5YK8N6l+4=;
	b=PctWb+aWwX2yPLkx88QD7LFKfz0ji7MtdCVot+73GP+hIJhXcOUOpjYvme6Qbd9dV7zeq7
	EQu8nuPBqNCMIbKUvytVLTfvtaOhj/Z2vOUU2GFTuXn9amIBBzHrQvoVLRPRBaKHkqAGtV
	ZXHI8Mz0OHb3ol38RCXDKvqMTdTUB5k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-yvKlDf8CPLuqvtvcJ1YIzw-1; Thu,
 06 Mar 2025 06:54:00 -0500
X-MC-Unique: yvKlDf8CPLuqvtvcJ1YIzw-1
X-Mimecast-MFC-AGG-ID: yvKlDf8CPLuqvtvcJ1YIzw_1741262039
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 499A519560B3;
	Thu,  6 Mar 2025 11:53:59 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.247])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E6901801747;
	Thu,  6 Mar 2025 11:53:56 +0000 (UTC)
Date: Thu, 6 Mar 2025 12:53:53 +0100
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.41-rc2
Message-ID: <jnoop7vzwoott376m2y7y7nru5yr2xtgtdcsueqgd7igleooyb@gen2pdy7cbln>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111


The util-linux release v2.41-rc2 is now available at

  https://www.kernel.org/pub/linux/utils/util-linux/v2.41/util-linux-2.41-rc2.tar.xz

Feedback and bug reports, as always, are welcomed.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


