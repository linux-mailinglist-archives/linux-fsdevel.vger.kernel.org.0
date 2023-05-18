Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DF970834A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 15:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjERN4L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 09:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjERN4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 09:56:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4428710D5;
        Thu, 18 May 2023 06:56:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC7F96410A;
        Thu, 18 May 2023 13:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEB3C4339B;
        Thu, 18 May 2023 13:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684418168;
        bh=hHyuhDMjdrGvdqZgER2nh0JzKbT7a7ZLHIcfi0F4Ds0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dsloX7t6KQCKsExTq09JdNRt4DRwUADPhd104IQM8lXR3JQCYdP+zIytegAbnCRMT
         jgvy89L2iCP+Sslpz4GaGLrPfHo7HlXtl1+3FKK7BaTZ8kXOdFhq0EDMHMjFonm3Z3
         eNXnJPLDpwTWqQveTTDpXLwU7tdC2ZCgQp6ngSBLzbq8XlCNlJdfesp80aNWQk/HUD
         YVh910VanHRvrXq3u0T+th3WafPEUwjt38uVLv6nU2gv6+gWNOm1ZYMsf2AZG0gllr
         oDn0CKndio/khJxd/pxBEVOD1/JvMWgDsL2+MdpjurYaLbM1gwW40SQvYhlSMf6/Ra
         SUQuGhpwlMqkA==
Date:   Thu, 18 May 2023 15:56:03 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/9] block: introduce holder ops
Message-ID: <20230518-erdkruste-unteilbar-cb91c62511c9@brauner>
References: <20230516-kommode-weizen-4c410968c1f6@brauner>
 <20230517073031.GF27026@lst.de>
 <20230517-einreden-dermatologisch-9c6a3327a689@brauner>
 <20230517080613.GA31383@lst.de>
 <20230517-erhoffen-degradieren-d0aa039f0e1d@brauner>
 <20230517120259.GA16915@lst.de>
 <20230517-holzfiguren-anbot-490e5a7f74fe@brauner>
 <20230517142609.GA28898@lst.de>
 <20230518-teekanne-knifflig-a4ea8c3c885a@brauner>
 <20230518131216.GA32076@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230518131216.GA32076@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 03:12:16PM +0200, Christoph Hellwig wrote:
> On Thu, May 18, 2023 at 10:13:04AM +0200, Christian Brauner wrote:
> > Fwiw, I didn't mean to have a special device handler for an O_PATH fd.
> > I really just tried to figure out whether it would make sense to have an
> > fd-based block device lookup function because right now we only have
> > blkdev_get_by_path() and we'd be passing blkdev fds through the mount
> > api. But I understand now how I'd likely do it. So now just finding time
> > to actually implement it.
> 
> What's wrong with blkdev_get_by_dev(file_inode(file)->i_rdev) after
> the sanity checks from lookup_bdev (S_ISBLK and may_open_dev)?

Yeah, that's what I realized could work fine. I just need to check all
fses how they currently do this and how to do this cleanly.
