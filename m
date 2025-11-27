Return-Path: <linux-fsdevel+bounces-70029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 150F1C8EA01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 14:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D7043514A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 13:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A1132E130;
	Thu, 27 Nov 2025 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aoAKfVc9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A21274B46;
	Thu, 27 Nov 2025 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251692; cv=none; b=a/01zqiHgbWtq7Sp5WpF1jGQ5cM5f4xYOT3aHhW7OCiUGh9WnejDnZvuvGz5Otxu99SmFb4Q5sHQoHzVSlJqTegzR8N+Ji3uWxfLRCnE/Sc5Q1OcksJGv5OL4zv49ups5lYq9iQ6MFR8UjdmtX6lzsitS54T6XxL/JAa5t55O98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251692; c=relaxed/simple;
	bh=iACYJmqGWv7mTLZTHvA63yACqTmIZKgvi6B6vrVm5gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvg0q+ohMRBNne/X36c7ELaaoZgq8DvJ6f7Pp5eL8aL93iZn4skJhz0trJ88zcYWk7QD1D6yFgC4JZYrUstUhEjtVrLImjS7X/dmN/Z9WgsHFlKgFQCbbzIB0G9X0wJTBGTizzAqxiHgNR2Y18ToUCc6ClLGvJDoqlB8WmKZyu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aoAKfVc9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FPlh5iDpWzy3oYkKJyEDPKFCbBCTNoWio1NNY+Ejdb4=; b=aoAKfVc9h/ihKDjXlRTucCPLYk
	dPqVyKuFyj8kJvQ3mLrgtX4CZihwxSMDt01h6+9uBPRG18p5aRiARpOCDSfJWQ3rkdkN+DJUKY0VD
	KS+htVRCp0N1UJQ526/2szUW/djXIv950zbjqdegyJLh7my8ggu3/4K/ARcQTeSSVib+Qa12NjTMC
	K7MIra73jEkBdTlEN3GL7WAyEBwkQYI48XO/UiY/mBp+6hrLFddbARlTQxHgXZzXosTpAQ6fSnOHJ
	z4zRWGUomSj0gWpdEkWjo7n1MlMIkRX/NJcMPQBuLLhbWHeBckF490yoBXoHlYZZ8uQfsAnrm0rQB
	De4VC6xg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOcSM-0000000BoEc-19cw;
	Thu, 27 Nov 2025 13:54:46 +0000
Date: Thu, 27 Nov 2025 13:54:46 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jan Sokolowski <jan.sokolowski@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/1] idr: do not create idr if new id would be
 outside given range
Message-ID: <aShYJta2EHh1d8az@casper.infradead.org>
References: <20251127092732.684959-1-jan.sokolowski@intel.com>
 <20251127092732.684959-2-jan.sokolowski@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127092732.684959-2-jan.sokolowski@intel.com>

On Thu, Nov 27, 2025 at 10:27:32AM +0100, Jan Sokolowski wrote:
> A scenario was found where trying to add id in range 0,1
> would return an id of 2, which is outside the range and thus
> now what the user would expect.

Can you do a bit better with this bug report?  Under what circumstances
does this happen?  Preferably answer in the form of a test case for the
IDR test suite.  Here's my attempt to recreate your situation based on
what I read in that thread.  It doesn't show a problem, so clearly I got
something wrong.

To run the test suite, apply this patch, then

$ make -C tools/testing/radix-tree
$ ./tools/testing/radix-tree/idr-test

diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index 2f830ff8396c..774c0c9c141f 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -57,6 +57,21 @@ void idr_alloc_test(void)
 	idr_destroy(&idr);
 }
 
+void idr_alloc2_test(void)
+{
+	int id;
+	DEFINE_IDR(idr);
+
+	id = idr_alloc(&idr, idr_alloc2_test, 0, 1, GFP_KERNEL);
+	printf("id = %d\n", id);
+	assert(id == 0);
+	id = idr_alloc(&idr, idr_alloc2_test, 0, 1, GFP_KERNEL);
+	printf("id = %d\n", id);
+	assert(id == -ENOSPC);
+
+	idr_destroy(&idr);
+}
+
 void idr_replace_test(void)
 {
 	DEFINE_IDR(idr);
@@ -409,6 +424,7 @@ void idr_checks(void)
 
 	idr_replace_test();
 	idr_alloc_test();
+	idr_alloc2_test();
 	idr_null_test();
 	idr_nowait_test();
 	idr_get_next_test(0);

