Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF4550E966
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 21:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244912AbiDYTWV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 15:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbiDYTWU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 15:22:20 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F7712C8FB;
        Mon, 25 Apr 2022 12:19:15 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 1200268B1; Mon, 25 Apr 2022 15:19:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 1200268B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1650914355;
        bh=uK9lejukeVBAwOvZUQl9Q6kN2d+FjimXMTdDoFwje7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PooKFJAAL0pmL6EZ5CwRNN4q5a0ynKlqwEiIcjuhLj+eXiPpb3X/p4shSZGYlKyqm
         Ry2BPPOKGLQqbFV2tiTXVlp14gkOs5bzyPyH5JzdOn7OCvM3KZGsK4ldmatf4bKMQ1
         Uo9T1cvBCsbRrTDAxAhTwGjrn54NQUHcd5wYdhFU=
Date:   Mon, 25 Apr 2022 15:19:15 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v21 0/7] NFSD: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20220425191915.GF24825@fieldses.org>
References: <1650739455-26096-1-git-send-email-dai.ngo@oracle.com>
 <20220425161722.GC24825@fieldses.org>
 <20220425175327.GD24825@fieldses.org>
 <ed6893fa-fbb1-36a7-226a-4436edd34644@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed6893fa-fbb1-36a7-226a-4436edd34644@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 25, 2022 at 11:16:54AM -0700, dai.ngo@oracle.com wrote:
> 
> On 4/25/22 10:53 AM, J. Bruce Fields wrote:
> >I'm getting a few new pynfs failures after applying these.  I haven't
> >tried to investigage what's happening.
> >
> >--b.
> >
> >**************************************************
> >RENEW3   st_renew.testExpired                                     : FAILURE
> >            nfs4lib.BadCompoundRes: Opening file b'RENEW3-1':
> >            operation OP_OPEN should return NFS4_OK, instead got
> >            NFS4ERR_DELAY
> >LKU10    st_locku.testTimedoutUnlock                              : FAILURE
> >            nfs4lib.BadCompoundRes: Opening file b'LKU10-1':
> >            operation OP_OPEN should return NFS4_OK, instead got
> >            NFS4ERR_DELAY
> >CLOSE9   st_close.testTimedoutClose2                              : FAILURE
> >            nfs4lib.BadCompoundRes: Opening file b'CLOSE9-1':
> >            operation OP_OPEN should return NFS4_OK, instead got
> >            NFS4ERR_DELAY
> >CLOSE8   st_close.testTimedoutClose1                              : FAILURE
> >            nfs4lib.BadCompoundRes: Opening file b'CLOSE8-1':
> >            operation OP_OPEN should return NFS4_OK, instead got
> >            NFS4ERR_DELAY
> 
> with this patches, OPEN (v4.0 and v4.1) might have to handle NFS4ERR_DELAY
> if there is a reservation conflict. I had to modify open_confirm (v4.0) and
> open_create_file (v4.1) to handle the NFS4ERR_DELAY error.

Looking at your patch 2....

OK, my suggestion was: "in the case of a conflict, call
try_to_expire_client and queue_work(), then modify e.g.
nfs4_get_vfs_file to flush_workqueue() and then retry after unlocking
fi_lock."  You're returning DELAY instead of waiting for the workqueue.

After thinking on it a minute.... I like your way better.  It's simpler.
Any client has to handle DELAY on OPEN, for the delegation-conflict
case.  Maybe it's a little suboptimal, but so what, this is a very rare
case.

So, good thinking, let's stick with that idea.  We'll just need to fix
up pynfs some time.

--b.
