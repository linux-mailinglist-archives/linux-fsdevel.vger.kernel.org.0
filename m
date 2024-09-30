Return-Path: <linux-fsdevel+bounces-30347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E63A698A1FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 14:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897D9281594
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 12:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C92192B60;
	Mon, 30 Sep 2024 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoGvy5J5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D35118E778;
	Mon, 30 Sep 2024 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698320; cv=none; b=oKwYAR7k50fwuKZGrRfj72/987Va2AjuR2lTvW61aep+FEs8GK5igcHKCM6BiZ9nNcvB3JKsaS86kig7Ds14Jw7Sy3wVZFI7lKTh8rswgwISUxYLWnqs2hzVc5cK3brYjAZmlOxr/qm+CQWCWMQFKO+pWC71+jAurt1XWoWIqCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698320; c=relaxed/simple;
	bh=PN+pVT5TT24Sk4ntvNlo6LVYPStz22N4kv1xhwFM2ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8EzSuNAzN0VltEOMuvW2Uw/Rkt+d8v0v97Tx8gIDGfpxRi2iU+qO8ueh4DQRhhOLa1YaBatiud7SDkLvEIfb7Qk966Vj0Fx9yn692gNZpm681VcELfUMGN5DE2aZi2LrAWP9u6rIPHKN5mq77G2xV0m216g51c9gC+x93Li8fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoGvy5J5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4136C4CEC7;
	Mon, 30 Sep 2024 12:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727698320;
	bh=PN+pVT5TT24Sk4ntvNlo6LVYPStz22N4kv1xhwFM2ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PoGvy5J5eH8MF9+NlPUsxr0y7cW7mk1uVSGZCWpodlJVW2Wpxc69+7O429eGafTAP
	 eIGp+zkvY4w9Ks09thnUMcpXyJwh62J1Bf2GrYdvYVVL8GgdKgJ6WhJDVesFkTgW1Y
	 LwbmJuJuMFFbVd5fwGXCSoQqrGPcChaZIoVkRFzzyk2I00ES6BvZanIvTpp7oNJhc/
	 9BAHQDlD1rEJJc4NI79sfIL1x/rc1n8fESTpG+z/PKUhA1aWcHqAvYhbFI2Yz4thOj
	 a4XwXh2zT4FCBQULzVkXl/q5TgAkY+OtMKlJUchABUpa1EFx60BvJKgqVrJFkC5PUx
	 o8SdzGR9H+Q5A==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix the netfs_folio tracepoint to handle NULL mapping
Date: Mon, 30 Sep 2024 14:11:54 +0200
Message-ID: <20240930-gasversorger-dient-dd843f92df8b@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2917423.1727697556@warthog.procyon.org.uk>
References: <2917423.1727697556@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=brauner@kernel.org; h=from:subject:message-id; bh=PN+pVT5TT24Sk4ntvNlo6LVYPStz22N4kv1xhwFM2ks=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT9mtrlxrd02+HPC7vncF6JUxdYa7ucJ0f6fd9DraJgv nlsJ5JlOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyV52R4dyR/hcZabtM7832 cPD38J45dUVMLp9Om/3TrGW9okdP3WH47+sYqLNvCcNeuTbP9l07VnD8Twiavv1cT4u71gPbq9P seAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 30 Sep 2024 12:59:16 +0100, David Howells wrote:
> Fix the netfs_folio tracepoint to handle folios that have a NULL mapping
> pointer.  In such a case, just substitute a zero inode number.
> 
> 

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] netfs: Fix the netfs_folio tracepoint to handle NULL mapping
      https://git.kernel.org/vfs/vfs/c/f801850bc263

