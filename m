Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB256433B83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 18:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbhJSQEH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 12:04:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58914 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhJSQEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:04:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BF6E221981;
        Tue, 19 Oct 2021 16:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634659312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8hIx4eb8RNDvqpfcSYXsTTz8oiHfDvbCGCZib+Ictaw=;
        b=PpiTBGbBw0Mz+wxjp3SLGi553EsrgcRkICcmK0CqwPPepfUkV/PdHKAJ8qLFFgkcOIMJM8
        iJnqVEBJg1Ama7ybduuDV5zdzQbH9dQzgQeRF6lzIe1t3hUYBbIULHT9i52HJ2S/zhVeuE
        nkYKeUfyqB0AsLf+vCA2lO9PjxoCchc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634659312;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8hIx4eb8RNDvqpfcSYXsTTz8oiHfDvbCGCZib+Ictaw=;
        b=8bzN2S5Q8vMJhRL9+u61e0yYLZSymEmRUfnEEFU4nwv26As/HmzWbyqtRrzrndJzY8EmhX
        QCxjlpFles6rxLDQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id AA05AA3B8C;
        Tue, 19 Oct 2021 16:01:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7AF771E0983; Tue, 19 Oct 2021 18:01:52 +0200 (CEST)
Date:   Tue, 19 Oct 2021 18:01:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v8 30/32] ext4: Send notifications on error
Message-ID: <20211019160152.GT3255@quack2.suse.cz>
References: <20211019000015.1666608-1-krisman@collabora.com>
 <20211019000015.1666608-31-krisman@collabora.com>
 <20211019154426.GR3255@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019154426.GR3255@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 19-10-21 17:44:26, Jan Kara wrote:
> On Mon 18-10-21 21:00:13, Gabriel Krisman Bertazi wrote:
> > Send a FS_ERROR message via fsnotify to a userspace monitoring tool
> > whenever a ext4 error condition is triggered.  This follows the existing
> > error conditions in ext4, so it is hooked to the ext4_error* functions.
> > 
> > It also follows the current dmesg reporting in the format.  The
> > filesystem message is composed mostly by the string that would be
> > otherwise printed in dmesg.
> > 
> > A new ext4 specific record format is exposed in the uapi, such that a
> > monitoring tool knows what to expect when listening errors of an ext4
> > filesystem.
> > 
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> Looks good to me. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Hum, I actually retract this because the code doesn't match what is written
in the documentation and I'm not 100% sure what is correct. In particular:

> > @@ -759,6 +760,8 @@ void __ext4_error(struct super_block *sb, const char *function,
> >  		       sb->s_id, function, line, current->comm, &vaf);
> >  		va_end(args);
> >  	}
> > +	fsnotify_sb_error(sb, NULL, error);
> > +

E.g. here you pass the 'error' to fsnotify. This will be just standard
'errno' number, not ext4 error code as described in the documentation. Also
note that frequently 'error' will be 0 which gets magically transformed to
EFSCORRUPTED in save_error_info() in the ext4 error handling below. So
there's clearly some more work to do...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
