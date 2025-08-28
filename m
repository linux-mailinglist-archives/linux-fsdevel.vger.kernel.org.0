Return-Path: <linux-fsdevel+bounces-59492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62546B39D8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 14:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250F61C8190B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 12:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AD630FC20;
	Thu, 28 Aug 2025 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zu/BBwm3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622C230F937;
	Thu, 28 Aug 2025 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756384949; cv=none; b=tSvgBXvc2S37QXeLWv7U1wfgur6GuQMMl7X1iifvFRUyZF7sm/5u8GS3Lu0KwC2d6A15fLg2mm57JlxotSc9R+6ocgZUqnTvD/yM4aOkcT2Us/bOoKHBzZ1CeYzwuocoRY6nBtwz9jdA7Ix8138XBOAbTYgXh9dsybB/e4XHEQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756384949; c=relaxed/simple;
	bh=QPJO80OLAwsNHbS46mfszf+j9NbPW3iQVPvMp6vZD9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPlWJ6Yi2DGwOGO14mqNK9MzXqt+yhDHqb3W6ydrI42v7P9MfsP8REegIJH/C0uyKulZnY7nXx2mNewiGKPq1ZVMpLfV4s1RDevyQnUz7J1q9ouNr4dAnhyFpQkF8i7e6v3SdLhBGlK7m95KYn5uGL5JiM3mAWaOHrUmmlG9eAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zu/BBwm3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063CDC4CEEB;
	Thu, 28 Aug 2025 12:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756384947;
	bh=QPJO80OLAwsNHbS46mfszf+j9NbPW3iQVPvMp6vZD9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zu/BBwm3fiNtSfqe5ajiNK+T/Pcp/QDTJiNVF2F2845jq167U2t6wvp5qhp5ea6WZ
	 UOyQiC3JKfsNiPxSIHcXKKz1us77JZ+vjE3vOMx0AkFN2kkcXQp93jyH3SvIt98Z1T
	 Eyk5LsnMh4AB4uj8Wd6xjeJxM2Bt8UYaHzE1yTjBcpdqni7eD5hi4xgQbeaXqCCzef
	 cBU5YvdEaSUOvKg8Qf++kdkE7fELvdfArVN3HzEWARZJmpi87u93RlB9f0eQBHcmrl
	 3p8faqPjFxwCKgCYEVAvz3nUb5KvGtbMYfTWM43jowYUuc4a6L7PA+nI+318aqZJr/
	 +Uu4eCBkixnJA==
Date: Thu, 28 Aug 2025 14:42:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	kernel-team@fb.com, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, amir73il@gmail.com
Subject: Re: [PATCH v2 51/54] fs: remove I_FREEING|I_WILL_FREE
Message-ID: <20250828-fragen-reinfallen-d5229c53be79@brauner>
References: <cover.1756222464.git.josef@toxicpanda.com>
 <8b9be971cd6ea2e19584ae3852169f01e7855ca7.1756222465.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b9be971cd6ea2e19584ae3852169f01e7855ca7.1756222465.git.josef@toxicpanda.com>

On Tue, Aug 26, 2025 at 11:39:51AM -0400, Josef Bacik wrote:
> Now that we're using the i_count reference count as the ultimate arbiter
> of whether or not an inode is life we can remove the I_FREEING and
> I_WILL_FREE flags.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---

Very good looking diff.

