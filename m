Return-Path: <linux-fsdevel+bounces-31468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF339997500
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 20:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA6728288A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 18:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F8B1E103A;
	Wed,  9 Oct 2024 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1wvl+2R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8233A15FA74;
	Wed,  9 Oct 2024 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728499163; cv=none; b=ALLtPQGUud9OWho4N5dCta5y15UnjoVpsLTMGkyq1mZVonfoBnRM9dSeggIBUf/HYwiE8UFwwRID+oy4Z4l6E4aU7y06H/yAE6+EMeDBHmjRHaTTlYYSmKDto3kMMEai6r0afdReE4/glE3d6o8HcMxxb4eRsBZ2jTzxifPDDYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728499163; c=relaxed/simple;
	bh=O70RbJ/W5KHjzKkgn4kRyKo1RCjNBwz5v/r1wAjDke8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bhq2AAtN7MVBS80+qIqfzKLf6/Wzpm7lYZxYvcOp0HsvaFCzXmEqvit3FvR1DoResEl1w3YZW9i2LTHUeJT04LaDIIcWOUiyggfauwUFvqgKPI2WvfOfFhfIShT4NF0pObRiWEIYiDJepkLqxB/fGys+Ysu46T7mrgVVdyeC3Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1wvl+2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808F7C4CEC3;
	Wed,  9 Oct 2024 18:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728499163;
	bh=O70RbJ/W5KHjzKkgn4kRyKo1RCjNBwz5v/r1wAjDke8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F1wvl+2RVwRn2XOu1mJqRxd79+WnXqk4klgGaZ1jKx6iWpFs8YCPZYRvie1XKyKnF
	 kQNfHeMmDwRj7yXztr6BQYM/kh0pUTyzb5qfilVAxITZeI4P4JIv3+Z9nei41ZczRj
	 3bKDFpw/f+vErIoWvvJpvRjdrb9tcW5VQwbnfXohTn0IG6n+lCZHe5FrY7MdFPOkPi
	 sIEBaOE/6oa+gXqiNqISO2l2R0IgLuBL6dcf20EAc3B6uTeanmQ2MrNZTsWHEEwKXG
	 pWDV5PXYjzNMuKXoOnbUj7xyJTi84tNlqeXNtM01f3J89YtxmzAgokxv0jWyE61nbi
	 um0OS53IGB9Ww==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Tom Haynes <loghyr@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 0/9] nfsd: implement the "delstid" draft
Date: Wed,  9 Oct 2024 14:39:06 -0400
Message-ID: <172849911981.133262.7783476014242763634.b4-ty@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241004-delstid-v4-0-62ac29c49c2e@kernel.org>
References: <20241004-delstid-v4-0-62ac29c49c2e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2015; i=chuck.lever@oracle.com; h=from:subject:message-id; bh=vjk84pj+f7RaG5/L8WxmqKn7Vt+lY94zwhS721SEN/4=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnBs3ODC79kAdsar9qk76sfCWZIl+5gi9RS21oS 3iMUeWfQpyJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZwbNzgAKCRAzarMzb2Z/ lxU/D/9gepVIputtBIgStSYtu0b8nXFE/N6ds4GjK4SOFWxdm3sDlXImFN0O+vBnhyUq8fATk51 jK10Q6Vja+CafV77caoPbVMVmsUe1wjGdh2tqdheoYVjg0oaT7McjWxMGJ8ZLuCtxUZw0rv9Ib3 k4HvQcSmAi9ZwUciSwjRmlR2VbVIVWBYjnZUg1atX72AgYsXkFGWrTB9OlqOkb53K+jDj2b3alF sDL5HTyvLa8JppaeDLQvzxSogS2dIUDlGEyKQZJCXXVTtoe4Bs/k4o61MXr1B5+/p8bQQOkgYOK qh7ULVxp5ywCieBMXHXminPBXdi8yQWMlIsqwHNw8J+3l9LFnfv/rp4oDaWHNFmT+MuDByaWaIc G6ByMRx3hsEbIy/zCkcf8gCGeKg8DfD8Af4u7hvJjgTJR6vhsa5/RLa0GO6cU9+PwKxxPatYunM sfD8Brb2tYSmuC9Q6HQm1YW6/Ge1V6xuRTq22bN9VaSbaO+vOA4M1qcNAzQ6A2fEmiD3qBhn8CC Wd8qv/3pFyTbfs5aQceDQogVnWW3V9XfufPfehX3aVSvJmvTgXD3DjNzZbOeektHqSxr6EBjpqe OUigXHrv/waLytvHUrx8zs1O2VtPKwglCJWGc3CnWL2dg9Osq8/GBpiHBXYVPRE7eoVpvZQ4+DF 4CsqEw
 b2hfCGtRQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 04 Oct 2024 09:16:43 -0400, Jeff Layton wrote:                                              
> We had to pull this series from v6.11 due to a report of a fs_mark file
> creation performance regression from the kernel test robot [1]. I tried to
> reproduce this and couldn't. I've asked Oliver to see if this is still
> reproducible there but haven't heard back yet.
> 
> During this, we realized that not handing out an updated open stateid
> when there is an existing one is problematic [2], so this also fixes the
> server to only respect WANT_OPEN_XOR_DELEGATION if the open stateid
> is brand new.
> 
> [...]                                                                        

Applied to nfsd-next for v6.13, thanks!                                                                

[1/9] nfsd: drop the ncf_cb_bmap field
      commit: be4c44221f4d066d3726a4712133f69690ac680b
[2/9] nfsd: drop the nfsd4_fattr_args "size" field
      commit: 43f2357392c457616b623ed9eb14ddfb009a37f8
[3/9] nfsd: have nfsd4_deleg_getattr_conflict pass back write deleg pointer
      commit: fcfcbf7764811c90226da385bec30800f29240cb
[4/9] nfsd: fix handling of delegated change attr in CB_GETATTR
      commit: 99ce540b196c8ba7137cdb54d1f8dfdb2f8ebf0e
[5/9] nfs_common: make include/linux/nfs4.h include generated nfs4_1.h
      commit: d1e2a01bdbf0cd1b3d0cf4b576a495b7bb2706b0
[6/9] nfsd: add support for FATTR4_OPEN_ARGUMENTS
      commit: bba1dc5b66342e54fcc0b710e6317a076b732bab
[7/9] nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION
      commit: e816ca3f9ee0832a30c7947feb137142676d8673
[8/9] nfsd: add support for delegated timestamps
      commit: 82ad9af82af79a49ea3b18df06008e8614f9c3e9
[9/9] nfsd: handle delegated timestamps in SETATTR
      commit: ba47874bd44a65d23e67f9b6666eb2475ea1c077                                                                      

--                                                                              
Chuck Lever


