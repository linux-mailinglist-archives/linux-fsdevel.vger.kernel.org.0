Return-Path: <linux-fsdevel+bounces-10459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D9984B5EF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A9C285AD7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 13:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F344E130AC5;
	Tue,  6 Feb 2024 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jw6VHZF6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4BD2BCE8;
	Tue,  6 Feb 2024 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224802; cv=none; b=KCJH4NdKlEvw8Ur01+sIYEHvPmSDKSJOd0RnbWi5x6a1FwC3uJQCsP8VKcJjzHT3EzAjzPQlx2Tp+hJL4rk1HNYx1FwSAmtTtN8eawjh5e+8KXuddsCKbMXAzRj2AxVemxmhymJkJ9MnpitrYxvMC/agjm4vjrgyB5pKHG2YEbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224802; c=relaxed/simple;
	bh=znXXXW+2+UB9AsEyxME9EuhEuQIpcxvc7+GfF1GzZFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfDzXjTg54GDjTE0bit5WS0JqZqKUiDXNu/sTRJngSK4vApg+49ALbSbcXQrM39R5YzwYZuSS+9Bb4u9OYT4xUBFUi2qRbV5Q/p4jXOJVY6OTuclxkMhwY+jhgyqKfq4nW0qW8XxLKKzib8q8oJ59FuPzAaNqOW0Pqsd8/1OXGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jw6VHZF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A466FC433F1;
	Tue,  6 Feb 2024 13:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707224802;
	bh=znXXXW+2+UB9AsEyxME9EuhEuQIpcxvc7+GfF1GzZFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jw6VHZF6iUptl85cKX1PPVXX4FACo42dcGe0SWJ97OUwzAoSfIRs/+z0Zxg3rkX5l
	 zttq5RoV7pU+np3o95pY6B8Lz6mjd436c9gOKn+Kh/ex0q13ekQKNoY4ASzXYgFRVL
	 ++8EkbaxiJPkq5GhoFRRnsnLot+fVQdz0hP78EAtmeRcff9/c+kpIGYtqnM7fJRATC
	 G54hdqsCH6cDUNZKVt+owZvCbxrTDjfZFfdQd+JJHBAEvbnxKIWiEU8cBW0bHwryzJ
	 kdg07Z/PqXMyc6EOiyr1bhKp8JfXYw4kvkDYYaNS7Y3LxLPNdcBxHEHbH6cEoJuzU0
	 q4QKL1A+X7EOA==
Date: Tue, 6 Feb 2024 14:06:36 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: JonasZhou <jonaszhou-oc@zhaoxin.com>, CobeChen@zhaoxin.com, 
	JonasZhou@zhaoxin.com, LouisQi@zhaoxin.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] fs/address_space: move i_mmap_rwsem to mitigate a false
 sharing with i_mmap.
Message-ID: <20240206-beinbruch-unverantwortlich-03a9093aa161@brauner>
References: <Zb1DVNGaorZCDS7R@casper.infradead.org>
 <20240205062229.5283-1-jonaszhou-oc@zhaoxin.com>
 <ZcFqWifk2cBExIvG@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZcFqWifk2cBExIvG@casper.infradead.org>

> Got it.  OK, let's put this patch in.  It's a stopgap measure, clearly.
> I'll reply to Dave's email with a longer term solution.

Fyi, I've picked this up yesterday. You should've gotten a notification
hopefully.

