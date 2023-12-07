Return-Path: <linux-fsdevel+bounces-5196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1C780927B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 21:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E064281EA1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 20:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB662563AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 20:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dxjkUD26"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D5DA9;
	Thu,  7 Dec 2023 11:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701976784;
	bh=8EhX5dFEoQVo4ra/hauFi9FL5y3h3LfWv35aPkeCC9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dxjkUD26Nj6K/4ciJrCrVr2UOWn52vU+Fs4HJzgCi+NnOQJo/XEm4ZcNXd6KKxMmJ
	 lxVBEzoyhC58LUoNs38SgEqduBnSJuKhtVuVHYMrkI4kV2WtgEHiS2t85YfBXeiGEQ
	 sy4GqrNlgZKtQDGu63+OGmMNEkrMqWvdquQsz7xo=
Date: Thu, 7 Dec 2023 20:19:43 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Joel Granados <j.granados@samsung.com>
Cc: Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Iurii Zaikin <yzaikin@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
Message-ID: <fa911908-a14d-4746-a58e-caa7e1d4b8d4@t-8ch.de>
References: <CGME20231204075237eucas1p27966f7e7da014b5992d3eef89a8fde25@eucas1p2.samsung.com>
 <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231207104357.kndqvzkhxqkwkkjo@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231207104357.kndqvzkhxqkwkkjo@localhost>

On 2023-12-07 11:43:57+0100, Joel Granados wrote:
> Hey Thomas
> 
> You have a couple of test bot issues for your 12/18 patch. Can you
> please address those for your next version.

I have these fixed locally, I assumed Luis would also pick them up
directly until I have a proper v2, properly should have communicated
that.

> On Mon, Dec 04, 2023 at 08:52:13AM +0100, Thomas Weißschuh wrote:
> > Problem description:
> > 
> > The kernel contains a lot of struct ctl_table throught the tree.
> > These are very often 'static' definitions.
> > It would be good to make the tables unmodifiable by marking them "const"
> Here I would remove "It would be good to". Just state it: "Make the
> tables unmodifiable...."

Ack.

> 
> > to avoid accidental or malicious modifications.
> > This is in line with a general effort to move as much data as possible
> > into .rodata. (See for example[0] and [1])

> If you could find more examples, it would make a better case.

I'll look for some. So far my constifications went in without them :-)

> > 
> > Unfortunately the tables can not be made const right now because the
> > core registration functions expect mutable tables.
> > 
> > This is for two main reasons:
> > 
> > 1) sysctl_{set,clear}_perm_empty_ctl_header in the sysctl core modify
> >    the table.
> > 2) The table is passed to the handler function as a non-const pointer.
> > 
> > This series migrates the core and all handlers.

> awesome!
> 
> > 
> > Structure of the series:
> > 
> > Patch 1-3:   Cleanup patches
> > Patch 4-7:   Non-logic preparation patches
> > Patch 8:     Preparation patch changing a bit of logic
> > Patch 9-12:  Treewide changes to handler function signature
> > Patch 13-14: Adaption of the sysctl core implementation
> > Patch 15:    Adaption of the sysctl core interface
> > Patch 16:    New entry for checkpatch
> > Patch 17-18: Constification of existing "struct ctl_table"s
> > 
> > Tested by booting and with the sysctl selftests on x86.
> > 
> > Note:
> > 
> > This is intentionally sent only to a small number of people as I'd like
> > to get some more sysctl core-maintainer feedback before sending this to
> > essentially everybody.

> When you do send it to the broader audience, you should chunk up your big
> patches (12/18 and 11/18) and this is why:
> 1. To avoid mail rejections from lists:
>    You have to tell a lot of people about the changes in one mail. That
>    will make mail header too big for some lists and it will be rejected.
>    This happened to me with [3]
> 2. Avoid being rejected for the wrong reasons :)
>    Maintainers are busy ppl and sending them a set with so many files
>    may elicit a rejection on the grounds that it involves too many
>    subsystems at the same time.
> I suggest you chunk it up with directories in mind. Something similar to
> what I did for [4] where I divided stuff that when for fs/*, kernel/*,
> net/*, arch/* and drivers/*. That will complicate your patch a tad
> because you have to ensure that the tree can be compiled/run for every
> commit. But it will pay off once you push it to the broader public.

This will break bisections. All function signatures need to be switched
in one step. I would strongly like to avoid introducing broken commits.

The fact that these big commits have no functional changes at all makes
me hope it can work.

