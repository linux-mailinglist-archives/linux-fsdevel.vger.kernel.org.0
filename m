Return-Path: <linux-fsdevel+bounces-59620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF886B3B4A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 09:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 274747B6A61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 07:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47723285068;
	Fri, 29 Aug 2025 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAdV+x6e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0144284B26;
	Fri, 29 Aug 2025 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453667; cv=none; b=I7s3nTazWDElIKhD8cz6yRjlXJAy9QskaNI6rfwAm6NCAmKcO62WUNSO4fBgXwB+6TDmymI6LZsvlH/zgMVNoB02VRguN/sFBk+52clRo9tgIgbKdOsQGWgLsxNNb7+pii+XqamPt+vQfg7jDlcL/aXBFQrAVzojROpd4f3YkHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453667; c=relaxed/simple;
	bh=Jy7pGBPtr8Vlq/VT0ZBckUR2OS4i9xJbszZQLf2lEaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0D/5IHcMdqdAS1aFcwqQxV4BH2xq0IxGuPADN+C9+H18t6V8cDuQEoPQLRC91hWrH1mNe45e5urGm5BY4A65tZG3dmZ6G4x3ZcSfsmBa1BElSYvoh+jmgjsPGDgm3oAi0YFrWHcPEZ95EECEz1BieXlMLJ/FN+ADewhRzTFVrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAdV+x6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA31C4CEF0;
	Fri, 29 Aug 2025 07:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756453667;
	bh=Jy7pGBPtr8Vlq/VT0ZBckUR2OS4i9xJbszZQLf2lEaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QAdV+x6e2chE6Xp//l1xxS50lRGq50bdGUkNkjCmaH+W6wJcBDva0n5D/99lqVUJb
	 yQhFyrupTlxRDzKu44Jw449KMavtcDWl6M4sKCtRByDDrQNP09klymwXh718IUoOvj
	 v28XFPDIyH3mFSa+gTN1+LgJdZdVYaZjt2r91KHL1SsclADuUjsVVL/paksK5M6X+5
	 fwXvJev9jitNJtChr3vW9jnANZPlv4WDMHmBSjbFLPA/0VbA7tJue9pExssrcPFitG
	 1rpTWzD7A5zp9JOsdKOGwLvj7HLPyBWcZYedb1ZhA91jRvtR1nZF3sCNbr/QKe93dX
	 7uxarYwnG26CQ==
Date: Fri, 29 Aug 2025 09:47:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] do_nfs4_mount(): switch to vfs_parse_fs_string()
Message-ID: <20250829-pappkarton-heimreisen-f43ae434b7e9@brauner>
References: <20250828000001.GY39973@ZenIV>
 <20250828000113.GB3011378@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828000113.GB3011378@ZenIV>

On Thu, Aug 28, 2025 at 01:01:13AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

