Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 019F81200B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 10:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfLPJOO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 04:14:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:55368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726891AbfLPJON (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:14:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 74C8BAE5C;
        Mon, 16 Dec 2019 09:14:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 053271E0B2E; Mon, 16 Dec 2019 10:14:11 +0100 (CET)
Date:   Mon, 16 Dec 2019 10:14:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     Marko Rauhamaa <marko.rauhamaa@f-secure.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: Can fanotify OPEN_PERM work with CIFS?
Message-ID: <20191216091410.GA19204@quack2.suse.cz>
References: <87r22jk7s5.fsf@drapion.f-secure.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r22jk7s5.fsf@drapion.f-secure.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Thu 07-11-19 17:47:38, Marko Rauhamaa wrote:
> In a common setup, CIFS file access is tied to the credentials of the
> regular Linux user, but the local root has no access. If the local root
> monitors such a CIFS mount point with OPEN_PERM, dentry_open() in
> fs/notify/fanotify/fanotify_user.c fails with EPERM or EACCES depending
> on the kernel version. In effect, the whole mount point becomes
> inaccessible to any user.
> 
> I understand the question has intricate corner cases and security
> considerations, but is the common use case insurmountable? When the
> regular user is opening a file for reading and waiting for a permission
> to continue, must the file be reopened instead of being "lent" to the
> content checker via duping the fd?

I'm sorry for late reply. I've noticed this email only now. It is difficult
to "lend" the fd being opened by the application to the fanotify permission
event. Mainly because by the time the event is generated, that file
descriptor is not open yet - the event gets generated while we are checking
whether open is permitted which is before the "opening act" really happens.
And this is a fundamental thing because open(2) can have various side
effects (like truncating a file). And then there are also other smaller
issues like that different file mode or flags may need to be used for
fanotify event than for the original open.

I don't know details of CIFS permission model but I assume that there's a
similar problem as with NFS with generally untrusted client and thus the
server restricts client access to the authenticated credentials. That is
problematic with fanotify because even if we impersonated original opening
process we needn't be able to open the file with requested mode (think of
client having only read access to a file and fanotify request also write
access). So the permission model of network filesystems is incompatible
with fanotify permission model and I don't see an easy way how to
work-around this :-|.

								Honza

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
