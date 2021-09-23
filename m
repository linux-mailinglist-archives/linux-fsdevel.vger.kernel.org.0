Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B361B4165F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 21:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242852AbhIWTeN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 15:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242796AbhIWTeM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 15:34:12 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356E8C061574;
        Thu, 23 Sep 2021 12:32:41 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 963DC1512; Thu, 23 Sep 2021 15:32:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 963DC1512
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1632425559;
        bh=xkjN57pNriAf/4GA6VhqgIP0rfzKAEP9yyQo51zE1es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fz9S1xV9jwRb3mBJdTbpmQy8Z9xqRNf9QwN2M/g9W/jUNKDmQjg9rksuEXyJ/oVWn
         8lwFv0AbqPLZUPOJdLW+5LIOhZtXc5BylvZPZLe+lAA4pozq0T7hLGzTt7+/ro8MKb
         gdzlcEEcOoOaL1mjBrc9V3TRexYIi1nkiQw1mexg=
Date:   Thu, 23 Sep 2021 15:32:39 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] nfsd: Initial implementation of NFSv4 Courteous
 Server
Message-ID: <20210923193239.GD18334@fieldses.org>
References: <20210916182212.81608-1-dai.ngo@oracle.com>
 <20210916182212.81608-3-dai.ngo@oracle.com>
 <20210923013458.GE22937@fieldses.org>
 <9e33d9b7-5947-488d-343f-80c86a27fd84@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e33d9b7-5947-488d-343f-80c86a27fd84@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 10:09:35AM -0700, dai.ngo@oracle.com wrote:
> On 9/22/21 6:34 PM, J. Bruce Fields wrote:
> >On Thu, Sep 16, 2021 at 02:22:11PM -0400, Dai Ngo wrote:
> >>+/*
> >>+ * If the conflict happens due to a NFSv4 request then check for
> >>+ * courtesy client and set rq_conflict_client so that upper layer
> >>+ * can destroy the conflict client and retry the call.
> >>+ */
> >I think we need a different approach.
> 
> I think nfsd_check_courtesy_client is used to handle conflict with
> delegation. So instead of using rq_conflict_client to let the caller
> knows and destroy the courtesy client as the current patch does, we
> can ask the laundromat thread to do the destroy.

I can't see right now why that wouldn't work.

> In that case,
> nfs4_get_vfs_file in nfsd4_process_open2 will either return no error
> since the the laufromat destroyed the courtesy client or it gets
> get nfserr_jukebox which causes the NFS client to retry. By the time
> the retry comes the courtesy client should already be destroyed.

Make sure this works for local (non-NFS) lease breakers as well.  I
think that mainly means making sure the !O_NONBLOCK case of
__break_lease works.

--b.
