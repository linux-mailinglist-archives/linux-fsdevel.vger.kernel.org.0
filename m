Return-Path: <linux-fsdevel+bounces-1688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 850687DDC7C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 07:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9DA1C20D4D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 06:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841764C8E;
	Wed,  1 Nov 2023 06:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HGVlniQo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96A94C67
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 06:19:05 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E67FC
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 23:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BeJx05v06og43//w9Jtw5MciO8Ksf/TZ+zoulnv1l6E=; b=HGVlniQoinkWf3IZPyzCwsdvI7
	KrkMQZoURHpXFZ9MKVfx7onXtNpvO1kIu3rF1R1UPXgEMN1UWqpsWVS7EmPXD5QUk5GWktVVpLllp
	zDlHrcwPPgMyK1YyIYayr1XgosJZEbzxL/MBMXlbao9FCArZjZrl1G5nQmA+okPvVJ6CxLnxLuhzl
	TejxTCENcLxPZ+AwU9JbTMLSsHyeURg/ePT8669QRMu51qnLpD8sJ9TosD0Gd2Te0t5nH8Yqtok9C
	EIlw6jIeFFO8mNICENKouE1z9LJdBly+MgtdjI2jNX5cPauoYNImPUS/Xlk1lAc+uIeZt7NXZHB2n
	dHSStJng==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qy4Z6-008pXc-39;
	Wed, 01 Nov 2023 06:18:57 +0000
Date: Wed, 1 Nov 2023 06:18:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] simplifying fast_dput(), dentry_kill() et.al.
Message-ID: <20231101061856.GF1957730@ZenIV>
References: <20231030003759.GW800259@ZenIV>
 <20231030215315.GA1941809@ZenIV>
 <CAHk-=wjGv_rgc8APiBRBAUpNsisPdUV3Jwco+hp3=M=-9awrjQ@mail.gmail.com>
 <20231031001848.GX800259@ZenIV>
 <20231031015351.GA1957730@ZenIV>
 <20231031061226.GC1957730@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031061226.GC1957730@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 31, 2023 at 06:12:26AM +0000, Al Viro wrote:
> On Tue, Oct 31, 2023 at 01:53:51AM +0000, Al Viro wrote:
> 
> > Carving that series up will be interesting, though...
> 
> I think I have a sane carve-up; will post if it survives testing.

OK, current variant survives local testing.  Lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.dcache

Shortlog:
      fast_dput(): having ->d_delete() is not reason to delay refcount decrement
      fast_dput(): handle underflows gracefully
      fast_dput(): new rules for refcount
      __dput_to_list(): do decrement of refcount in the caller
      retain_dentry(): lift decrement of ->d_count into callers
      __dentry_kill(): get consistent rules for ->d_count
      dentry_kill(): don't bother with retain_dentry() on slow path
      Call retain_dentry() with refcount 0
      fold the call of retain_dentry() into fast_dput()
      don't try to cut corners in shrink_lock_dentry()
      fold dentry_kill() into dput()
      get rid of __dget()
      shrink_dentry_list(): no need to check that dentry refcount is marked dead
      to_shrink_list(): call only if refcount is 0
      switch select_collect{,2}() to use of to_shrink_list()

Diffstat:
 fs/dcache.c | 268 ++++++++++++++++++++++--------------------------------------
 1 file changed, 96 insertions(+), 172 deletions(-)

Individual patches in followups.  Review and testing would be welcome,
and it's obviously next cycle fodder.  Massage of refcounting is in the
first 11 commits, last 4 are followups.

