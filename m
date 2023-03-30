Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE7D6D021B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 12:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjC3KuI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 06:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjC3Ktt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:49:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AFE7A9B;
        Thu, 30 Mar 2023 03:48:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8F9DB82761;
        Thu, 30 Mar 2023 10:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16448C433EF;
        Thu, 30 Mar 2023 10:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680173321;
        bh=8oWvMr4wiz2aNx6cQIoyYHUmn/pZJiT8/q+iAW7Gv14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AeILlbSJQ4H9+z+a4cMaHn9n/hS7Mm30CJRM+ghJiQ4TqalpxEiKeOMHZ9EmY1phT
         TBmxXvCJuvfmu6VQ1rsQTbg6rvk7q2DcpzQitHTNcHC68dn7BdJErkw1TGuW5Zys6l
         QN18U/M3OYdzBrnhww2D0SNbcLzF1adOxIeD/GqA=
Date:   Thu, 30 Mar 2023 12:48:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Chuck Lever <chuck.lever@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: consolidate duplicate dt_type helpers
Message-ID: <ZCVpAyA__NrAOVOg@kroah.com>
References: <20230330104144.75547-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330104144.75547-1-jlayton@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 30, 2023 at 06:41:43AM -0400, Jeff Layton wrote:
> There are three copies of the same dt_type helper sprinkled around the
> tree. Convert them to use the common fs_umode_to_dtype function instead,
> which has the added advantage of properly returning DT_UNKNOWN when
> given a mode that contains an unrecognized type.
> 
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Phillip Potter <phil@philpotter.co.uk>
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/configfs/dir.c | 9 ++-------
>  fs/kernfs/dir.c   | 8 +-------
>  fs/libfs.c        | 9 ++-------
>  3 files changed, 5 insertions(+), 21 deletions(-)
> 
> v2: consolidate S_DT helper as well
> v3: switch existing dt_type helpers to use fs_umode_to_dtype
>     drop v9fs hunks since they're no longer needed

You forgot the "v3" in the subject line :(

