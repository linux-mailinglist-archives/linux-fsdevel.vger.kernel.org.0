Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5242222B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 14:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgGPMoO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 08:44:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:39214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgGPMoN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:44:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8AD96ADC4;
        Thu, 16 Jul 2020 12:44:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6B2D71E12C9; Thu, 16 Jul 2020 14:44:12 +0200 (CEST)
Date:   Thu, 16 Jul 2020 14:44:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 10/22] fanotify: no external fh buffer in
 fanotify_name_event
Message-ID: <20200716124412.GA5022@quack2.suse.cz>
References: <20200716084230.30611-1-amir73il@gmail.com>
 <20200716084230.30611-11-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716084230.30611-11-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 16-07-20 11:42:18, Amir Goldstein wrote:
> The fanotify_fh struct has an inline buffer of size 12 which is enough
> to store the most common local filesystem file handles (e.g. ext4, xfs).
> For file handles that do not fit in the inline buffer (e.g. btrfs), an
> external buffer is allocated to store the file handle.
> 
> When allocating a variable size fanotify_name_event, there is no point
> in allocating also an external fh buffer when file handle does not fit
> in the inline buffer.
> 
> Check required size for encoding fh, preallocate an event buffer
> sufficient to contain both file handle and name and store the name after
> the file handle.
> 
> At this time, when not reporting name in event, we still allocate
> the fixed size fanotify_fid_event and an external buffer for large
> file handles, but fanotify_alloc_name_event() has already been prepared
> to accept a NULL file_name.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

When reading this, I've got one cleanup idea for later: For FID events, we
could now easily check fh len in fanotify_alloc_fid_event(). If it fits in
inline size, allocate the event from kmem cache, if it does not, allocate
appropriately sized event from kmalloc(). Similarly when freeing event we
could check fh len to determine how to free the event. This way we can
completely get rid of the external buffer code, somewhat simplify all
the fh handling, remove the alignment restrictions on fanotify_fh and
fanotify_info...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
