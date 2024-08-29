Return-Path: <linux-fsdevel+bounces-27809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B899643E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C9CD28736C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 12:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A1A193083;
	Thu, 29 Aug 2024 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chyrJykN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBD818A6D1;
	Thu, 29 Aug 2024 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933080; cv=none; b=uBfKNZagPMslkXulr00XlNhXrftWDa/box/9AdD36x86jHot4ZID3OJl2f1GzsD+9W3gTbGXndPnUzeEKhwPKTIjHrcDUBMNejrTx062q1YPM8mXqi8CuL9ZsVCAuonqyxDlLBkenGiZa6dt9aAyZ1fWq6mt9O8WL55ktMEV32A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933080; c=relaxed/simple;
	bh=O62hW6YoTMMZ4TwahubM0k5YhwbbI6tnUMxnsFn/VgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gzgItK69942DwpRQ+IejnfqwF0JOqMkXXN74+IwZfh0gQDbR6OtEhvcbPMrmxQd8B4IWw4HqstBXR/txrUNMIuIiBdm8+7N4Z+e20P9UEgIRAxTlqcxKK1YyqgUuwcJOIo2+ayoU+VCnk0NyNK4BM64mxNah20DYEpyxuqbgGn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chyrJykN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C40EC4CEC1;
	Thu, 29 Aug 2024 12:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724933079;
	bh=O62hW6YoTMMZ4TwahubM0k5YhwbbI6tnUMxnsFn/VgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=chyrJykN+WTpedfOg/Gn5SGnxheu/37y8wMTmMwW0HZiUBabP5A49lL7GsrCVY3MK
	 ZihnbWnr1c24TyVXf4xzUy63ht2PajzZRz38eJCbgA+NrL8TYDfGeFVU2KLbANwAbk
	 bnxcVSWu9M5X5/O4qvi94L+vmjTmg/7JiNDjBuc2Z/7gKlTf69S9OojTSHbmwqDysq
	 d8AvHrwXUC4V2e/O4wHuJOdhfcpz+QQGTWDHE+HdX0QZ/6kj8tFhVlydFfO0YsuYbr
	 +Gw17GCnJ67EO8X3Y4kFItjuACTzTAou4CjFO8G5t+G6CiUD3XKmIkWV/c2Ed/qOiS
	 D3zrWMZP2l+Yw==
From: Christian Brauner <brauner@kernel.org>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jack@suse.cz,
	viro@zeniv.linux.org.uk,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] writeback: Refine the show_inode_state() macro definition
Date: Thu, 29 Aug 2024 14:04:25 +0200
Message-ID: <20240829-wegfahren-weiten-540367488713@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240828081359.62429-1-sunjunchao2870@gmail.com>
References: <20240828081359.62429-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=979; i=brauner@kernel.org; h=from:subject:message-id; bh=O62hW6YoTMMZ4TwahubM0k5YhwbbI6tnUMxnsFn/VgE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRdSD6f6VD37JqNc/9UnWypj8GVhu9j0ivXHEg5f/7TP 9/eD3pTO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZiz8fwv/IX393L7BO4rtxZ eEApW0Fz8rZPM5Y/WORw3eFXQUuInRAjw1sXwzCP4MenC4Ndj178x76oyIZDiTX219qM6mfTfG9 qMwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 28 Aug 2024 16:13:59 +0800, Julian Sun wrote:
> Currently, the show_inode_state() macro only prints
> part of the state of inode->i_state. Let’s improve it
> to display more of its state.
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] writeback: Refine the show_inode_state() macro definition
      https://git.kernel.org/vfs/vfs/c/5b07b8fbb89a

