Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12BB2AF392
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 15:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgKKObI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 09:31:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:40478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgKKObI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:31:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 84EB3ABD1;
        Wed, 11 Nov 2020 14:31:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 06C6A1E130B; Wed, 11 Nov 2020 15:31:06 +0100 (CET)
Date:   Wed, 11 Nov 2020 15:31:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     Costa Sapuntzakis <costa@purestorage.com>
Cc:     Hillf Danton <hdanton@sina.com>, Jan Kara <jack@suse.cz>,
        syzbot <syzbot+7a4ba6a239b91a126c28@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: BUG: sleeping function called from invalid context in
 ext4_superblock_csum_set
Message-ID: <20201111143106.GC28132@quack2.suse.cz>
References: <000000000000f50cb705b313ed70@google.com>
 <20201102033326.3343-1-hdanton@sina.com>
 <CAABuPhbFbQ+_nwDKXjUngtuS5twU6OqKtNu5xYW-d82JJ3cFuQ@mail.gmail.com>
 <20201104131235.GD5600@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104131235.GD5600@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 04-11-20 14:12:35, Jan Kara wrote:
> On Tue 03-11-20 09:16:19, Costa Sapuntzakis wrote:
> > Jan, does this fixup from Hillf look ok to you?  You originally argued for
> > lock_buffer/unlock_buffer.
> > 
> > I think the problem here is that the ext4 code assumes that
> > ext4_commit_super will not sleep if sync == 0 (or at least
> > __ext4_grp_locked_error deos). Perhaps there should be a comment on
> > ext4_commit_super documenting this constraint.
> 
> Hum, right. I forgot about that. The spinlock Hillf suggests kind of works
> but it still doesn't quite handle the case where superblock is modified in
> parallel from another place (that can still lead to sb checksum mismatch on
> next load). When we are going for a more complex solution I'd rather solve
> this as well... I'm looking into possible solutions now.

Just an update: I'm still working on this and it's like peeling an onion.
The mixing of journalled superblock updates with unjournalled one is really
evil and commit acaa532687cd fixes just a small part of the problems. So
for now I suggest to just revert acaa532687cd (to avoid sleep in atomic
context) and I'll submit larger set of fixes once they are ready.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
