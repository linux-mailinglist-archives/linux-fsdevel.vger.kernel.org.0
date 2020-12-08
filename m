Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428AE2D2B8B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 14:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgLHM7N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 07:59:13 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36328 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgLHM7N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:59:13 -0500
Received: from localhost (unknown [IPv6:2804:14c:132:242d::1001])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2D1771F44C2F;
        Tue,  8 Dec 2020 12:58:30 +0000 (GMT)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu, khazhy@google.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 5/8] vfs: Include origin of the SB error notification
Organization: Collabora
References: <20201208003117.342047-6-krisman@collabora.com>
        <20201208003117.342047-1-krisman@collabora.com>
        <952750.1607431868@warthog.procyon.org.uk>
Date:   Tue, 08 Dec 2020 09:58:25 -0300
In-Reply-To: <952750.1607431868@warthog.procyon.org.uk> (David Howells's
        message of "Tue, 08 Dec 2020 12:51:08 +0000")
Message-ID: <87r1o05ua6.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> Gabriel Krisman Bertazi <krisman@collabora.com> wrote:
>
>> @@ -130,6 +131,8 @@ struct superblock_error_notification {
>>  	__u32	error_cookie;
>>  	__u64	inode;
>>  	__u64	block;
>> +	char	function[SB_NOTIFICATION_FNAME_LEN];
>> +	__u16	line;
>>  	char	desc[0];
>>  };
>
> As Darrick said, this is a UAPI breaker, so you shouldn't do this (you can,
> however, merge this ahead a patch).  Also, I would put the __u16 before the
> char[].
>
> That said, I'm not sure whether it's useful to include the function name and
> line.  Both fields are liable to change over kernel commits, so it's not
> something userspace can actually interpret.  I think you're better off dumping
> those into dmesg.
>
> Further, this reduces the capacity of desc[] significantly - I don't know if
> that's a problem.

Yes, that is a big problem as desc is already quite limited.  I don't
think it is a problem for them to change between kernel versions, as the
monitoring userspace can easily associate it with the running kernel.
The alternative would be generating something like unique IDs for each
error notification in the filesystem, no?

> And yet further, there's no room for addition of new fields with the desc[]
> buffer on the end.  Now maybe you're planning on making use of desc[] for
> text-encoding?

Yes.  I would like to be able to provide more details on the error,
without having a unique id.  For instance, desc would have the formatted
string below, describing the warning:

ext4_warning(inode->i_sb, "couldn't mark inode dirty (err %d)", err);


>
> David
>

-- 
Gabriel Krisman Bertazi
