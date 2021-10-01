Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A8A41F681
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 22:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhJAUz0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 16:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355450AbhJAUzZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 16:55:25 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80751C061775;
        Fri,  1 Oct 2021 13:53:28 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C38A32839; Fri,  1 Oct 2021 16:53:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C38A32839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1633121607;
        bh=V4FoBQA3JU469tT/UTIuI1kHhKaQhNKWB11Q7A/TjLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sNu31CzYRnflJp0sUgY12SLmNBPaJbn5Ww97L4j+GSky2TF37LZrwnsOOc5wdeBpM
         vD9DQrUZOCi/JWm+hTHwtUT7zevxjPEFtckRIANraMW9DVPyrZtDW6Nr9ECvq0DBgT
         eskqqG1KL798BiYEQgfr0lDvLYwf4VCi3xcT9frA=
Date:   Fri, 1 Oct 2021 16:53:27 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20211001205327.GN959@fieldses.org>
References: <20210929005641.60861-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929005641.60861-1-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 28, 2021 at 08:56:39PM -0400, Dai Ngo wrote:
> 
> Hi Bruce,
> 
> This series of patches implement the NFSv4 Courteous Server.

Apologies, I keep meaning to get back to this and haven't yet.

I do notice I'm seeing a timeout on pynfs 4.0 test OPEN18.

--b.

> 
> A server which does not immediately expunge the state on lease expiration
> is known as a Courteous Server.  A Courteous Server continues to recognize
> previously generated state tokens as valid until conflict arises between
> the expired state and the requests from another client, or the server
> reboots.
> 
> The v2 patch includes the following:
> 
> . add new callback, lm_expire_lock, to lock_manager_operations to
>   allow the lock manager to take appropriate action with conflict lock.
> 
> . handle conflicts of NFSv4 locks with NFSv3/NLM and local locks.
> 
> . expire courtesy client after 24hr if client has not reconnected.
> 
> . do not allow expired client to become courtesy client if there are
>   waiters for client's locks.
> 
> . modify client_info_show to show courtesy client and seconds from
>   last renew.
> 
> . fix a problem with NFSv4.1 server where the it keeps returning
>   SEQ4_STATUS_CB_PATH_DOWN in the successful SEQUENCE reply, after
>   the courtesy client re-connects, causing the client to keep sending
>   BCTS requests to server.
> 
> The v3 patch includes the following:
> 
> . modified posix_test_lock to check and resolve conflict locks
>   to handle NLM TEST and NFSv4 LOCKT requests.
> 
> . separate out fix for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.
> 
> The v4 patch includes:
> 
> . rework nfsd_check_courtesy to avoid dead lock of fl_lock and client_lock
>   by asking the laudromat thread to destroy the courtesy client.
> 
> . handle NFSv4 share reservation conflicts with courtesy client. This
>   includes conflicts between access mode and deny mode and vice versa.
> 
> . drop the patch for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.
> 
> The v5 patch includes:
> 
> . fix recursive locking of file_rwsem from posix_lock_file. 
> 
> . retest with LOCKDEP enabled.
> 
> NOTE: I will submit pynfs tests for courteous server including tests
> for share reservation conflicts in a separate patch.
> 
