Return-Path: <linux-fsdevel+bounces-27229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFC395FA5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 22:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9344B1F21197
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 20:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CB1199EA7;
	Mon, 26 Aug 2024 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ei6CbuRA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60AD199259;
	Mon, 26 Aug 2024 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702768; cv=none; b=Wqc+7igizLDOpqtRILI6x59TpwIpOSxdjM9JXBn0emL6oQOt7fQMfNis2uJhpZNA6Wtzj8GqyPcutxPUOcPSsYa1LfaNy5WQmI7VQO1auZ/US9VJ8P+mxSGji84D9vS/r9Z4LYFBkYd6lUY/3U9JOGYktpXHLIMhf8COiks2ytA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702768; c=relaxed/simple;
	bh=4HdFyJdvZKE0tNyptE2wGNNoK+nN5uPzYDUa2pU7TkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTrjSm1Usy4b1NRvsTWiPmDeriQSFh/Ss/FEjUUyfovjBPb/xHkvhDA673UkxL4ODKsAJ7NHDKkO26moK08Ww2yT5lZBB8hsBVH0xZ2EJnQauQ0l4NINr17yowFSfCsyecvZ8zpHFyzUU6bY+LhMOKnxnhywJg8UWrmSoDKVppY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ei6CbuRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9A0C4FF72;
	Mon, 26 Aug 2024 20:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724702768;
	bh=4HdFyJdvZKE0tNyptE2wGNNoK+nN5uPzYDUa2pU7TkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ei6CbuRAuetpbe48frNv0DGa8REv90njY+nqhLw9yxilYkyp3e26ljbYaR+3K2zeE
	 K0scN4JEpuWiDqj8Gd1HCwWF5EmuSjUnvWPgv5gs/ZjwSf0tScodjn/Ol2B2lZ+5C5
	 Zo32ZQ0GNsXJSrHkV2I42Utxcr74h7YUaGg8pkMhxqUBdOXyu/Lyr9WPqupBgVi9KM
	 q4ssm3PFUmJpJ6PIMXjvkir5hOPbMmnOKIICyxEYdLtaL9l+biaARTkEuZuB854jkR
	 774AMH7bUIqMnszhvR4MB1rt/hHCLdKPg20oy48XlqMoylPjWpeMaYnyLyx7qeBmdr
	 9RPFZHdGDUSuA==
From: Kees Cook <kees@kernel.org>
To: Greg Ungerer <gregungerer@westnet.com.au>,
	linux-kernel@vger.kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf_fdpic: fix AUXV size calculation when ELF_HWCAP2 is defined
Date: Mon, 26 Aug 2024 13:06:04 -0700
Message-Id: <172470276219.1124110.5967273192476181059.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826032745.3423812-1-jcmvbkbc@gmail.com>
References: <20240826032745.3423812-1-jcmvbkbc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 25 Aug 2024 20:27:45 -0700, Max Filippov wrote:
> create_elf_fdpic_tables() does not correctly account the space for the
> AUX vector when an architecture has ELF_HWCAP2 defined. Prior to the
> commit 10e29251be0e ("binfmt_elf_fdpic: fix /proc/<pid>/auxv") it
> resulted in the last entry of the AUX vector being set to zero, but with
> that change it results in a kernel BUG.
> 
> Fix that by adding one to the number of AUXV entries (nitems) when
> ELF_HWCAP2 is defined.
> 
> [...]

Applied to for-linus/execve, thanks!

[1/1] binfmt_elf_fdpic: fix AUXV size calculation when ELF_HWCAP2 is defined
      https://git.kernel.org/kees/c/c6a09e342f8e

Take care,

-- 
Kees Cook


