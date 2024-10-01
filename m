Return-Path: <linux-fsdevel+bounces-30509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CA198BEDE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 16:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69EB1C21F7C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D871C3F1F;
	Tue,  1 Oct 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wh7MHN2W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DADB28F4;
	Tue,  1 Oct 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791428; cv=none; b=luFQk6JZ+AwjB1CTDTq/ZZp+h5JfcFETXeOzExLU3NImIN8YnjtCgZJWvyVwbjbmRiesdDzf5WZiyrNPaZeymtfaE9viFj/0yMs/E41M9iQ064raO2M/lRwxwZkIMZYDkkpQuvK0Yt8N/LUeYty8uD0NF2Jck5fcMuXiWD/wwLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791428; c=relaxed/simple;
	bh=/nhn+SWprwiztlWKYdYqdvIVtsJh5dygDuCJ0NZz6XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGGBNNd2Xs5hb54QKDCY5Tql1SChWBgadd5eaXYLgxvfV7oqtC+DzIeyc+9/bq9U+Mv6bpXiAYQ7kNEl3A5nZG5vZqbsf/XlJsTZ1fE/acmIC71Jogm1+TlMsbqp4ScwZFmW6clyqIRlscKXFi8jOJb+452RcR4DJuxEsAL8PoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wh7MHN2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCD4C4CEC7;
	Tue,  1 Oct 2024 14:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727791428;
	bh=/nhn+SWprwiztlWKYdYqdvIVtsJh5dygDuCJ0NZz6XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wh7MHN2WYalSL7SA8PvpNjeaBafbTlCGjSOjtpXQv3Mizs/MgcwCGBaEoRpU124R7
	 Uks6JHchwRlMszJr2Tkmz1beRSvmO74JgQnuTOLXrls2y21dDEWPgG6Z1ApCB8jf03
	 nPbwpEiOJOFJwsDmSqgdD+YOlTL90yXiLdYbW0SNyp/1Fuk98Y1mNosnrRPPC3VcH4
	 qQ9D3+LOvq9U4egKnUA+Y8PymE6jzP6mjMaapECbknPXHZUjVIjzLB+Esv8/c1FR0X
	 3SKHlK+gKzr6XwxSqcCK+6MDwK9WEcjchPTYpFbYAGAfzViFkSovmEFK+PKNYyLpWb
	 CwJIRIr1j1Q7w==
From: Christian Brauner <brauner@kernel.org>
To: dhowells@redhat.com,
	Chang Yu <marcus.yu.56@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	jlayton@kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2] netfs: Fix a KMSAN uninit-value error in netfs_clear_buffer
Date: Tue,  1 Oct 2024 16:03:40 +0200
Message-ID: <20241001-parade-futter-776bcefe0ce5@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <ZvuXWC2bYpvQsWgS@gmail.com>
References: <ZvuXWC2bYpvQsWgS@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=941; i=brauner@kernel.org; h=from:subject:message-id; bh=/nhn+SWprwiztlWKYdYqdvIVtsJh5dygDuCJ0NZz6XQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT9YbSbFeb1TUNE7ZjgtkVWFybI7ai53X6YdeNaK3lJf d/yH28yO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyPJSRoTUtxsJodZuLolBy w6ElTHIfJs5bcLP4IotMxzOjjHixyYwMa6NzDv+dGdlmkbIy5jPvLEGj0DvebMcKp/ge/bTmv2o XIwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 30 Sep 2024 23:31:52 -0700, Chang Yu wrote:
> Use folioq_count instead of folioq_nr_slots to fix a KMSAN uninit-value
> error in netfs_clear_buffer
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

[1/1] netfs: Fix a KMSAN uninit-value error in netfs_clear_buffer
      https://git.kernel.org/vfs/vfs/c/f6023535b52f

