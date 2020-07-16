Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F24B2228A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 19:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgGPRBf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 13:01:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:55540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgGPRBf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:01:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DA9C6B85A;
        Thu, 16 Jul 2020 17:01:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 74DC11E0E81; Thu, 16 Jul 2020 19:01:33 +0200 (CEST)
Date:   Thu, 16 Jul 2020 19:01:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 15/22] fsnotify: send event with parent/name info to
 sb/mount/non-dir marks
Message-ID: <20200716170133.GJ5022@quack2.suse.cz>
References: <20200716084230.30611-1-amir73il@gmail.com>
 <20200716084230.30611-16-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716084230.30611-16-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 16-07-20 11:42:23, Amir Goldstein wrote:
> Similar to events "on child" to watching directory, send event "on child"
> with parent/name info if sb/mount/non-dir marks are interested in
> parent/name info.
> 
> The FS_EVENT_ON_CHILD flag can be set on sb/mount/non-dir marks to specify
> interest in parent/name info for events on non-directory inodes.
> 
> Events on "orphan" children (disconnected dentries) are sent without
> parent/name info.
> 
> Events on direcories are send with parent/name info only if the parent
> directory is watching.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Hum, doesn't this break ignore mask handling in
fanotify_group_event_mask()? Because parent's ignore mask will be included
even though parent is added into the iter only to carry the parent info...

Also I'm constantly getting confused about mark->mask handling in that
function WRT __fsnotify_parent() sending FS_EVENT_ON_CHILD event. But in
the end I've convinced myself it is correct ;)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
