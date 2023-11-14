Return-Path: <linux-fsdevel+bounces-2851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630917EB5E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 18:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB956B20B70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 17:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8AD2C1B2;
	Tue, 14 Nov 2023 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="toNbkVQM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769BC2C187
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 17:57:28 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD0713D
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 09:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eQ0EJF+xKqG7mQw1Re9QtMiNzWSkFITM4cOP0HmKkOc=; b=toNbkVQMVkJIr0XhbhmGUdJXwl
	L41mUgfiQe/gu7xDT5dfjZBP/ZlqBSw3nk9WUi1F+mpBGkLMpL905P9PIrATPuWOyt5ZCGxRtZ9JX
	ooq2gT2kMoxfDYSQg+/evpoaNAm9/DvDeLZPRLxRXNSpB/XuItHzpZix4CCSUKj917H6QLNdWw7w+
	JGgo8CjTKRXXbLbx8tm7QzoYa7WRlWq0uUdE3nkS7CPN5e3NpFuRTocFmwAqVHXVnnJ1NIVBB9C6J
	Vv4EF8fXTRj3a+9/O2NZPHJQ0dtBzC4dFrm9eXW3s8LuEB+Ah3CnF7EG7RjgIQUvF5t25vJFPM994
	mzDXtI0A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r2xf0-00FlkJ-2v;
	Tue, 14 Nov 2023 17:57:15 +0000
Date: Tue, 14 Nov 2023 17:57:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, akpm@linux-foundation.org,
	hughd@google.com, jlayton@redhat.com,
	Tavian Barnes <tavianator@tavianator.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RFC] libfs: getdents() should return 0 after reaching EOD
Message-ID: <20231114175714.GT1957730@ZenIV>
References: <169997697704.4588.14555611205729567800.stgit@bazille.1015granger.net>
 <20231114-begleichen-miniatur-3c3a02862c4c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114-begleichen-miniatur-3c3a02862c4c@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 14, 2023 at 06:29:15PM +0100, Christian Brauner wrote:

> I think it's usually best practice to only modify the file->private_data
> pointer during f_op->open and f_op->close but not override
> file->private_data once the file is visible to other threads. I think
> here it might not matter because access to file->private_data is
> serialized on f_pos_lock and it's not used by anything else.

That is entirely up to filesystem.  Warning that use of that library
helper means that you can't use your ->d_fsdata for anything else - sure,
but that's it.

