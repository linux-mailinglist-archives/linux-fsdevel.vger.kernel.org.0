Return-Path: <linux-fsdevel+bounces-45103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931B0A71EBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 20:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C84BB7A70DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 18:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EB5253349;
	Wed, 26 Mar 2025 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdQt4jVo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676591E1E08;
	Wed, 26 Mar 2025 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743015591; cv=none; b=XAT0Gyv1hdvJvzEliBPoGzIKmsVDQYHnd+xnAWgF3z6aNeHl+kmrk+71MOA6Bgz8UZ+Jb3GiCFhqUX+X9myufwLZVG5/MKDObHRQ8n5QGpr8kJ/bdIgor0aqLjegvZ/Csdi7uG+QK8ciCy/ozbnGpGbbzegzpSHWOIIdthd8rTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743015591; c=relaxed/simple;
	bh=pW+KWG0BasRbETrmC+vBqDBocdhh2fAVnZiSRD4q2gc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VE2vKNyf+qtOqDcamJ7oU6w/Zxq8i1Zq/M8MTnQe3TZD/ZVyCeDgClivNgo01kmESDH07hNQtOEhrPr0e2tP+DK3+mxzll5XAMN5h1B668s9fjbE3eT6awm1IfHQithRBmX0hPOGDmwet85KRyJVtFZO7RgO2CRT9s8P7XgvVVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdQt4jVo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EDEC4CEE2;
	Wed, 26 Mar 2025 18:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743015590;
	bh=pW+KWG0BasRbETrmC+vBqDBocdhh2fAVnZiSRD4q2gc=;
	h=Date:From:To:Cc:Subject:From;
	b=AdQt4jVo/w8czNYEpwhuRoPfhsRB9oOegrxPVD88aqwo45NHon6775piY1lqgvnem
	 CH2kv7dYLJ/xgbKqMROeeoKdIwGBWwkYspJRZpYPBZ32e2ri2kpKIjGKzgehd8DvF/
	 M19dSUOrtdLRNCZbG8L3GVt32en1JK++IkF8NdQ/VVu8Uxv7s8XPu84LhcOF4lFIOd
	 SjfRhfQkBpdmTE8vuwEvsr5W5PLCbGyCvQWfSf8+4cTGnY5ViU95Ah61bK2ySwd89A
	 gjSZi5UdDbR/zA9PX+y7sYm2Oj9LFzGwy8Batiw8uYsSewHpYi4E/D+Ma7EcWRlYRP
	 ZaKv+x0gPLlig==
Date: Wed, 26 Mar 2025 11:59:48 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: lsf-pc@lists.linux-foundation.org, patches@lists.linux.dev,
	fstests@vger.kernel.org, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	oliver.sang@intel.com, hannes@cmpxchg.org, willy@infradead.org,
	jack@suse.cz, apopple@nvidia.com, brauner@kernel.org, hare@suse.de,
	oe-lkp@lists.linux.dev, lkp@intel.com, john.g.garry@oracle.com,
	p.raghav@samsung.com, da.gomez@samsung.com, dave@stgolabs.net,
	riel@surriel.com, krisman@suse.de, boris@bur.io,
	jackmanb@google.com, gost.dev@samsung.com
Subject: [LSF/MM/BPF Topic] synthetic mm testing like page migration
Message-ID: <Z-ROpGYBo37-q9Hb@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'd like to propose this as a a BoF for MM.

We can find issues if we test them, but some bugs are hard to reproduce,
specially some mm bugs. How far are we willing to add knobs to help with
synthetic tests which which may not apply to numa for instance? An
example is the recent patch I just posted to force testing page
migration [0]. We can only run that test if we have a numa system, and a
lot of testing today runs on guests without numa. Would we be willing
to add a fake numa node to help with synthetic tests like page
migration?

Then what else could we add to help stress test page migration and
compaction further? We already have generic/750 and that has found some
snazzy issues so far. But what else can we do to help random guests
all over running fstests start covering complex mm tests better?

[0] https://lore.kernel.org/r/20250326185101.2237319-1-mcgrof@kernel.org

  Luis

