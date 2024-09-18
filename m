Return-Path: <linux-fsdevel+bounces-29644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF4597BD8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 16:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438251F24F7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 14:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0054A18C917;
	Wed, 18 Sep 2024 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQxJLCxT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A7118BC2A;
	Wed, 18 Sep 2024 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668109; cv=none; b=amU4KYf+sVSnc1vYzHlgQjE9Yku0WIVksQmmTO6608iP+lJP9JLyhuknv4V9J124ywS2GhnPwfi6ZPyHooAuD5pFlNw4SgCq0qbx5bbEQbLTrKtvuO1o9nJKjuGmXERVOJ4l5E4iPUoxQBnyMQwvJG9bSustn2Bij5kRKDaLytI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668109; c=relaxed/simple;
	bh=Gqo/olFf/TqaNzYStJ4h4iSgp/m9SF1eYLZDSlE6sec=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rDMnzQVfhCj0gm4uquuJ4f6MNZOxImR1+JvR6GGXPSnVI+gs3j3BqG2CAOcH2O2HE8MrOdpmNXg9Ez/w/o93hLzxP3VZ41YNz15S/m2XC0X/Mz+Du3yDNgNcoVkoe0UHd6Kn3XIf7bQsNTSEaLKA9tDNnnQwkl6WFojSb4a9fvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQxJLCxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F7C4C4CEC2;
	Wed, 18 Sep 2024 14:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668109;
	bh=Gqo/olFf/TqaNzYStJ4h4iSgp/m9SF1eYLZDSlE6sec=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=dQxJLCxTEYzKVu8bfUsRAJTyOREkmAq8iq9/J0SU9jxn9UtiZd6qVsBaH+7S6bwC7
	 SItPvFCII7x8vy88sBcCZkMMXGxS+FUvs68TPro8/BDHU3uB2EtHTkoyial6yoWYfh
	 hYfze8yqIkswolvjVpFDMd+3wIY2cIlJ5mkMWoIPqpY/1g+VmjMsK4+YPe2E6EmKat
	 HL6AUYCMXX+drNbcRIgSBezrYmp1vSIU/V9tI5jly88iSbQ6pw+da+SN104k6gW8Sl
	 yERVcRyjodlaoI9ntc1pAftyOrMXypgbNMGUJCzk14eoUXpRnfbV6n39LyD8iHkUvZ
	 ZVQfYnC1mAZCA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E044CCD191;
	Wed, 18 Sep 2024 14:01:49 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Subject: [PATCH 0/3] Backport statx(..., NULL, AT_EMPTY_PATH, ...)
Date: Wed, 18 Sep 2024 22:01:18 +0800
Message-Id: <20240918-statx-stable-linux-6-10-y-v1-0-8364a071074f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAC7d6mYC/x2M0Q5EMBAAf0X22UrXieJXxIOr5TaRnrRIRfy78
 jLJPMyc4NkJe2iSExzv4uVvo1CagPn1dmKUITrkKi9UTRX6tV/Dw+/MOIvdApZICg8kbT5sdFF
 rU0HsF8ejhPfdwl5mpKC7rhtguFJ8cgAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>, Mateusz Guzik <mjguzik@gmail.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@samsung.com>, 
 Alice Ryhl <aliceryhl@google.com>, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org, Miao Wang <shankerwangmiao@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1261;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=Gqo/olFf/TqaNzYStJ4h4iSgp/m9SF1eYLZDSlE6sec=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBm6t1K3ccq23E7ZBFaXcjel3XM1t9hHB7i4wcQW
 DHQaHvjZCeJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZurdSgAKCRCwMePKe/7Z
 bqqAD/9mFnhmtbaWcLZxM02VcGsraDoJF/L1Ix/DNiwMxjuGZCqdjDZLmzMSvDYwdMnXrGA48O7
 Jg5PJxqTecHodyF0sF8lAW2NRUkPHo/ABLRmkkDf9xvS3lV2RkW4hqBaXoCZGd9BHM7IZw4RUm9
 euiXHFQ6hjaKRlj4efAi5zf0O7yI4bgvo7tNsFE6j/WaITzZ03tb7Fq8YXaeMjVdlJuZhas5KgC
 BUGGrtm9lwkpXfseosEvDKfEr+oxl0DfGzXn7fcQ5bt9w4uQTlFzzjj9iFz7vmWmUJhxCQztX3v
 bcdOdWxRnzBDNeYrYOnGNn2vi+RjgPIUeZjuZob4cRo27N71yJwPBTVXWASglVNY5lcbxiuUtAk
 0QGSEXsxlEWh1L0jD9k704StspBOnn1y9QXc02vzqns/8QTOzZHIs/VLRlmTANmicQ3P1YGAhlN
 LUG/gLinXqzcYbaExAl18TjEnomMVHoch9Wm8whPBaBSIMdOinZPHHp4H5de0VAngpI87HrqlEI
 oYNtgvLIycHzpS8F9zUswLPQSnzurQUd9OlBC1fbpLUDiP3GaUgbmVwidHU4khcyiTlgFqNQSg2
 MvcvF76G7xFmCCCXZK15MKeHqtNDBN12Y8pP9y/G6MRd2Tx/mOplubimhlKjamnYB3/I8+Y9ERa
 zxIikM6a1A0OXpA==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/default with
 auth_id=189
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Reply-To: shankerwangmiao@gmail.com

Commit 0ef625bba6fb ("vfs: support statx(..., NULL, AT_EMPTY_PATH,
...)") added support for passing in NULL when AT_EMPTY_PATH is given,
improving performance when statx is used for fetching stat informantion
from a given fd, which is especially important for 32-bit platforms.
This commit also improved the performance when an empty string is given
by short-circuiting the handling of such paths.

This series is based on the commits in the Linus’ tree. Sligth
modifications are applied to the context of the patches for cleanly
applying.

Tested-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
Christian Brauner (2):
      fs: new helper vfs_empty_path()
      stat: use vfs_empty_path() helper

Mateusz Guzik (1):
      vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)

 fs/internal.h      |  14 ++++++
 fs/namespace.c     |  13 ------
 fs/stat.c          | 123 ++++++++++++++++++++++++++++++++++++-----------------
 include/linux/fs.h |  17 ++++++++
 4 files changed, 116 insertions(+), 51 deletions(-)
---
base-commit: 049be94099ea5ba8338526c5a4f4f404b9dcaf54
change-id: 20240918-statx-stable-linux-6-10-y-17c3ec7497c8

Best regards,
-- 
Miao Wang <shankerwangmiao@gmail.com>



