Return-Path: <linux-fsdevel+bounces-57078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC6CB1E929
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 15:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 891F1582604
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 13:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398DD27D780;
	Fri,  8 Aug 2025 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVrD1vdH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8E620ED;
	Fri,  8 Aug 2025 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754659682; cv=none; b=kQ7bLxX6389luFzYHk1axzt2JHrzPFVXf/X/kcOzLG5/jOpSlFZelak6rak95pSe2EY7uEf3fA+8e/ADPdcpb/16UBSo2MZYY+P9UKpi+g8h/n0BpVg2TX3bTNCa+4I6qjkwCmyAMNw1Oi6+Cto1xv/bRgdvVNtu8Ky45QM7RtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754659682; c=relaxed/simple;
	bh=976PJWpxguFHFCo5zyJH+l9FUHbqjblXu/xKA/FqtsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvGw19uXxvfq/6y9nruPc3IvL3+WAe1s0ZVugOp0VEV9UC7xmFBwuKfAyMt7iXxYXhK5Lih2WcUc5ZIkjTRS0AFuaNbgEP3sAy5Q5Iv7y06QrITpGvwm14Tpu3Jfh7O7858t8kHE73v9eq7zRHo/AYGtXqauNnjLzb+whwUr6TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVrD1vdH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADADC4CEED;
	Fri,  8 Aug 2025 13:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754659682;
	bh=976PJWpxguFHFCo5zyJH+l9FUHbqjblXu/xKA/FqtsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tVrD1vdHyE87TGiBcRfH36cv/NvLYYWGPmt6chSEoY5O16UgT6AH2eLV7O7BlbmTd
	 AXoq1ZDJ77qefE6cGN+mE9hZZrKU91dnj0beZ61ZgDh4IQH3AOzjRJzBRWqkBjrbAg
	 ScFCW6hHcGDYPS8RlFQVNHl/hY8xT4a8SfFO9zhr8ul/ZcezhS0YHBDYDRQ3XqBjET
	 Zl8EgdmcIrHxG02nuQ59bua6OGliqACaYtu37/+HVaREN0LQ8T1so1+vsGZgCXDAJH
	 o1CtMhpLK7N2Ol7TQ+5S145/Bg85u8F2QB37lD5cNHn+81pis3ac33HrMYXRn3OH4d
	 u7eXfSD12oyQA==
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 0/2] vfs: output mount_too_revealing() errors to fscontext
Date: Fri,  8 Aug 2025 15:27:45 +0200
Message-ID: <20250808-fluktuation-panne-1056600eb918@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250806-errorfc-mount-too-revealing-v2-0-534b9b4d45bb@cyphar.com>
References: <20250806-errorfc-mount-too-revealing-v2-0-534b9b4d45bb@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1404; i=brauner@kernel.org; h=from:subject:message-id; bh=976PJWpxguFHFCo5zyJH+l9FUHbqjblXu/xKA/FqtsQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRM/R3LLTq16Vs1v7uh6+oJChoLkzZmWJn+zpL3bbWZe jWt/+2njlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlccGD4Z/P4vWG83Jad7fJf Xgdt3XuoeKJJVjPLDyPRF0wPtq/82snwP4Iv5/UuywKOtI0lxt/OfbDJWvvw/hbW2XM10yZcf3j Bng8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 06 Aug 2025 16:07:04 +1000, Aleksa Sarai wrote:
> It makes little sense for fsmount() to output the warning message when
> mount_too_revealing() is violated to kmsg. Instead, the warning should
> be output (with a "VFS" prefix) to the fscontext log. In addition,
> include the same log message for mount_too_revealing() when doing a
> regular mount for consistency.
> 
> With the newest fsopen()-based mount(8) from util-linux, the error
> messages now look like
> 
> [...]

Nice, thank you!

---

Applied to the vfs-6.18.mount branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.mount branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.mount

[1/2] fscontext: add custom-prefix log helpers
      https://git.kernel.org/vfs/vfs/c/49e998eb0154
[2/2] vfs: output mount_too_revealing() errors to fscontext
      https://git.kernel.org/vfs/vfs/c/3441e1534e67

