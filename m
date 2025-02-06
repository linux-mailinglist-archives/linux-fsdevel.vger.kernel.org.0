Return-Path: <linux-fsdevel+bounces-41050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D74A2A53C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 10:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59531882EB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 09:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91492226540;
	Thu,  6 Feb 2025 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAVXHDQ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A9C2248A1;
	Thu,  6 Feb 2025 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835714; cv=none; b=guHGL78/r0dgTU92IoISPdxYg1ekISOnlgs3fsj3ABBxXTWGkK3QSnP5+GmySxy+r6JQRcg2sdpMN/3l/r6xfSUKBkxvenv7thetm0AqtZTaXkVOGmjcd68ukREhowg1NFul0DHUfxG+a9Nj91cjGsNazZz/hJD6hm0wzBQfFFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835714; c=relaxed/simple;
	bh=Z/QmR/9sudGm7q3KtVavrUJwY14wyLF+gpeZm/QzLys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jl4WHD2tp+dMqc10ahcjTeR//5eoAYA8t1ZH87qsKhmQlJ11d0Db7RboZ0PD3FulPIgTFGFSf5LHR/bKrSePz7Z4iem9MQKktRjhs+J5ngh2yP4j5f5k04E5VkE1gfgpgJ7gDduguHomwiLxCMRotRsz5gOZWaq+l1gC8DXyTyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAVXHDQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2ADC4CEDD;
	Thu,  6 Feb 2025 09:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738835713;
	bh=Z/QmR/9sudGm7q3KtVavrUJwY14wyLF+gpeZm/QzLys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LAVXHDQ6o9AFWsfWeLBZBUdCLn7ZjZ+Ixvax0VAjrNBy3xE1QZb7Oe4viBGSiPyq+
	 5LBUCr+5STC5OsvVUd2qyc9sMGK3+UtvKzyjdJ4B9bcV4LtE3LXh33gDpjTmfeGsnR
	 jOjZGxHvOgTRMU5+9e6QkooQToBRqZrkZXkVGcEf/dVWuc0Tv94UTSEl/RFZzMgA6E
	 g1w8dzZFPckYXq5pz/DU142EsPKae3C0UaokfQ+qcKdPBQWLf6KDx5vsngPt1Jbtgm
	 e7Gk9VcVZeLMjKZ15EJuPq96fQhWoP/OcdTyzdl45DgpV4ebcDOY7/BDFg5Ps1pkKa
	 bfUqIzlZWIizg==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Oliver Sang <oliver.sang@intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	WangYuli <wangyuli@uniontech.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] pipe: don't update {a,c,m}time for anonymous pipes
Date: Thu,  6 Feb 2025 10:55:02 +0100
Message-ID: <20250206-muschel-spiegel-a0ede4c84b9d@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205181716.GA13817@redhat.com>
References: <20250205181716.GA13817@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198; i=brauner@kernel.org; h=from:subject:message-id; bh=Z/QmR/9sudGm7q3KtVavrUJwY14wyLF+gpeZm/QzLys=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQvafthPDEzRt7qsabfw8eP1oWvu/X8Zls6o0qWpoBMc WeR88VTHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5osrwV/JW4Z/gHN+IG5o9 MqvuCvN9lKp7rnUgfNp3k2nvN/ut2sLIsEVFnHt2xJ0zUza0F/2a0c4ZwLQoVMbPeXL3mi3MFxy W8wEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 05 Feb 2025 19:17:16 +0100, Oleg Nesterov wrote:
> OK, let me send v3 right now...
> 
> Changes: make pipeanon_fops static.
> 
> Link to v1: https://lore.kernel.org/all/20250204132153.GA20921@redhat.com/
> Link to v2: https://lore.kernel.org/all/20250205161636.GA1001@redhat.com/
> 
> [...]

Applied to the vfs-6.15.pipe branch of the vfs/vfs.git tree.
Patches in the vfs-6.15.pipe branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.15.pipe

[1/2] pipe: introduce struct file_operations pipeanon_fops
      https://git.kernel.org/vfs/vfs/c/262b2fa99cbe
[2/2] pipe: don't update {a,c,m}time for anonymous pipes
      https://git.kernel.org/vfs/vfs/c/f017b0a4951f

