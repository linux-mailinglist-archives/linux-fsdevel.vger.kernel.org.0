Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3DE520632
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 22:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiEIUyZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 16:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiEIUyY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 16:54:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495402B1DC6;
        Mon,  9 May 2022 13:50:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54E1EB81982;
        Mon,  9 May 2022 20:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90C0C385BA;
        Mon,  9 May 2022 20:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652129427;
        bh=kXVd6vnfRmzO2uRkNEeqbmWM5xOEJ+KvMyUlqJkZmhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OLv8a3WERiYcZxZHrzte5xOxI1AQKJJ5qpGWOrRlY3o67OD24WULItJq7fDYhDVue
         BbVMFMWctZkDiXVcCxwgu+2tLy+fhu3URJ1N/T/Qzwzm5MFSStXZ3y8+D8QTGTxOeP
         uUuaauuhUiEWiU+Ctz9hOYyD77CXNHrQe60Nt+z0Ua8ZchnireZQZxcENmdtNG8ISB
         WSyjtz+mj9OY0N9H0mOnhUhq80mlRdHXSrBoBFWR1VOUcXSA3/A+rJKAfn8RAG3RaH
         68Uiv05QqJgX+N7QOFV2suu16oXXxC6Yx47o4QwYuK9bgi2g8X0/1TtzWQRPvWDIgH
         od38x7N5j4ybg==
Date:   Mon, 9 May 2022 13:50:25 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Haimin Zhang <tcs.kernel@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Haimin Zhang <tcs_kernel@tencent.com>,
        TCS Robot <tcs_robot@tencent.com>
Subject: Re: [PATCH v2] fs/pipe: Deinitialize the watch_queue when pipe is
 freed
Message-ID: <Ynl+kUGRYaovLc8q@sol.localdomain>
References: <20220509131726.59664-1-tcs.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509131726.59664-1-tcs.kernel@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 09, 2022 at 09:17:26PM +0800, Haimin Zhang wrote:
> From: Haimin Zhang <tcs_kernel@tencent.com>
> 
> Add a new function call to deinitialize the watch_queue of a freed pipe.
> When a pipe node is freed, it doesn't make pipe->watch_queue->pipe null.
> Later when function post_one_notification is called, it will use this
> field, but it has been freed and watch_queue->pipe is a dangling pointer.
> It makes a uaf issue.
> Check wqueu->defunct before pipe check since pipe becomes invalid once all
> watch queues were cleared.
> 
> Reported-by: TCS Robot <tcs_robot@tencent.com>
> Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>

Is this fixing something?  If so it should have a "Fixes" tag.

- Eric
