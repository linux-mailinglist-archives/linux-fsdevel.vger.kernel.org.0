Return-Path: <linux-fsdevel+bounces-4573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D70800D46
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 15:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60EB281427
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8328E3E477
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+8ZjZs5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE813208A6
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 13:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE26C433CA;
	Fri,  1 Dec 2023 13:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701436803;
	bh=soyL2fGmMrIEiiU66FcyU70AJdcAiUh0bYERhK4T18M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+8ZjZs5u4PUFVVd52XvpBbsUBrtt/0ksyDs0Ms2CxOJp3DJfn0TiclVFM2kmJDlV
	 533rRE9mGP7do6JpiaR3BKA0fupNSaO5ZHaDejSx1ftXgIAj+z0uvInaRi+tVka6UN
	 hKmSXer9vaifTFl76jWT6CBzMJgp39OLAEnOZ292F1MrubdrYPd2iz9csJmWzDsOR3
	 rLpt7XUbmfuTorS21lXUFvIsIabov8CHlK8Pn4oHbxFJg9WzXAc8MnxI4nGCFeD79H
	 hVHUv37/ktOTowY/+17Z4UF3myKJdoF75GZMiyRpeHgffI0PUKZDlhwaU64Bu+cP7N
	 ZVrFepmGU9IEg==
Date: Fri, 1 Dec 2023 14:19:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Jens Axboe <axboe@kernel.dk>, Carlos Llamas <cmllamas@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH RFC 3/5] fs: replace f_rcuhead with f_tw
Message-ID: <20231201-archaisch-blatt-771818b94798@brauner>
References: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org>
 <20231130-vfs-files-fixes-v1-3-e73ca6f4ea83@kernel.org>
 <CAHk-=wjWvbbX4c-8nGWOqMden6X8k=8kYCNfy96r0N+8FJbU6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjWvbbX4c-8nGWOqMden6X8k=8kYCNfy96r0N+8FJbU6g@mail.gmail.com>

On Fri, Dec 01, 2023 at 08:37:30AM +0900, Linus Torvalds wrote:
> On Thu, 30 Nov 2023 at 21:49, Christian Brauner <brauner@kernel.org> wrote:
> >
> > The naming is actively misleading since we switched to
> > SLAB_TYPESAFE_BY_RCU. rcu_head is #define callback_head. Use
> > callback_head directly and rename f_rcuhead to f_tw.
> 
> Please just write it out, ie "f_taskwork" or something. Using random
> letter combinations is very illegible. It may make sense at the time
> (when you are literally editing a line about "init_task_work()") but
> it's literally just line noise in that structure definition that makes
> me go "f_tw is wtf backwards, wtf?".

Oh, I didn't even think about this.

> It might even be a good idea to say *what* it is a task work for.

Ok, I've added a comment about for both f_llist and f_task_work.

