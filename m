Return-Path: <linux-fsdevel+bounces-18724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1754B8BBA81
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 12:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ADEAB21999
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 10:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2364A1802E;
	Sat,  4 May 2024 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iu++Z7ti"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8A0EEB2;
	Sat,  4 May 2024 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714818148; cv=none; b=mUe3UEaFo61R4WUll89l86fg3BT6uGtgST9ydgqK+Bj6/c4DmaEHXkbVXJoQmAjC2PVHcBu2sPjONUKDIWbWE/+QwyOanh2V2f+tlfckLUvW0CCWC90yX7bREYJa0iKmhmzOYy70piVInMeobONzW2ym9NTL5lbjIg+qwhMAHJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714818148; c=relaxed/simple;
	bh=Y+62+v4QzViMQav6U3UW7GLCIaVgf0yM4MdiPjt00s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g7u69sEZ8l1KL09qxvZ54pQtOb958549xQw+jSMNl0Dil0tKPa1Y7qGAh3qaWBnsuFZGuO62nQ8iEr0UkdPgZpg82+OXV+JJVFbzQWB3T14QuPfEu3bKxtxigtpHisIyt0B/I36XgWj2WjR2d8cvTFyewlRpIMM+mo26E8dlD20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iu++Z7ti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE99C072AA;
	Sat,  4 May 2024 10:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714818148;
	bh=Y+62+v4QzViMQav6U3UW7GLCIaVgf0yM4MdiPjt00s4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iu++Z7tiHPWWCAP2cpgRX+1/GBfcz75lOv8suI7jk7eUBJclxzMeCOpCvFKFoOVYU
	 4SuFPBBT5sCHVAvKgduNaPwIkmhA4yMYim/8hY39mIldwhPc0fzM1mqVZSXPIAzrG/
	 +MkwNAJRs6iXXqazvkFtPpZEvx+7vaiO+mnQn5xbVWMzjUkIPHS9uJWx9g358jJ7c/
	 QYs+mtgsmtLwHXIqrAl8U1Q2sTGSEp6MJCJiwAwo43J8cfedWzTW5AJt9ORY/GzMpl
	 GRds8qmQvg9wUrPfst+a/6r2Ld5xqhHzwLNh0inG9Yy0W6PCReo124fXwOYIuJoMqj
	 h21pzuu7SyPkg==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] afs: Fix fileserver rotation getting stuck
Date: Sat,  4 May 2024 12:22:14 +0200
Message-ID: <20240504-checken-bankdaten-9f8d7a288ba5@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <998836.1714746152@warthog.procyon.org.uk>
References: <998836.1714746152@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=871; i=brauner@kernel.org; h=from:subject:message-id; bh=Y+62+v4QzViMQav6U3UW7GLCIaVgf0yM4MdiPjt00s4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSZ8cTxvuXfsPju3QObtEXi5omstqti5H419XmuhK2Yn uZl5kLtjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm8ymVkWBjFpB+4IU9loYZl kVLuoz7b/E03JiyPWn72X8zqRw+YOxn+1zm2Fi9OP16sur/1q1N2cKDPsdjDilOks+7/2MMv/Vq RFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 03 May 2024 15:22:32 +0100, David Howells wrote:
> Could you pick this up, please?
> 
> David
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

[1/1] afs: Fix fileserver rotation getting stuck
      https://git.kernel.org/vfs/vfs/c/21965b764cec

