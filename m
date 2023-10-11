Return-Path: <linux-fsdevel+bounces-122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED32A7C5D65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 21:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223531C20F11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 19:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C096F12E50;
	Wed, 11 Oct 2023 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Kvpppry5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970353A28E
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 19:06:44 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576C990
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 12:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QHliAQ1dbPi8wL6gAqug7RzPRCQpa8qmUkjp/nnpEg4=; b=Kvpppry5Tcf6mLXdyC+YC1SsAx
	k0nnTMo5TxBk2WikeURmedx7cWPMVjCLTH5huWlDGOxygKfIzXVzPKsDMdhPEdCUzuclyRT+z9egs
	GHPoXf2pzR0Ook7dtfft43Jmvdmw/nY50PbN/S9KsGTzgWbJAJS9wuJIALWx3fUl5FS1RC5UcCjDE
	phiJ7+bKMzkXeABOt19AgJAIDSwJOHWQ7oEyAvp76Rhsry4zN6Yzxwew6zvJmt6WjK6t3HqhKilLa
	Daxj2kHurT6DNqLgmUjLZrpXLS4iXkbJrTqmnpPDnnGYMRDIlMCJa2inBuvifITqKsZ2dfSx+YNhG
	kpRj3rmg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qqeXW-000LOC-0y;
	Wed, 11 Oct 2023 19:06:38 +0000
Date: Wed, 11 Oct 2023 20:06:38 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mo Zou <lostzoumo@gmail.com>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: fs: fix directory locking proofs
Message-ID: <20231011190638.GV800259@ZenIV>
References: <20231011052815.15022-1-lostzoumo@gmail.com>
 <20231011064608.GU800259@ZenIV>
 <CAHfrynPiUWiB0Vg3-pTi_yC6cER0wYMmCo_V8HZyWAD5Q_m+jQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHfrynPiUWiB0Vg3-pTi_yC6cER0wYMmCo_V8HZyWAD5Q_m+jQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_FILL_THIS_FORM_SHORT,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 10:11:42PM +0800, Mo Zou wrote:
> 
> Consider directories objects A, B, C. The pointer orders are that A < B
> and C < A. And B is ancestor to C, so B < C. Thus we have A < B < C
> < A!
> 
> A concrete deadlock  example can be constructed as follows. Suppose
> the tree has following edges /A and /B/C and A < B and C < A. There are
> three operations forming a deadlock.
> 
> rename(/A, /B) executes: lock /; lock A; (about to lock B)
> unlink(/B/C) executes: lock B; (about to lock C)
> rename(/A/x, /C/y) executes: lock C; (about to lock A)

Nope - your C in line 2 is not C in line 3.

There *IS* a deadlock, but it's more subtle than that.
Look:
# address(/X/A) < address(C) < address(X)
T_1: rename /C/D /X/A/B
T_2: exchange /X /C
T_3: rmdir /X/A
T_1:	looked up /X/A and /C (all in dcache)
T_2:	looked up /
T_3:	looked up /X
T_1:	grabbed ->s_vfs_rename_mutex
T_1:	grabbed /X/A
T_2:	grabbed /
T_2:	grabbed /C
T_3:	grabbed /X
T_2:	tries to grab /X
T_3:	tries to grab /X/A
T_1:	tries to grab /C

