Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC5845484D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 15:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238284AbhKQORf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 09:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238270AbhKQORc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:17:32 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08523C061570;
        Wed, 17 Nov 2021 06:14:34 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8FEEB6814; Wed, 17 Nov 2021 09:14:33 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8FEEB6814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1637158473;
        bh=Rs8e9L+HTu9jk83ch0lpQa0cG1eZHh1N7FIFPt+dnR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WN0j0YTiw4TYkDUZOXuZp5VDfLovSJr5XFFTa/bjc/l0SHuhPLysyMaQXpoRbn6zW
         Xy8GGFTDJlxArX7j7DBUyboWqttFfSUb1yLY6EC1EsQZJzQNvIJCLWKxcUlJU35cTs
         pcGwly9xQKolRO69Kk4EXk+2hAif0Rpyk3d3tN88=
Date:   Wed, 17 Nov 2021 09:14:33 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20211117141433.GB24762@fieldses.org>
References: <20210929005641.60861-1-dai.ngo@oracle.com>
 <20211001205327.GN959@fieldses.org>
 <a6c9ba13-43d7-4ea9-e05d-f454c2c9f4c2@oracle.com>
 <33c8ea5a-4187-a9fa-d507-a2dcec06416c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33c8ea5a-4187-a9fa-d507-a2dcec06416c@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 16, 2021 at 03:06:32PM -0800, dai.ngo@oracle.com wrote:
> Just a reminder that this patch is still waiting for your review.

Yeah, I was procrastinating and hoping yo'ud figure out the pynfs
failure for me....  I'll see if I can get some time today.--b.

> 
> Thanks,
> -Dai
> 
> On 10/1/21 2:41 PM, dai.ngo@oracle.com wrote:
> >
> >On 10/1/21 1:53 PM, J. Bruce Fields wrote:
> >>On Tue, Sep 28, 2021 at 08:56:39PM -0400, Dai Ngo wrote:
> >>>Hi Bruce,
> >>>
> >>>This series of patches implement the NFSv4 Courteous Server.
> >>Apologies, I keep meaning to get back to this and haven't yet.
> >>
> >>I do notice I'm seeing a timeout on pynfs 4.0 test OPEN18.
> >
> >It's weird, this test passes on my system:
> >
> >
> >[root@nfsvmf25 nfs4.0]# ./testserver.py $server --rundeps -v OPEN18
> >INIT     st_setclientid.testValid : RUNNING
> >INIT     st_setclientid.testValid : PASS
> >MKFILE   st_open.testOpen : RUNNING
> >MKFILE   st_open.testOpen : PASS
> >OPEN18   st_open.testShareConflict1 : RUNNING
> >OPEN18   st_open.testShareConflict1 : PASS
> >**************************************************
> >INIT     st_setclientid.testValid : PASS
> >OPEN18   st_open.testShareConflict1 : PASS
> >MKFILE   st_open.testOpen : PASS
> >**************************************************
> >Command line asked for 3 of 673 tests
> >Of those: 0 Skipped, 0 Failed, 0 Warned, 3 Passed
> >[root@nfsvmf25 nfs4.0]#
> >
> >Do you have a network trace?
> >
> >-Dai
> >
> >>
> >>--b.
> >>
> >>>A server which does not immediately expunge the state on lease
> >>>expiration
> >>>is known as a Courteous Server.  A Courteous Server continues
> >>>to recognize
> >>>previously generated state tokens as valid until conflict
> >>>arises between
> >>>the expired state and the requests from another client, or the server
> >>>reboots.
> >>>
> >>>The v2 patch includes the following:
> >>>
> >>>. add new callback, lm_expire_lock, to lock_manager_operations to
> >>>   allow the lock manager to take appropriate action with
> >>>conflict lock.
> >>>
> >>>. handle conflicts of NFSv4 locks with NFSv3/NLM and local locks.
> >>>
> >>>. expire courtesy client after 24hr if client has not reconnected.
> >>>
> >>>. do not allow expired client to become courtesy client if there are
> >>>   waiters for client's locks.
> >>>
> >>>. modify client_info_show to show courtesy client and seconds from
> >>>   last renew.
> >>>
> >>>. fix a problem with NFSv4.1 server where the it keeps returning
> >>>   SEQ4_STATUS_CB_PATH_DOWN in the successful SEQUENCE reply, after
> >>>   the courtesy client re-connects, causing the client to keep sending
> >>>   BCTS requests to server.
> >>>
> >>>The v3 patch includes the following:
> >>>
> >>>. modified posix_test_lock to check and resolve conflict locks
> >>>   to handle NLM TEST and NFSv4 LOCKT requests.
> >>>
> >>>. separate out fix for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.
> >>>
> >>>The v4 patch includes:
> >>>
> >>>. rework nfsd_check_courtesy to avoid dead lock of fl_lock and
> >>>client_lock
> >>>   by asking the laudromat thread to destroy the courtesy client.
> >>>
> >>>. handle NFSv4 share reservation conflicts with courtesy client. This
> >>>   includes conflicts between access mode and deny mode and vice versa.
> >>>
> >>>. drop the patch for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.
> >>>
> >>>The v5 patch includes:
> >>>
> >>>. fix recursive locking of file_rwsem from posix_lock_file.
> >>>
> >>>. retest with LOCKDEP enabled.
> >>>
> >>>NOTE: I will submit pynfs tests for courteous server including tests
> >>>for share reservation conflicts in a separate patch.
> >>>
