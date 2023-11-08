Return-Path: <linux-fsdevel+bounces-2374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4797E5246
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 10:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83F52B2105A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 09:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C411FDDD5;
	Wed,  8 Nov 2023 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLFl0/qj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18005DDA0;
	Wed,  8 Nov 2023 09:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D18C433C7;
	Wed,  8 Nov 2023 09:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699434058;
	bh=vJ85S/+VwWfVPb6/ezPuR3XHwrkVyJ6cqSheMDyuEEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gLFl0/qjla4vURPW4pwvtjWXZTU25an1H7WXuYHBVBal+Hfk82CiditFaaOGmKiCz
	 Bn0pi/9GAnweAK/ScZDXtmLILknvpzCTSlhxu5FyYsCLZIkXEMTPI9YGS7Vo1XNkLF
	 CuWA6Q5QIyYUggyVLCC6tMNj+eFzohH47V4lA+eFu/6MHgWsoWCrqOZX/n+EuiS0cZ
	 noMHUSHqGGJdi4qXCRNOeKHDZMZ+ycY4qivgtDj3L9shPLU+YxIYt2LA1DrShDVyfM
	 LGZH9Zl7WxLuRHYG2CEOcRy7x5OQ951bgnRrM68oTdKgwvBpaiNeKRgTTKKEa2OmQz
	 rhKqMHQlTF2Bw==
Date: Wed, 8 Nov 2023 10:00:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/18] btrfs: add get_tree callback for new mount API
Message-ID: <20231108-wohnraum-komisch-a21ee427cbb5@brauner>
References: <cover.1699308010.git.josef@toxicpanda.com>
 <01325fa7043a86fb58cddbf821933caf0f1bb965.1699308010.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01325fa7043a86fb58cddbf821933caf0f1bb965.1699308010.git.josef@toxicpanda.com>

On Mon, Nov 06, 2023 at 05:08:20PM -0500, Josef Bacik wrote:
> This is the actual mounting callback for the new mount API.  Implement
> this using our current fill super as a guideline, making the appropriate
> adjustments for the new mount API.
> 
> Our old mount operation had two fs_types, one to handle the actual
> opening, and the one that we called to handle the actual opening and
> then did the subvol lookup for returning the actual root dentry.  This
> is mirrored here, but simply with different behaviors for ->get_tree.
> We use the existence of ->s_fs_info to tell which part we're in.  The
> initial call allocates the fs_info, then call mount_fc() with a
> duplicated fc to do the actual open_ctree part.  Then we take that
> vfsmount and use it to look up our subvolume that we're mounting and
> return that as our s_root.  This idea was taken from Christians attempt
> to convert us to the new mount api.
> 
> References: https://lore.kernel.org/all/20230626-fs-btrfs-mount-api-v1-2-045e9735a00b@kernel.org/
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

