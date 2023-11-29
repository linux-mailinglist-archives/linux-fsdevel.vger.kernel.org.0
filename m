Return-Path: <linux-fsdevel+bounces-4175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785FB7FD484
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 11:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94431C20BFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 10:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174D41B27C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWdAckbp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE406FCA;
	Wed, 29 Nov 2023 10:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499FDC433C7;
	Wed, 29 Nov 2023 10:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701253276;
	bh=8TNjAboxiQCy/aqySF5iW9tbp3JOh4XvvQZCD1R3+KE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWdAckbpxi5sMiKpOoUVyVGd+sJzQHppJ5GdXnwg/vT1OEkjFYBfAWJe6Qj35Dm+R
	 68SGHuD24EeDw5Q99y55vcirXhp8eFF1UHSU0eIwa0N4/wAwg0dn6NxhGJ6s9ga6NU
	 OHrocLcmczVvowoP7ib1VmF0ktm1NgxPVqeCBE+02C8qypswDN4NIWLlWaMtgfNtpw
	 SlOPEVmbWg1FtXs+XyL1l8Oaxc3cFsfxzegQVWH1cSIO17hn9rSnlXCMJ3vSkBnfxK
	 3538fPYIhC/RjduiM180EBUhQ7BcZwhBnF0TQ1X06K4xfMApo3bTvpmkRAp4LTAadk
	 SUAnyDLa1FAyw==
Date: Wed, 29 Nov 2023 11:21:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
	jaegeuk@kernel.org, linux-ext4@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Gabriel Krisman Bertazi <gabriel@krisman.be>
Subject: Re: fun with d_invalidate() vs. d_splice_alias() was Re: [f2fs-dev]
 [PATCH v6 0/9] Support negative dentries on case-insensitive ext4 and f2fs
Message-ID: <20231129-birnen-erwandern-92bfa945d3e0@brauner>
References: <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
 <20231123171255.GN38156@ZenIV>
 <20231123182426.GO38156@ZenIV>
 <20231123215234.GQ38156@ZenIV>
 <87leangoqe.fsf@>
 <20231125220136.GB38156@ZenIV>
 <20231126045219.GD38156@ZenIV>
 <20231126184141.GF38156@ZenIV>
 <20231127063842.GG38156@ZenIV>
 <20231129045313.GA1130947@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129045313.GA1130947@ZenIV>

> 2) lookup fails.  It's already possible; e.g. if server has

I think that's the sanest option. The other options seem even less
intuitive.

> not fatal.  The trouble is, that won't be a transient failure -
> not until somebody tries to look the old location up.

Eh, nfs semantics are quite special anyway already. I'd rather have that
in lookup than more magic involving moving mounts around or having them
disappear (Yes, we have the detach semantics on removal but that's
different.).

