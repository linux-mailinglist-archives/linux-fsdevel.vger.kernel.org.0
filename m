Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CEA2E877A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Jan 2021 14:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbhABN0a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Jan 2021 08:26:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbhABN03 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Jan 2021 08:26:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAABD224D4;
        Sat,  2 Jan 2021 13:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609593949;
        bh=nQptyWsIb5DLXUAZK2xe+ITycsezO9g8NVJXR3oAkm4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=V8EdnLsyWJKT9bxjUp5n2zEUvpNVcnHpEfJIqpZDfNqU45WzeiJl8WvVsEgET8JHK
         /MVvoFy59bzktC95YX/+LAyH8bLYWXWeHkY7lH4U6P6SsonscRHCHaax+eg9iMUqD9
         v1gIa20v6BIikhb4H69COOpMBsWH+Cui7dHtXXKfYCBpABidWvd8W1u6kX5Q9GBTNu
         CXapbNzjaj3Tv8XDY3ZlBmLtolpfRL4btczqchZk7XxD10IrWH4XWjDzHkSh1UseNT
         NTdvu/kgGU+iU9SxlWZcJlLdS5Z4rgFBEtVYnv0gwJY9wlQ0q1vrkR/FQDWCCdSnSn
         RE9wGmXcJOF+A==
Message-ID: <a8dc3066ec2dd2038af1375d7ecb2e72fe101e7b.camel@kernel.org>
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chengguang Xu <cgxu519@mykernel.net>
Date:   Sat, 02 Jan 2021 08:25:46 -0500
In-Reply-To: <20201228204837.GA28221@casper.infradead.org>
References: <20201223200746.GR874@casper.infradead.org>
         <20201223202140.GB11012@ircssh-2.c.rugged-nimbus-611.internal>
         <20201223204428.GS874@casper.infradead.org>
         <CAOQ4uxjAeGv8x2hBBzHz5PjSDq0Q+RN-ikgqEvAA+XE_U-U5Nw@mail.gmail.com>
         <20201224121352.GT874@casper.infradead.org>
         <CAOQ4uxj5YS9LSPoBZ3uakb6NeBG7g-Zeu+8Vt57tizEH6xu0cw@mail.gmail.com>
         <1334bba9cefa81f80005f8416680afb29044379c.camel@kernel.org>
         <20201228155618.GA6211@casper.infradead.org>
         <5bc11eb2e02893e7976f89a888221c902c11a2b4.camel@kernel.org>
         <CAOQ4uxhFz=Uervz6sMuz=RcFUWAxyLEhBrWnjQ+U0Jj_AaU59w@mail.gmail.com>
         <20201228204837.GA28221@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-12-28 at 20:48 +0000, Matthew Wilcox wrote:
> On Mon, Dec 28, 2020 at 09:37:37PM +0200, Amir Goldstein wrote:
> > Having said that, I never objected to the SEEN flag split.
> 
> I STRONGLY object to the SEEN flag split.  I think it is completely
> unnecessary and nobody's shown me a use-case that changes my mind.

I think the flag split makes better sense conceptually, though the
existing callers don't really have a need for it. I have a use-case in
mind that doesn't really involve overlayfs:

We still have a lot of internal callers that ultimately call
filemap_check_errors() to check and clear the mapping's AS_EIO/AS_ENOSPC
flags.

Splitting the SEEN flag in two could allow those callers to instead
sample the errseq_t using errseq_peek for their own purposes, without
clearing the REPORTED flag. That means that the existing semantics for
seeing errors on newly opened files could be preserved while allowing
internal callers to use errseq_t-based error handling.

That said, I don't have any patches to do this right now. It's a fairly
significant project to convert all of the existing callers of
filemap_check_errors() to such a scheme wholesale. It could be done
piecemeal though, and we could start discouraging new callers of
filemap_check_errors and the like.

-- 
Jeff Layton <jlayton@kernel.org>

