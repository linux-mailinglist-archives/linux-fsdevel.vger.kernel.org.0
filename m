Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E212222EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 14:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgGPMwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 08:52:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:41896 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbgGPMwM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:52:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9E672ADC4;
        Thu, 16 Jul 2020 12:52:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9BACC1E12C9; Thu, 16 Jul 2020 14:52:11 +0200 (CEST)
Date:   Thu, 16 Jul 2020 14:52:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 12/22] inotify: report both events on parent and child
 with single callback
Message-ID: <20200716125211.GB5022@quack2.suse.cz>
References: <20200716084230.30611-1-amir73il@gmail.com>
 <20200716084230.30611-13-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716084230.30611-13-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 16-07-20 11:42:20, Amir Goldstein wrote:
> fsnotify usually calls inotify_handle_event() once for watching parent
> to report event with child's name and once for watching child to report
> event without child's name.
> 
> Do the same thing with a single callback instead of two callbacks when
> marks iterator contains both inode and child entries.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Another idea for possible future cleanup here: Everybody except for
fanotify cares only about inode marks and reporting both parent and child
only complicates things for them (and I can imagine bugs being created by
in-kernel fsnotify users because they misunderstand inode-vs-child mark
types etc.). So maybe we can create another fsnotify_group operation
similar to ->handle_event but with simpler signature for these simple
notification handlers and send_to_group() will take care of translating 
the complex fsnotify() call into a sequence of these simple callbacks.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
