Return-Path: <linux-fsdevel+bounces-59389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D57F8B38609
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 17:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A318D3671F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 15:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA68276048;
	Wed, 27 Aug 2025 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEWOPwlc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE19275B1B;
	Wed, 27 Aug 2025 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307679; cv=none; b=s0YzLr/HVyrJ2oYdcst7QGsUkWk2nQEPjOCuN+V9szO9y1j7EV1MqDUfL8j9JB96AxygtWvzhcirBs9SA8PquRsHU0tl9UN1pIhAEK7mYXQUZWG1+qxRVSBNuqxpofmrhQeRQhpTBRB56SDMhHUTo5rR1vtoq6bgLNdhSU50bpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307679; c=relaxed/simple;
	bh=QEXhxovWYUHVgBkEl/gTdcNOIaqUcKQWivj1PPJZ8ak=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Kj5h731xrtRMlsud5Fi2zcvo9ovuqHUvgLsWbU0mfwJjn0uGCKknN2W15QH0Ynx2fQj8t0Yc/zRIC9klZRUIFP56mmSGzqxoclCiBX7/FMiMgBPtgXO2K/Drv9X0asRA7cBeKT/XcDYV8iZv+Po9bbhfsamWDf0hNRPe7c8joA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEWOPwlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E17C4CEEB;
	Wed, 27 Aug 2025 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756307679;
	bh=QEXhxovWYUHVgBkEl/gTdcNOIaqUcKQWivj1PPJZ8ak=;
	h=Date:From:To:Subject:From;
	b=sEWOPwlc5DcbkrzZsmuHKldDt3UJ3b5kzMqaCJH54R/JAgt6PKT+d3cIy9+n5HXOl
	 sd8nKssxoWawsydvr/q12+rIZjQUWAR/O04Ah7W0Nn14jGr/6lrt27ZdXEPLZtUNEG
	 N9u9zlQR5O0fOj5LjrlB8PpLE1M1QF2HlDFUb7L2I01sJxQDPsxpbrV36AEv/VrrAi
	 YoDcUISMUVxYkOZbn0QqiN58yH4HiN/3K6qkOaIfboApMQA71dWUsVLgEILXNDETX7
	 jC3NgGuiaF5jF4praeEiyqacWdNqNSXKvt7anzhGEfGjEMskyGaRogWYkaZV8Kxfpq
	 21/HIz6dxHsTw==
Date: Wed, 27 Aug 2025 17:14:36 +0200
From: Andrey Albershteyn <aalbersh@kernel.org>
To: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fstests@vger.kernel.org
Subject: Tests for file_getattr()/file_setattr() and xfsprogs update
Message-ID: <dvht4j3ipg74c2inz33n6azo65sebhhag5odh7535hfssamxfa@6wr2m4niilye>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

This two patchsets are update to xfsprogs to utilize recently added
file_getattr() and file_setattr() syscalls.

The second patchset adds two tests to fstests, one generic one on
these syscals and second one is for XFS's original usecase for these
syscalls (projects quotas).

-- 
- Andrey

