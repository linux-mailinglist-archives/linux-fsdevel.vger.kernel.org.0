Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE43B4B8FA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 18:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbiBPRs2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 12:48:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbiBPRs1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:48:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDA8254A46;
        Wed, 16 Feb 2022 09:48:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1DA260F6D;
        Wed, 16 Feb 2022 17:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52DAC340E8;
        Wed, 16 Feb 2022 17:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645033694;
        bh=P0xCoobi3PX2V5oBKTfTY1baelnZ+APwbOUC4Rkw/mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dq1v+rUoe2FpPJGFuqDUodPgLvzQCLHuayIj0VVCSvEISd4clE8/41zsxytE3gser
         8T6D2eGqnIedjy7sevCAsK/uWM3moR0nXbwhJX2v9ZQypHt7L3Nq21Tu4lUi9l8ZHq
         iL4OaNpL24iXjhJxQGtiCj5FMGQSy485+zPO9cTY=
Date:   Wed, 16 Feb 2022 18:48:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/23] cachefiles: introduce new devnode for on-demand
 read mode
Message-ID: <Yg0421B10PPwunI+@kroah.com>
References: <bd9cb3bb-e29c-d4b3-e9bf-915b9771b553@linux.alibaba.com>
 <20220215111335.123528-1-jefflexu@linux.alibaba.com>
 <YgzWkhXCnlNDADvb@kroah.com>
 <becd656c-701c-747e-f063-2b9867cbd3d2@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <becd656c-701c-747e-f063-2b9867cbd3d2@linux.alibaba.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 16, 2022 at 08:49:35PM +0800, JeffleXu wrote:
> >> +struct cachefiles_req_in {
> >> +	uint64_t id;
> >> +	uint64_t off;
> >> +	uint64_t len;
> > 
> > For structures that cross the user/kernel boundry, you have to use the
> > correct types.  For this it would be __u64.
> 
> OK I will change to __xx style in the next version.
> 
> By the way, I can't understand the disadvantage of uintxx_t style.

The "uint*" types are not valid kernel types.  They are userspace types
and do not transfer properly in all arches and situations when crossing
the user/kernel boundry.  They are also in a different C "namespace", so
should not even be used in kernel code, although a lot of people do
because they are used to writing userspace C code :(

thanks,

greg k-h
