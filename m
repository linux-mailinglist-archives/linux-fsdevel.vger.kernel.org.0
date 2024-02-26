Return-Path: <linux-fsdevel+bounces-12788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DFC867306
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 12:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FD1287EEE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 11:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086E91D545;
	Mon, 26 Feb 2024 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFZfWHym"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677AD1CF8F
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708946872; cv=none; b=idAwYBp0iPMbV3Yf23aAr9qJm8jF0JRqaIFdYk4PIb3BplWCYFZEK/hUULtt0vmPCwtZXMLnSwGzVpcCz4Qg3QbV94mz23G3a6QjGVy0KI6bwMo6z2nWwRK1PwIEkw4nQS7rKw5iYYV5/tIMInGCFKzMmlIcjNP6BQA9mxy9ZVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708946872; c=relaxed/simple;
	bh=O7nR7P59uCe23H3uS2e+JSh/+7/6VUa8WWelv1T33rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daD3KZjZ6J0U+xNK32gLJAgp9p+b1gQZWiBqFEuMWaeGgSU/4lepStGIOw7RyVPDIoZ1EaTGpsah2t+Q+rpEnAyZCP/Twh+tywdMODe2UW7ow+dRGA+zQ+CV3IfaGijmoA2IUkgPGAy8LQGISvkuypqcR/sO5F862H1o3pOYfYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFZfWHym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAE8C433C7;
	Mon, 26 Feb 2024 11:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708946872;
	bh=O7nR7P59uCe23H3uS2e+JSh/+7/6VUa8WWelv1T33rU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZFZfWHymycuE0nYElq7kpqDo1q+PK1XYaJ/sGZZ7GgsUZ/hBFjBnzTJDEQpGshReM
	 ZnVaFqfNoq0Tn5j/pWxvdhFuBXgAl2D+rD3cu4ZPm836F5RY/mXHc/meJ/OSeeEtZo
	 QVBiGLJ8+BnDm2Ik6RcXea+rssQSbjBYLva16/f1BLdgYenEds994wKAeXQzVZBR/Y
	 1AcFGALC+7dgLfXS30YrVF6E65JqvhYp9wi6BwTQq4ehv7xOGeI2zSY/+cVjGDkeaJ
	 Giw06envQHzeLYtk4TImeb49q6GdVCSKYbXBofNPUuHGoUgNgmXe/8oZOTbB/bpKmf
	 k7ziRbrIqS9Lw==
Date: Mon, 26 Feb 2024 12:27:47 +0100
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>, 
	Alexander Viro <aviro@redhat.com>, Bill O'Donnell <billodo@redhat.com>, Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH RFC] vfs: always log mount API fs context messages to
 dmesg
Message-ID: <20240226-geboxt-absitzen-57467986b708@brauner>
References: <9934ed50-5760-4326-a921-cee0239355b0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9934ed50-5760-4326-a921-cee0239355b0@redhat.com>

> * systemd is currently probing with a dummy mount option which will
>   generate noise, see
>   https://github.com/systemd/systemd/blob/main/src/basic/mountpoint-util.c#L759
>   i.e. - 
>   [   10.689256] proc: Unknown parameter 'adefinitelynotexistingmountoption'
>   [   10.801045] tmpfs: Unknown parameter 'adefinitelynotexistingmountoption'
>   [   11.119431] proc: Unknown parameter 'adefinitelynotexistingmountoption'
>   [   11.692032] proc: Unknown parameter 'adefinitelynotexistingmountoption'

Yeah, I remember that they want to know whether a given mount option is
supported or not. That would potentially cause some people to pipe up
complaining about dmesg getting spammed with this if we enable it.

Ok, so right now invalfc() is logged in the fs_context but it isn't
logged in dmesg, right? Would it make sense to massage invalfc() so that
it logs with error into the fs_context but with info into dmesg? This
would avoid spamming dmesg and then we could risk turning this on to see
whether this causes complaints.

You know you could probably test your patch with xfstests to see if this
causes any new test failures because dmesg contains new output. This
doesn't disqualify the patch ofc it might just useful to get an idea how
much noiser we are by doing this.

