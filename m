Return-Path: <linux-fsdevel+bounces-55034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BD4B0682F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 22:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3110F7B3FA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 20:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5917C2BE7D9;
	Tue, 15 Jul 2025 20:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAgPb5sS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF0F1F0E24;
	Tue, 15 Jul 2025 20:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612967; cv=none; b=DJavZePG0VKMzZOzM4nmQpXtaszkhz7UagdAXih+/QDpOlvgZLMJUmsFckkt/zeLA3Ho4RCQL3YNw8YRzx2w6A8H71jvs7jQxshI03K/ArXgmCzePhpcHqUknlBbZmavzJHtR3Z/vfo/vntrkCN5goLF9OLqd72DSOLaKPFBSvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612967; c=relaxed/simple;
	bh=BypLHT8P3y7WLcxpAqRf9nezS1MXJSKqpoWXatLi35Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwM3cgZGp7vTJ1fIUFVhwLvjcw7yRjxZl34kuGXMdW0i9FaTsvmFkACshM+cE3x2Xmy0ebtshA7KU8HdQqcSvBmD59GP4XoRhkn+oqAheC9yMG74JaSnWFk9HONv4dLDjWS5a68ytbj/OHklv25WjrepOpfce/VFdXzakk0mnho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAgPb5sS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC9BC4CEE3;
	Tue, 15 Jul 2025 20:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752612967;
	bh=BypLHT8P3y7WLcxpAqRf9nezS1MXJSKqpoWXatLi35Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gAgPb5sSG955z0OLvwZTks1uWTR0zFbzL+bgn37yNPO9OwCbjWyZenxB2NhU9PjEK
	 2nWUmDRao/DnjxwrGOKGCopYuqmXp5ayTa31AnSCS7eJDn5LQ4+uMFKCleJoWTT2S8
	 rXtFFVJQLFcf/k1KI7+rlsN6jNlj/774pp24ThYNdEjBonSXFG43QamgWrp9Gpe3sl
	 jlwU1bKkMxYBR2vx29ZCNEgaCZtfJ/2zgbJ/zTOUmlAOg3OtD3I5ytGaTSdYmjsFA2
	 8mtVnEu0K64YvnY5WsHSwP/3eV7MjGMPai0FcDwYWWWQOC85+m+9JVNVX3raJGWwcm
	 sYESA+iKvoLFA==
Date: Tue, 15 Jul 2025 14:56:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <aHbAZBf12kiEdXfH@kbusch-mbp>
References: <20250714131713.GA8742@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714131713.GA8742@lst.de>

On Mon, Jul 14, 2025 at 03:17:13PM +0200, Christoph Hellwig wrote:
> Is is just me, or would it be a good idea to require an explicit
> opt-in to user hardware atomics?

IMO, if the block device's limits reports atomic capabilities, it's fair
game for any in kernel use. These are used outside of filesystems too,
like through raw block fops.

We've already settled on discarding problematic nvme attributes from
consideration. Is there something beyond that you've really found? If
so, maybe we should continue down the path of splitting more queue
limits into "hardware" and "user" values, and make filesystems subscribe
to the udev value where it defaults to "unsupported" for untrusted
devices.

