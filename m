Return-Path: <linux-fsdevel+bounces-37-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE3A7C4AEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 08:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFAAA280FC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 06:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F927FC19;
	Wed, 11 Oct 2023 06:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="n2bls/sI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ACA6132
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 06:46:14 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05603A7
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 23:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1moOL3FcEJL5whG3fIwL4tjrW3YxKY2d5YDlK/9iRK0=; b=n2bls/sIVM813j+a3X9RY9l1VM
	CrOgjH2ry145tTQF8EdgAK17X6hXDAHQS+RPZN1z3fSLQF5qwRaLC4Tc3VTPlgmpuB8hgK85Ii/o/
	xvRmnXYxITxg/y9YQYs/aq11RZMSCX7c8JlMdOMVwzFKRJxxL/in3ohDJL+wFzoTFOGLAnKhxWb8d
	9cf/ewWukSbEtUKj6wFaVkYqaRhrclmeV3ni7b3MfvvZNL8a26CeiHellX8MMzpw0Tvj7wQ/KUJ5+
	raogWCY2Y/Solh2yIRzNFPrqml8M50ettfvpAja7SUd5d3ZC4N72m9Ffp7ZkxHlTO0xt97T/qguDZ
	/ssI9wHA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qqSyu-000Au3-3B;
	Wed, 11 Oct 2023 06:46:09 +0000
Date: Wed, 11 Oct 2023 07:46:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mo Zou <lostzoumo@gmail.com>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: fs: fix directory locking proofs
Message-ID: <20231011064608.GU800259@ZenIV>
References: <20231011052815.15022-1-lostzoumo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011052815.15022-1-lostzoumo@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 01:28:15PM +0800, Mo Zou wrote:
> Commit 28eceeda130f ("fs: Lock moved directories") acquires locks also for
> directories when they are moved and updates the deadlock-freedom proof
> to claim "a linear ordering of the objects - A < B iff (A is an ancestor
> of B) or (B is an ancestor of A and ptr(A) < ptr(B))". This claim,
> however, is not correct. Because cross-directory rename may acquire two
> parents (old parent and new parent) and two child directories (source
> and target) and the ordering between old parent and target (or new parent
> and source) may not fall into the above cases, i.e. ptr(old parent) <
> ptr(target) may not hold. We should revert to previous description that
> "at any moment we have a partial ordering of the objects - A < B iff A is
> an ancestor of B".

Not quite.  I agree that the proof needs fixing, but your change doesn't
do it.

The thing is, the ordering in "neither is an ancestor of another" case
of lock_two_directories() does, unfortunately, matter.  That's new,
subtle and not adequately discussed.

Another thing is that callers of lock_two_nondirectories() are not
covered at all.

I'll put something together and post it; it's 2:45am here at the moment,
and I'd rather get some sleep first.

